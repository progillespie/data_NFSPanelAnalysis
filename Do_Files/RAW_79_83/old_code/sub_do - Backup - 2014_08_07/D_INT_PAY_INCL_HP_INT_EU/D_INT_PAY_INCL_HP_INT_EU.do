* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.


local startdir: pwd // Save current working directory location


* Move into the root of the variable's directory
local this_file_calculates "D_INT_PAY_INCL_HP_INT_EU"
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
local nonexist_vlist "`nonexist_vlist' HP_TOTAL_REPAYMENTS_EU"



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
replace E_TERM_TOTAL_INTEREST_DEBITED_EU = 0 /// 
   if missing(E_TERM_TOTAL_INTEREST_DEBITED_EU)

replace N_TERM_TOTAL_INTEREST_DEBITED_EU = 0 /// 
   if missing(N_TERM_TOTAL_INTEREST_DEBITED_EU)

replace HP_TOTAL_REPAYMENTS_EU = 0 /// 
   if missing(HP_TOTAL_REPAYMENTS_EU)



capture drop TERM_TOTAL_INTEREST_DEBITED_EU  
gen TERM_TOTAL_INTEREST_DEBITED_EU  = ///
  E_TERM_TOTAL_INTEREST_DEBITED_EU  + ///
  N_TERM_TOTAL_INTEREST_DEBITED_EU  


capture drop `this_file_calculates'
gen  `this_file_calculates' =    ///
  TERM_TOTAL_INTEREST_DEBITED_EU  + ///
  (HP_TOTAL_REPAYMENTS_EU * 0.07)


replace `this_file_calculates' = 0 /// 
   if missing(`this_file_calculates')



* Add required variables to global list of required vars
global required_vars "$required_vars "

* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars) 


log using `this_file_calculates'.log, text replace




summ `this_file_calculates', detail
codebook `this_file_calculates' 

log close

cd `startdir' // return Stata to previous directory
