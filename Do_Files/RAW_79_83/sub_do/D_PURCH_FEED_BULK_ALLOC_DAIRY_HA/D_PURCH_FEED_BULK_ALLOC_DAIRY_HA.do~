* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.


local startdir: pwd // Save current working directory location


* Move into the root of the variable's directory
local this_file_calculates "D_PURCH_FEED_BULK_ALLOC_DAIRY_HA"
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
local nonexist_vlist "`nonexist_vlist' ALLOC_DAIRY_HERD_QTY811"
local nonexist_vlist "`nonexist_vlist' ALLOC_DAIRY_HERD_QTY812"
local nonexist_vlist "`nonexist_vlist' ALLOC_DAIRY_HERD_QTY902"
local nonexist_vlist "`nonexist_vlist' ALLOC_DAIRY_HERD_QTY903"
local nonexist_vlist "`nonexist_vlist' ALLOC_DAIRY_HERD_QTY901"
local nonexist_vlist "`nonexist_vlist' ALLOC_DAIRY_HERD_QTY904"
local nonexist_vlist "`nonexist_vlist' ALLOC_DAIRY_HERD_QTY905"
local nonexist_vlist "`nonexist_vlist' ALLOC_DAIRY_HERD_QTY906"
local nonexist_vlist "`nonexist_vlist' ALLOC_DAIRY_HERD_QTY907"
local nonexist_vlist "`nonexist_vlist' ALLOC_DAIRY_HERD_QTY908"
local nonexist_vlist "`nonexist_vlist' ALLOC_DAIRY_HERD_QTY909"
local nonexist_vlist "`nonexist_vlist' ALLOC_DAIRY_HERD_QTY955"
local nonexist_vlist "`nonexist_vlist' ALLOC_DAIRY_HERD_QTY980"
local nonexist_vlist "`nonexist_vlist' ALLOC_DAIRY_HERD_QTY931"
local nonexist_vlist "`nonexist_vlist' ALLOC_DAIRY_HERD_QTY932"
local nonexist_vlist "`nonexist_vlist' ALLOC_DAIRY_HERD_QTY933"
local nonexist_vlist "`nonexist_vlist' ALLOC_DAIRY_HERD_QTY131"
local nonexist_vlist "`nonexist_vlist' ALLOC_DAIRY_HERD_QTY132"



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



local vlist "`vlist' HAY_TOTAL_YIELD_TONNES"
local vlist "`vlist' D_HAY_ADJUSTED_HA"
local vlist "`vlist' SIL_TOTAL_YIELD_TONNES"
local vlist "`vlist' D_SIL_ADJUSTED_HA"
local vlist "`vlist' ALLOC_DAIRY_HERD_QTY922"
local vlist "`vlist' ALLOC_DAIRY_HERD_QTY923"
local vlist "`vlist' ALLOC_DAIRY_HERD_QTY811"
local vlist "`vlist' ALLOC_DAIRY_HERD_QTY812"
local vlist "`vlist' ALLOC_DAIRY_HERD_QTY902"
local vlist "`vlist' ALLOC_DAIRY_HERD_QTY903"
local vlist "`vlist' ALLOC_DAIRY_HERD_QTY901"
local vlist "`vlist' ALLOC_DAIRY_HERD_QTY904"
local vlist "`vlist' ALLOC_DAIRY_HERD_QTY905"
local vlist "`vlist' ALLOC_DAIRY_HERD_QTY906"
local vlist "`vlist' ALLOC_DAIRY_HERD_QTY907"
local vlist "`vlist' ALLOC_DAIRY_HERD_QTY908"
local vlist "`vlist' ALLOC_DAIRY_HERD_QTY909"
local vlist "`vlist' ALLOC_DAIRY_HERD_QTY955"
local vlist "`vlist' ALLOC_DAIRY_HERD_QTY980"
local vlist "`vlist' ALLOC_DAIRY_HERD_QTY931"
local vlist "`vlist' ALLOC_DAIRY_HERD_QTY932"
local vlist "`vlist' ALLOC_DAIRY_HERD_QTY933"
local vlist "`vlist' ALLOC_DAIRY_HERD_QTY131"
local vlist "`vlist' ALLOC_DAIRY_HERD_QTY132"

foreach var of local vlist{

    * Ensure no missing values in the terms of the equation
    replace `var' = 0  if missing(`var')
  
}



*====================================================================
* Create term vars to simplify equation
*====================================================================


* term1 -- area equiv of hay allocated to dairy
* -------------------------------------------------
local var "term1"
local code "922"
capture drop `var'
gen `var' = 0


* term definition if divisors are positive 
replace `var' =                                ///
  ALLOC_DAIRY_HERD_QTY`code'                    / ///
  (HAY_TOTAL_YIELD_TONNES / D_HAY_ADJUSTED_HA)    ///
                                               ///
  if [HAY_TOTAL_YIELD_TONNES > 0                & ///
      D_HAY_ADJUSTED_HA      > 0]                 

* term def using default divisor if it's <= 0
replace `var' =                                ///
  ALLOC_DAIRY_HERD_QTY`code'                    / ///
  5 * 2.471                                       ///
                                               ///
  if ![HAY_TOTAL_YIELD_TONNES > 0               & ///
       D_HAY_ADJUSTED_HA      > 0]                   



* term2 -- area equiv of silage allocated to dairy
* -------------------------------------------------
local var "term2"
local code "923"
capture drop `var'
gen `var' = 0


* term definition if divisors are positive 
replace `var' =                                ///
  ALLOC_DAIRY_HERD_QTY`code'                    / ///
  (SIL_TOTAL_YIELD_TONNES / D_SIL_ADJUSTED_HA)    ///
                                               ///
  if [SIL_TOTAL_YIELD_TONNES > 0                & ///
      D_SIL_ADJUSTED_HA      > 0]


* term def using default divisor if it's not > 0
replace `var' =                                ///
  ALLOC_DAIRY_HERD_QTY`code'                    / ///
  25 * 2.471                                      ///
                                               ///
  if ![SIL_TOTAL_YIELD_TONNES > 0               & ///
       D_SIL_ADJUSTED_HA      > 0]

*====================================================================

* Be doubly sure no missings in term1 or term2
replace term1 = 0 if missing(term1)
replace term2 = 0 if missing(term2)


capture drop `this_file_calculates'
gen double `this_file_calculates' =       ///
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


replace `this_file_calculates' = 0 /// 
   if missing(`this_file_calculates')



* Add required variables to global list of required vars
global required_vars "$required_vars `vlist'"

* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars) 


log using `this_file_calculates'.log, text replace




summ `this_file_calculates', detail
codebook `this_file_calculates' 
codebook term1 term2

drop term1 term2

log close

cd `startdir' // return Stata to previous directory
