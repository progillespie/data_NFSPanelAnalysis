* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.


local startdir: pwd // Save current working directory location


* Move into the root of the variable's directory
local this_file_calculates "I_DAIRY_LU_HOME_GRAZING"
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
local vlist "`vlist' COMMONAGE_DY_CTLE1_ANIMALS_NO"
local vlist "`vlist' COMMONAGE_DY_CTLE2_ANIMALS_NO"
local vlist "`vlist' COMMONAGE_DY_CTLE3_ANIMALS_NO"
local vlist "`vlist' COMMONAGE_DY_CTLE1_DAYS_NO"
local vlist "`vlist' COMMONAGE_DY_CTLE2_DAYS_NO"
local vlist "`vlist' COMMONAGE_DY_CTLE3_DAYS_NO"
local vlist "`vlist' COMMONAGE_DY_CTLE1_LU_EQUIV"
local vlist "`vlist' COMMONAGE_DY_CTLE2_LU_EQUIV"
local vlist "`vlist' COMMONAGE_DY_CTLE3_LU_EQUIV"

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



capture drop COMMONAGE_DAIRY_ANIMALS_NO           
    gen COMMONAGE_DAIRY_ANIMALS_NO = 0
    replace COMMONAGE_DAIRY_ANIMALS_NO = ///
      (                                     ///
        COMMONAGE_DY_CTLE1_ANIMALS_NO     + ///
        COMMONAGE_DY_CTLE2_ANIMALS_NO     + ///
        COMMONAGE_DY_CTLE3_ANIMALS_NO     ///
      ) * alloc  


capture drop COMMONAGE_DAIRY_DAYS_NO 
    gen COMMONAGE_DAIRY_DAYS_NO = 0
    replace COMMONAGE_DAIRY_DAYS_NO =      ///
      (                                       ///
        COMMONAGE_DY_CTLE1_DAYS_NO          + ///
        COMMONAGE_DY_CTLE2_DAYS_NO          + ///
        COMMONAGE_DY_CTLE3_DAYS_NO          ///
      ) * alloc                    


capture drop COMMONAGE_DAIRY_LU_EQUIV
    gen COMMONAGE_DAIRY_LU_EQUIV= 0
    replace COMMONAGE_DAIRY_LU_EQUIV =     ///
      (                                       ///
        COMMONAGE_DY_CTLE1_LU_EQUIV         + ///
        COMMONAGE_DY_CTLE2_LU_EQUIV         + ///
        COMMONAGE_DY_CTLE3_LU_EQUIV         ///
      ) * alloc
*=======================================================================



* List of equation terms. Ensure not missing.
local vlist "`vlist' D_DAIRY_LVSTCK_UNITS_INCL_BULLS"
local vlist "`vlist' COMMONAGE_DAIRY_ANIMALS_NO"
local vlist "`vlist' COMMONAGE_DAIRY_DAYS_NO"
local vlist "`vlist' COMMONAGE_DAIRY_LU_EQUIV"
local vlist "`vlist' D_DAIRY_LU_BOARDING_OUT"
local vlist "`vlist' D_DAIRY_LU_BOARDING_IN"

foreach var of local vlist{

    * Ensure there's no missing value in these either
    replace `var' = 0  if missing(`var')
  
}



capture drop `this_file_calculates'
gen double `this_file_calculates' =  ///
  D_DAIRY_LVSTCK_UNITS_INCL_BULLS  - ///
  (                                  ///
    COMMONAGE_DAIRY_ANIMALS_NO        * ///
      (COMMONAGE_DAIRY_DAYS_NO / 365) * ///
    COMMONAGE_DAIRY_LU_EQUIV            ///
  )                -                    ///
  D_DAIRY_LU_BOARDING_OUT             + ///
  D_DAIRY_LU_BOARDING_IN



replace `this_file_calculates' = 0 /// 
   if missing(`this_file_calculates')



* Add required variables to global list of required vars
global required_vars "$required_vars D_DAIRY_LVSTCK_UNITS_INCL_BULLS"
global required_vars "$required_vars COMMONAGE_DAIRY_ANIMALS_NO"
global required_vars "$required_vars COMMONAGE_DAIRY_DAYS_NO"
global required_vars "$required_vars COMMONAGE_DAIRY_LU_EQUIV"
global required_vars "$required_vars D_DAIRY_LU_BOARDING_OUT"
global required_vars "$required_vars D_DAIRY_LU_BOARDING_IN"

* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars)



cd `startdir' // return Stata to previous directory
summ `this_file_calculates', detail
codebook `this_file_calculates' 
