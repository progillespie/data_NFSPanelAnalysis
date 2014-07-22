* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.


local startdir: pwd // Save current working directory location


* Move into the root of the variable's directory
local this_file_calculates "D_FORAGE_AREA_HA"
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
local nonexist_vlist "`nonexist_vlist' FED_DAIRY_TONNES_HA1320"
local nonexist_vlist "`nonexist_vlist' FED_DAIRY_TONNES_HA1321"
local nonexist_vlist "`nonexist_vlist' FED_DAIRY_TONNES_HA1322"
local nonexist_vlist "`nonexist_vlist' FED_DAIRY_TONNES_HA1323"
local nonexist_vlist "`nonexist_vlist' FED_DAIRY_TONNES_HA1324"
local nonexist_vlist "`nonexist_vlist' FED_DAIRY_TONNES_HA1325"
local nonexist_vlist "`nonexist_vlist' FED_DAIRY_TONNES_HA1326"
local nonexist_vlist "`nonexist_vlist' FED_DAIRY_TONNES_HA1327"
local nonexist_vlist "`nonexist_vlist' FED_DAIRY_TONNES_HA1328"
local nonexist_vlist "`nonexist_vlist' FED_DAIRY_TONNES_HA1329"



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

local vlist "`vlist' D_PASTURE_ADJUSTED_HAY_SILAGE_HA" 
local vlist "`vlist' D_TOTAL_HA_EQUIV_COMMONAGE_HA"
local vlist "`vlist' D_TOTAL_LIVESTOCK_UNITS"
local vlist "`vlist' D_DAIRY_LVSTCK_UNITS_INCL_BULLS"
local vlist "`vlist' D_DAIRY_LU_BOARDING_OUT"
local vlist "`vlist' D_YIELD_ADJUSTED_SILAGE_HA"
local vlist "`vlist' D_YIELD_ADJUSTED_HAY_HA"




foreach var of local vlist{

    * Ensure no missing values in the terms of the equation
    replace `var' = 0  if missing(`var')
  
}



*====================================================================
* Temporarily create terms of eq. to simplify formula
*====================================================================

* term1
*---------
local var "term1"
capture drop `var'
gen `var' = 0
replace `var' =                     ///
  D_PASTURE_ADJUSTED_HAY_SILAGE_HA   + ///
  D_TOTAL_HA_EQUIV_COMMONAGE_HA
 



* term2
*---------
local var "term2"


capture drop `var'
gen `var' = 0
replace `var' =                     ///
  ( D_DAIRY_LVSTCK_UNITS_INCL_BULLS  - ///
    D_DAIRY_LU_BOARDING_OUT )        / ///
  D_TOTAL_LIVESTOCK_UNITS              ///
                                    ///
  if D_TOTAL_LIVESTOCK_UNITS > 0


* term3
*---------
local var "term3"
capture drop `var'
gen `var' = 0
replace `var' =                                    ///
  (FED_DAIRY_TONNES_HA9230+FED_DAIRY_TONNES_HA9231) / ///
  D_YIELD_ADJUSTED_SILAGE_HA                          ///
                                                   ///
  if D_YIELD_ADJUSTED_SILAGE_HA > 0


* term4
*---------
local var "term4"
capture drop `var'
gen `var' = 0
replace `var' =                                    ///
  (FED_DAIRY_TONNES_HA9220+FED_DAIRY_TONNES_HA9221) / ///
  D_YIELD_ADJUSTED_HAY_HA                          ///
                                                   ///
  if D_YIELD_ADJUSTED_HAY_HA > 0


* term5
*---------
local var "term5"
capture drop `var'

* Initialise at 0
gen `var' = 0

* Create total by looping over codes
foreach code in 9061 9041 9031 9021 9051 9071 9081 8121 9060 9040 ///
                9030 9020 9050 9070 9080 8120 {

  * Ensure FED_DAIRY_TONNES_HAXXXX isn't missing
  replace FED_DAIRY_TONNES_HA`code' = 0 if ///
    missing(FED_DAIRY_TONNES_HA`code')

  * Then add to running total
  replace `var' =   ///
    `var'            + ///
    FED_DAIRY_TONNES_HA`code'

}



* term6
*---------
local var "term6"
capture drop `var'
gen `var' = 0
replace `var' =                                    ///
  (FED_DAIRY_TONNES_HA8110+FED_DAIRY_TONNES_HA8111) / 7


* term7
*---------
local var "term7"
capture drop `var'
gen `var' = 0
replace `var' =                              ///
  ( FED_DAIRY_TONNES_HA1320                   + ///
    FED_DAIRY_TONNES_HA1321                   + ///
    FED_DAIRY_TONNES_HA1322                   + ///
    FED_DAIRY_TONNES_HA1323                   + ///
    FED_DAIRY_TONNES_HA1324                   + ///
    FED_DAIRY_TONNES_HA1325                   + ///
    FED_DAIRY_TONNES_HA1326                   + ///
    FED_DAIRY_TONNES_HA1327                   + ///
    FED_DAIRY_TONNES_HA1328                   + ///
    FED_DAIRY_TONNES_HA1329 )                   ///
               /                                ///
  (CY_TOTAL_YIELD1321 / CY_HECTARES_HA1321)     ///
                                             ///
if CY_HECTARES_HA1321 > 0                     & ///
CY_TOTAL_YIELD1321/CY_HECTARES_HA1321 > 0


*====================================================================



* Be doubly sure that term vars have no missing values
replace term1 = 0 if missing(term1)
replace term2 = 0 if missing(term2)
replace term3 = 0 if missing(term3)
replace term4 = 0 if missing(term4)
replace term6 = 0 if missing(term6)
replace term7 = 0 if missing(term7)




capture drop `this_file_calculates'
gen double `this_file_calculates' =     ///
  term1 * ///
  term2   ///
    +     ///
  term3 + ///
  term4 + ///
  term5 + ///
  term6 + ///
  term7


replace `this_file_calculates' = 0 /// 
   if missing(`this_file_calculates')



* Add required variables to global list of required vars
global required_vars "$required_vars `vlist'"

* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars) 


log using `this_file_calculates'.log, text replace




summ `this_file_calculates', detail
codebook `this_file_calculates' 






log close

cd `startdir' // return Stata to previous directory
