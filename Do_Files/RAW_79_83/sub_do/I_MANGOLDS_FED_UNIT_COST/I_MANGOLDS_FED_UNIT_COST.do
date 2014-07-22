* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.


local startdir: pwd // Save current working directory location


* Move into the root of the variable's directory
local this_file_calculates "I_MANGOLDS_FED_UNIT_COST"
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



* Calc. intermediate term1 to simplify equation
capture drop term1
gen double term1 = 0 


local term1_codes ///
  "`term1_codes' 9050 9051 9052 9053 9054 9055 9056 9057 9058 9059"
foreach code of local term1_codes{  

    local term_var "CY_FED_QTY_TONNES_HA`code'"
    capture confirm variable `term_var' 
    if _rc==0 {
        
        di "`term_var' exists, adding to term1." 

        * Ensure you don't add missing value to sub-total
        replace `term_var' = 0 if missing(`term_var')

        replace term1 =                  ///
          term1                           + ///
          CY_FED_QTY_TONNES_HA`code' 

    }



    else {

        di "`term_var' is not in the data. term1 unchanged."

    }



    local term_var "OP_INV_FED_QTY_TONNES_HA`code'"
    capture confirm variable `term_var'
    if _rc==0 {
        
        di "`term_var' exists, adding to term1." 

        * Ensure you don't add missing value to sub-total
        replace `term_var' = 0 if missing(`term_var')
       
        replace term1 =                  ///
          term1                           + ///
          OP_INV_FED_QTY_TONNES_HA`code'

    }



    else {

        di "`term_var' is not in the data. term1 unchanged."

    }



}



local vlist "`vlist' I_OP_INV_VAL_EU9050"
local vlist "`vlist' OP_INV_QTY_TONNES_HA9050"
local vlist "`vlist' OP_INV_FED_QTY_TONNES_HA9050"
local vlist "`vlist' CY_FED_QTY_TONNES_HA9051"
local vlist "`vlist' D_TOTAL_DIRECT_COST_EU9051"
local vlist "`vlist' CY_TOTAL_YIELD9051"

foreach var of local vlist{

    * Ensure no missing values in the terms of the equation
    replace `var' = 0  if missing(`var')
  
}




capture drop `this_file_calculates'
gen double `this_file_calculates' = 0  

* Formula when all fed came from opening
replace `this_file_calculates' =                 ///
  I_OP_INV_VAL_EU9050 / OP_INV_QTY_TONNES_HA9050    ///
                                                 ///
  if OP_INV_FED_QTY_TONNES_HA9050 >                 ///
     CY_FED_QTY_TONNES_HA9051 


* Formula when NOT all fed came from opening AND
*  divisor of 2nd term is > 0 
replace `this_file_calculates' =                      ///
  (                                                   ///
    I_OP_INV_VAL_EU9050                                  ///
                   +                                     ///
    (D_TOTAL_DIRECT_COST_EU9051 / CY_TOTAL_YIELD9051)  * ///
    FED_TOTAL_TONNES_HA9051                              ///
  )                                                   ///
                   /                                     ///
  term1                                                  ///
                                                      ///
  if ![OP_INV_FED_QTY_TONNES_HA9050 >                    ///
     CY_FED_QTY_TONNES_HA9051]                         & ///
     CY_TOTAL_YIELD9051 > 0


* 2nd term in numerator is 0 (i.e. omitted) 
*  if CY_TOTAL_YIELD9051 <= 0
replace `this_file_calculates' =         ///
    I_OP_INV_VAL_EU9050  / term1            ///
                                         ///
  if ![OP_INV_FED_QTY_TONNES_HA9050 >       ///
     CY_FED_QTY_TONNES_HA9051]            & ///
     CY_TOTAL_YIELD9051 <= 0



replace `this_file_calculates' = 0 /// 
   if missing(`this_file_calculates')



* Add required variables to global list of required vars
global required_vars "$required_vars `vlist'"

* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars)



cd `startdir' // return Stata to previous directory
summ `this_file_calculates', detail
codebook `this_file_calculates' term1
quietly{
drop term1
}
