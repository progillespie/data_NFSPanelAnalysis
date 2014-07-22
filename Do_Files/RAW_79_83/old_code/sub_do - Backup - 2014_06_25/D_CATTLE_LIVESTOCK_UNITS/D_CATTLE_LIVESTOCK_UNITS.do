* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.


local startdir: pwd // Save current working directory location


* Move into the root of the variable's directory
local this_file_calculates "D_CATTLE_LIVESTOCK_UNITS"
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


/* DON'T NEED THIS AFTER ALL
* We don't have 12MTH split by sex_age categories, so we'll use 
*  averages based off of opening and closing inventories
local sex_age "MALE_1_2YRS" 
capture drop CATTLE_`sex_age'_AVG
gen CATTLE_`sex_age'_AVG =    ///
(CATTLE_`sex_age'_OP_INV_NO    + ///
 CATTLE_`sex_age'_CLOS_INV_NO) / 2


local sex_age "FEMALE_1_2YRS" 
capture drop CATTLE_`sex_age'_AVG
gen CATTLE_`sex_age'_AVG =    ///
(CATTLE_`sex_age'_OP_INV_NO    + ///
 CATTLE_`sex_age'_CLOS_INV_NO) / 2


local sex_age "MALE_2_3YRS" 
capture drop CATTLE_`sex_age'_AVG
gen CATTLE_`sex_age'_AVG =    ///
(CATTLE_`sex_age'_OP_INV_NO    + ///
 CATTLE_`sex_age'_CLOS_INV_NO) / 2


local sex_age "FEMALE_2_3YRS" 
capture drop CATTLE_`sex_age'_AVG
gen CATTLE_`sex_age'_AVG =    ///
(CATTLE_`sex_age'_OP_INV_NO    + ///
 CATTLE_`sex_age'_CLOS_INV_NO) / 2
*/

local vlist "`vlist' MTH12_TOTAL_OTHER_COWS_NO"
local vlist "`vlist' MTH12_TOTAL_IN_CALF_HEIFERS_NO"
local vlist "`vlist' MTH12_TOTAL_CALVES_LT6MTHS_NO"
local vlist "`vlist' MTH12_TOTAL_CALVES_6_12MTHS_NO"
local vlist "`vlist' MTH12_TOTAL_CATTLE_1_2YRS_NO"
local vlist "`vlist' MTH12_TOTAL_CATTLE_GT2YRS_NO"
local vlist "`vlist' MTH12_TOTAL_BEEF_STOCK_BULLS_NO"

foreach var of local vlist{

    * Ensure no missing values in the terms of the equation
    replace `var' = 0 if missing(`var')

}


* Had to edit formula. There no historical var for suckler cows & 
*  12MTH stocks aren't split by sex. Can just sub in the combined
*  figure though, because the male and female stock get the same 
*  weight
capture drop `this_file_calculates'
gen double `this_file_calculates' =          ///
(                                            ///
 ( MTH12_TOTAL_OTHER_COWS_NO           * 0.9) + ///
 ( MTH12_TOTAL_IN_CALF_HEIFERS_NO      * 0.7) + ///
 ( MTH12_TOTAL_CALVES_LT6MTHS_NO       * 0.2) + ///
 ( MTH12_TOTAL_CALVES_6_12MTHS_NO      * 0.4) + ///
 ( MTH12_TOTAL_CATTLE_1_2YRS_NO        * 0.7) + ///
 ( MTH12_TOTAL_CATTLE_GT2YRS_NO        * 1)   + ///
 ( MTH12_TOTAL_BEEF_STOCK_BULLS_NO     * 1)     ///
) / 12


replace `this_file_calculates' = 0 /// 
   if missing(`this_file_calculates')



* Add required variables to global list of required vars
global required_vars "$required_vars `vlist'"

* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars)



cd `startdir' // return Stata to previous directory
summ `this_file_calculates', detail
codebook `this_file_calculates' 
