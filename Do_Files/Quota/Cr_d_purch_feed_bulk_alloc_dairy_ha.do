*====================================================================
* Create term vars to simplify equation
*====================================================================


local varstokeep ""
local varstokeep "`varstokeep' ALLOC_DAIRY_HERD_QTY"
local varstokeep "`varstokeep' HAY_TOTAL_YIELD_TONNES"
local varstokeep "`varstokeep' SIL_TOTAL_YIELD_TONNES"
local varstokeep "`varstokeep' d_adjusted_hectarage_of_hay_ha"
local varstokeep "`varstokeep' d_adj_hectarage_of_silage_ha"


* Keep only obs with relevant bulky feed codes
keep if [regexm(string(BULKYFEED_CODE), "13[1-2]" ) |  ///
         regexm(string(BULKYFEED_CODE), "81[1-2]" ) |  ///
         regexm(string(BULKYFEED_CODE), "90[0-9]" ) |  ///
         regexm(string(BULKYFEED_CODE), "92[2-3]" ) |  ///
         regexm(string(BULKYFEED_CODE), "93[1-3]" ) |  ///
         regexm(string(BULKYFEED_CODE), "955"     ) |  ///
         regexm(string(BULKYFEED_CODE), "980"     ) ]



local sumlist "`sumlist'"
* Loop over the vars specified above
foreach var of local varstokeep {

  * Build list of vars to sum in the collapse command at the end  
  if "`var'" == "ALLOC_DAIRY_HERD_QTY" ///
       local sumlist "`sumlist ' (sum) `var'???"

  else local sumlist "`sumlist ' (mean) `var'"
    * The other vars in varstokeep are from data with 1 ob per farm-year
    *   which started repeating when merged with this data (multi. obs
    *   per farm-year). We still need these. Use the mean to collapse
    *   these vars back down again (mean of a repeated value is just 
    *   the value again). Collapse command is further down.
  
}


reshape wide ALLOC_DAIRY_HERD_QTY, i(FARM_CODE YE_AR) j(BULKYFEED_CODE)


* Change missing values to 0's
mvencode _all, mv(0) override


macro list _sumlist
collapse `sumlist', by(FARM_CODE YE_AR)


* term1 -- area equiv of hay allocated to dairy
* -------------------------------------------------
local var "term1"
local code "922"
capture drop `var'
gen `var' = 0


* term definition if divisors are positive 
replace `var' =                                ///
  ALLOC_DAIRY_HERD_QTY`code'                    / ///
  (HAY_TOTAL_YIELD_TONNES / d_adjusted_hectarage_of_hay_ha )    ///
                                               ///
  if [HAY_TOTAL_YIELD_TONNES > 0                & ///
      d_adjusted_hectarage_of_hay_ha > 0]                 

* term def using default divisor if it's <= 0
replace `var' =                                ///
  ALLOC_DAIRY_HERD_QTY`code'                    / ///
  5 * 2.471                                       ///
                                               ///
  if ![HAY_TOTAL_YIELD_TONNES > 0               & ///
      d_adjusted_hectarage_of_hay_ha > 0]                   



* term2 -- area equiv of silage allocated to dairy
* -------------------------------------------------
local var "term2"
local code "923"
capture drop `var'
gen `var' = 0


* term definition if divisors are positive 
replace `var' =                                ///
  ALLOC_DAIRY_HERD_QTY`code'                    / ///
  (SIL_TOTAL_YIELD_TONNES /d_adj_hectarage_of_silage_ha )    ///
                                               ///
  if [SIL_TOTAL_YIELD_TONNES > 0                & ///
      d_adj_hectarage_of_silage_ha > 0]


* term def using default divisor if it's not > 0
replace `var' =                                ///
  ALLOC_DAIRY_HERD_QTY`code'                    / ///
  25 * 2.471                                      ///
                                               ///
  if ![SIL_TOTAL_YIELD_TONNES > 0               & ///
       d_adj_hectarage_of_silage_ha > 0]

*====================================================================

* Be doubly sure no missings in term1 or term2
replace term1 = 0 if missing(term1)
replace term2 = 0 if missing(term2)

* Make sure the vars exist
foreach var in            ///
  ALLOC_DAIRY_HERD_QTY811 /// 
  ALLOC_DAIRY_HERD_QTY812 /// 
  ALLOC_DAIRY_HERD_QTY902 /// 
  ALLOC_DAIRY_HERD_QTY903 /// 
  ALLOC_DAIRY_HERD_QTY901 /// 
  ALLOC_DAIRY_HERD_QTY904 /// 
  ALLOC_DAIRY_HERD_QTY905 /// 
  ALLOC_DAIRY_HERD_QTY906 /// 
  ALLOC_DAIRY_HERD_QTY907 /// 
  ALLOC_DAIRY_HERD_QTY908 /// 
  ALLOC_DAIRY_HERD_QTY909 /// 
  ALLOC_DAIRY_HERD_QTY955 /// 
  ALLOC_DAIRY_HERD_QTY980 /// 
  ALLOC_DAIRY_HERD_QTY931 /// 
  ALLOC_DAIRY_HERD_QTY932 /// 
  ALLOC_DAIRY_HERD_QTY933 /// 
  ALLOC_DAIRY_HERD_QTY131 /// 
  ALLOC_DAIRY_HERD_QTY132 {

  capture confirm variable `var'
  if _rc != 0  gen `var' = 0

}


local mkvar "d_purch_feed_bulk_alloc_dairy_ha"
capture drop `mkvar '
gen double `mkvar ' =                     ///
  term1                                    + ///
  term2                                    + ///
  ALLOC_DAIRY_HERD_QTY811 / (7 * 2.471)    + /// 
  ALLOC_DAIRY_HERD_QTY812 / (3 * 2.471)    + /// 
  ALLOC_DAIRY_HERD_QTY902 / (15 * 2.471)   + /// 
  ALLOC_DAIRY_HERD_QTY903 / (15 * 2.471)   + /// 
  ALLOC_DAIRY_HERD_QTY901 / 1              + /// 
  ALLOC_DAIRY_HERD_QTY904 / 1              + /// 
  ALLOC_DAIRY_HERD_QTY905 / 1              + /// 
  ALLOC_DAIRY_HERD_QTY906 / 1              + /// 
  ALLOC_DAIRY_HERD_QTY907 / 1              + /// 
  ALLOC_DAIRY_HERD_QTY908 / 1              + /// 
  ALLOC_DAIRY_HERD_QTY909 / 1              + /// 
  ALLOC_DAIRY_HERD_QTY955 / (2.8 * 2.471)  + /// 
  ALLOC_DAIRY_HERD_QTY980 / (540 * 2.471)  + /// 
  ALLOC_DAIRY_HERD_QTY931 / (3600 * 2.471) + /// 
  ALLOC_DAIRY_HERD_QTY932 / (140 * 2.471)  + /// 
  ALLOC_DAIRY_HERD_QTY933 / (18 * 2.471)   + /// 
  ALLOC_DAIRY_HERD_QTY131 / (10 * 2.471)   + /// 
  ALLOC_DAIRY_HERD_QTY132 / (20 * 2.471)
replace `mkvar' = 0 if missing(`mkvar')
