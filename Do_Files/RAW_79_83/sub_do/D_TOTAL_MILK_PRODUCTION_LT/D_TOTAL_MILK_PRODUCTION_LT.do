* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.


local startdir: pwd // Save current working directory location


* Move into the root of the variable's directory
local this_file_calculates "D_TOTAL_MILK_PRODUCTION_LT"
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



  
  


* List of terms of the equation. Ensure not missing.
local vlist "`vlist' WHOLE_MILK_SOLD_TO_CREAMERY_LT"
local vlist "`vlist' CREAMERY_FED_CALVES_LT"
local vlist "`vlist' CREAMERY_FED_PIGS_LT"
local vlist "`vlist' CREAMERY_FED_POULTRY_LT"
local vlist "`vlist' LqMilkSoldWSALE_LT"
local vlist "`vlist' LqMilkSoldRETAIL_LT"
local vlist "`vlist' ALLOW_WHOLE_MILK_HOUSE_LT"
local vlist "`vlist' ALLOW_WHOLE_MILK_WAGES_LT"
local vlist "`vlist' ALLOW_WHOLE_MILK_OTHER_LT"
local vlist "`vlist' ALLOW_OTHER_DAIRY_HOUSE_LT"
local vlist "`vlist' ALLOW_OTHER_DAIRY_WAGES_LT"

foreach var of local vlist{
    * Ensure no missing values in the terms of the equation
    replace `var' = 0 if missing(`var')
}



* Formula calls for var which is the sum of two of our raw vars
capture drop LQMILK_SOLD_WHOLESALE_RETAIL_LT 
gen LQMILK_SOLD_WHOLESALE_RETAIL_LT = 0 
replace LQMILK_SOLD_WHOLESALE_RETAIL_LT = ///
  LqMilkSoldWSALE_LT + LqMilkSoldRETAIL_LT



* Also ensure that this isn't missing.
local var "LQMILK_SOLD_WHOLESALE_RETAIL_LT"
replace `var' = 0 if missing(`var')



capture drop `this_file_calculates'
gen double `this_file_calculates' =    ///
  WHOLE_MILK_SOLD_TO_CREAMERY_LT      + ///
  CREAMERY_FED_CALVES_LT              + ///
  CREAMERY_FED_PIGS_LT                + ///
  CREAMERY_FED_POULTRY_LT             + ///
  LQMILK_SOLD_WHOLESALE_RETAIL_LT     + ///
  ALLOW_WHOLE_MILK_HOUSE_LT           + ///
  ALLOW_WHOLE_MILK_WAGES_LT           + ///
  ALLOW_WHOLE_MILK_OTHER_LT           + ///
  ALLOW_OTHER_DAIRY_HOUSE_LT          + ///
  ALLOW_OTHER_DAIRY_WAGES_LT



replace `this_file_calculates' = 0 /// 
   if missing(`this_file_calculates')



* Add required variables to global list of required vars
global required_vars "$required_vars WHOLE_MILK_SOLD_TO_CREAMERY_LT"
global required_vars "$required_vars CREAMERY_FED_CALVES_LT"
global required_vars "$required_vars CREAMERY_FED_PIGS_LT"
global required_vars "$required_vars CREAMERY_FED_POULTRY_LT"
global required_vars "$required_vars LqMilkSoldWSALE_LT"
global required_vars "$required_vars LqMilkSoldRETAIL_LT"
global required_vars "$required_vars ALLOW_WHOLE_MILK_HOUSE_LT"
global required_vars "$required_vars ALLOW_WHOLE_MILK_WAGES_LT"
global required_vars "$required_vars ALLOW_WHOLE_MILK_OTHER_LT"
global required_vars "$required_vars ALLOW_OTHER_DAIRY_HOUSE_LT"
global required_vars "$required_vars ALLOW_OTHER_DAIRY_WAGES_LT"

* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars) 


log using `this_file_calculates'.log, text replace




summ `this_file_calculates', detail
codebook `this_file_calculates' 


log close

cd `startdir' // return Stata to previous directory
