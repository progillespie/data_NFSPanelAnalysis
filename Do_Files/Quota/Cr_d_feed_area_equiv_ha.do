*====================================================================
* Temporarily create terms of eq. to simplify formula
*====================================================================
* term2
*---------
local var "term2"

replace CONC_ALLOC_DAIRY_HERD_50KG_NO = 0 ///
  if missing(CONC_ALLOC_DAIRY_HERD_50KG_NO)

capture drop `var'
gen `var' = 0
replace `var' =                              ///
  (CONC_ALLOC_DAIRY_HERD_50KG_NO / 100)


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


* term5
*---------
local var "term5"

capture drop `var'
gen `var' = 0
replace `var' =                  ///
  (D_DAIRY_LU_BOARDING_NET        / ///
   D_FARM_TOTAL_LU_BOARDING_NET)  * /// 
  D_FARM_ADJUSTED_PASTURE           ///
                                 ///
  if D_FARM_TOTAL_LU_BOARDING_NET > 0


*====================================================================



* Be doubly sure that term vars have no missing values
replace term2 = 0 if missing(term2)
replace term3 = 0 if missing(term3)
replace term5 = 0 if missing(term5)



capture drop `this_file_calculates'
gen double `this_file_calculates' =    ///
  D_FORAGE_AREA_HA                      + ///
  term2                                 + ///
  term3                                 + ///
  D_PURCH_FEED_BULK_ALLOC_DAIRY_HA      + ///
  term5


