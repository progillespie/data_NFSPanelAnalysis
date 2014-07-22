* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.


local startdir: pwd // Save current working directory location


* Move into the root of the variable's directory
local this_file_calculates "D_MISC_OVERHEAD_COSTS_EU"
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

* The following vars are not in the 79 - 83 raw data.
* OTHER_FARM_INSURANCES_EU
* TEAGASC_ADVISORY_FEES_EU
* ACCOUNTANTS_CONSULTANTS_FEES_EU
* 
* We can calc. OTHER_MISC_EXPENSES_EU (assuming its 
*  the sum of the "in cash" and "in kind" variables),
*  but the var TOTAL_MISC_RECEIPTS_EU includes this figure
*  and possibly some others (not captured in their own vars)
*  , so we'll use this in the equation instead.




* Ensure no missing values in the terms of the equation
replace D_EXPENDITURE_ON_LIME_EU        = 0 /// 
   if missing(D_EXPENDITURE_ON_LIME_EU)

replace TOTAL_MISC_RECEIPTS_EU = 0 /// 
   if missing(TOTAL_MISC_RECEIPTS_EU)

replace BUILDINGS_FIRE_INSURANCE_EU = 0 /// 
   if missing(BUILDINGS_FIRE_INSURANCE_EU)

replace SLURRY_FYM_PURCH_VALUE_EU = 0 /// 
   if missing(SLURRY_FYM_PURCH_VALUE_EU)

* This equation has been edited
capture drop `this_file_calculates'
gen  `this_file_calculates' =    ///
 D_EXPENDITURE_ON_LIME_EU        + ///
 TOTAL_MISC_RECEIPTS_EU          + ///
 BUILDINGS_FIRE_INSURANCE_EU     + ///
 SLURRY_FYM_PURCH_VALUE_EU


/* Terms of the unedited equation
 D_EXPENDITURE_ON_LIME_EU        + ///
 ACCOUNTANTS_CONSULTANTS_FEES_EU + ///
 TEAGASC_ADVISORY_FEES_EU        + ///
 OTHER_FARM_INSURANCES_EU        + ///
 OTHER_MISC_EXPENSES_EU          + ///
 BUILDINGS_FIRE_INSURANCE_EU     + ///
 SLURRY_FYM_PURCH_VALUE_EU
*/ 

replace `this_file_calculates' = 0 /// 
   if missing(`this_file_calculates')



* Add required variables to global list of required vars
global required_vars "$required_vars D_EXPENDITURE_ON_LIME_EU"
global required_vars "$required_vars TOTAL_MISC_RECEIPTS_EU"
global required_vars "$required_vars BUILDINGS_FIRE_INSURANCE_EU"
global required_vars "$required_vars SLURRY_FYM_PURCH_VALUE_EU"

* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars)



cd `startdir' // return Stata to previous directory
summ `this_file_calculates', detail
codebook `this_file_calculates' 
