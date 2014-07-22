* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.


local startdir: pwd // Save current working directory location


* Move into the root of the variable's directory
local this_file_calculates "D_OS_GROSS_OUTPUT_OP_INV_EU"
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
local nonexist_vlist "`nonexist_vlist' OP_INV_SALES_VALUE_EU1430"
local nonexist_vlist "`nonexist_vlist' OP_INV_FED_VALUE_EU1430"
local nonexist_vlist "`nonexist_vlist' OP_INV_SEED_VALUE_EU1430"
local nonexist_vlist "`nonexist_vlist' OP_INV_CLOSING_VALUE_EU1430"
local nonexist_vlist "`nonexist_vlist' OP_INV_VALUE_EU1430"
local nonexist_vlist "`nonexist_vlist' D_ALLOWANCES_OP_TONNES_HA1430"
local nonexist_vlist "`nonexist_vlist' OP_INV_CLOSING_QTY_TONNES_HA1430"
local nonexist_vlist "`nonexist_vlist' OP_INV_WASTE_TONNES_HA1430"
local nonexist_vlist "`nonexist_vlist' OP_INV_VALUE_EU1430"



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


* Replace missings for equation's terms
foreach var of varlist ///
 OP_INV_SALES_VALUE_EU1430           ///
 OP_INV_FED_VALUE_EU1430             ///
 OP_INV_SEED_VALUE_EU1430            ///
 OP_INV_CLOSING_VALUE_EU1430         ///
 OP_INV_VALUE_EU1430                 ///
 D_ALLOWANCES_OP_TONNES_HA1430       ///
 OP_INV_CLOSING_QTY_TONNES_HA1430    ///
 OP_INV_WASTE_TONNES_HA1430          ///
 OP_INV_VALUE_EU1430                 ///
 TOTAL_EU1431                        {

	replace `var' =0 if missing(`var')

}



capture drop `this_file_calculates'
gen  `this_file_calculates' =  ///
 (                                ///                            
 OP_INV_SALES_VALUE_EU1430         + ///
 OP_INV_FED_VALUE_EU1430           + ///
 OP_INV_SEED_VALUE_EU1430          + ///
 OP_INV_CLOSING_VALUE_EU1430       - ///
 OP_INV_VALUE_EU1430               + ///
 D_ALLOWANCES_OP_TONNES_HA1430       ///
                                     ///
 )                  /                ///
                                  ///
 (                                ///
 OP_INV_CLOSING_QTY_TONNES_HA1430  - ///
 OP_INV_WASTE_TONNES_HA1430          ///
                                     ///
 )                  *                ///
                                 ///
 (                               ///                            
 OP_INV_VALUE_EU1430               + ///
 TOTAL_EU1431                        ///
 )


replace `this_file_calculates' = 0 /// 
   if missing(`this_file_calculates')



* Add required variables to global list of required vars
global required_vars "$required_vars OP_INV_SALES_VALUE_EU1430"
global required_vars "$required_vars OP_INV_FED_VALUE_EU1430"
global required_vars "$required_vars OP_INV_SEED_VALUE_EU1430"
global required_vars "$required_vars OP_INV_CLOSING_VALUE_EU1430"
global required_vars "$required_vars OP_INV_VALUE_EU1430"
global required_vars "$required_vars D_ALLOWANCES_OP_TONNES_HA1430"
global required_vars "$required_vars OP_INV_CLOSING_QTY_TONNES_HA1430"
global required_vars "$required_vars OP_INV_WASTE_TONNES_HA1430"
global required_vars "$required_vars OP_INV_VALUE_EU1430"
global required_vars "$required_vars TOTAL_EU1431"

* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars)



cd `startdir' // return Stata to previous directory
