* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.


local startdir: pwd // Save current working directory location


* Move into the root of the variable's directory
local this_file_calculates "D_DAIRY_PASTURE_EU"
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



* List of rough derivation terms. Ensure not missing.
local vlist "`vlist' MTH12_TOTAL_DAIRY_COWS_NO"
local vlist "`vlist' MTH12_TOTAL_DAIRY_STOCK_BULLS_NO"
local vlist "`vlist' MTH12_TOTAL_ALL_CATTLE_NO"
local vlist "`vlist' BOARDING_OUT_DAIRY_CATTLE1_EU"
local vlist "`vlist' BOARDING_OUT_DAIRY_CATTLE2_EU"
local vlist "`vlist' BOARDING_OUT_DAIRY_CATTLE3_EU"
local vlist "`vlist' BOARDING_IN_DAIRY_CATTLE1_EU"
local vlist "`vlist' BOARDING_IN_DAIRY_CATTLE2_EU"
local vlist "`vlist' BOARDING_IN_DAIRY_CATTLE3_EU"
        
foreach var of local vlist{

    * Ensure no missing values in the terms of the equation
    replace `var' = 0 if missing(`var')

}



*=======================================================================
* Rough derivation of COMMONAGE vars for Dairy only
*=======================================================================
capture drop alloc
gen alloc = ///
(MTH12_TOTAL_DAIRY_COWS_NO         + ///
 MTH12_TOTAL_DAIRY_STOCK_BULLS_NO    ///
)                  /                 ///
 MTH12_TOTAL_ALL_CATTLE_NO


local var "BOARDING_OUT_DAIRY_EU"
capture drop `var'
    gen `var' = 0
    replace `var' = ///
      (                                     ///
        BOARDING_OUT_DAIRY_CATTLE1_EU        + ///
        BOARDING_OUT_DAIRY_CATTLE2_EU        + ///
        BOARDING_OUT_DAIRY_CATTLE3_EU        ///
      ) * alloc  


local var "BOARDING_IN_DAIRY_EU"
capture drop `var'
    gen `var' = 0
    replace `var' = ///
      (                                       ///
        BOARDING_IN_DAIRY_CATTLE1_EU           + ///
        BOARDING_IN_DAIRY_CATTLE2_EU           + ///
        BOARDING_IN_DAIRY_CATTLE3_EU           ///
      ) * alloc                    
*=======================================================================



* List of equation's terms
local vlist "`vlist' I_DAIRY_LU_HOME_GRAZING"
local vlist "`vlist' I_TOTAL_LU_HOME_GRAZING"
local vlist "`vlist' D_GRAZING_TOTAL_DIRECT_COSTS_EU"
local vlist "`vlist' BOARDING_OUT_DAIRY_EU"
local vlist "`vlist' BOARDING_IN_DAIRY_EU"
        
foreach var of local vlist{

    * Ensure no missing values in the terms of the equation
    replace `var' = 0 if missing(`var')

}



capture drop `this_file_calculates'
gen  `this_file_calculates' =   ///
(                               ///
 I_DAIRY_LU_HOME_GRAZING         / ///
 I_TOTAL_LU_HOME_GRAZING           ///
)                  *               ///
D_GRAZING_TOTAL_DIRECT_COSTS_EU  + ///
                                ///
BOARDING_OUT_DAIRY_EU            - ///
BOARDING_IN_DAIRY_EU


replace `this_file_calculates' = 0 /// 
   if missing(`this_file_calculates')



* Add required variables to global list of required vars
global required_vars "$required_vars I_DAIRY_LU_HOME_GRAZING"
global required_vars "$required_vars I_TOTAL_LU_HOME_GRAZING"
global required_vars "$required_vars D_GRAZING_TOTAL_DIRECT_COSTS_EU"
global required_vars "$required_vars BOARDING_OUT_DAIRY_EU"
global required_vars "$required_vars BOARDING_IN_DAIRY_EU"

* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars)



cd `startdir' // return Stata to previous directory
summ `this_file_calculates', detail
codebook `this_file_calculates' 
