* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.


local startdir: pwd // Save current working directory location


* Move into the root of the variable's directory
local this_file_calculates "D_GROSS_OUTPUT_FDR_CROPS_SOLD_EU"
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

* !!! temporary fix !!! * 
* Create a list of variables which may not exist for the early years
local nonexist_vlist "`nonexist_vlist' USED_IN_HOUSE_TURF_EU"



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



local op_sales_codes "`op_sales_codes' 9060"
local op_sales_codes "`op_sales_codes' 9040"
local op_sales_codes "`op_sales_codes' 9030"
local op_sales_codes "`op_sales_codes' 9020"
local op_sales_codes "`op_sales_codes' 9050"
local op_sales_codes "`op_sales_codes' 9070"
local op_sales_codes "`op_sales_codes' 9080"
local op_sales_codes "`op_sales_codes' 8110"
local op_sales_codes "`op_sales_codes' 8120"

capture drop ALL_OP_INV_SALES_VALUE_EU
gen ALL_OP_INV_SALES_VALUE_EU = 0 

foreach code of local op_sales_codes {

	* Record which codes are missing
	capture confirm variable OP_INV_SALES_VALUE_EU`code'
	if _rc!=0{
	   local miss_c_codes "`miss_c_codes' `code'"
	}
	
	* Add value to total, ignore if var doesn't exist	
	capture replace ALL_OP_INV_SALES_VALUE_EU= ///
	   ALL_OP_INV_SALES_VALUE_EU                + ///
	   OP_INV_SALES_VALUE_EU`code' 


}


/* ---- ORIGINAL IB CODE for this term of the equation ----
sum(for $i in root/svy_crops return
if(matches($i/@crop_code, '902[1-9]') 
or matches($i/@crop_code, '903[1-9]') or matches($i/@crop_code, '904[1-9]') 
or matches($i/@crop_code, '905[1-9]') or matches($i/@crop_code, '906[1-9]') 
or matches($i/@crop_code, '907[1-9]') or matches($i/@crop_code, '908[1-9]')
or matches($i/@crop_code, '811[1-9]') or matches($i/@crop_code, '812[1-9]'))
then ($i/@cy_sales_value_eu) else 0)

in english

The IB code says "Look up tables for the crop code prefixes listed and with 
the suffixes 1 - 9 and  return the value of the variable CY_SALES_VALUE_EU 
(which occurs in each table). Then sum over all of these values.  

The Stata data set is a single large dataset, so each crops' value of  
CY_SALES_VALUE_EU is stored in a variable  CY_SALES_VALUE_EUXXXX where XXXX
is the four digit crop code pasted on to the end of the variable name (to 
avoid duplicate varnames). To sum over all of the values for the relevant 
crop codes we can create the summing variable = 0 then add each crop code
value to it inside of a loop (in this case a double loop). 
*/



capture drop ALL_CY_SALES_VALUE_EU
gen ALL_CY_SALES_VALUE_EU = 0 

foreach prefix of numlist 902 903 904 905 906 907 908 811 812 {

	local i = 1
	while `i' < 10 {

	  local cy_sales_codes "`cy_sales_codes' CY_SALES_VALUE_EU`prefix'`i'"

	  * Confirm variable exists
	  capture confirm variable CY_SALES_VALUE_EU`prefix'`i'

	  * Note in a list if it doesn't 
	  if _rc!=0{
	    local miss_c_codes "`miss_c_codes' `prefix'`i'"
	  }

	  * Deal with missing values in existing variables
	  capture replace CY_SALES_VALUE_EU`prefix'`i' = 0 ///
	     if missing(CY_SALES_VALUE_EU`prefix'`i')
	
	  capture replace ALL_CY_SALES_VALUE_EU = ///
	   ALL_CY_SALES_VALUE_EU + ///
	   CY_SALES_VALUE_EU`prefix'`i'

	  local i = `i' + 1
	
	}
}

global missing_crop_codes "missing_crop_codes `miss_c_codes'" 
global missing_crop_codes: list uniq global(missing_crop_codes)




capture drop `this_file_calculates'
/* ---- Special Calculation ----------------------------------- 
 The equation as listed in the documentation requires variables
  recording Boarding-in for Dairy and non-Dairy livestock 
  separately, but apparently this is not available from 79-83.
  The data instead records the combined Dairy and non-Dairy figures 

  Entering the 79-83 values under the same variables without
   knowing if it is appropriate to do so is a bad idea. Rather, 
   I've created new variables which make it clear that these
   values are for the combined Dairy and non-Dairy figures.

  In case this code is ever applied to data that has those vars, 
   I make the equation conditional. The code checks for the 
   original formula's  vars. If it finds them, the original 
   formula is applied. However, unless the original formula's
   variables can be confirmed in the data (_rc==0), my 
   edited formula is applied. 

   THIS WILL NOT HANDLE THE CASE WHERE THE VARIABLES EXIST 
   FOR SOME YEARS, BUT NOT FOR OTHERS!!! You would probably 
   be best served by making the formula conditional on specific
   years instead of the _rc code in this instance.
------------------------------------------------------------*/



* Check for original formula's variables
capture confirm variable BOARDING_IN_CATTLE2_EU
local BI_CTL1 = _rc
capture confirm BOARDING_IN_CATTLE1_EU
local BI_CTL2 = _rc
capture confirm BOARDING_IN_DAIRY_EU
local BI_DY = _rc



* If you confirm their existence, do the original formula
if `BI_CTL1'==0 & `BI_CTL2'==0 & `BI_DY'==0 {

        di "Using original formula"
	gen  `this_file_calculates' =    ///
	 ALL_OP_INV_SALES_VALUE_EU        + ///
	 ALL_CY_SALES_VALUE_EU            + ///
	 D_HAY_SALES_OP_EU                + ///
	 D_HAY_SALES_CU_EU                + ///
	 D_SIL_SALES_OP_EU                + ///
	 D_SIL_SALES_CU_EU                + ///
	 BOARDING_IN_HORSES_EU            + ///
	 BOARDING_IN_SHEEP2_EU            + ///
	 BOARDING_IN_SHEEP1_EU            + ///
	 BOARDING_IN_CATTLE2_EU           + ///
	 BOARDING_IN_CATTLE1_EU           + ///
	 BOARDING_IN_DAIRY_EU             + ///
	 USED_IN_HOUSE_TURF_EU



	global required_vars "$required_vars ALL_OP_INV_SALES_VALUE_EU"
	global required_vars "$required_vars ALL_CY_SALES_VALUE_EU"
	global required_vars "$required_vars D_HAY_SALES_OP_EU"
	global required_vars "$required_vars D_HAY_SALES_CU_EU"
	global required_vars "$required_vars D_SIL_SALES_OP_EU"
	global required_vars "$required_vars D_SIL_SALES_CU_EU"
	global required_vars "$required_vars BOARDING_IN_HORSES_EU"
	global required_vars "$required_vars BOARDING_IN_SHEEP2_EU"
	global required_vars "$required_vars BOARDING_IN_SHEEP1_EU"
	global required_vars "$required_vars BOARDING_IN_CATTLE2_EU"
	global required_vars "$required_vars BOARDING_IN_CATTLE1_EU"
	global required_vars "$required_vars BOARDING_IN_DAIRY_EU"
	global required_vars "$required_vars USED_IN_HOUSE_TURF_EU"

}

