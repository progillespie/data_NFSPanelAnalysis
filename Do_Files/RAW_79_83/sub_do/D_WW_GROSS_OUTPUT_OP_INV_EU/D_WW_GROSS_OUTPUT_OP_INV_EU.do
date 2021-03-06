* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.


local startdir: pwd // Save current working directory location


* Move into the root of the variable's directory
local this_file_calculates "D_WW_GROSS_OUTPUT_OP_INV_EU"
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



* Get farm counts for conditions
qui capture replace OP_INV_SALES_VALUE_EU1116 = 0 ///
     if missing(OP_INV_SALES_VALUE_EU1116)
qui capture count if OP_INV_SALES_VALUE_EU1116 > 0
if _rc==0 {
	local count1116 = `r(N)'
}

else {
	local count1116 = 0
}


qui capture replace OP_INV_SALES_VALUE_EU1111 = 0 ///
     if missing(OP_INV_SALES_VALUE_EU1111)
qui capture count if OP_INV_SALES_VALUE_EU1111 > 0
if _rc==0 {
	local count1111 = `r(N)'
}

else {
	local count1111 = 0
}



capture drop `this_file_calculates'
gen  `this_file_calculates' =  0  

if `count1116' > 0 & `count1111' > 0 {

	* Do nothing... already set to zero.

}


else if `count1116' > 0 {

	replace `this_file_calculates' =    ///
	 OP_INV_SALES_VALUE_EU1110               + ///
	 OP_INV_FED_VALUE_EU1110                 + ///
	 OP_INV_SEED_VALUE_EU1110                + ///
	 OP_INV_CLOSING_VALUE_EU1110             - ///
	 OP_INV_VALUE_EU1110                     + ///
	 D_ALLOWANCES_OP_TONNES_HA1110

}


else {

	* Do nothing... already set to zero.

}



replace `this_file_calculates' = 0 /// 
   if missing(`this_file_calculates')



* Add required variables to global list of required vars
global required_vars "$required_vars OP_INV_SALES_VALUE_EU1110"
global required_vars "$required_vars OP_INV_FED_VALUE_EU1110"
global required_vars "$required_vars OP_INV_SEED_VALUE_EU1110"
global required_vars "$required_vars OP_INV_CLOSING_VALUE_EU1110"
global required_vars "$required_vars OP_INV_VALUE_EU1110"
global required_vars "$required_vars D_ALLOWANCES_OP_TONNES_HA1110"

* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars) 


log using `this_file_calculates'.log, text replace




summ `this_file_calculates', detail
codebook `this_file_calculates' 

log close

cd `startdir' // return Stata to previous directory
