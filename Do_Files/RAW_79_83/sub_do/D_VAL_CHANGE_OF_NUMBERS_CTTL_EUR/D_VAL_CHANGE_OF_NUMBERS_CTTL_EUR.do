
* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.


local startdir: pwd // Save current working directory location


* Move into the root of the variable's directory
local this_file_calculates "D_VAL_CHANGE_OF_NUMBERS_CTTL_EUR"
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
local nonexist_vlist "`nonexist_vlist' CATTLE_SUCKLER_COWS_CLOS_INV_NO"
local nonexist_vlist "`nonexist_vlist' CATTLE_SUCKLER_COWS_OP_INV_NO"
local nonexist_vlist "`nonexist_vlist' CATTLE_SUCKLER_COWS_CLOS_INV_EU"
local nonexist_vlist "`nonexist_vlist' CATTLE_OTHER_CLOS_INV_NO"
local nonexist_vlist "`nonexist_vlist' CATTLE_OTHER_OP_INV_NO"
local nonexist_vlist "`nonexist_vlist' CATTLE_OTHER_CLOS_INV_EU"




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
gen  `this_file_calculates' =        ///
(                                                                    ///
 (CATTLE_SUCKLER_COWS_CLOS_INV_NO - CATTLE_SUCKLER_COWS_OP_INV_NO) * ///
 CATTLE_SUCKLER_COWS_CLOS_INV_EU                                     ///
)                                                                 ///
                   +                                              ///
                                                                  ///
(                                                                    ///
  (CATTLE_OTHER_COWS_CLOS_INV_NO - CATTLE_OTHER_COWS_OP_INV_NO)    * ///
  CATTLE_OTHER_COWS_CLOS_INV_EU                                      ///
)                                                                 ///
                   +                                              ///
                                                                  ///
(                                                                    ///
  (CATTLE_IN_CALF_HF_CLOS_INV_NO -                                   ///
                                 CATTLE_IN_CALF_HEIFERS_OP_INV_NO) * ///
  CATTLE_IN_CALF_HF_CLOS_INV_EU                                      ///
)                                                                 ///
                   +                                              ///
                                                                  ///
(                                                                    ///
  (CATTLE_STOCK_BULLS_CLOS_INV_NO - CATTLE_STOCK_BULLS_OP_INV_NO)  * ///
  CATTLE_STOCK_BULLS_CLOS_INV_EU                                     ///
)                                                                 ///
                   +                                              ///
                                                                  ///
(                                                                    ///
  (CATTLE_CALVES_LT6M_CLOS_INV_NO -                               ///
                                 CATTLE_CALVES_LT6MTHS_OP_INV_NO)  * ///
  CATTLE_CALVES_LT6M_CLOS_INV_EU                                  ///
)                                                                 ///
                   +                                              ///
                                                                  ///
(                                                                    ///
  (CATTLE_CALVES_6M_1YR_CLOS_INV_NO -                             ///
                               CATTLE_CALVES_6M_1YR_OP_INV_NO)     * ///
  CATTLE_CALVES_6M_1YR_CLOS_INV_EU                                ///
)                                                                 ///
                   +                                              ///
                                                                  ///
(                                                                    ///
  (CATTLE_MALE_1_2YRS_CLOS_INV_NO - CATTLE_MALE_1_2YRS_OP_INV_NO)  * ///
  CATTLE_MALE_1_2YRS_CLOS_INV_EU                                     ///
)                                                                    ///
                   +                                              /// 
                                                                  ///
(                                                                    ///
  (CATTLE_FEMALE_1_2YRS_CLOS_INV_NO -                                ///
                                  CATTLE_FEMALE_1_2YRS_OP_INV_NO)  * ///
  CATTLE_FEMALE_1_2YRS_CLOS_INV_EU                                   ///
)                                                                 ///
                   +                                              ///
                                                                  ///
(                                                                    ///
  (CATTLE_MALE_2_3YRS_CLOS_INV_NO - CATTLE_MALE_2_3YRS_OP_INV_NO)  * ///
  CATTLE_MALE_2_3YRS_CLOS_INV_EU                                     ///
)                                                                 ///
                   +                                              ///
                                                                  ///
(                                                                    ///
  (CATTLE_FEMALE_2_3YRS_CLOS_INV_NO -                                ///
                                  CATTLE_FEMALE_2_3YRS_OP_INV_NO) *  ///
  CATTLE_FEMALE_2_3YRS_CLOS_INV_EU                                   ///
)                                                                 ///
                   +                                              ///
                                                                  ///
(                                                                    ///
  (CATTLE_OTHER_CLOS_INV_NO - CATTLE_OTHER_OP_INV_NO)             *  ///
  CATTLE_OTHER_CLOS_INV_EU                                           ///
)



replace `this_file_calculates' = 0 /// 
   if missing(`this_file_calculates')



* Add required variables to global list of required vars
global required_vars "$required_vars "

* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars) 


log using `this_file_calculates'.log, text replace



* "*" on larger terms (all of them EU terms)
tabstat `this_file_calculates' ///       1
   CATTLE_SUCKLER_COWS_CLOS_INV_NO  ///  2
   CATTLE_SUCKLER_COWS_OP_INV_NO    ///  3
   CATTLE_SUCKLER_COWS_CLOS_INV_EU  ///  4
   CATTLE_OTHER_COWS_CLOS_INV_NO    ///  5
   CATTLE_OTHER_COWS_OP_INV_NO      ///  6
   CATTLE_OTHER_COWS_CLOS_INV_EU    ///  7 *
   CATTLE_IN_CALF_HF_CLOS_INV_NO    ///  8
   CATTLE_IN_CALF_HEIFERS_OP_INV_NO ///  9
   CATTLE_IN_CALF_HF_CLOS_INV_EU    /// 10 * 
   CATTLE_STOCK_BULLS_CLOS_INV_NO   /// 11
   CATTLE_STOCK_BULLS_OP_INV_NO     /// 12
   CATTLE_STOCK_BULLS_CLOS_INV_EU   /// 13
   CATTLE_CALVES_LT6M_CLOS_INV_NO   /// 14
   CATTLE_CALVES_LT6MTHS_OP_INV_NO  /// 15
   CATTLE_CALVES_LT6M_CLOS_INV_EU   /// 16
   CATTLE_CALVES_6M_1YR_CLOS_INV_NO /// 17
   CATTLE_CALVES_6M_1YR_OP_INV_NO   /// 18
   CATTLE_CALVES_6M_1YR_CLOS_INV_EU /// 19 * 
   CATTLE_MALE_1_2YRS_CLOS_INV_NO   /// 20
   CATTLE_MALE_1_2YRS_OP_INV_NO     /// 21
   CATTLE_MALE_1_2YRS_CLOS_INV_EU   /// 22 *
   CATTLE_FEMALE_1_2YRS_CLOS_INV_NO /// 23
   CATTLE_FEMALE_1_2YRS_OP_INV_NO   /// 24
   CATTLE_FEMALE_1_2YRS_CLOS_INV_EU /// 25 *
   CATTLE_MALE_2_3YRS_CLOS_INV_NO   /// 26
   CATTLE_MALE_2_3YRS_OP_INV_NO     /// 27	
   CATTLE_MALE_2_3YRS_CLOS_INV_EU   /// 28 *
   CATTLE_FEMALE_2_3YRS_CLOS_INV_NO /// 29
   CATTLE_FEMALE_2_3YRS_OP_INV_NO   /// 30
   CATTLE_FEMALE_2_3YRS_CLOS_INV_EU /// 31 *
   CATTLE_OTHER_CLOS_INV_NO         /// 32
   CATTLE_OTHER_OP_INV_NO           /// 33
   CATTLE_OTHER_CLOS_INV_EU         /// 34
   , by(year)



log close



cd `startdir' // return Stata to previous directory
