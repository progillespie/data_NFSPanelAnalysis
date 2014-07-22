* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.


local startdir: pwd // Save current working directory location


* Move into the root of the variable's directory
local this_file_calculates "I_HAY_FED_UNIT_COST"
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



local vlist "`vlist' I_HAY_OP_VAL_EU "
local vlist "`vlist' HAY_WASTE_QUANTITY_TONNES"
local vlist "`vlist' HAY_OP_INV_QTY_TONNES"
local vlist "`vlist' HAY_FED_QUANTITY_TONNES"
local vlist "`vlist' FED_TOTAL_TONNES_HA9220"
local vlist "`vlist' D_HAY_TOTAL_DIRECT_COST_EU"
local vlist "`vlist' HAY_TOTAL_YIELD_TONNES"

foreach var of local vlist{

    * Ensure no missing values in the terms of the equation
    replace `var' = 0  if missing(`var')
  
}




capture drop `this_file_calculates'
gen double `this_file_calculates' = 0  


replace `this_file_calculates' =                     ///
  (I_HAY_OP_VAL_EU - HAY_WASTE_QUANTITY_TONNES)       / ///
  HAY_OP_INV_QTY_TONNES                                 ///
                                                     ///
  if HAY_OP_INV_QTY_TONNES >= HAY_FED_QUANTITY_TONNES & ///
     HAY_OP_INV_QTY_TONNES > 0   
         

replace `this_file_calculates' =                          ///
  (                                                       ///
    I_HAY_OP_VAL_EU                                        * ///
    (FED_TOTAL_TONNES_HA9220 / HAY_OP_INV_QTY_TONNES)      + ///
    (D_HAY_TOTAL_DIRECT_COST_EU / HAY_TOTAL_YIELD_TONNES   * ///
     FED_TOTAL_TONNES_HA9220)                                ///
  )                                                        / ///
  HAY_FED_QUANTITY_TONNES                                    ///
                                                          ///
  if HAY_OP_INV_QTY_TONNES   > 0                           & ///
     HAY_TOTAL_YIELD_TONNES  > 0                           & ///
     HAY_FED_QUANTITY_TONNES > 0                           & ///
     ![HAY_OP_INV_QTY_TONNES >= HAY_FED_QUANTITY_TONNES]  


replace `this_file_calculates' =                          ///
  (                                                       ///
    I_HAY_OP_VAL_EU                                        * ///
    0                                                      + ///
    (D_HAY_TOTAL_DIRECT_COST_EU / HAY_TOTAL_YIELD_TONNES   * ///
     FED_TOTAL_TONNES_HA9220)                                ///
  )                                                        / ///
  HAY_FED_QUANTITY_TONNES                                    ///
                                                          ///
  if HAY_OP_INV_QTY_TONNES  <= 0                           & ///
     HAY_TOTAL_YIELD_TONNES > 0                            & ///
     HAY_FED_QUANTITY_TONNES > 0                           & ///
     ![HAY_OP_INV_QTY_TONNES >= HAY_FED_QUANTITY_TONNES]  


replace `this_file_calculates' =                          ///
  (                                                       ///
    I_HAY_OP_VAL_EU                                        * ///
    (FED_TOTAL_TONNES_HA9220 / HAY_OP_INV_QTY_TONNES)      + ///
    0                                                        ///
  )                                                        / ///
  HAY_FED_QUANTITY_TONNES                                    ///
                                                          ///
  if HAY_OP_INV_QTY_TONNES  > 0                            & ///
     HAY_TOTAL_YIELD_TONNES <= 0                           & ///
     HAY_FED_QUANTITY_TONNES > 0                           & ///
     ![HAY_OP_INV_QTY_TONNES >= HAY_FED_QUANTITY_TONNES]  


replace `this_file_calculates' =                          ///
  (                                                       ///
    I_HAY_OP_VAL_EU                                        * ///
    0                                                      + ///
    0                                                        ///
  )                                                        / ///
  HAY_FED_QUANTITY_TONNES                                    ///
                                                          ///
  if HAY_OP_INV_QTY_TONNES  <= 0                           & ///
     HAY_TOTAL_YIELD_TONNES <= 0                           & ///
     HAY_FED_QUANTITY_TONNES > 0                           & ///
     ![HAY_OP_INV_QTY_TONNES >= HAY_FED_QUANTITY_TONNES]  



replace `this_file_calculates' = 0 /// 
   if missing(`this_file_calculates')



* Add required variables to global list of required vars
global required_vars "$required_vars `vlist'"

* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars)



cd `startdir' // return Stata to previous directory
summ `this_file_calculates', detail
codebook `this_file_calculates' 
