* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.


local startdir: pwd // Save current working directory location


* Move into the root of the variable's directory
local this_file_calculates "D_SETASIDE_TOTAL_PAY_RECD"
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
local nonexist_vlist "`nonexist_vlist' ARABLE_AID_SETASIDE_CURR_YEAR_EU"
local nonexist_vlist "`nonexist_vlist' ARABLE_AID_SETASIDE_PREV_YEAR_EU"



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



capture drop `this_file_calculates'
gen  `this_file_calculates' =    ///
  ARABLE_AID_SETASIDE_CURR_YEAR_EU + ///
  ARABLE_AID_SETASIDE_PREV_YEAR_EU



replace `this_file_calculates' = 0 /// 
   if missing(`this_file_calculates')



* Add required variables to global list of required vars
global required_vars "$required_vars ARABLE_AID_SETASIDE_CURR_YEAR_EU"
global required_vars "$required_vars ARABLE_AID_SETASIDE_PREV_YEAR_EU"

* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars) 


log using `this_file_calculates'.log, text replace




summ `this_file_calculates', detail
codebook `this_file_calculates' 

log close

cd `startdir' // return Stata to previous directory
