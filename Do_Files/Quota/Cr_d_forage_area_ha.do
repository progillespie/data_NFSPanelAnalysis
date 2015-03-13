*====================================================================
* Temporarily create terms of eq. to simplify formula
*====================================================================
capture drop d_pasture_adjusted_hay_silage_ha 

capture drop d_pasture_adjusted_hay_silage_ha 
gen d_pasture_adjusted_hay_silage_ha = d_pasture_adj_for_hay_silage_ha  
capture drop d_total_pasture_ha
gen d_total_pasture_ha = D_TOTAL_PASTURE_HA

capture drop pasture_equiv_rough_ha
gen pasture_equiv_rough_ha = PASTURE_EQUIV_ROUGH_HA

capture drop d_total_ha_equiv_commonage_ha
gen d_total_ha_equiv_commonage_ha =  ///
  (d_total_pasture_ha + pasture_equiv_rough_ha) - ///
  (d_adj_hectarage_of_silage_ha+  ///
   d_adjusted_hectarage_of_hay_ha)

capture drop d_total_livestock_units
gen d_total_livestock_units = ///
  d_dairy_livstk_units_inc_bulls + ///
  d_cattle_livestock_units       + ///
  d_sheep_livestock_units        + ///
  d_horses_livestock_units
  


* term1
*---------
local var "term1"
capture drop `var'
gen `var' = 0
replace `var' =                     ///
  d_pasture_adjusted_hay_silage_ha   + ///
  d_total_ha_equiv_commonage_ha
 
 


* term2
*---------
local var "term2"


capture drop `var'
gen `var' = 0
replace `var' =                     ///
  (d_dairy_livstk_units_inc_bulls  - ///
    d_dairy_lu_boarding_out )        / ///
  d_total_livestock_units              ///
                                    ///
  if d_total_livestock_units > 0

*was d_dairy_lvstck_units_incl_bulls in PRG original code



* term3
*---------
* Need yield adjusted variable
mvencode SIL_TOTAL_YIELD_TONNES d_adj_hectarage_of_silage_ha , mv(0) override
capture drop d_yield_adjusted_silage_ha 
gen d_yield_adjusted_silage_ha =                     ///
  SIL_TOTAL_YIELD_TONNES / d_adj_hectarage_of_silage_ha ///
                                                        ///
  if d_adj_hectarage_of_silage_ha > 0 

* originally d_sil_adjusted_ha, but d_adj_hectarage_of_silage_ha is the same (see IB formula)


local var "term3"
capture drop `var'
gen `var' = 0
replace `var' =                  ///
  sil_fed_dairy_tns_ha_1  /         ///
  d_yield_adjusted_silage_ha        ///
              ///
  if d_yield_adjusted_silage_ha > 0

* sil_fed_dairy_tns_ha_1 is (fed_dairy_tonnes_ha9230+fed_dairy_tonnes_ha9231) / ///



* term4
*---------
* Need yield adjusted variable
mvencode HAY_TOTAL_YIELD_TONNES d_adjusted_hectarage_of_hay_ha, mv(0) override
capture drop d_yield_adjusted_hay_ha 
gen d_yield_adjusted_hay_ha =                          ///
  HAY_TOTAL_YIELD_TONNES / d_adjusted_hectarage_of_hay_ha ///
              ///
  if d_adjusted_hectarage_of_hay_ha > 0 
  
* originally d_hay_adjusted_ha, but d_adjusted_hectarage_of_hay_ha is the same (see IB formula)


local var "term4"
capture drop `var'
gen `var' = 0
replace `var' =                  ///
  hay_fed_dairy_tns_ha_1  /         ///
  d_yield_adjusted_hay_ha           ///
              ///
  if d_yield_adjusted_hay_ha > 0
*hay_fed_dairy_tns_ha_1 is  (fed_dairy_tonnes_ha9220+fed_dairy_tonnes_ha9221) / ///


* term5
*---------
local var "term5"
capture drop `var'

* Initialise at 0
gen `var' = 0

* Create total by looping over codes
foreach term of varlist fdrbt_fed_dairy_tns_ha_1   /// 9060 + 9061
                       asil_fed_dairy_tns_ha_1    /// 9030 + 9031
                       mz_sil_fed_dairy_tns_ha_1  /// 9020 + 9021
                       mgolds_fed_dairy_tns_ha_1  /// 9050 + 9051
                       kale_fed_dairy_tns_ha_1    /// 9070 + 9071
                       rseed_fed_dairy_tns_ha_1   /// 9080 + 9081
                       sug_fed_dairy_tns_ha_1     {

  * Ensure var isn't missing
  replace `term' = 0 if missing(`term')
}

replace `var' =          ///
  fdrbt_fed_dairy_tns_ha_1  + /// 9060 + 9061
  (FED_DAIRY_TONNES_HA9040 + FED_DAIRY_TONNES_HA9041) + /// 904
  asil_fed_dairy_tns_ha_1   + /// 9030 + 9031
  mz_sil_fed_dairy_tns_ha_1 + /// 9020 + 9021
  mgolds_fed_dairy_tns_ha_1 + /// 9050 + 9051
  kale_fed_dairy_tns_ha_1   + /// 9070 + 9071
  rseed_fed_dairy_tns_ha_1  + /// 9080 + 9081
  sug_fed_dairy_tns_ha_1      //  8120 + 8121


*fdrbt_fed_dairy_tns_ha_1  906
*Turnips_mangles           904 <-- Cr_Alloc_Winter_WinterForage only allocates these to sheep. Leaving them out, though they are in the IB formula.
*asil_fed_dairy_tns_ha_1   903
*mz_sil_fed_dairy_tns_ha_1 902
*mgolds_fed_dairy_tns_ha_1 905
*kale_fed_dairy_tns_ha_1  907
*rseed_fed_dairy_tns_ha_1  908
*sug_fed_dairy_tns_ha_1    812


* term6
*---------
local var "term6"
capture drop `var'
gen `var' = 0
replace `var' =                                    ///
  (FED_DAIRY_TONNES_HA8110 + FED_DAIRY_TONNES_HA8111) / 7



* term7
*---------

* First check var exists for FED_DAIRY_TONNES for each 132? crop code
foreach i of numlist 0/9 {

  capture confirm variable FED_DAIRY_TONNES_HA132`i'                   
  if _rc != 0 gen FED_DAIRY_TONNES_HA132`i' = 0

}

* Then calc the last term
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
replace term5 = 0 if missing(term5)
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
