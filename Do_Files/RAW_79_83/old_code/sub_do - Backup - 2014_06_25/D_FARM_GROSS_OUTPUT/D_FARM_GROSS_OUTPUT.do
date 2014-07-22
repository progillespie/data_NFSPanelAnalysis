* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.



local startdir: pwd // Save current working directory location



* Move into the root of the variable's directory
local this_file_calculates "D_FARM_GROSS_OUTPUT"
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
local nonexist_vlist "`nonexist_vlist' SALE_OF_TURF_VALUE_EU"
local nonexist_vlist "`nonexist_vlist' PROTEIN_PAYMENTS_TOTAL_EU"
local nonexist_vlist "`nonexist_vlist' SHEEP_WELFARE_SCHEME_TOTAL_EU"
local nonexist_vlist "`nonexist_vlist' MILK_QUOTA_LET_EU"
local nonexist_vlist "`nonexist_vlist' SINGLE_FARM_PAYMENT_NET_VALUE_EU"
local nonexist_vlist "`nonexist_vlist' OTHER_SUBS_TOTAL_EU"
local nonexist_vlist "`nonexist_vlist' SUPER_LEVY_REFUND_EU"
local nonexist_vlist "`nonexist_vlist' SUPER_LEVY_CHARGE_EU"



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
gen  `this_file_calculates' =             ///
 D_TOTAL_LIVESTOCK_GROSS_OUTPUT    + ///
 D_TOTAL_CROPS_GROSS_OUTPUT_EU     + ///
 HIRED_MACHINERY_IN_CASH_EU        + ///
 HIRED_MACHINERY_IN_KIND_EU        + ///
 OTHER_RECEIPTS_IN_CASH_EU         + ///
 OTHER_RECEIPTS_IN_KIND_EU         + ///
 SALE_OF_TURF_VALUE_EU             + ///
 USED_IN_HOUSE_OTHER_EU            + ///
 MISC_GRANTS_SUBSIDIES_EU          + ///
 PROTEIN_PAYMENTS_TOTAL_EU         + ///
 SHEEP_WELFARE_SCHEME_TOTAL_EU     + ///
 OTHER_SUBS_TOTAL_EU               + ///
 LAND_LET_OUT_EU                   + ///
 MILK_QUOTA_LET_EU                 + ///
 SINGLE_FARM_PAYMENT_NET_VALUE_EU  - ///
 D_INTER_ENTERPRISE_TRANSFERS_EU

replace `this_file_calculates' =       ///
 `this_file_calculates'                 + ///
 SUPER_LEVY_REFUND_EU                     ///
 if SUPER_LEVY_REFUND_EU > SUPER_LEVY_CHARGE_EU



replace `this_file_calculates' = 0 /// 
   if missing(`this_file_calculates')



* Add required variables to global list of required vars
global required_vars "$required_vars "

* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars)



cd `startdir' // return Stata to previous directory
codebook `this_file_calculates'
summ `this_file_calculates', detail

di "This file calculates: `this_file_calculates'."
tabstat `this_file_calculates'  ///
 D_TOTAL_LIVESTOCK_GROSS_OUTPUT      ///
 D_TOTAL_CROPS_GROSS_OUTPUT_EU       ///
 HIRED_MACHINERY_IN_CASH_EU          ///
 HIRED_MACHINERY_IN_KIND_EU          ///
 OTHER_RECEIPTS_IN_CASH_EU           ///
 OTHER_RECEIPTS_IN_KIND_EU           ///
 SALE_OF_TURF_VALUE_EU               ///
 USED_IN_HOUSE_OTHER_EU              ///
 MISC_GRANTS_SUBSIDIES_EU            ///
 PROTEIN_PAYMENTS_TOTAL_EU           ///
 SHEEP_WELFARE_SCHEME_TOTAL_EU       ///
 OTHER_SUBS_TOTAL_EU                 ///
 LAND_LET_OUT_EU                     ///
 MILK_QUOTA_LET_EU                   ///
 SINGLE_FARM_PAYMENT_NET_VALUE_EU    ///
 D_INTER_ENTERPRISE_TRANSFERS_EU     ///
 , by(year)
