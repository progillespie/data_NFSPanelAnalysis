*====================================================================
* Temporarily create terms of eq. to simplify formula
*====================================================================
* term2
*---------
local var "term2"
*
* Was CONC_ALLOC_DAIRY_HERD_50KG_NO in PRG original code
replace CONC_ALLC_DARY_HRD_50KGBGS_NO = 0 ///
  if missing(CONC_ALLC_DARY_HRD_50KGBGS_NO)

capture drop `var'
gen `var' = 0
replace `var' =                              ///
  (CONC_ALLC_DARY_HRD_50KGBGS_NO / 100)


* term3
*---------
local var "term3"
capture drop `var'
gen `var' = 0

qui ds FED_DAIRY_TONNES_HA????
local vlist "`r(varlist)'"
foreach term_var of local vlist {

    * Extract the crop code from the varname
    local code = substr("`term_var'", -4, .)



    * Check that it's a relevant crop code
    if [regexm("`code'", "111[0-9]") | ///
    	regexm("`code'", "115[0-9]") | ///
    	regexm("`code'", "114[0-9]") | ///
    	regexm("`code'", "157[0-9]") | ///
    	regexm("`code'", "131[0-9]") | ///
    	regexm("`code'", "132[0-9]") ] {


        * Create var if it doesn't exist
        local mkvar "FED_DAIRY_TONNES_HA`code'"
        capture confirm variable `mkvar'
        if _rc != 0 gen `mkvar' = 0

        local mkvar "CY_TOTAL_YIELD`code'"
        capture confirm variable `mkvar'
        if _rc != 0 gen `mkvar' = 0

        local mkvar "CY_SALES_QTY_TONNES_HA`code'"
        capture confirm variable `mkvar'
        if _rc != 0 gen `mkvar' = 0


        * Ensure missings are 0's  (too many to put on vlist)
        replace FED_DAIRY_TONNES_HA`code' = 0 ///
          if missing(FED_DAIRY_TONNES_HA`code')
        replace CY_TOTAL_YIELD`code' = 0 ///
          if missing(CY_TOTAL_YIELD`code')
        replace CY_SALES_QTY_TONNES_HA`code' = 0 ///
          if missing(CY_SALES_QTY_TONNES_HA`code')


        replace `var' =                              ///
          `var'                                       + /// 
          (                                          ///
            FED_DAIRY_TONNES_HA`code'                 / ///
            (CY_TOTAL_YIELD`code'                     / ///
             CY_SALES_QTY_TONNES_HA`code')              ///
          )                                          ///
                                                     ///
          if CY_SALES_QTY_TONNES_HA`code'   > 0       & ///
             (CY_TOTAL_YIELD`code' /                    ///
              CY_SALES_QTY_TONNES_HA`code') > 0

    }
}


foreach livesys in dairy cattle sheep horses {

  local mkvar "d_`livesys'_lu_boarding_net"
  capture drop `mkvar'
  gen `mkvar' = d_`livesys'_lu_boarding_out - d_`livesys'_lu_boarding_in
  replace `mkvar' = 0 if missing(`mkvar')

}


local mkvar "d_farm_total_lu_boarding_out "
capture drop `mkvar'
gen `mkvar' =  ///
  d_dairy_lu_boarding_out    + ///
  d_cattle_lu_boarding_out   + ///
  d_sheep_lu_boarding_out_no + ///
  d_horses_lu_boarding_out
replace `mkvar' = 0 if missing(`mkvar')


local mkvar "d_farm_total_lu_boarding_in "
capture drop `mkvar'
gen `mkvar' =  ///
  d_dairy_lu_boarding_in    + ///
  d_cattle_lu_boarding_in   + ///
  d_sheep_lu_boarding_in_no + ///
  d_horses_lu_boarding_in
replace `mkvar' = 0 if missing(`mkvar')


local mkvar "d_farm_total_lu_boarding_net"
capture drop `mkvar'
gen `mkvar' = d_farm_total_lu_boarding_out - d_farm_total_lu_boarding_in
replace `mkvar' = 0 if missing(`mkvar')


local mkvar "d_farm_total_lu_on_commage_no"
capture drop `mkvar'
gen `mkvar' = ///
  (COMMONAGE_DAIRY_ANIMALS_NO      *   /// 
   COMMONAGE_DAIRY_DAYS_NO   / 365 *   /// 
   COMMONAGE_DAIRY_LU_EQUIV   )        /// 
                   +              /// 
  (COMMONAGE_CATTLE1_ANIMALS_NO    *   /// 
   COMMONAGE_CATTLE1_DAYS_NO / 365 *   /// 
   COMMONAGE_CATTLE1_LU_EQUIV )        /// 
                     +              /// 
  (COMMONAGE_CATTLE2_ANIMALS_NO    *   ///    
   COMMONAGE_CATTLE2_DAYS_NO / 365 *   /// 
   COMMONAGE_CATTLE2_LU_EQUIV )        /// 
                     +              /// 
  (COMMONAGE_SHEEP1_ANIMALS_NO     *   /// 
   COMMONAGE_SHEEP1_DAYS_NO  / 365 *   ///
   COMMONAGE_SHEEP1_LU_EQUIV  )        /// 
                     +              /// 
  (COMMONAGE_SHEEP2_ANIMALS_NO     *   ///  
   COMMONAGE_SHEEP2_DAYS_NO  / 365 *   /// 
   COMMONAGE_SHEEP2_LU_EQUIV  )        /// 
                     +              /// 
  (COMMONAGE_HORSES_ANIMALS_NO     *   /// 
   COMMONAGE_HORSES_DAYS_NO  / 365 *   /// 
   COMMONAGE_HORSES_LU_EQUIV  )
replace `mkvar' = 0 if missing(`mkvar')



local mkvar "d_farm_adjusted_pasture"
capture drop `mkvar'
gen `mkvar' =  (                                 ///
                 (d_pasture_adj_for_hay_silage_ha + /// ok
                  d_total_ha_equiv_commonage_ha)    /// ok
                               /                 ///
                 (d_total_livestock_units         + /// ok
                  d_farm_total_lu_on_commage_no   + /// ok
                  d_farm_total_lu_boarding_net )    ///
               ) * d_farm_total_lu_boarding_net
replace `mkvar' = 0 if missing(`mkvar')



/*

Local mkvar ""
capture drop `mkvar'
gen `mkvar' = 
replace `mkvar' = 0 if missing(`mkvar')
*/

* term5
*---------
local var "term5"

capture drop `var'
gen `var' = 0
replace `var' =                  ///
  (d_dairy_lu_boarding_net        / ///
   d_farm_total_lu_boarding_net)  * /// 
  d_farm_adjusted_pasture           ///
                                 ///
  if d_farm_total_lu_boarding_net > 0


*====================================================================



* Be doubly sure that term vars have no missing values
replace term2 = 0 if missing(term2)
replace term3 = 0 if missing(term3)
replace term5 = 0 if missing(term5)


local mkvar "d_feed_area_equiv_ha"
capture drop `mkvar'
gen double `mkvar' =                   ///
  d_forage_area_ha                      + ///
  term2                                 + ///
  term3                                 + ///
  d_purch_feed_bulk_alloc_dairy_ha      + ///
  term5

mvencode `mkvar', mv(0) override
