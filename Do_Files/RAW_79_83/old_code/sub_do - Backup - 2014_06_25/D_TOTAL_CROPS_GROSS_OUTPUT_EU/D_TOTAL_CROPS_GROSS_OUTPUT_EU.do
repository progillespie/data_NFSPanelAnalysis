* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.



local startdir: pwd // Save current working directory location



* Move into the root of the variable's directory
local this_file_calculates "D_TOTAL_CROPS_GROSS_OUTPUT_EU"
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


* D_OUTPUT_INV_MISC_CASH_CROP_EU is currently incorrect
*  Set to 0 to ignore it for now.
replace D_OUTPUT_INV_MISC_CASH_CROP_EU = 0     

capture drop `this_file_calculates'
gen  `this_file_calculates' =       ///
 D_GROSS_OUTPUT_FDR_CROPS_SOLD_EU    + /// 
 D_OUTPUT_INV_MISC_CASH_CROP_EU      + /// 
 D_OUTPUT_CURRENT_MISC_CASH_CROP

 





replace `this_file_calculates' = 0 /// 
   if missing(`this_file_calculates')



* Add required variables to global list of required vars
global required_vars "$required_vars D_GROSS_OUTPUT_FODDER_CROPS_SOLD_EU"
global required_vars "$required_vars D_OUTPUT_FROM_INV_MISC_CASH_CROP_EU"
global required_vars "$required_vars D_OUTPUT_FROM_CURRENT_MISC_CASH_CROP"

* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars)



cd `startdir' // return Stata to previous directory
codebook `this_file_calculates'
summ `this_file_calculates', detail

di "This file calculates: `this_file_calculates'."
di "NOTE: Eq.s for terms of D_OUTPUT_INV_MISC_CASH_CROP_EU are incorrect."
di "      Therefore, D_OUTPUT_INV_MISC_CASH_CROP_EU has been set to 0." 
tabstat `this_file_calculates'  ///
 D_GROSS_OUTPUT_FDR_CROPS_SOLD_EU      /// 
 D_OUTPUT_INV_MISC_CASH_CROP_EU        /// 
 D_OUTPUT_CURRENT_MISC_CASH_CROP       ///
 , by(year)
