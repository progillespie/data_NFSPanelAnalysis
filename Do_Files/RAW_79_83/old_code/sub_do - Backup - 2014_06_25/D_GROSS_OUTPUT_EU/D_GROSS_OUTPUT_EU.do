* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.


local startdir: pwd // Save current working directory location


* Move into the root of the variable's directory
local this_file_calculates "D_GROSS_OUTPUT_EU"
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
qui ds CY_SALES_VALUE_EU????
local vlist "`r(varlist)'"

foreach var of local vlist {
	local code = substr("`var'", -4, .) 
	local crop_codes "`crop_codes' `code'"
}

* Make sure there's no repeating codes
local crop_codes: list uniq crop_codes



foreach code of local crop_codes {

* Create a list of variables which may not exist for the early years
local nonexist_vlist "`nonexist_vlist' D_TOTAL_DIRECT_COST_EU`code'"

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



foreach code of local crop_codes {

	* Removing missings in eq.'s terms
	foreach var of varlist ///
	  CY_SALES_VALUE_EU`code'        ///
          CY_FED_VALUE_EU`code'          ///
          CY_CLOSING_VALUE_EU`code'      ///
          CY_WASTE_TONNES_HA`code'   ///
          CY_ALLOW_HOUSE_TONNES_HA`code' ///
          CY_ALLOW_WAGES_TONNES_HA`code' {
	     
	      
	      replace `var' = 0 /// 
	         if missing(`var')
         } 


	* Intermediate var for if statement
	capture drop HouseAndWages`code'
	gen HouseAndWages`code' = ///
	  CY_ALLOW_HOUSE_TONNES_HA`code' + ///
	  CY_ALLOW_WAGES_TONNES_HA`code'
	

	* Initialise var at 0 
	capture drop `this_file_calculates'`code'
	gen  `this_file_calculates'`code' = 0

	* Update based on condition
	replace  `this_file_calculates'`code' =    ///
          (                                        ///
            CY_SALES_VALUE_EU`code'             + ///
            CY_FED_VALUE_EU`code'               + ///
            CY_CLOSING_VALUE_EU`code'             ///
                                                   ///
          )        +                                  ///
                                                   ///
          (                                        ///
            (                                      ///
              CY_ALLOW_HOUSE_TONNES_HA`code'    + ///
              CY_ALLOW_WAGES_TONNES_HA`code'      ///
                                                   ///
            )      /                                  ///
                                                   ///
            (                                      ///
              CY_CLOSING_QTY_TONNES_HA`code'       - ///
              CY_WASTE_TONNES_HA`code'            ///
            )                                      ///
                                                   ///
          )        *                               ///
                                                   ///
	  D_TOTAL_DIRECT_COST_EU`code'             ///
	   if HouseAndWages`code' > 0 



replace `this_file_calculates'`code' = 0 /// 
   if missing(`this_file_calculates'`code')



}



* Add required variables to global list of required vars
global required_vars "$required_vars "

* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars)



cd `startdir' // return Stata to previous directory
