* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.



local startdir: pwd // Save current working directory location



* Move into the root of the variable's directory
local this_file_calculates "D_DAIRY_HERD_VALUE_CHANGE_EU"
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



capture drop `this_file_calculates'
gen  `this_file_calculates' =    ///
(                                                      ///
  (DAIRY_COWS1_CLOS_INV_NO - DAIRY_COWS1_OP_INV_NO) *  /// 1ST TERM
  DAIRY_COWS1_CLOS_INV_EU                              ///
)                                                   ///
                   +                                ///
                                                    ///
(                                                      ///
  (DAIRY_COWS2_CLOS_INV_NO - DAIRY_COWS2_OP_INV_NO)  * /// 2ND TERM
  DAIRY_COWS2_CLOS_INV_EU                              ///
)                                                   ///
                   +                                ///
                                                    ///
(                                                      ///
  (DAIRY_STOCK_BULLS_CLOS_INV_NO                       /// 3RD TERM
                      - DAIRY_STOCK_BULLS_OP_INV_NO) * ///
  DAIRY_STOCK_BULLS_CLOS_INV_EU                        ///
)                                                   ///
                   +                                ///
                                                    ///
(                                                      ///
  (DAIRY_CALVES_LT1WEEK_CLOS_INV_NO                    ///
                   - DAIRY_CALVES_LT1WEEK_OP_INV_NO) * /// 4TH TERM
  DAIRY_CALVES_LT1WEEK_CLOS_INV_EU                     ///
)                                                   ///
                   +                                ///
                                                    ///
(                                                      ///
  (DAIRY_OTHER_CLOS_INV_NO - DAIRY_OTHER_OP_INV_NO)  * /// 5TH TERM
  DAIRY_OTHER_CLOS_INV_EU                              ///
)



replace `this_file_calculates' = 0 /// 
   if missing(`this_file_calculates')



* Add required variables to global list of required vars
global required_vars "$required_vars DAIRY_COWS1_CLOS_INV_NO"
global required_vars "$required_vars DAIRY_COWS1_OP_INV_NO"
global required_vars "$required_vars DAIRY_COWS1_CLOS_INV_EU"
global required_vars "$required_vars DAIRY_COWS2_CLOS_INV_NO"
global required_vars "$required_vars DAIRY_COWS2_OP_INV_NO"
global required_vars "$required_vars DAIRY_COWS2_CLOS_INV_EU"
global required_vars "$required_vars DAIRY_STOCK_BULLS_CLOS_INV_NO"
global required_vars "$required_vars DAIRY_STOCK_BULLS_OP_INV_NO"
global required_vars "$required_vars DAIRY_STOCK_BULLS_CLOS_INV_EU"
global required_vars "$required_vars DAIRY_CALVES_LT1WEEK_CLOS_INV_NO"
global required_vars "$required_vars DAIRY_CALVES_LT1WEEK_OP_INV_NO"
global required_vars "$required_vars DAIRY_CALVES_LT1WEEK_CLOS_INV_EU"
global required_vars "$required_vars DAIRY_OTHER_CLOS_INV_NO"
global required_vars "$required_vars DAIRY_OTHER_OP_INV_NO"
global required_vars "$required_vars DAIRY_OTHER_CLOS_INV_EU"

* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars)



cd `startdir' // return Stata to previous directory
