* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.


local startdir: pwd // Save current working directory location


* Move into the root of the variable's directory
local this_file_calculates "D_VAL_CHANGE_IN_NUMBERS_SHP_EU"
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
( ///
  ( ///
    (EWES_CLOS_INV_NO - EWES_OP_INV_NO)  * ///
    EWES_CLOS_INV_EU                       ///
  )                                     ///
                                        ///
                   +                    ///
  (                                     ///
    (LAMBS_PRE_WEANING_CLOS_INV_NO - LAMBS_PRE_WEANING_OP_INV_NO) * ///
    LAMBS_PRE_WEANING_CLOS_INV_EU                                   ///
  )                                     ///
                                        ///
                   +                    ///
  (                                     ///
    (LAMBS_LT1YR_CLOS_INV_NO - LAMBS_LT1YR_OP_INV_NO) * ///
    LAMBS_LT1YR_CLOS_INV_EU                             ///
  )                                     ///
                                        ///
                   +                    ///
  (                                     ///
    (SHEEP_1_2YRS_CLOS_INV_NO - SHEEP_1_2YRS_OP_INV_NO) * ///
    SHEEP_1_2YRS_CLOS_INV_EU                              ///
  )                                     ///
                                        ///
                   +                    ///
  (                                     ///
    (SHEEP_GT2YRS_CLOS_INV_NO - SHEEP_GT2YRS_OP_INV_NO) * ///
    SHEEP_GT2YRS_CLOS_INV_EU                              ///
  )                                     ///
                                        ///
                   +                    ///
  (                                     ///
    (RAMS_CLOS_INV_NO - RAMS_OP_INV_NO)     * ///
    RAMS_CLOS_INV_EU                          ///
  )                                     ///
) 



* Add required variables to global list of required vars
global required_vars "$required_vars EWES_CLOS_INV_NO"
global required_vars "$required_vars EWES_OP_INV_NO"
global required_vars "$required_vars EWES_CLOS_INV_EU"
global required_vars "$required_vars LAMBS_PRE_WEANING_CLOS_INV_NO"
global required_vars "$required_vars LAMBS_PRE_WEANING_OP_INV_NO"
global required_vars "$required_vars LAMBS_PRE_WEANING_CLOS_INV_EU"
global required_vars "$required_vars LAMBS_LT1YR_CLOS_INV_NO"
global required_vars "$required_vars LAMBS_LT1YR_OP_INV_NO"
global required_vars "$required_vars LAMBS_LT1YR_CLOS_INV_EU"
global required_vars "$required_vars SHEEP_1_2YRS_CLOS_INV_NO"
global required_vars "$required_vars SHEEP_1_2YRS_OP_INV_NO"
global required_vars "$required_vars SHEEP_1_2YRS_CLOS_INV_EU"
global required_vars "$required_vars SHEEP_GT2YRS_CLOS_INV_NO"
global required_vars "$required_vars SHEEP_GT2YRS_OP_INV_NO"
global required_vars "$required_vars SHEEP_GT2YRS_CLOS_INV_EU"
global required_vars "$required_vars RAMS_CLOS_INV_NO"
global required_vars "$required_vars RAMS_OP_INV_NO"
global required_vars "$required_vars RAMS_CLOS_INV_EU"

* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars)



cd `startdir' // return Stata to previous directory