* Otherwise, do the edited formula (will apply in 79 - 83)
else {

        di "Using edited formula"
	gen  `this_file_calculates' =    ///
	 ALL_OP_INV_SALES_VALUE_EU        + ///
	 ALL_CY_SALES_VALUE_EU            + ///
	 D_HAY_SALES_OP_EU                + ///
	 D_HAY_SALES_CU_EU                + ///
	 D_SIL_SALES_OP_EU                + ///
	 D_SIL_SALES_CU_EU                + ///
	 BOARDING_IN_HORSES_EU            + ///
	 BOARDING_IN_SHEEP2_EU            + ///
	 BOARDING_IN_SHEEP1_EU            + ///
	 BOARDING_IN_DAIRY_CATTLE1_EU      + /// 
	 BOARDING_IN_DAIRY_CATTLE2_EU      + ///
	 BOARDING_IN_DAIRY_CATTLE3_EU      + ///
	 USED_IN_HOUSE_TURF_EU



	global required_vars "$required_vars ALL_OP_INV_SALES_VALUE_EU"
	global required_vars "$required_vars ALL_CY_SALES_VALUE_EU"
	global required_vars "$required_vars D_HAY_SALES_OP_EU"
	global required_vars "$required_vars D_HAY_SALES_CU_EU"
	global required_vars "$required_vars D_SIL_SALES_OP_EU"
	global required_vars "$required_vars D_SIL_SALES_CU_EU"
	global required_vars "$required_vars BOARDING_IN_HORSES_EU"
	global required_vars "$required_vars BOARDING_IN_SHEEP2_EU"
	global required_vars "$required_vars BOARDING_IN_SHEEP1_EU"
	global required_vars "$required_vars BOARDING_IN_DAIRY_CATTLE1_EU"
	global required_vars "$required_vars BOARDING_IN_DAIRY_CATTLE2_EU"
	global required_vars "$required_vars BOARDING_IN_DAIRY_CATTLE3_EU"
	global required_vars "$required_vars USED_IN_HOUSE_TURF_EU"

}


 
replace `this_file_calculates' = 0 /// 
   if missing(`this_file_calculates')



* Add required variables to global list of required vars
/*
 NOTE: The required vars global will reflect the particular formula 
       applied above (as you'd expect). To accomplish this, the 
       lines defining the macro were move up a bit (into the if 
       and else statements). 

       !IMPORTANT!: I kept the comment "Add required variables..."
       in the same place though, and did not copy it because I use 
       that line for searching and replacing text in my text editor. 
       DON'T MOVE THAT COMMENT!
*/

* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars)



cd `startdir' // return Stata to previous directory
