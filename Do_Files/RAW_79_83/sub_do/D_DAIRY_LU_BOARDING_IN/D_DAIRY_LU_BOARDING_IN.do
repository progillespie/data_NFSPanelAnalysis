* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.


local startdir: pwd // Save current working directory location


* Move into the root of the variable's directory
local this_file_calculates "D_DAIRY_LU_BOARDING_IN"
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



local vlist "`vlist' MTH12_TOTAL_DAIRY_COWS_NO"
local vlist "`vlist' MTH12_TOTAL_DAIRY_STOCK_BULLS_NO"
local vlist "`vlist' MTH12_TOTAL_ALL_CATTLE_NO"
local vlist "`vlist' BOARDING_IN_DAIRY_CATTLE1_NO"
local vlist "`vlist' BOARDING_IN_DAIRY_CATTLE2_NO"
local vlist "`vlist' BOARDING_IN_DAIRY_CATTLE3_NO"
local vlist "`vlist' BOARDING_IN_DAIRY_CATTLE1_DAYS"
local vlist "`vlist' BOARDING_IN_DAIRY_CATTLE2_DAYS"
local vlist "`vlist' BOARDING_IN_DAIRY_CATTLE3_DAYS"

foreach var of local vlist{

    * Ensure no missing values in the terms of the equation
    replace `var' = 0  if missing(`var')
  
}



*=======================================================================
* Rough derivation of Boarding out vars for Dairy only
*=======================================================================
capture drop alloc
gen alloc = ///
(MTH12_TOTAL_DAIRY_COWS_NO         + ///
 MTH12_TOTAL_DAIRY_STOCK_BULLS_NO    ///
)                  /                 ///
 MTH12_TOTAL_ALL_CATTLE_NO



capture drop BOARDING_IN_DAIRY_ANIMALS_NO           
    gen BOARDING_IN_DAIRY_ANIMALS_NO = 0
    replace BOARDING_IN_DAIRY_ANIMALS_NO = ///
      (                                     ///
        BOARDING_IN_DAIRY_CATTLE1_NO        + ///
        BOARDING_IN_DAIRY_CATTLE2_NO        + ///
        BOARDING_IN_DAIRY_CATTLE3_NO          ///
      ) * alloc  


capture drop BOARDING_IN_DAIRY_DAYS_NO 
    gen BOARDING_IN_DAIRY_DAYS_NO = 0
    replace BOARDING_IN_DAIRY_DAYS_NO =      ///
      (                                       ///
        BOARDING_IN_DAIRY_CATTLE1_DAYS        + ///
        BOARDING_IN_DAIRY_CATTLE2_DAYS        + ///
        BOARDING_IN_DAIRY_CATTLE3_DAYS          ///
      ) * alloc



local vlist "`vlist' BOARDING_IN_DAIRY_ANIMALS_NO"
local vlist "`vlist' BOARDING_IN_DAIRY_DAYS_NO"

foreach var of local vlist{

    * Ensure there's no missing value in these either
    replace `var' = 0  if missing(`var')
  
}

*=======================================================================





capture drop `this_file_calculates'
gen double `this_file_calculates' =      ///
  BOARDING_IN_DAIRY_ANIMALS_NO           * ///
  (BOARDING_IN_DAIRY_DAYS_NO / 365)      * 1



replace `this_file_calculates' = 0 /// 
   if missing(`this_file_calculates')



* Add required variables to global list of required vars
global required_vars "`required_vars' BOARDING_IN_DAIRY_ANIMALS_NO"
global required_vars "`required_vars' BOARDING_IN_DAIRY_DAYS_NO"

* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars) 


log using `this_file_calculates'.log, text replace




summ `this_file_calculates', detail
codebook `this_file_calculates' 


log close

cd `startdir' // return Stata to previous directory
