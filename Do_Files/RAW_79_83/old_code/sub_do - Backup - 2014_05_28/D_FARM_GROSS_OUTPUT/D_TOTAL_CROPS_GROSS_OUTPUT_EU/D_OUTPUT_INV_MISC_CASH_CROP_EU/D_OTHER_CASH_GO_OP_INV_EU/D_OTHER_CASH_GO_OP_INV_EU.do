* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.


local startdir: pwd // Save current working directory location


* Move into the root of the variable's directory
local this_file_calculates "D_OTHER_CASH_GO_OP_INV_EU"
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

/*foreach code in 1130 1131 1133 1160 1161 1450 1451 1550 1551 1557  ///
                1560 1561 1611 2210 2211 2213 2214 2220 2221 2230  ///
                2231 2233 2234 2237 2280 2281 2290 2291 2371 2384  ///
                2385 2431 2445 2515 2534 2545 2600 2601 2635 2645  ///
                2651 2653 2654 2994 3010 3011 3020 3021 6990 6991  ///
                8100 8120 8121 9010 9011 9090 9091 9093 { */


foreach code in 1130 1131 1133 1160 1161 1210 1211 1320 1450 1451  ///
                1550 1551 1557 1560 1561 1581 1611 2210 2211 2213  ///
		2214 2220 2221 2230 2231 2233 2234 2237 2280 2281  ///
                2290 2291 2371 2384 2385 2431 2445 2515 2534 2545  ///
                2600 2601 2635 2645 2651 2653 2654 2994 3010 3011  ///
                3020 3021 6990 6991 8100 8120 8121 9010 9011 9090  ///
                9091 9093 {


	* Create a list of variables which may not exist for the early years
	local nonexist_vlist "`nonexist_vlist' PURCHASED_SEED_EU`code'"
	local nonexist_vlist "`nonexist_vlist' CROP_PROTECTION_EU`code'"
	local nonexist_vlist "`nonexist_vlist' TRANSPORT_GROSS_COST_EU`code'"
	local nonexist_vlist "`nonexist_vlist' TRANSPORT_SUBSIDY_EU`code'"
	local nonexist_vlist "`nonexist_vlist' MACHINERY_HIRE_EU`code'"
	local nonexist_vlist "`nonexist_vlist' MISCELLANEOUS_EU`code'"
	local nonexist_vlist "`nonexist_vlist' OP_INV_SALES_VALUE_EU`code'"
	local nonexist_vlist "`nonexist_vlist' OP_INV_FED_VALUE_EU`code'"
	local nonexist_vlist "`nonexist_vlist' OP_INV_SEED_VALUE_EU`code'"
	local nonexist_vlist "`nonexist_vlist' OP_INV_CLOSING_VALUE_EU`code'"
	local nonexist_vlist "`nonexist_vlist' OP_INV_VALUE_EU`code'"
	local nonexist_vlist "`nonexist_vlist' D_ALLOWANCES_OP_TONNES_HA`code'"
	local nonexist_vlist "`nonexist_vlist' OP_INV_CLOSING_QTY_TONNES_HA`code'"
	local nonexist_vlist "`nonexist_vlist' OP_INV_WASTE_TONNES_HA`code'"
}



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



*---------------------------------------------------------
* The IB code uses the indicator variable 
*  I_OTHER_CASH_CROP_IND_YN to determine whether or not a 
*  crop-code is classified in the catch all "other cash crop" 
*  category. This sort of thing is better handled with macros 
*  in Stata, so that variable is not created or used in this
*  code. 
* 
* The approach used here is to build a macro list of the 
*  crop codes for which the "other cash crop" category
*  applies, and then do calculations by looping over that
*  list. 
* 
*---------------------------------------------------------

/* Define and call program to generate list of all crop codes in data
do link_to_cropcodelist.do
cropcodelist
local crop_codes "`r(code_list)'"
*/


qui ds OP_INV_SALES_VALUE_EU????
local vlist "`r(varlist)'"

foreach var of local vlist {

	local code = substr("`var'", -4, .)
	local crop_codes "`crop_codes' `code'"
	
}


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


* Initialise variable at 0 (calc. in loop below)
capture drop `this_file_calculates'
gen  `this_file_calculates' = 0   ///

	  

