* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.


local startdir: pwd // Save current working directory location


* Move into the root of the variable's directory
local this_file_calculates "D_HAY_SALES_CU_EU"
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

* This equation required a class of derived variable which uses an 
*  I_ prefix instead of D_. Confusingly, the syntax of this language
*  also uses i as in index, but in this instance it is part of the 
*  actual varname. 

* We can easily calculate this variable using the closely related 
*  D_HAY_SALES_OP_EU
* If we use that code to generate the variable on the fly (again
*  possibly) we can avoid duplicated codes (and the errors that come
*  with it... e.g. updates to one, that are missed for the other).
qui cd ..
qui do D_HAY_SALES_OP_EU/D_HAY_SALES_OP_EU.do
cd `startdir' // return to this files working directory


capture drop `this_file_calculates'
gen  `this_file_calculates' = 0

replace `this_file_calculates' =                 ///
 HAY_SALES_VALUE_EU                               - ///
 D_HAY_SALES_OP_EU                                  ///
                                                 ///
 if I_HAY_SALES_OP_QTY        > 0              & ///
    HAY_SALES_QUANTITY_TONNES > 0

replace `this_file_calculates' = 0 if missing(`this_file_calculates')



* In terms of raw variables this should be equivalent to
/*
capture drop test
gen test = 0
replace test =                 ///
 HAY_SALES_VALUE_EU                               - ///
  (I_HAY_SALES_OP_QTY                             * ///
   (HAY_SALES_VALUE_EU / HAY_SALES_QUANTITY_TONNES) ///
  )                                              ///
                                                 ///
 if I_HAY_SALES_OP_QTY        > 0              & ///
    HAY_SALES_QUANTITY_TONNES > 0
replace test = 0 if missing(test)

br `this_file_calculates' test if `this_file_calculates'!=test
*/
* If you uncomment above you will see that differences are only due to 
*  limitations in machine precision, and occur several decimal places out
*  to the right. The benefits of reusing the same code outweight this 
*  small difference.



replace `this_file_calculates' = 0 /// 
   if missing(`this_file_calculates')



* Add required variables to global list of required vars
global required_vars "$required_vars "

* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars) 


log using `this_file_calculates'.log, text replace





log close

cd `startdir' // return Stata to previous directory
