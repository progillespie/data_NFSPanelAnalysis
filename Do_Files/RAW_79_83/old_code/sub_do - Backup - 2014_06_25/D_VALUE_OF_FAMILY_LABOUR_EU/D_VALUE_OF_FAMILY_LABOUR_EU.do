* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.


local startdir: pwd // Save current working directory location


* Move into the root of the variable's directory
local this_file_calculates "D_VALUE_OF_FAMILY_LABOUR_EU"
qui cd  `this_file_calculates'
local vardir: pwd 



* Needed variables get their own subdirectories. Look for subfolders
*  and use their names to determine which variables you need to 
*  calculate for this variable.
local vars_needed: dir "." dirs * 


foreach var_needed of local vars_needed {
	di "Deriving `var_needed'"
	qui do `var_needed'/`var_needed'.do
}



* Create a list of variables which may not exist for the early years
local nonexist_vlist "`nonexist_vlist' "



* Add nonexist variables to global list of zero vars
global zero_vlist "$zero_vlist `nonexist_vlist'"

* Make sure each variable enters list only once
global zero_vlist: list uniq global(zero_vlist)



* Check if those vars exist, and if not create them as zero vectors
foreach var of local nonexist_vlist {

	capture confirm variable `var'

	if _rc!=0{
	
		if "`var'"== "OTHER_SUBS_TOTAL_EU"{
		   gen OTHER_SUBS_TOTAL_EU = 0
		}
	
		else {
		   gen `var' = 0
		}

	}

}


* Will have to go back to the uncollapsed data for this calculation.
*  Therefore preserve the data in memory, do the calculations, and
*  merge the new variable into the collapsed data
preserve

* Stata could be in any directory now, but RAW_79_83 should
*  be in the path. Extract it from the vardir local.  
local RAW_79_83=regexr("`vardir'", "RAW_79_83.*$", "RAW_79_83")	

* Now change directory to it
cd `RAW_79_83'


local i = 79
while `i' < 84 {

	import excel using raw`i'_head.xls ///
          , firstrow sheet("Sheet57") clear

	rename farm farmcode
	qui do sub_do/_renameSheet/renameSheet57.do

	
	gen int YE_AR = 1900 + `i'



	*=============================================================
	/* YEAR_BORN is a 2 digit year. The first two digits are 19 if
	    1. The year is in the 20th century (i.e. is 19XX) OR
	    2. The year is in the 21st century, but YEAR_BORN 
	        is larger than the number of years in the century to
	        date (in the year being considered).
	  ... otherwise, we should go with 20 as the first two digits,
	  and use that figure to calculate the age. 
	
	 YEAR_BORN has been renamed with a card specific name, e.g. 
         UNPAID_YEAR_BORN                                             */
	*=============================================================

	* Create temporary var WorkerAge to simplify conditions in eq.
	gen int WorkerAge = 0

	replace WorkerAge = YE_AR                 - ///
           (1900  + UNPAID_YEAR_BORN)                 ///
	  if YE_AR < 2000                         | ///
	     [                                   ///    The eq which 
	       YE_AR > 2000                       & /// should apply
	       (UNPAID_YEAR_BORN) > (YE_AR - 2000) ///    for 79 - 83. 
	     ] 
	

	replace WorkerAge = YE_AR                 - ///
           (2000  + UNPAID_YEAR_BORN)                 ///  Included for 
	  if  YE_AR >= 2000                       & /// compatability
	     (UNPAID_YEAR_BORN) <= (YE_AR - 2000)  //    w/ later years
        
        gen int checkWC1 = 0 
        replace checkWC1 = 1 if UNPAID_WORKER_CODE == 1

        * Create FARM_MD_AGE, which is presumably just the age of 
        *   those with UNPAID_WORKER_CODE == 1 (the most common). 
        capture drop FARM_MD_AGE 
        gen int FARM_MD_AGE = 0
        replace FARM_MD_AGE = WorkerAge if UNPAID_WORKER_CODE == 1
        label var FARM_MD_AGE  "Age of holder"
	*=============================================================
	
	capture drop AWUUnweighted

	gen double AWUUnweighted =  ///
	  UNPAID_HOURS_WORKED / 1800

	replace AWUUnweighted  = 1  ///
	  if AWUUnweighted > 1 
	   


	capture drop `this_file_calculates'
	gen `this_file_calculates' = 0
	
	replace `this_file_calculates' =   ///
	  AWUUnweighted  * 18652           ///
	  if WorkerAge >= 18
	

	replace `this_file_calculates' =    ///
	  AWUUnweighted  * 13036            ///
	  if WorkerAge < 18                  & ///
	     WorkerAge > 14
	

	* If <= 14 it Hours should be 0, which is what it will be, because it
	*  hasn't been replaced (changed from the initialised value of 0).
	


	rename YE_AR year
	qui do sub_do/do_collapse
	save temp`i', replace


	local i = `i' + 1

}



* Append the temp files together
local i = 79
use temp`i'.dta, clear
save temp_appended.dta, replace
erase temp`i'.dta
local i = `i' + 1
while `i' < 84 {
	
	append using temp`i'.dta
	save temp_appended.dta, replace
	erase temp`i'.dta
	
	local i = `i' + 1

}

duplicates report farmcode year
tabstat FARM_MD_AGE, by(year)
tab checkWC1
count
cd sub_do
STOP!!!

* Go back to the preserved dataset
restore



* Bring calculated variable into data. Not every farm has UNPAID labour, so 
*  the using data will have fewer obs, but it's still 1:1 (one row is one
*  farm-year. 
merge 1:1 farmcode year using temp_appended.dta  ///
  , nogen keepusing(`this_file_calculates' ) 



replace `this_file_calculates' = 0 /// 
   if missing(`this_file_calculates')
label var `this_file_calculates' "Imputed value of family labour (time sensitive)"



* Add required variables to global list of required vars
global required_vars "$required_vars UNPAID_HOURS_WORKED"
global required_vars "$required_vars UNPAID_YEAR_BORN"
global required_vars "$required_vars YE_AR"

* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars)



cd `startdir' // return Stata to previous directory
summ `this_file_calculates', detail
codebook `this_file_calculates' 

