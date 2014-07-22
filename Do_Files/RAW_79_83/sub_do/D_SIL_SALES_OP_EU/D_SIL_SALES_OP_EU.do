* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.


local startdir: pwd // Save current working directory location


* Move into the root of the variable's directory
local this_file_calculates "D_SIL_SALES_OP_EU"
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


* Create temporary intermediate variable to clarify formula
capture drop OP_INV_less_FED 
gen OP_INV_less_FED = SIL_OP_INV_QTY_TONNES - SIL_FED_QUANTITY_TONNES



capture drop `this_file_calculates'
gen  `this_file_calculates' = 0

* All silage sales came out of opening stock
replace `this_file_calculates' =                        ///
  SIL_SALES_VALUE_EU                                       ///
                                                        ///
 if SIL_SALES_QUANTITY_TONNES > 0                     & ///
 SIL_FED_QUANTITY_TONNES      < SIL_OP_INV_QTY_TONNES & ///
 SIL_SALES_QUANTITY_TONNES    < OP_INV_less_FED         ///



* Only a proportion of silage sales came out of opening stock
replace `this_file_calculates' =                         ///
  (OP_INV_less_FED / SIL_SALES_QUANTITY_TONNES)           * ///
  SIL_SALES_VALUE_EU                                        ///
                                                         ///
 if SIL_SALES_QUANTITY_TONNES >  0                     & ///
 SIL_FED_QUANTITY_TONNES      <  SIL_OP_INV_QTY_TONNES & ///
 SIL_SALES_QUANTITY_TONNES    >= OP_INV_less_FED         ///



* Won't need the intermediate vars any longer
drop OP_INV_less_FED 


/* ---- Original IB code (indentation and spacing added) ----

if(number(SIL_SALES_QUANTITY_TONNES) <= 0) 
   then 0

else
   if(number(SIL_FED_QUANTITY_TONNES) >=  
		SIL_OP_INV_QTY_TONNES) 
      then 0

   else
      if(SIL_SALES_QUANTITY_TONNES < 
            (SIL_OP_INV_QTY_TONNES - 
             SIL_FED_QUANTITY_TONNES)
        ) 
         then SIL_SALES_VALUE_EU

      else
         if(SIL_SALES_QUANTITY_TONNES >= 
            (SIL_OP_INV_QTY_TONNES -
             SIL_FED_QUANTITY_TONNES)
           ) then 
                (
                 (SIL_OP_INV_QTY_TONNES - SIL_FED_QUANTITY_TONNES) div 
                  SIL_SALES_QUANTITY_TONNES
                )                                                  * 
                SIL_SALES_VALUE_EU
         else 0


NOTE: Some of the inequalities flipped due to the difference in 
approach I've taken. I start with all values = 0 then replace values
on the basis of the conditions, whereas the IB code assigns 0's and 
non-zeroes on the basis of conditions. 

e.g. the lines

if(number(SIL_SALES_QUANTITY_TONNES) <= 0) 
   then 0

... are redundant for me, because my variable is already set to 0. 
-----------------------------------------------------------*/



replace `this_file_calculates' = 0 /// 
   if missing(`this_file_calculates')



* Add required variables to global list of required vars
global required_vars "$required_vars "

* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars) 


log using `this_file_calculates'.log, text replace





log close

cd `startdir' // return Stata to previous directory
