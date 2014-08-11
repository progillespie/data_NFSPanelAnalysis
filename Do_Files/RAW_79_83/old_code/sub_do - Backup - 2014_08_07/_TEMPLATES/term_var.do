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
