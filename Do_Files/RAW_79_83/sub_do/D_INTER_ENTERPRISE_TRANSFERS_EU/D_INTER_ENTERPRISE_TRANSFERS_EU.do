* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.



local startdir: pwd // Save current working directory location



* Move into the root of the variable's directory
local this_file_calculates "D_INTER_ENTERPRISE_TRANSFERS_EU"
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



* Create sum of HOME_GROWN_SEED_VALUE_EU for all crops
capture drop ALL_HOME_GROWN_SEED_VALUE_EU
gen ALL_HOME_GROWN_SEED_VALUE_EU = 0


foreach var of varlist HOME_GROWN_SEED_VALUE_EU???? {
	
	* Deal with missing values before adding
	qui replace `var' = 0 if missing(`var')

	di "Adding in `var'"
		replace ALL_HOME_GROWN_SEED_VALUE_EU = ///
	 	 ALL_HOME_GROWN_SEED_VALUE_EU  + `var'

}



capture drop `this_file_calculates'
gen  `this_file_calculates' =   ///
 D_MILK_FED_TO_LIVESTOCK_EU      + ///
 D_CASH_CROPS_FED_EU             + ///
 ALL_HOME_GROWN_SEED_VALUE_EU 



replace `this_file_calculates' = 0 /// 
   if missing(`this_file_calculates')



* Add required variables to global list of required vars
global required_vars "$required_vars D_MILK_FED_TO_LIVESTOCK_EU"
global required_vars "$required_vars D_CASH_CROPS_FED_EU"
global required_vars "$required_vars ALL_HOME_GROWN_SEED_VALUE_EU"

* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars) 


log using `this_file_calculates'.log, text replace




codebook `this_file_calculates'
summ `this_file_calculates', detail

di "This file calculates: `this_file_calculates'."
tabstat `this_file_calculates'  ///
 D_MILK_FED_TO_LIVESTOCK_EU        ///
 D_CASH_CROPS_FED_EU               ///
 ALL_HOME_GROWN_SEED_VALUE_EU      ///
 , by(year)

log close

cd `startdir' // return Stata to previous directory
