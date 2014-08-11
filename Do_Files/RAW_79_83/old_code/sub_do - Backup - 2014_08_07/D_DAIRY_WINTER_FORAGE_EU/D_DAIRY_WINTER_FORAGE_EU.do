* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.


local startdir: pwd // Save current working directory location


* Move into the root of the variable's directory
local this_file_calculates "D_DAIRY_WINTER_FORAGE_EU"
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

/*
* TEMPORARY FIX... for testing only
capture gen I_SILAGE_FED_UNIT_COST        = 1
capture gen I_HAY_FED_UNIT_COST           = 1
capture gen I_ARABLE_SILAGE_FED_UNIT_COST = 1
capture gen I_FODDER_BEET_FED_UNIT_COST   = 1
capture gen I_SUGAR_BEET_FED_UNIT_COST    = 1
capture gen I_MAIZE_SILAGE_FED_UNIT_COST  = 1
capture gen I_OAT_IN_SHEAF_FED_UNIT_COST  = 1
capture gen I_MANGOLDS_FED_UNIT_COST      = 1
capture gen I_RAPE_SEED_FED_UNIT_COST     = 1
capture gen I_STRAW_FED_UNIT_COST         = 1
capture gen I_SUGAR_FED_UNIT_COST         = 1
capture gen I_KALE_FED_UNIT_COST          = 1
*/


*====================================================================
* Create terms for the equation (makes it simpler to read)
*====================================================================
* term1
*---------
local var "term1"
capture drop `var'
gen `var' = 0
replace `var' =                              ///
  (ALLOC_DAIRY_HERD_QTY / BULKYFEED_QUANTITY) * /// 
  BULKYFEED_COST_EU                             ///
  if BULKYFEED_QUANTITY > 0


* term2
*---------
local var "term2"
capture drop `var'
gen `var' = 0
capture confirm variable FED_DAIRY_TONNES_HA9230
if _rc==0 {
    replace `var' =                          ///
      I_SILAGE_FED_UNIT_COST                  * ///
      (FED_DAIRY_TONNES_HA9230 + FED_DAIRY_TONNES_HA9231)
}


* term3
*---------
local var "term3"
capture drop `var'
gen `var' = 0
capture confirm variable FED_DAIRY_TONNES_HA9220
if _rc==0 {
replace `var' =                              ///
  I_HAY_FED_UNIT_COST                         * ///
  (FED_DAIRY_TONNES_HA9220 + FED_DAIRY_TONNES_HA9221)
}


* term4
*---------
local var "term4"
capture drop `var'
gen `var' = 0
capture confirm variable FED_DAIRY_TONNES_HA9030
if _rc==0 {
    replace `var' =                          ///
      I_ARABLE_SILAGE_FED_UNIT_COST           * ///
      (FED_DAIRY_TONNES_HA9030 + FED_DAIRY_TONNES_HA9031)
}


* term5
*---------
local var "term5"
capture drop `var'
gen `var' = 0
capture confirm variable FED_DAIRY_TONNES_HA9060
if _rc==0 {
	replace `var' =                      ///
	  I_FODDER_BEET_FED_UNIT_COST         * ///
	  (FED_DAIRY_TONNES_HA9060 + FED_DAIRY_TONNES_HA9061)
}


* term6
*---------
local var "term6"
capture drop `var'
gen `var' = 0
capture confirm variable FED_DAIRY_TONNES_HA1320
if _rc==0 {
	replace `var' =                      ///
	  I_SUGAR_BEET_FED_UNIT_COST          * ///
	  (FED_DAIRY_TONNES_HA1320 + FED_DAIRY_TONNES_HA1321)
}


