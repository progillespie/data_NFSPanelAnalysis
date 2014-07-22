* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.


local startdir: pwd // Save current working directory location


* Move into the root of the variable's directory
local this_file_calculates "D_SIL_SALES_CU_EU"
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



* Create temporary intermediate variable to clarify formula
capture drop OP_INV_less_FED 
gen OP_INV_less_FED = SIL_OP_INV_QTY_TONNES - SIL_FED_QUANTITY_TONNES



capture drop `this_file_calculates'
gen  `this_file_calculates' = 0
replace `this_file_calculates' =                     ///
 (SIL_SALES_QUANTITY_TONNES - OP_INV_less_FED)        * ///
 (SIL_SALES_VALUE_EU / SIL_SALES_QUANTITY_TONNES)       ///
                                                     ///
 if SIL_SALES_QUANTITY_TONNES    > OP_INV_less_FED & ///
    OP_INV_less_FED              > 0 


replace `this_file_calculates' =                     ///
 SIL_SALES_QUANTITY_TONNES                            * ///
 (SIL_SALES_VALUE_EU / SIL_SALES_QUANTITY_TONNES)       ///
                                                     ///
 if SIL_SALES_QUANTITY_TONNES    > OP_INV_less_FED & ///
    OP_INV_less_FED             <= 0



/* ---- Original IB code (indentation and spacing added) ----
IF(
   SIL_SALES_QUANTITY_TONNES > 
   (SIL_OP_INV_QTY_TONNES - SIL_FED_QUANTITY_TONNES))

   THEN(
        SIL_SALES_QUANTITY_TONNES -
        (IF(
            (SIL_OP_INV_QTY_TONNES - SIL_FED_QUANTITY_TONNES) > 0
           ) 
         THEN
             SIL_OP_INV_QTY_TONNES - SIL_FED_QUANTITY_TONNES

         ELSE 0
        )
       )
	           *
(SIL_SALES_VALUE_EU    DIV 
 SIL_SALES_QUANTITY_TONNES)

ELSE 0
-----------------------------------------------------------*/


replace `this_file_calculates' = 0 /// 
   if missing(`this_file_calculates')



* Add required variables to global list of required vars
global required_vars "$required_vars "

* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars)



cd `startdir' // return Stata to previous directory
