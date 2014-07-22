* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.


local startdir: pwd // Save current working directory location


* Move into the root of the variable's directory
local this_file_calculates "D_HAY_TOTAL_DIRECT_COST_EU"
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



* Calculate var not derived var, but not in historical data. 
local code = 9221
capture drop ALLOCATED_TO_CROP_EU`code'
gen ALLOCATED_TO_CROP_EU`code' = 0
local i = 1
while `i' < 7 {

	replace ALLOCATED_TO_CROP_EU`code' = ///
	  ALLOCATED_TO_CROP_EU`code'           + /// 
	  ALLOCATED_TO_CROP`i'_EU                ///
	  if CROP`i'_CODE == `code'

	local i = `i' + 1

}



local vlist "`vlist' D_HAY_FERTILISER_COST_EU"
local vlist "`vlist' ALLOCATED_TO_CROP_EU9221"
local vlist "`vlist' I_TOTAL_HOME_GROWN_SEED_EU9221"


foreach var of local vlist{

    * Ensure no missing values in the terms of the equation
    replace `var' = 0  if missing(`var')
  
}



capture drop `this_file_calculates'
gen double `this_file_calculates' =    ///
  D_HAY_FERTILISER_COST_EU              + ///
  ALLOCATED_TO_CROP_EU9221              + ///
  I_TOTAL_HOME_GROWN_SEED_EU9221






replace `this_file_calculates' = 0 /// 
   if missing(`this_file_calculates')



* Add required variables to global list of required vars
global required_vars "$required_vars `vlist'"

* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars)



cd `startdir' // return Stata to previous directory
summ `this_file_calculates', detail
codebook `this_file_calculates' 
