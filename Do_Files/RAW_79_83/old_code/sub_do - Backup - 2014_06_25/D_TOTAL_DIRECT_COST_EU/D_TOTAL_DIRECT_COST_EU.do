* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.


local startdir: pwd // Save current working directory location


* Move into the root of the variable's directory
local this_file_calculates "D_TOTAL_DIRECT_COST_EU"
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



* Extract a list of crop codes from the varnames
*  NOTE: D_FERTILISER_COST_EU was derived in the 
*  conversion process, which is why it exists.
qui ds D_FERTILISER_COST???? I_TOTAL_HOME_GROWN_SEED_EU????
local vlist "`r(varlist)'"

foreach var of local vlist {
	
	local code = substr("`var'", -4, .) 
	local crop_codes "`crop_codes' `code'"
}

* Remove duplicate codes and sort
local crop_codes: list uniq crop_codes
local crop_codes: list sort crop_codes


foreach code of local crop_codes {

	
   * Create a list of variables which may not exist for the early years
   local nonexist_vlist "`nonexist_vlist' D_FERTILISER_COST`code'" 
	 local nonexist_vlist "`nonexist_vlist' I_TOTAL_HOME_GROWN_SEED_EU`code'" 

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



* D_FERTILISER_COST_EU has been calculated 
*  previously (see the do file for this variable, 
*  which is just commentary). 

foreach code of local crop_codes {

	capture gen D_FERTILISER_COST_EU`code' = ///
           D_FERTILISER_COST`code'
	
	* ALLOCATED_TO_CROP_EU is still amalgamated into 6 
	*  variables with an accompanying code variable (which)
	*  indicates the crop. Convert this to separate vars
	*  for each crop. 
	* Initialise the crop specific var
	capture drop ALLOCATED_TO_CROP_EU`code'
	gen ALLOCATED_TO_CROP_EU`code' = 0 
	

	* Loop through amalgamated variables to get value 
	*  for this crop
	local i = 1
	while `i' < 7 {

          * Ensure no missing values
          local var "ALLOCATED_TO_CROP`i'_EU"
          replace `var' = 0 if missing(`var')

	  replace ALLOCATED_TO_CROP_EU`code' = ///
	   ALLOCATED_TO_CROP_EU`code'           + /// 
	   ALLOCATED_TO_CROP`i'_EU                ///
	    if CROP`i'_CODE == `code'

	   local i = `i' + 1

	}



        * Ensure no missing values
        local var "D_FERTILISER_COST_EU`code'" 
        replace `var' = 0 if missing(`var')

        local var "ALLOCATED_TO_CROP_EU`code'" 
        replace `var' = 0 if missing(`var')

        local var "I_TOTAL_HOME_GROWN_SEED_EU`code'" 
        replace `var' = 0 if missing(`var')



	capture drop `this_file_calculates'`code'
	gen  `this_file_calculates'`code' =    ///
	  D_FERTILISER_COST_EU`code'            + ///
 	  ALLOCATED_TO_CROP_EU`code'            + ///
 	  I_TOTAL_HOME_GROWN_SEED_EU`code'

 


  replace `this_file_calculates'`code' = 0 /// 
   if missing(`this_file_calculates'`code')

}

* Add required variables to global list of required vars
global required_vars "$required_vars D_FERTILISER_COST_EUXXXX"
global required_vars "$required_vars ALLOCATED_TO_CROP_EUXXXX"
global required_vars "$required_vars I_TOTAL_HOME_GROWN_SEED_EUXXXX"

* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars)



cd `startdir' // return Stata to previous directory
ds `this_file_calculates'*, varwidth(32)
