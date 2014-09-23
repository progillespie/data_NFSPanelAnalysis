* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.




local startdir: pwd // Save current working directory location


* Move into the root of the variable's directory
local this_file_calculates "D_VAL_CHANGE_IN_NUMBERS_PIGS_EU"
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


* NOTE: Some of the PERHEAD vars have PERHEAD removed to make the 
*        varname < 32 characters long (Stata limit)

capture drop `this_file_calculates'
gen  `this_file_calculates' =    ///
(                                                           ///
 ((SOWS_IN_PIG_CLOS_INV_NO    - SOWS_IN_PIG_OP_INV_NO)    * ///
     SOWS_IN_PIG_CLOS_INV_PERHEAD_EU)                       ///
                             +                              ///
 ((GILTS_IN_PIG_CLOS_INV_NO   - GILTS_IN_PIG_OP_INV_NO)   * ///
     GILTS_IN_PIG_CLOS_INV_PERHEAD_EU)                      ///
                             +                              ///
 ((SOWS_SUCKLING_CLOS_INV_NO  - SOWS_SUCKLING_OP_INV_NO)  * ///
     SOWS_SUCKLING_CLOS_INV_EU)                             ///
                             +                              ///
 ((BONHAMS_CLOS_INV_NO        - BONHAMS_OP_INV_NO)        * ///
     BONHAMS_CLOS_INV_PERHEAD_EU)                           ///
                             +                              ///
 ((WEANERS_CLOS_INV_NO        - WEANERS_OP_INV_NO)        * ///
     WEANERS_CLOS_INV_PERHEAD_EU)                           ///
                             +                              ///
 ((FATTENERS1_CLOS_INV_NO     - FATTENERS1_OP_INV_NO)     * ///
     FATTENERS1_CLOS_INV_PERHEAD_EU)                        ///
                             +                              ///
 ((FATTENERS2_CLOS_INV_NO     - FATTENERS2_OP_INV_NO)     * ///
     FATTENERS2_CLOS_INV_PERHEAD_EU)                        ///
                             +                              ///
 ((FATTENERS3_CLOS_INV_NO     - FATTENERS3_OP_INV_NO)     * /// 
     FATTENERS3_CLOS_INV_PERHEAD_EU)                        ///
                             +                              ///
 ((FATTENING_SOWS_CLOS_INV_NO - FATTENING_SOWS_OP_INV_NO) * ///
     FATTENING_SOWS_CLOS_INV_EU)                            ///
                             +                              ///
 ((STOCK_BOARS_CLOS_INV_NO    - STOCK_BOARS_OP_INV_NO)    * ///
     STOCK_BOARS_CLOS_INV_PERHEAD_EU)                       ///
)                                            // end of equation




replace `this_file_calculates' = 0 ///
   if missing(`this_file_calculates')



* Add required variables to global list of required vars
global required_vars "$required_vars "



* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars) 


log using `this_file_calculates'.log, text replace






log close

cd `startdir' // return Stata to previous directory
