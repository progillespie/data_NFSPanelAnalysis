* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.



local startdir: pwd // Save current working directory location



* Move into the root of the variable's directory
local this_file_calculates "D_ALLOWANCES_OP_TONNES_HA"
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



 * Extract a list of crop codes from the varnames
qui ds OP_INV_SALES_VALUE_EU????
local vlist "`r(varlist)'"
di "`vlist'"
foreach var of local vlist {
	local code = substr("`var'", -4, .) 
	local crop_codes "`crop_codes' `code'"
}
* Make sure there's no repeating codes
local crop_codes: list uniq crop_codes



foreach code in 1130 1131 1133 1160 1161 1210 1211 1320 1450 1451  ///
                1550 1551 1557 1560 1561 1611 2210 2211 2213 2214  ///
                2220 2221 2230 2231 2233 2234 2237 2280 2281 2290  ///
                2291 2371 2384 2385 2431 2445 2515 2534 2545 2600  ///
                2601 2635 2645 2651 2653 2654 2994 3010 3011 3020  ///
                3021 6990 6991 8100 8120 8121 9010 9011 9090 9091  ///
                9093 `crop_codes' {


   * Create a list of variables which may not exist for the early years
   local nonexist_vlist "`nonexist_vlist' OP_INV_SALES_VALUE_EU`code'"
   local nonexist_vlist "`nonexist_vlist' OP_INV_FED_VALUE_EU`code'"
   local nonexist_vlist "`nonexist_vlist' OP_INV_SEED_VALUE_EU`code'"
   local nonexist_vlist "`nonexist_vlist' OP_INV_CLOSING_VALUE_EU`code'"
   local nonexist_vlist "`nonexist_vlist' OP_INV_SALES_QTY_TONNES_HA`code'"
   local nonexist_vlist "`nonexist_vlist' OP_INV_FED_QTY_TONNES_HA`code'"
   local nonexist_vlist "`nonexist_vlist' OP_INV_SEED_QTY_TONNES_HA`code'"
   local nonexist_vlist "`nonexist_vlist' OP_INV_CLOSING_QTY_TONNES_HA`code'"
   local nonexist_vlist "`nonexist_vlist' OP_INV_ALLOW_HOUSE_TONNES_HA`code'"
   local nonexist_vlist "`nonexist_vlist' OP_INV_ALLOW_WAGES_TONNES_HA`code'"
}

