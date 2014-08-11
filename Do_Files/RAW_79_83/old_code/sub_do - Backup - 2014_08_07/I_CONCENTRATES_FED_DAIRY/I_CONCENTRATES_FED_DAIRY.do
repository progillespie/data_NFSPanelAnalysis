* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.




* Move into the root of the variable's directory
local this_file_calculates "I_CONCENTRATES_FED_DAIRY"



* Get a list of crop codes
qui ds FED_DAIRY_TONNES_HA????
local vlist "`r(varlist)'"
foreach var of local vlist {
	local code = substr("`var'", -4, .)
	local crop_codes "`crop_codes' `code'"
}



* Build list of codes in "other cash crops" category
foreach code of local crop_codes {

	if [regexm("`code'", "11[1-9][0-9]") | ///
	    regexm("`code'", "157[0-9]")     | ///
	    regexm("`code'", "128[0-9]")     ] {

	   * Add this code to the list.
	   local crop_codes_fed_dy "`crop_codes_fed_dy' `code'"

	}
	
}



foreach code of local crop_codes_fed_dy {

* Create a list of variables which may not exist for the early years
local nonexist_vlist "`nonexist_vlist' CY_FED_VALUE_EU`code'"
local nonexist_vlist "`nonexist_vlist' OP_INV_FED_VALUE_EU`code'"

}

* Add nonexist variables to global list of zero vars
global zero_vlist "$zero_vlist OP_INV_FED_VALUE_EUXXXX"

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
gen  `this_file_calculates' = 0

foreach code of local crop_codes_fed_dy {

	* Ensure terms are not missing
	replace  FED_DAIRY_TONNES_HA`code' = 0 ///
	   if missing(FED_DAIRY_TONNES_HA`code')
	replace  FED_TOTAL_TONNES_HA`code' = 0 ///
	   if missing(FED_TOTAL_TONNES_HA`code')

	capture drop subtotal
	gen subtotal =                 ///
	    FED_DAIRY_TONNES_HA`code'   / ///
            FED_TOTAL_TONNES_HA`code'     ///
	    if FED_TOTAL_TONNES_HA`code' > 0

	replace subtotal =             ///
	   subtotal                     * ///
	   (                           ///
	     OP_INV_FED_VALUE_EU`code'  + ///
             CY_FED_VALUE_EU`code'        ///
           )     


	replace subtotal  = 0   /// 
	   if missing(subtotal)


	replace `this_file_calculates' =   ///
	   `this_file_calculates'           + ///
	    subtotal

}



* Add required variables to global list of required vars
global required_vars "$required_vars "

* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars)



codebook `this_file_calculates'
summ `this_file_calculates', detail
