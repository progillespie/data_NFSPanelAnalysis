* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.


local startdir: pwd // Save current working directory location


* Move into the root of the variable's directory
local this_file_calculates "D_OUTPUT_CURRENT_MISC_CASH_CROP"
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



* Define and call program to generate list of all crop codes in data
do link_to_cropcodelist.do
cropcodelist
local crop_codes "`r(code_list)'"


* Build list of codes in "other cash crops" category
foreach code of local crop_codes {

	if [regexm("`code'", "111[0-9]") | ///
	   regexm("`code'", "115[0-9]") | ///
	   regexm("`code'", "114[0-9]") | ///
	   regexm("`code'", "143[0-9]") | ///
	   regexm("`code'", "157[0-9]") | ///
	   regexm("`code'", "131[0-9]") | ///
	   regexm("`code'", "132[0-9]") | ///
	   regexm("`code'", "146[0-9]") | ///
	   regexm("`code'", "811[0-9]") | ///
	   regexm("`code'", "921[0-9]") | ///
	   regexm("`code'", "922[0-9]") | ///
	   regexm("`code'", "923[0-9]") | ///
	   regexm("`code'", "902[0-9]") | ///
	   regexm("`code'", "903[0-9]") | ///
	   regexm("`code'", "904[0-9]") | ///
	   regexm("`code'", "905[0-9]") | ///
	   regexm("`code'", "906[0-9]") | ///
	   regexm("`code'", "907[0-9]") | ///
	   regexm("`code'", "908[0-9]") | ///
	   regexm("`code'", "175[0-9]")] {

	   * This code doesn't belong on the list
	   *  so do nothing.
	}


	else {

	   * This one does belong, so add it
	   local crop_codes_other "`crop_codes_other' `code'"
	
	}

}

* Ensure codes aren't repeated and sort them
local crop_codes_other: list uniq crop_codes_other
local crop_codes_other: list sort crop_codes_other

di "`crop_codes_other'"

* Add vars for all crop_codes_other codes + a few extra
foreach code in `crop_codes_other'                ///
1116 1111 1117 1146 1141 1147 1571 1577 1156 1151 ///
1157 1431 1436 1211 1561 1311 1317 1321 1751 {

* Create a list of variables which may not exist for the early years
local nonexist_vlist "`nonexist_vlist' PROTEIN_PAYMENTS_TOTAL_EU"
local nonexist_vlist "`nonexist_vlist' D_GROSS_OUTPUT_EU`code'"

}


* Add nonexist variables to global list of zero vars
global zero_vlist "$zero_vlist PROTEIN_PAYMENTS_TOTAL_EU"

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





capture drop D_GROSS_OUTPUT_EU_OTH 
gen D_GROSS_OUTPUT_EU_OTH = 0
  
foreach code of local crop_codes_other {

	replace D_GROSS_OUTPUT_EU_OTH = ///
	  D_GROSS_OUTPUT_EU_OTH          + ///
	  D_GROSS_OUTPUT_EU`code' 

}

capture drop `this_file_calculates'
gen  `this_file_calculates' =    ///
 D_GROSS_OUTPUT_EU1116  + ///
 D_GROSS_OUTPUT_EU1111  + ///
 D_GROSS_OUTPUT_EU1117  + ///
 D_GROSS_OUTPUT_EU1146  + ///
 D_GROSS_OUTPUT_EU1141  + ///
 D_GROSS_OUTPUT_EU1147  + ///
 D_GROSS_OUTPUT_EU1571  + ///
 D_GROSS_OUTPUT_EU1577  + ///
 D_GROSS_OUTPUT_EU1156  + ///
 D_GROSS_OUTPUT_EU1151  + ///
 D_GROSS_OUTPUT_EU1157  + ///
 D_GROSS_OUTPUT_EU1431  + ///
 D_GROSS_OUTPUT_EU1436  + ///
 D_GROSS_OUTPUT_EU1211  + ///
 D_GROSS_OUTPUT_EU1561  + ///
 D_GROSS_OUTPUT_EU1311  + ///
 D_GROSS_OUTPUT_EU1317  + ///
 D_GROSS_OUTPUT_EU1321  + ///
 D_GROSS_OUTPUT_EU1751  + ///
 D_GROSS_OUTPUT_EU_OTH  + /// 
 D_ARABLE_AID           + ///
 PROTEIN_PAYMENTS_TOTAL_EU



replace `this_file_calculates' = 0 /// 
   if missing(`this_file_calculates')



* Add required variables to global list of required vars
global required_vars "$required_vars D_GROSS_OUTPUT_EUXXXX"
global required_vars "$required_vars D_ARABLE_AID"
global required_vars "$required_vars PROTEIN_PAYMENTS_TOTAL_EU"

* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars)



cd `startdir' // return Stata to previous directory
summ `this_file_calculates', detail
codebook `this_file_calculates' 