foreach code of local crop_codes_other{

	
	* Replace missings in equation's terms
	qui replace PURCHASED_SEED_EU`code' = 0 ///
 	    if missing(PURCHASED_SEED_EU`code')

	qui replace CROP_PROTECTION_EU`code' = 0 ///
 	    if missing(CROP_PROTECTION_EU`code')

	qui replace TRANSPORT_GROSS_COST_EU`code' = 0 ///
 	    if missing(TRANSPORT_GROSS_COST_EU`code')

	qui replace TRANSPORT_SUBSIDY_EU`code' = 0 ///
 	    if missing(TRANSPORT_SUBSIDY_EU`code')

	qui replace MACHINERY_HIRE_EU`code' = 0 ///
 	    if missing(MACHINERY_HIRE_EU`code')

	qui replace MISCELLANEOUS_EU`code' = 0 ///
 	    if missing(MISCELLANEOUS_EU`code')

	qui replace OP_INV_SALES_VALUE_EU`code' = 0 ///
 	    if missing(OP_INV_SALES_VALUE_EU`code')

	qui replace OP_INV_FED_VALUE_EU`code' = 0 ///
 	    if missing(OP_INV_FED_VALUE_EU`code')

	qui replace OP_INV_SEED_VALUE_EU`code' = 0 ///
 	    if missing(OP_INV_SEED_VALUE_EU`code')

	qui replace OP_INV_CLOSING_VALUE_EU`code' = 0 ///
 	    if missing(OP_INV_CLOSING_VALUE_EU`code')

	qui replace OP_INV_VALUE_EU`code' = 0 ///
 	    if missing(OP_INV_VALUE_EU`code')

	qui replace D_ALLOWANCES_OP_TONNES_HA`code' = 0 ///
 	    if missing(D_ALLOWANCES_OP_TONNES_HA`code')

	qui replace OP_INV_CLOSING_QTY_TONNES_HA`code' = 0 ///
 	    if missing(OP_INV_CLOSING_QTY_TONNES_HA`code')

	qui replace OP_INV_WASTE_TONNES_HA`code' = 0 ///
 	    if missing(OP_INV_WASTE_TONNES_HA`code')



	* Make TOTAL_EU if missing for a code
	qui capture confirm variable TOTAL_EU`code'
	if _rc!=0 {
	
	   qui gen TOTAL_EU`code' = ///
	     PURCHASED_SEED_EU`code'       + ///
	     CROP_PROTECTION_EU`code'      + ///
	     TRANSPORT_GROSS_COST_EU`code' - ///
	     TRANSPORT_SUBSIDY_EU`code'    + ///
	     MACHINERY_HIRE_EU`code'       + ///
	     MISCELLANEOUS_EU`code'
	}

	qui replace TOTAL_EU`code' = 0 ///
 	    if missing(TOTAL_EU`code')

	

* This equation makes no sense!
*  Talked to Brian Moran about it... he thinks its gone haywire too!
*   Says what's supposed to be happening, is that the costs of 
*   keeping an opening stock (drying mainly, but storage as well)
*   need to be subtracted from the value of opening stock, but 
*   that doesn't seem to be happening here.

	qui capture drop subtotal
	qui gen  subtotal =                   ///
	 (                                    ///
	  OP_INV_SALES_VALUE_EU`code'          + ///  39
	  OP_INV_FED_VALUE_EU`code'            + /// 101
	  OP_INV_SEED_VALUE_EU`code'           + ///  12
	  OP_INV_CLOSING_VALUE_EU`code'        - ///  22 
	  OP_INV_VALUE_EU`code'                  /// 138
                                              ///	
	 )  	       /                         /// 
                                              ///
	 (                                    ///
	  OP_INV_CLOSING_QTY_TONNES_HA`code'   - ///   4
	  OP_INV_WASTE_TONNES_HA`code'         - ///  12
	  D_ALLOWANCES_OP_TONNES_HA`code'        ///   6
                                              ///	
	 )         *                             ///
                                              ///	
	 (                                    ///
	  OP_INV_VALUE_EU`code'                + /// 138
	  TOTAL_EU`code'                         /// 149
	 ) 


	qui replace subtotal = 0 if missing(subtotal)

	qui replace `this_file_calculates' =    ///
	  `this_file_calculates'             + ///
	   subtotal

}



qui replace `this_file_calculates' = 0 /// 
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
 , by(year)