* term7
*---------
local var "term7"
capture drop `var'
gen `var' = 0
capture confirm variable FED_DAIRY_TONNES_HA9020
if _rc==0 {
	replace `var' =                      ///
	  I_MAIZE_SILAGE_FED_UNIT_COST        * ///
	  (FED_DAIRY_TONNES_HA9020 + FED_DAIRY_TONNES_HA9021)
}


* term8
*---------
local var "term8"
capture drop `var'
gen `var' = 0
capture confirm variable FED_DAIRY_TONNES_HA9010
if _rc==0 {
	replace `var' =                      ///
	  I_OAT_IN_SHEAF_FED_UNIT_COST        * ///
	  (FED_DAIRY_TONNES_HA9010 + FED_DAIRY_TONNES_HA9011)
}


* term9
*---------
local var "term9"
capture drop `var'
gen `var' = 0
capture confirm variable FED_DAIRY_TONNES_HA9050
if _rc==0 {
	replace `var' =                      ///
	  I_MANGOLDS_FED_UNIT_COST            * ///
	  (FED_DAIRY_TONNES_HA9050 + FED_DAIRY_TONNES_HA9051)
}


* term10
*---------
local var "term10"
capture drop `var'
gen `var' = 0
capture confirm variable FED_DAIRY_TONNES_HA9080
if _rc==0 {
	replace `var' =                      ///
	  I_RAPE_SEED_FED_UNIT_COST           * ///
	  (FED_DAIRY_TONNES_HA9080 + ///
           FED_DAIRY_TONNES_HA9081 + ///
           FED_DAIRY_TONNES_HA9083)
}

* term11
*---------
local var "term11"
capture drop `var'
gen `var' = 0 
capture confirm variable FED_DAIRY_TONNES_HA8110
if _rc==0 {
	replace `var' =                      ///
	  I_STRAW_FED_UNIT_COST               * ///
	  (FED_DAIRY_TONNES_HA8110 + FED_DAIRY_TONNES_HA8111)
}


* term12
*---------
local var "term12"
capture drop `var'
gen `var' = 0
capture confirm variable FED_DAIRY_TONNES_HA8120
if _rc==0 {
	replace `var' =                      ///
	  I_SUGAR_FED_UNIT_COST               * ///
	  (FED_DAIRY_TONNES_HA8120 + FED_DAIRY_TONNES_HA8121)
}


