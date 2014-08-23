* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.


local startdir: pwd // Save current working directory location


* Move into the root of the variable's directory
local this_file_calculates "I_SHEEP_LU_HOME_GRAZING"
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
local vlist "`vlist' D_SHEEP_LIVESTOCK_UNITS"
local vlist "`vlist' COMMONAGE_SHEEP1_ANIMALS_NO"
local vlist "`vlist' COMMONAGE_SHEEP1_DAYS_NO"
local vlist "`vlist' COMMONAGE_SHEEP1_LU_EQUIV"
local vlist "`vlist' COMMONAGE_SHEEP2_ANIMALS_NO"
local vlist "`vlist' COMMONAGE_SHEEP2_DAYS_NO"
local vlist "`vlist' COMMONAGE_SHEEP2_LU_EQUIV"
local vlist "`vlist' D_SHEEP_LU_BOARDING_OUT_NO"
local vlist "`vlist' D_SHEEP_LU_BOARDING_IN_NO"

foreach var of local vlist{

    * Ensure there's no missing value in these either
    replace `var' = 0  if missing(`var')
  
}

  

capture drop `this_file_calculates'
gen double `this_file_calculates' =   ///
  (                                      ///
    D_SHEEP_LIVESTOCK_UNITS              ///
                                      ///
                   -                     ///
                                      ///
    (                                 ///
      COMMONAGE_SHEEP1_ANIMALS_NO      * ///
      (COMMONAGE_SHEEP1_DAYS_NO / 365) * ///
      COMMONAGE_SHEEP1_LU_EQUIV       ///
                                      ///
                   +                  ///
                                      ///
      COMMONAGE_SHEEP2_ANIMALS_NO      * ///
      (COMMONAGE_SHEEP2_DAYS_NO / 365) * ///
      COMMONAGE_SHEEP2_LU_EQUIV          ///
    )                                 ///
                                      ///
  )                                   ///                 
                   -                     ///
  (                                   ///
    D_SHEEP_LU_BOARDING_OUT_NO         - ///
    D_SHEEP_LU_BOARDING_IN_NO            ///
  )                                  



replace `this_file_calculates' = 0 /// 
   if missing(`this_file_calculates')



* Add required variables to global list of required vars
global required_vars "$required_vars `vlist'"

* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars)



cd `startdir' // return Stata to previous directory
summ `this_file_calculates', detail
codebook `this_file_calculates' 
