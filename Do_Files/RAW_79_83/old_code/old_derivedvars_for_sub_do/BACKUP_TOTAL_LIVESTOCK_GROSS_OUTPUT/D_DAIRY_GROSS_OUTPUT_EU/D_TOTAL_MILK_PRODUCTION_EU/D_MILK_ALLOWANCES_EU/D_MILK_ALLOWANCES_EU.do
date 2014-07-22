* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.


local startdir: pwd // Save current working directory location


* Move into the root of the variable's directory
local this_file_calculates "D_MILK_ALLOWANCES_EU"
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
global : list uniq global(zero_vlist)



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
gen  `this_file_calculates' =    ///
 ALLOW_WHOLE_MILK_HOUSE_EU  + ///
 ALLOW_WHOLE_MILK_WAGES_EU  + ///
 ALLOW_WHOLE_MILK_OTHER_EU  + ///
 ALLOW_BUTTER_HOUSE_EU      + ///
 ALLOW_BUTTER_WAGES_EU      + ///
 ALLOW_BUTTER_OTHER_EU      + ///
 ALLOW_OTHER_DAIRY_HOUSE_EU + ///
 ALLOW_OTHER_DAIRY_WAGES_EU



replace `this_file_calculates' = 0 /// 
   if missing(`this_file_calculates')



* Add required variables to global list of required vars
global required_vars "$required_vars ALLOW_WHOLE_MILK_HOUSE_EU"
global required_vars "$required_vars ALLOW_WHOLE_MILK_WAGES_EU"
global required_vars "$required_vars ALLOW_WHOLE_MILK_OTHER_EU"
global required_vars "$required_vars ALLOW_BUTTER_HOUSE_EU"
global required_vars "$required_vars ALLOW_BUTTER_WAGES_EU"
global required_vars "$required_vars ALLOW_BUTTER_OTHER_EU"
global required_vars "$required_vars ALLOW_OTHER_DAIRY_HOUSE_EU"
global required_vars "$required_vars ALLOW_OTHER_DAIRY_WAGES_EU"

* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars)



cd `startdir' // return Stata to previous directory
