* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.



local startdir: pwd // Save current working directory location



* Move into the root of the variable's directory
local this_file_calculates "D_DAIRY_GROSS_OUTPUT_EU"
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
local nonexist_vlist "`nonexist_vlist' DAIRY_COWS_SH_BULLS_SUBSIDIES_EU"
local nonexist_vlist "`nonexist_vlist' SLAUGHTER_PREM_DAIRY_RECVD_TY_EU"



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



  * D_DAIRY_VALUE_DROPPED_CALVES_SOLD_TRANS_EU
  *    changed to
  * D_DAIRY_VALUE_DROPPED_CALVES_EU


  * SLAUGHTER_PREMIUM_DAIRY_PAYMENT_RECEIVED_TY_EU 
  *    changed to
  * SLAUGHTER_PREM_DAIRY_RECEIVED_TY_EU

capture drop `this_file_calculates'
gen  `this_file_calculates' =        ///
  D_TOTAL_MILK_PRODUCTION_EU                     +  ///
  D_DAIRY_VALUE_DROPPED_CALVES_EU                +  ///
  D_DAIRY_HERD_REPLACE_COST_EU                   +  ///
  DAIRY_COWS_SH_BULLS_SUBSIDIES_EU               +  ///
  SLAUGHTER_PREM_DAIRY_RECVD_TY_EU



replace `this_file_calculates' = 0 /// 
   if missing(`this_file_calculates')



* Add required variables to global list of required vars
global required_vars "$required_vars D_TOTAL_MILK_PRODUCTION_EU"
global required_vars "$required_vars D_DAIRY_VALUE_DROPPED_CALVES_EU"
global required_vars "$required_vars D_DAIRY_HERD_REPLACE_COST_EU"
global required_vars "$required_vars DAIRY_COWS_SH_BULLS_SUBSIDIES_EU"
global required_vars "$required_vars SLAUGHTER_PREM_DAIRY_RECVD_TY_EU"

* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars)



cd `startdir' // return Stata to previous directory
codebook `this_file_calculates'
summ `this_file_calculates', detail

di "This file calculates: `this_file_calculates'."
tabstat `this_file_calculates'  ///
  D_TOTAL_MILK_PRODUCTION_EU       ///
  D_DAIRY_VALUE_DROPPED_CALVES_EU  ///
  D_DAIRY_HERD_REPLACE_COST_EU     ///
  DAIRY_COWS_SH_BULLS_SUBSIDIES_EU ///
  SLAUGHTER_PREM_DAIRY_RECVD_TY_EU ///
  , by(year)