*!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
* Add crop codes to the foreach definition to expand the nonexist
*  vlist above (where that particular crop code doesn't exist in the
*  data at all, i.e. there is no variable with that crop code). It 
*  is not appropriate to include codes for which variables exist 
*  (even if all missing values... that's dealt a few lines down). 
*!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


* Add nonexist variables to global list of zero vars
global required_vars "$required_vars OP_INV_SALES_VALUE_EUXXXX"
global required_vars "$required_vars OP_INV_FED_VALUE_EUXXXX"
global required_vars "$required_vars OP_INV_SEED_VALUE_EUXXXX"
global required_vars "$required_vars OP_INV_CLOSING_VALUE_EUXXXX"
global required_vars "$required_vars OP_INV_SALES_QTY_TONNES_HAXXXX"
global required_vars "$required_vars OP_INV_FED_QTY_TONNES_HAXXXX"
global required_vars "$required_vars OP_INV_SEED_QTY_TONNES_HAXXXX"
global required_vars "$required_vars OP_INV_CLOSING_QTY_TONNES_HAXXXX"
global required_vars "$required_vars OP_INV_ALLOW_HOUSE_TONNES_HAXXXX"
global required_vars "$required_vars OP_INV_ALLOW_WAGES_TONNES_HAXXXX"

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



foreach code of local crop_codes {

	* Removing missings in eq.'s terms
	foreach var of varlist ///
	  OP_INV_SALES_VALUE_EU`code'        ///
          OP_INV_FED_VALUE_EU`code'          ///
          OP_INV_SEED_VALUE_EU`code'         ///
          OP_INV_CLOSING_VALUE_EU`code'      ///
          OP_INV_SALES_QTY_TONNES_HA`code'   ///
          OP_INV_FED_QTY_TONNES_HA`code'     ///
          OP_INV_SEED_QTY_TONNES_HA`code'    ///
          OP_INV_CLOSING_QTY_TONNES_HA`code' ///
          OP_INV_ALLOW_HOUSE_TONNES_HA`code' ///
          OP_INV_ALLOW_WAGES_TONNES_HA`code' {
	     
	      
	      replace `var' = 0 /// 
	         if missing(`var')
         } 


	* Intermediate var for if statement
	capture drop HouseAndWages`code'
	gen HouseAndWages`code' = ///
	  OP_INV_ALLOW_HOUSE_TONNES_HA`code' + ///
	  OP_INV_ALLOW_WAGES_TONNES_HA`code'
	

	* Initialise var at 0 
	capture drop `this_file_calculates'`code'
	gen  `this_file_calculates'`code' = 0

	* Update based on condition
	replace  `this_file_calculates'`code' =    ///
          (                                        ///
            OP_INV_SALES_VALUE_EU`code'             + ///
            OP_INV_FED_VALUE_EU`code'               + ///
            OP_INV_SEED_VALUE_EU`code'              + ///
            OP_INV_CLOSING_VALUE_EU`code'             ///
          )        /                                  ///
                                                   ///
          (                                        ///
            OP_INV_SALES_QTY_TONNES_HA`code'        + ///
            OP_INV_FED_QTY_TONNES_HA`code'          + ///
            OP_INV_SEED_QTY_TONNES_HA`code'         + ///
            OP_INV_CLOSING_QTY_TONNES_HA`code'        ///
          )        *                                  ///
                                                   ///
          (                                        ///
            OP_INV_ALLOW_HOUSE_TONNES_HA`code'      + ///
            OP_INV_ALLOW_WAGES_TONNES_HA`code'        ///
          )                                           ///
                                                   ///
	  if HouseAndWages`code' > 0 




replace `this_file_calculates'`code' = 0 /// 
   if missing(`this_file_calculates'`code')


}



* Add required variables to global list of required vars
global required_vars "$required_vars OP_INV_SALES_VALUE_EUXXXX"
global required_vars "$required_vars OP_INV_FED_VALUE_EUXXXX"
global required_vars "$required_vars OP_INV_SEED_VALUE_EUXXXX"
global required_vars "$required_vars OP_INV_CLOSING_VALUE_EUXXXX"
global required_vars "$required_vars OP_INV_SALES_QTY_TONNES_HAXXXX"
global required_vars "$required_vars OP_INV_FED_QTY_TONNES_HAXXXX"
global required_vars "$required_vars OP_INV_SEED_QTY_TONNES_HAXXXX"
global required_vars "$required_vars OP_INV_CLOSING_QTY_TONNES_HAXXXX"
global required_vars "$required_vars OP_INV_ALLOW_HOUSE_TONNES_HAXXXX"
global required_vars "$required_vars OP_INV_ALLOW_WAGES_TONNES_HAXXXX"

* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars) 


log using `this_file_calculates'.log, text replace







/* ---- Original IB code --------------------------------------------
if(
   (
  sum(root/svy_crops[@crop_code='****']/@op_inv_allow_house_tonnes_ha) 
            +
  sum(
   root/svy_crops[@crop_code='****']/@op_inv_allow_wages_tonnes_ha))>0
     ) 
then
(
(
sum(root/svy_crops[@crop_code='****']/@op_inv_sales_value_eu) +
 sum(root/svy_crops[@crop_code='****']/@op_inv_fed_value_eu) +
 sum(root/svy_crops[@crop_code='****']/@op_inv_seed_value_eu) +
sum(root/svy_crops[@crop_code='****']/@op_inv_closing_value_eu) 
)
  div
( sum(root/svy_crops[@crop_code='****']/@op_inv_sales_qty_tonnes_ha) +
 sum(root/svy_crops[@crop_code='****']/@op_inv_fed_qty_tonnes_ha) +
 sum(root/svy_crops[@crop_code='****']/@op_inv_seed_qty_tonnes_ha) +
 sum(root/svy_crops[@crop_code='****']/@op_inv_closing_qty_tonnes_ha
)
) *
(sum(root/svy_crops[@crop_code='****']/@op_inv_allow_house_tonnes_ha) +
  sum(root/svy_crops[@crop_code='****']/@op_inv_allow_wages_tonnes_ha))
)
else 0
-------------------------------------------------------------------*/


log close

cd `startdir' // return Stata to previous directory
