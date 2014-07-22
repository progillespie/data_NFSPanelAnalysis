* Create whatever derived variables are needed for this variable and
*  calculate the variable itself.


local startdir: pwd // Save current working directory location


* Move into the root of the variable's directory
local this_file_calculates "D_DEER_SALES_EU"
dir
cd  `this_file_calculates'
local vardir: pwd


* Needed variables get their own subdirectories. Look for subfolders
*  and use their names to determine which variables you need to
*  calculate for this variable.
local vars_needed: dir "." dirs *


foreach var_needed of local vars_needed {
	di "Deriving `var_needed'"
	qui do `var_needed'/`var_needed'.do
	pwd
}



* Create a list of variables which may not exist for the early years
local nonexist_vlist "`nonexist_vlist' FINISHED_MALES_SALES_EU"
local nonexist_vlist "`nonexist_vlist' FINISHED_FEMALES_SALES_EU"
local nonexist_vlist "`nonexist_vlist' BREEDING_MALES_SALES_EU"
local nonexist_vlist "`nonexist_vlist' BREEDING_FEMALES_SALES_EU"
local nonexist_vlist "`nonexist_vlist' STORE_CALVES_FEMALE_SALES_EU"
local nonexist_vlist "`nonexist_vlist' STORE_CALVES_MALE_SALES_EU"
local nonexist_vlist "`nonexist_vlist' CULLS_SALES_EU"
local nonexist_vlist "`nonexist_vlist' OTHER_INCL_ALLOWANCES_SALES_EU"


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



capture drop `this_file_calculates'
gen `this_file_calculates' =   ///
 FINISHED_MALES_SALES_EU        + ///
 FINISHED_FEMALES_SALES_EU      + ///
 BREEDING_MALES_SALES_EU        + ///
 BREEDING_FEMALES_SALES_EU      + ///
 STORE_CALVES_FEMALE_SALES_EU   + ///
 STORE_CALVES_MALE_SALES_EU     + ///
 CULLS_SALES_EU                 + ///
 OTHER_INCL_ALLOWANCES_SALES_EU



replace `this_file_calculates' = 0 /// 
   if missing(`this_file_calculates')



* Add required variables to global list of required vars
global required_vars "$required_vars "

* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars) 


log using `this_file_calculates'.log, text replace





log close

cd `startdir' // return Stata to previous directory
