* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.


local startdir: pwd // Save current working directory location


* Move into the root of the variable's directory
local this_file_calculates "D_LABOUR_UNITS_PAID"
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
*  be in the path. Use info from vardir local to define dodir and 
*  origdata locals.
local dodir    = regexr("`vardir'" , "RAW_79_83.*$" , "RAW_79_83")
local origdata = regexr("`dodir'"  , "Do_Files"     , "OrigData")

* Now change directory to it
cd `origdata'


local i = 79
while `i' < 84 {

	import excel using raw`i'_head.xls ///
          , firstrow sheet("Sheet58") clear

	rename farm farmcode
	qui do `dodir'/sub_do/_renameSheet/renameSheet58.do

	
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
         PAID_YEAR_BORN                                             */
	*=============================================================

	* Create temporary var WorkerAge to simplify conditions in eq.
	gen int WorkerAge = 0

	replace WorkerAge = YE_AR                 - ///
           (1900  + PAID_YEAR_BORN)                 ///
	  if YE_AR < 2000                         | ///
	     [                                   ///    The eq which 
	       YE_AR > 2000                       & /// should apply
	       (PAID_YEAR_BORN) > (YE_AR - 2000) ///    for 79 - 83. 
	     ] 
	

	replace WorkerAge = YE_AR                 - ///
           (2000  + PAID_YEAR_BORN)                 ///  Included for 
	  if  YE_AR >= 2000                       & /// compatability
	     (PAID_YEAR_BORN) <= (YE_AR - 2000)  //    w/ later years
	*=============================================================
	

	   
	capture drop `this_file_calculates'
	gen `this_file_calculates' = 0
	
	replace `this_file_calculates' = 1  ///
	  if PAID_HOURS_WORKED / 1800 > 1
	

	replace `this_file_calculates' =    ///
	  (PAID_HOURS_WORKED/1800)           * /// 
	   1                                ///
	  if PAID_HOURS_WORKED / 1800 <= 1   & ///
	  WorkerAge > 18
	

	replace `this_file_calculates' =    ///
	  (PAID_HOURS_WORKED/1800)           * /// 
	   0.75                             ///
	  if PAID_HOURS_WORKED / 1800 <= 1   & ///
	  WorkerAge <= 18                    & ///
	  WorkerAge > 16
	

	replace `this_file_calculates' =    ///
	  (PAID_HOURS_WORKED/1800)           * /// 
	   0.5                              ///
	  if PAID_HOURS_WORKED / 1800 <= 1   & ///
	  WorkerAge <= 16                    & ///
	  WorkerAge > 14


	* If <= 14 it Hours should be 0, which is what it will be, 
        *   because it hasn't been replaced (changed from the 
        *   initialised value of 0).
	

	* Collapsing (summing) years won't make sense
	drop YE_AR

	qui do `dodir'/sub_do/do_collapse

        * Recalculate year for collapsed data
	gen int year = 1900 + `i'
	save temp`i', replace



	* Thats the non-casual labour calculated, but we need casual 
        *  labour too. That's simpler though. 

	import excel using raw`i'_head.xls ///
          , firstrow sheet("Sheet59") clear
	rename farm farmcode
	qui do `dodir'/sub_do/_renameSheet/renameSheet59.do
	
	
	gen int YE_AR = 1900 + `i'

	
	capture drop CasualLabourUnits
	gen CasualLabourUnits =  ///
	  (CASUAL_HOURS_WORKED/1800) * ///
	  CASUAL_LABOUR_UNIT_EQUIVALENT
	  
	
	
	* Drop and recreate year again (see above)
	drop YE_AR
	qui do `dodir'/sub_do/do_collapse
	gen int year = 1900 + `i'
	save tempcas`i'.dta, replace



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

* Append the temp files together
local i = 79
use tempcas`i'.dta, clear
save tempcas_appended.dta, replace
erase tempcas`i'.dta
local i = `i' + 1
while `i' < 84 {
	
	append using tempcas`i'.dta
	save tempcas_appended.dta, replace
	erase tempcas`i'.dta
	
	local i = `i' + 1

}



* Go back to the preserved dataset
restore



* Bring calculated variable into data. Not every farm has paid labour, so 
*  the using data will have fewer obs, but it's still 1:1 (one row is one
*  farm-year. 
merge 1:1 farmcode year using temp_appended.dta ///
   , nogen  keepusing(D_LABOUR_UNITS_PAID) 

merge 1:1 farmcode year using tempcas_appended.dta ///
   , nogen  keepusing(CasualLabourUnits) 

erase temp_appended.dta
erase tempcas_appended.dta



* But this still needs the Casual labour added in. 
replace `this_file_calculates' = 0 /// 
   if missing(`this_file_calculates')

replace CasualLabourUnits = 0 /// 
   if missing(CasualLabourUnits)


replace `this_file_calculates'= ///
 `this_file_calculates'         + ///
  CasualLabourUnits



replace `this_file_calculates' = 0 /// 
   if missing(`this_file_calculates')
label var `this_file_calculates' "Paid Farm Workers -- Annual Work Units"



* Add required variables to global list of required vars
global required_vars "$required_vars PAID_HOURS_WORKED"
global required_vars "$required_vars PAID_YEAR_BORN"
global required_vars "$required_vars YE_AR"

* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars) 


log using `this_file_calculates'.log, text replace




summ `this_file_calculates', detail
codebook `this_file_calculates' 

log close

cd `startdir' // return Stata to previous directory
