* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.


local startdir: pwd // Save current working directory location


* Move into the root of the variable's directory
local this_file_calculates "I_TOTAL_LU_HOME_GRAZING"
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



* List of equation terms. Ensure not missing.
local vlist "`vlist' D_DEER_LIVESTOCK_UNITS"
local vlist "`vlist' I_HORSES_LU_HOME_GRAZING"
local vlist "`vlist' I_SHEEP_LU_HOME_GRAZING"
local vlist "`vlist' I_CATTLE_LU_HOME_GRAZING"
local vlist "`vlist' I_DAIRY_LU_HOME_GRAZING"

foreach var of local vlist{

    * Ensure there's no missing value in these either
    replace `var' = 0  if missing(`var')
  
}



capture drop `this_file_calculates'
gen double `this_file_calculates' =  ///
D_DEER_LIVESTOCK_UNITS   + ///
I_HORSES_LU_HOME_GRAZING + ///
I_SHEEP_LU_HOME_GRAZING  + ///
I_CATTLE_LU_HOME_GRAZING + ///
I_DAIRY_LU_HOME_GRAZING


replace `this_file_calculates' = 0 /// 
   if missing(`this_file_calculates')



* Add required variables to global list of required vars
global required_vars "$required_vars D_DEER_LIVESTOCK_UNITS"
global required_vars "$required_vars I_HORSES_LU_HOME_GRAZING"
global required_vars "$required_vars I_SHEEP_LU_HOME_GRAZING"
global required_vars "$required_vars I_CATTLE_LU_HOME_GRAZING"
global required_vars "$required_vars I_DAIRY_LU_HOME_GRAZING"

* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars)



cd `startdir' // return Stata to previous directory
summ `this_file_calculates', detail
codebook `this_file_calculates' 
