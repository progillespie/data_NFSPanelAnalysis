* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.


local startdir: pwd // Save current working directory location


* Move into the root of the variable's directory
local this_file_calculates "D_SO_GROSS_OUTPUT_OP_INV_EU"
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
qui capture replace OP_INV_SALES_VALUE_EU1156 = 0 ///
     if missing(OP_INV_SALES_VALUE_EU1156)
qui capture count if OP_INV_SALES_VALUE_EU1156 > 0
if _rc==0 {
	local count1156 = `r(N)'
}

else {
	local count1156 = 0
}


qui capture replace OP_INV_SALES_VALUE_EU1151 = 0 ///
     if missing(OP_INV_SALES_VALUE_EU1151)
qui capture count if OP_INV_SALES_VALUE_EU1151 > 0
if _rc==0 {
	local count1151 = `r(N)'
}

else {
	local count1151 = 0
}



capture drop `this_file_calculates'
gen  `this_file_calculates' =  0  

if `count1156' > 0 & `count1151' > 0 {

	replace `this_file_calculates' =    ///
	 OP_INV_SALES_VALUE_EU1150               + ///
	 OP_INV_FED_VALUE_EU1150                 + ///
	 OP_INV_SEED_VALUE_EU1150                + ///
	 OP_INV_CLOSING_VALUE_EU1150             - ///
	 OP_INV_VALUE_EU1150                     + ///
	 D_ALLOWANCES_OP_TONNES_HA1150

}


else if `count1156' > 0 {

	* Do nothing... already set to zero.

}


else {

	replace `this_file_calculates' =    ///
	 OP_INV_SALES_VALUE_EU1150               + ///
	 OP_INV_FED_VALUE_EU1150                 + ///
	 OP_INV_SEED_VALUE_EU1150                + ///
	 OP_INV_CLOSING_VALUE_EU1150             - ///
	 OP_INV_VALUE_EU1150                     + ///
	 D_ALLOWANCES_OP_TONNES_HA1150

}



replace `this_file_calculates' = 0 /// 
   if missing(`this_file_calculates')



* Add required variables to global list of required vars
global required_vars "$required_vars OP_INV_SALES_VALUE_EU1150"
global required_vars "$required_vars OP_INV_FED_VALUE_EU1150"
global required_vars "$required_vars OP_INV_SEED_VALUE_EU1150"
global required_vars "$required_vars OP_INV_CLOSING_VALUE_EU1150"
global required_vars "$required_vars OP_INV_VALUE_EU1150"
global required_vars "$required_vars D_ALLOWANCES_OP_TONNES_HA1150"

* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars) 


log using `this_file_calculates'.log, text replace




summ `this_file_calculates', detail
codebook `this_file_calculates' 

log close

cd `startdir' // return Stata to previous directory
