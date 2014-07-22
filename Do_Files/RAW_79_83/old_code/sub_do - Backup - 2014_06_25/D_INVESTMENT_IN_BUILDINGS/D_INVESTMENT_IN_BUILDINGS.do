* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.


local startdir: pwd // Save current working directory location


* Move into the root of the variable's directory
local this_file_calculates "D_INVESTMENT_IN_BUILDINGS"
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



* Ensure no missing values in the terms of the equation
replace BLD_REPLACE_NET_VALUE = 0 /// 
   if missing(BLD_REPLACE_NET_VALUE)



* NOTE: In the original formula, REPLACE_NET_VALUE is summed over
*  the assets classes PMA (Power Machinery) and OMA (Other machinery)
*  The same is happening here, but we keep them in separate variables
*  instead of a single variable with classes.
capture drop `this_file_calculates'
gen  `this_file_calculates' =    ///
 BLD_REPLACE_NET_VALUE 



replace `this_file_calculates' = 0 /// 
   if missing(`this_file_calculates')



* Add required variables to global list of required vars
global required_vars "$required_vars PMA_REPLACE_NET_VALUE"
global required_vars "$required_vars OMA_REPLACE_NET_VALUE"

* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars)



cd `startdir' // return Stata to previous directory
summ `this_file_calculates', detail
codebook `this_file_calculates' 