* term13
*---------
local var "term13"
capture drop `var'
gen `var' = 0
capture confirm variable FED_DAIRY_TONNES_HA9070
if _rc==0 {
	replace `var' =                      ///
	  I_KALE_FED_UNIT_COST                * ///
	  (FED_DAIRY_TONNES_HA9070 + FED_DAIRY_TONNES_HA9071)
}


* term14
*---------
local var "term14"
capture drop `var'
gen `var' = 0

local `var'_codes ///
  "`term14_codes' 1270 1271 1272 1273 1274 1275 1276 1277 1278 1279"

local `var'_codes ///
  "`term14_codes' 1290 1291 1292 1293 1294 1295 1296 1297 1298 1299"

macro list _`var'_codes 

foreach code of local `var'_codes {

    capture confirm variable FED_DAIRY_TONNES_HA`code'
    if _rc==0 {

        * Change term vars to 0 if missing
        local term_var "FED_DAIRY_TONNES_HA`code'"
        replace `term_var' =0 if missing(`term_var')
    
        local term_var "FED_TOTAL_TONNES_HA`code'"
        replace `term_var' =0 if missing(`term_var')
    
        local term_var "OP_INV_FED_VALUE_EU1270"
        replace `term_var' =0 if missing(`term_var')
    
        local term_var "OP_INV_FED_VALUE_EU1290"
        replace `term_var' =0 if missing(`term_var')
    
        local term_var "CY_FED_VALUE_EU1271"
        replace `term_var' =0 if missing(`term_var')
    
        local term_var "CY_FED_VALUE_EU1291"
        replace `term_var' =0 if missing(`term_var')


        * Calculate term by adding to var in each pass of the loop
	replace `var' =                    ///
	   `var'                              /// Add to subtotal
	                   +                  /// ----------------
	  (                                ///
	    (                              ///
	      FED_DAIRY_TONNES_HA`code'     / /// Create code 
	      FED_TOTAL_TONNES_HA`code'       ///  specific ratio
	                                   ///
	    )                *                /// ---------------
	                                   ///
	    (                              ///    Which you mult.
	      OP_INV_FED_VALUE_EU1270       + ///   by the same 
	      OP_INV_FED_VALUE_EU1290       + ///   sum of open &
	      CY_FED_VALUE_EU1271           + ///   closing stocks
	      CY_FED_VALUE_EU1291             ///
	    )                              ///
	  )                                ///--------------------
	  if FED_TOTAL_TONNES_HA`code'>0 // no change if 0 divisor
    }
} 

* term15
*---------
local var "term15"
capture drop `var'
gen `var' = 0
local `var'_codes ///
  "1310 1311 1312 1313 1314 1315 1316 1317 1318 1319" ///

macro list _`var'_codes 

foreach code of local `var'_codes {

    capture confirm variable FED_DAIRY_TONNES_HA`code'
    if _rc==0 {

        * Change term vars to 0 if missing
	local term_var "FED_DAIRY_TONNES_HA`code'"
        replace `term_var' =0 if missing(`term_var')

	local term_var "FED_TOTAL_TONNES_HA`code'"
        replace `term_var' =0 if missing(`term_var')

	local term_var "OP_INV_FED_VALUE_EU1310"
        replace `term_var' =0 if missing(`term_var')

	local term_var "CY_FED_VALUE_EU1311"
        replace `term_var' =0 if missing(`term_var')


        * Calculate term by adding to var in each pass of the loop
	replace `var' =                    ///
	   `var'                              /// Add to subtotal
	                   +                  /// ----------------
	  (                                ///
	    (                              ///
	      FED_DAIRY_TONNES_HA`code'     / /// Create code 
	      FED_TOTAL_TONNES_HA`code'       ///  specific ratio
	                                   ///
	    )                *                /// ---------------
	                                   ///
	    (                              ///    Which you mult.
	      OP_INV_FED_VALUE_EU1310       + ///   by the same 
	      CY_FED_VALUE_EU1311             ///   closing stocks
	    )                              ///
	  )                                ///--------------------
	  if FED_TOTAL_TONNES_HA`code'>0 // no change if 0 divisor
    }	
}

*====================================================================



* List of eq terms. Ensure that missing are set to 0.
local vlist "`vlist' term1"
local vlist "`vlist' term2"
local vlist "`vlist' term3"
local vlist "`vlist' term4"
local vlist "`vlist' term5"
local vlist "`vlist' term6"
local vlist "`vlist' term7"
local vlist "`vlist' term8"
local vlist "`vlist' term9"
local vlist "`vlist' term10"
local vlist "`vlist' term11"
local vlist "`vlist' term12"
local vlist "`vlist' term13"
local vlist "`vlist' term14"
local vlist "`vlist' term15"

foreach var of local vlist{

    * Ensure no missing values in the terms of the equation
    replace `var' = 0  if missing(`var')
  
}



capture drop `this_file_calculates'
gen double `this_file_calculates' =    ///
  term1                                + ///
  term2                                + ///
  term3                                + ///
  term4                                + ///
  term5                                + ///
  term6                                + ///
  term7                                + ///
  term8                                + ///
  term9                                + ///
  term10                               + ///
  term11                               + ///
  term12                               + ///
  term13                               + ///
  term14                               + ///
  term15




replace `this_file_calculates' = 0 /// 
   if missing(`this_file_calculates')



* Add required variables to global list of required vars
global required_vars "$required_vars "

* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars) 


log using `this_file_calculates'.log, text replace




summ `this_file_calculates', detail
codebook `this_file_calculates' 

tabstat `this_file_calculates' term1-term15, by(year)

quietly {
* Cleaning up
drop term1
drop term2
drop term3
drop term4
drop term5
drop term6
drop term7
drop term8
drop term9
drop term10
drop term11
drop term12
drop term13
drop term14
drop term15
}

log close

cd `startdir' // return Stata to previous directory
