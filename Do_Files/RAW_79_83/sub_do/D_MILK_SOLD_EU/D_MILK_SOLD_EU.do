* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.


local startdir: pwd // Save current working directory location


* Move into the root of the variable's directory
local this_file_calculates "D_MILK_SOLD_EU"
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
local nonexist_vlist "`nonexist_vlist' LQMILK_SOLD_WHOLESALE_RETAIL_EU"
local nonexist_vlist "`nonexist_vlist' LQMILK_SOLD_WHOLESALE_RETAIL_LT"
local nonexist_vlist "`nonexist_vlist' CREAMERY_PENALTIES_EU"



* Add nonexist variables to global list of zero vars
global zero_vlist "$zero_vlist `nonexist_vlist'"

* Make sure each variable enters list only once
global zero_vlist: list uniq global(zero_vlist)



* Check if those vars exist, and if not create them as zero vectors
foreach var of local nonexist_vlist {

	capture confirm variable `var'

	if _rc!=0{
	
		if "`var'"== "LQMILK_SOLD_WHOLESALE_RETAIL_EU"{
		   gen `var' = ///
		    LqMilkSoldWSALE_EU  + ///
		    LqMilkSoldRETAIL_EU
		}

		else if "`var'"== "LQMILK_SOLD_WHOLESALE_RETAIL_LT"{
		   gen `var' =  ///
		    LqMilkSoldWSALE_LT  + ///
		    LqMilkSoldRETAIL_LT
		}

		else {
		   gen `var' = 0
		}

	}

}

* Shortened LQMILK_SOLD_WHOLESALE_RETAIL_EU (LIQUID = LQ)


capture drop `this_file_calculates'
gen  `this_file_calculates' =    ///
 ( LQMILK_SOLD_WHOLESALE_RETAIL_EU + ///
   WHOLE_MILK_SOLD_TO_CREAMERY_EU      + /// 1ST TERM
   CREAMERY_BONUSES_EU )                 ///
                     -                /// LAST TERM 
 CREAMERY_PENALTIES_EU                   



replace `this_file_calculates' = 0 /// 
   if missing(`this_file_calculates')



* Add required variables to global list of required vars
global required_vars "$required_vars LQMILK_SOLD_WHOLESALE_RETAIL_EU"
global required_vars "$required_vars WHOLE_MILK_SOLD_TO_CREAMERY_EU"
global required_vars "$required_vars CREAMERY_BONUSES_EU"
global required_vars "$required_vars CREAMERY_PENALTIES_EU"

* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars) 


log using `this_file_calculates'.log, text replace





log close

cd `startdir' // return Stata to previous directory
