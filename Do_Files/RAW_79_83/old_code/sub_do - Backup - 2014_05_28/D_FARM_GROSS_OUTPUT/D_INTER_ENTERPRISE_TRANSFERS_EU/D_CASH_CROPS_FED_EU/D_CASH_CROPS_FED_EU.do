* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.


local startdir: pwd // Save current working directory location


* Move into the root of the variable's directory
local this_file_calculates "D_CASH_CROPS_FED_EU"
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



* Create list of crop codes relevant to summing of OP_INV_FED_VALUE_EU
local op_crop_codes "`op_crop_codes' 1110" 
local op_crop_codes "`op_crop_codes' 1140" 
local op_crop_codes "`op_crop_codes' 1150" 
local op_crop_codes "`op_crop_codes' 1430" //missing
local op_crop_codes "`op_crop_codes' 1210" //missing
local op_crop_codes "`op_crop_codes' 1560" 
local op_crop_codes "`op_crop_codes' 1570"
local op_crop_codes "`op_crop_codes' 1310"
local op_crop_codes "`op_crop_codes' 1320" //missing
local op_crop_codes "`op_crop_codes' 1270" //missing
local op_crop_codes "`op_crop_codes' 1280" //missing
local op_crop_codes "`op_crop_codes' 1290" //missing

* Create variable and sum over crop codes
capture drop ALL_OP_INV_FED_VALUE_EU 
gen ALL_OP_INV_FED_VALUE_EU = 0

foreach code of local op_crop_codes{

	* Record which codes are missing
	capture confirm variable OP_INV_FED_VALUE_EU`code'
	if _rc!=0{
	   local miss_c_codes "`miss_c_codes' `code'"
	}

	* Add value to total, ignore if var doesn't exist	
	capture replace ALL_OP_INV_FED_VALUE_EU = ///
	   ALL_OP_INV_FED_VALUE_EU         + ///
	   OP_INV_FED_VALUE_EU`code' 

}



* Create list of crop codes relevant to summing of CY_FED_VALUE_EU
local cy_crop_codes "`cy_crop_codes' 1116"
local cy_crop_codes "`cy_crop_codes' 1111"
local cy_crop_codes "`cy_crop_codes' 1117"
local cy_crop_codes "`cy_crop_codes' 1146"
local cy_crop_codes "`cy_crop_codes' 1141"
local cy_crop_codes "`cy_crop_codes' 1147"
local cy_crop_codes "`cy_crop_codes' 1571"
local cy_crop_codes "`cy_crop_codes' 1156"
local cy_crop_codes "`cy_crop_codes' 1151"
local cy_crop_codes "`cy_crop_codes' 1431"
local cy_crop_codes "`cy_crop_codes' 1211" //missing
local cy_crop_codes "`cy_crop_codes' 1561"
local cy_crop_codes "`cy_crop_codes' 1311"
local cy_crop_codes "`cy_crop_codes' 1321"
local cy_crop_codes "`cy_crop_codes' 1271" //missing
local cy_crop_codes "`cy_crop_codes' 1281" //missing
local cy_crop_codes "`cy_crop_codes' 1286" //missing
local cy_crop_codes "`cy_crop_codes' 1291" //missing

* Create variable and sum over crop codes
capture drop ALL_CY_FED_VALUE_EU 
gen ALL_CY_FED_VALUE_EU = 0

foreach code of local cy_crop_codes{
	
	* Record which codes are missing
	capture confirm variable CY_FED_VALUE_EU`code'
	if _rc!=0{
	   local miss_c_codes "`miss_c_codes' `code'"
	}
	
	* Deal with missing obs (within existing codes)
	capture replace CY_FED_VALUE_EU`code'= 0 ///
	   if missing(ALL_CY_FED_VALUE_EU)

	* Add value to total, ignore if var doesn't exist	
	capture replace ALL_CY_FED_VALUE_EU = ///
	   ALL_CY_FED_VALUE_EU         + ///
	   CY_FED_VALUE_EU`code' 

}



* Add missing codes to global list of missing codes
*  making sure each code enters list only once
global missing_crop_codes: list uniq miss_c_codes



capture drop `this_file_calculates'
gen  `this_file_calculates' =    ///
 ALL_OP_INV_FED_VALUE_EU          + ///
 ALL_CY_FED_VALUE_EU          



replace `this_file_calculates' = 0 /// 
   if missing(`this_file_calculates')



* Add required variables to global list of required vars
global required_vars "$required_vars ALL_OP_INV_FED_VALUE_EU"
global required_vars "$required_vars ALL_CY_FED_VALUE_EU"

* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars)



cd `startdir' // return Stata to previous directory
