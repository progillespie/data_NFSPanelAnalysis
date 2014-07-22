* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.


local startdir: pwd // Save current working directory location


* Move into the root of the variable's directory
local this_file_calculates "I_TOTAL_HOME_GROWN_SEED_EU"
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



* Get varlist to extract crop codes, then build list
*   of crop codes
qui ds TOTAL_EU????  HOME_GROWN_SEED_VALUE_EU????
local vlist "`r(varlist)'"

foreach var of local vlist {

   local code = substr("`var'", -4 , .)
   local crop_codes "`crop_codes ' `code'"

}

* Remove duplicate codes and sort
local crop_codes: list uniq crop_codes
local crop_codes: list sort crop_codes
macro list _crop_codes



* Mark TOTAL_EUXXXX and seed value XXXX vars for existence checking
foreach code of local crop_codes {

    * Create a list of variables which may not exist for the early years
   local nonexist_vlist "`nonexist_vlist' TOTAL_EU`code'"  
   local nonexist_vlist "`nonexist_vlist' HOME_GROWN_SEED_VALUE_EU`code'"

}



* Add nonexist variables to global list of zero vars
*global zero_vlist "$zero_vlist `nonexist_vlist'"

* Make sure each variable enters list only once
*global zero_vlist: list uniq global(zero_vlist)



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



foreach code of local crop_codes {

    * Ensure no missing values in the terms of the equation
    local var "TOTAL_EU`code'"  
    replace `var' = 0  if missing(`var')

    local var "HOME_GROWN_SEED_VALUE_EU`code'"  
    replace `var' = 0  if missing(`var')



    capture drop `this_file_calculates'`code'
    gen double `this_file_calculates'`code' =    ///
      TOTAL_EU`code'                              + ///
      HOME_GROWN_SEED_VALUE_EU`code' 


    * Shouldn't be, but just be sure no missings in calculated var
    replace `this_file_calculates'`code' = 0 /// 
       if missing(`this_file_calculates'`code')

}



* Add required variables to global list of required vars
global required_vars "$required_vars TOTAL_EUXXXX "
global required_vars "$required_vars HOME_GROWN_SEED_VALUE_EUXXXX "

* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars)



cd `startdir' // return Stata to previous directory
ds `this_file_calculates'*, varwidth(32)
