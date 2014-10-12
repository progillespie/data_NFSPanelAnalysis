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



capture drop d_forage_area_ha
gen double d_forage_area_ha = 0 
replace d_forage_area_ha =  ///
  term1 * ///
  term2   ///
    +     ///
  term3 + ///
  term4 + ///
  term5 + ///
  term6 + ///
  term7
