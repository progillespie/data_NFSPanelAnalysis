* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.


local startdir: pwd // Save current working directory location


* Move into the root of the variable's directory
local this_file_calculates "D_FEED_AREA_EQUIV_HA"
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
qui ds FED_DAIRY_TONNES_HA????
local vlist "`r(varlist)'"
foreach term_var of local vlist {

    local code = substr("`term_var'", -4, .)

    local nonexist_vlist "`nonexist_vlist' FED_DAIRY_TONNES_HA`code'"
    local nonexist_vlist "`nonexist_vlist' CY_TOTAL_YIELD`code'"
    local nonexist_vlist "`nonexist_vlist' CY_SALES_QTY_TONNES_HA`code'"

}


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



local vlist "`vlist' D_DAIRY_LU_BOARDING_NET"
local vlist "`vlist' D_FARM_TOTAL_LU_BOARDING_NET"
local vlist "`vlist' D_FARM_ADJUSTED_PASTURE"
local vlist "`vlist' CONC_ALLOC_DAIRY_HERD_50KG_NO"
local vlist "`vlist' D_FORAGE_AREA_HA"
local vlist "`vlist' D_PURCH_FEED_BULK_ALLOC_DAIRY_HA"

foreach var of local vlist{

    * Ensure no missing values in the terms of the equation
    replace `var' = 0  if missing(`var')
  
}



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



replace `this_file_calculates' = 0 /// 
   if missing(`this_file_calculates')



* Add required variables to global list of required vars
global required_vars "$required_vars `vlist'"
global required_vars "$required_vars FED_DAIRY_TONNES_HAXXXX"
global required_vars "$required_vars CY_TOTAL_YIELDXXXX"
global required_vars "$required_vars CY_SALES_QTY_TONNES_HAXXXX"

* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars)



cd `startdir' // return Stata to previous directory
summ `this_file_calculates', detail
codebook `this_file_calculates' 
