* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.


local startdir: pwd // Save current working directory location


* Move into the root of the variable's directory
local this_file_calculates "D_PROTEIN_MILK_KGS"
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



foreach month in JAN FEB MAR APR MAY JUN JUL AUG SEP OCT NOV DEC { 

    * Create a list of variables which may not exist for early years
    local nonexist_vlist "`nonexist_vlist' CREAMERY_LITRES_SOLD_`month'_LT"
    local nonexist_vlist "`nonexist_vlist' CREAMERY_PROTEIN_SOLD_`month'_KGS"


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



local vlist "`vlist' "

foreach var of local vlist{

    * Ensure no missing values in the terms of the equation
    replace `var' = 0  if missing(`var')
  
}



capture drop `this_file_calculates'
gen double `this_file_calculates' =              ///
((CREAMERY_LITRES_SOLD_JAN_LT *                     ///
 (CREAMERY_PROTEIN_SOLD_JAN_KGS / 100)) * 1.0297)   ///
                 +                                  ///
((CREAMERY_LITRES_SOLD_FEB_LT *                     ///
 (CREAMERY_PROTEIN_SOLD_FEB_KGS / 100)) * 1.0297)   ///
                 +                                  ///
((CREAMERY_LITRES_SOLD_MAR_LT *                     ///
 (CREAMERY_PROTEIN_SOLD_MAR_KGS / 100)) * 1.0297)   ///
                 +                                  ///
((CREAMERY_LITRES_SOLD_APR_LT *                     ///
 (CREAMERY_PROTEIN_SOLD_APR_KGS / 100)) * 1.0297)   ///
                 +                                  ///
((CREAMERY_LITRES_SOLD_MAY_LT *                     ///
 (CREAMERY_PROTEIN_SOLD_MAY_KGS / 100)) * 1.0297)   ///
                 +                                  ///
((CREAMERY_LITRES_SOLD_JUN_LT *                     ///
 (CREAMERY_PROTEIN_SOLD_JUN_KGS / 100)) * 1.0297)   ///
                 +                                  ///
((CREAMERY_LITRES_SOLD_JUL_LT *                     ///
 (CREAMERY_PROTEIN_SOLD_JUL_KGS / 100)) * 1.0297)   ///
                 +                                  ///
((CREAMERY_LITRES_SOLD_AUG_LT *                     ///
 (CREAMERY_PROTEIN_SOLD_AUG_KGS / 100)) * 1.0297)   ///
                 +                                  ///
((CREAMERY_LITRES_SOLD_SEP_LT *                     ///
 (CREAMERY_PROTEIN_SOLD_SEP_KGS / 100)) * 1.0297)   ///
                 +                                  ///
((CREAMERY_LITRES_SOLD_OCT_LT *                     ///
 (CREAMERY_PROTEIN_SOLD_OCT_KGS / 100)) * 1.0297)   ///
                 +                                  ///
((CREAMERY_LITRES_SOLD_NOV_LT *                     ///
 (CREAMERY_PROTEIN_SOLD_NOV_KGS / 100)) * 1.0297)   ///
                 +                                  ///
((CREAMERY_LITRES_SOLD_DEC_LT *                     ///
 (CREAMERY_PROTEIN_SOLD_DEC_KGS / 100)) * 1.0297)



replace `this_file_calculates' = 0 /// 
   if missing(`this_file_calculates')



* Add required variables to global list of required vars
global required_vars "$required_vars `vlist'"

* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars) 


log using `this_file_calculates'.log, text replace




summ `this_file_calculates', detail
codebook `this_file_calculates' 



log close

cd `startdir' // return Stata to previous directory
