* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.


local startdir: pwd // Save current working directory location


* Move into the root of the variable's directory
local this_file_calculates "D_LS_GROSS_OUTPUT_OP_INV_EU"
qui cd  `this_file_calculates'
local vardir: pwd 


* Needed variables get their own subdirectories. Look for subfolders
*  and use their names to determine which variables you need to 
*  calculate for this variable.
*local vars_needed: dir "." dirs * 


foreach var_needed of local vars_needed {
	di "Deriving `var_needed'"
	qui do `var_needed'/`var_needed'.do
}



* Create a list of variables which may not exist for the early years
local nonexist_vlist "`nonexist_vlist' ALL_D_ALLOWANCES_OP_TONNES_HA"



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


* TODO: Get D_ALLOWANCE sorted out
        *D_ALLOWANCES_OP_TONNES_HA    ///



foreach varroot in                 ///
        OP_INV_SALES_VALUE_EU        ///
        OP_INV_FED_VALUE_EU          ///
        OP_INV_SEED_VALUE_EU         ///
        OP_INV_CLOSING_VALUE_EU      ///
        OP_INV_VALUE_EU              ///
        OP_INV_CLOSING_QTY_TONNES_HA ///
        OP_INV_WASTE_TONNES_HA       ///
        OP_INV_VALUE_EU              ///
        TOTAL_EU                     {

	
	* Get list of crop-spefic varnames based on "roots" above , 
	*   e.g. OP_INV_SALES_VALUE_EU1111, then the same for 1116, etc.
	qui ds `varroot'????
	local `varroot' "`r(varlist)'"

	* Initialise summing variable at 0
	capture drop ALL_`varroot'
	gen  ALL_`varroot' = 0

	*  Total variable over all crops. 
	foreach var of local `varroot' {
	
		* Adding missing values to a running total causes it
		*  to become a missing value, so replace all missing
		replace `var' = 0 if missing(`var')

		* Now build a total 
		replace ALL_`varroot' = ///
		   ALL_`varroot'         + ///
		   `var'
	}


        * Check that this total equals the total in the raw data
	*  (Don't have the raw var total for TOTAL_EU)
	*  Only differences should be due to missingness and rounding
	*  No output if true, error if false.
	   if "`varroot'"!="TOTAL_EU" {
	      assert round(ALL_`varroot', .01) == ///
                     round(`varroot',.01) if `varroot' < .
	   }
}


capture drop `this_file_calculates'
gen  `this_file_calculates' =    ///
   (                                    /// 
     ALL_OP_INV_SALES_VALUE_EU           + ///
     ALL_OP_INV_FED_VALUE_EU             + ///
     ALL_OP_INV_SEED_VALUE_EU            + ///
     ALL_OP_INV_CLOSING_VALUE_EU         - ///
     ALL_OP_INV_VALUE_EU                 + ///
     ALL_D_ALLOWANCES_OP_TONNES_HA      ///
                                        ///
   )            /                       /// 
                                        /// 
   (                                    /// 
      (                                 /// 
        ALL_OP_INV_CLOSING_QTY_TONNES_HA - /// 
        ALL_OP_INV_WASTE_TONNES_HA         /// 
                                        ///
      )         *                       ///
                                        ///
      (                                 /// 
        ALL_OP_INV_VALUE_EU              + /// 
        ALL_TOTAL_EU                       /// 
      )                                 ///
   )




replace `this_file_calculates' = 0 /// 
   if missing(`this_file_calculates')



* Add required variables to global list of required vars
global required_vars "$required_vars "

* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars)



cd `startdir' // return Stata to previous directory
*DON'T FORGET THAT YOU HAVE A DERIVED VAR ON THE NON-EXIST!!!
