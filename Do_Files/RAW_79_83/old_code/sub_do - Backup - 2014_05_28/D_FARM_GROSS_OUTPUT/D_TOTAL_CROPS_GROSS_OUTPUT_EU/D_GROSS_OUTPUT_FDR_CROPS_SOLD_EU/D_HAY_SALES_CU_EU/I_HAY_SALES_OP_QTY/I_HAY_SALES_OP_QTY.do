* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.


local startdir: pwd // Save current working directory location


* Move into the root of the variable's directory
local this_file_calculates "I_HAY_SALES_OP_QTY"
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




/* 
   Essentially, the opening inventory for hay sales is set to 
    HAY_SALES_QUANTITY_TONNES as long as this figure minus
    Sales, Waste, Amount Fed to livestock, and Allowances
    remains above 0. 

   If not, then use net of just Waste, Fed, and Allowances as 
    long as that is > 0. 

   If still <= 0, just set to 0.
*/

* Create a few temporary intermediate vars to clarify formula
gen OP_less_SalesWasteFedAllow = ///
 HAY_OP_INV_QTY_TONNES     - ///
 HAY_WASTE_QUANTITY_TONNES - ///
 HAY_FED_QUANTITY_TONNES   - ///
 HAY_ALLOW_QUANTITY_TONNES - ///
 HAY_SALES_QUANTITY_TONNES

gen OP_less_WasteFedAllow = ///
 HAY_OP_INV_QTY_TONNES     - ///
 HAY_WASTE_QUANTITY_TONNES - ///
 HAY_FED_QUANTITY_TONNES   - ///
 HAY_ALLOW_QUANTITY_TONNES - ///
 HAY_SALES_QUANTITY_TONNES
* REMINDER: a-(b+c) = a-b-c


* Create the variable=0, then update based on conditions
capture drop `this_file_calculates'
gen  `this_file_calculates' = 0   


replace `this_file_calculates' =     ///
 HAY_SALES_QUANTITY_TONNES              ///
                                     ///
if HAY_OP_INV_QTY_TONNES      > 0  & ///
   HAY_SALES_QUANTITY_TONNES  > 0  & ///
   OP_less_SalesWasteFedAllow > 0 


replace `this_file_calculates' = ///
 OP_less_WasteFedAllow                  ///
                                     ///
if HAY_OP_INV_QTY_TONNES     > 0   & ///
   HAY_SALES_QUANTITY_TONNES > 0   & ///
   OP_less_WasteFedAllow     > 0



* Won't need the intermediate vars anymore
drop OP_less_WasteFedAllow  OP_less_SalesWasteFedAllow 
  
  


/* ---- Original IB code ----
 Kept for comparison with above. Note that this whole formula
 was inside a number() function, which I assume sets the variable
 type, or maybe specifies the precision of the variable.

 I added the indentation and spacing to clarify it. 
   --------------------------

if(/root/svy_hay_silage/@hay_op_inv_qty_tonnes> 0 
   and 
   /root/svy_hay_silage/@hay_sales_quantity_tonnes > 0) 

   then
  
   if(/root/svy_hay_silage/@hay_op_inv_qty_tonnes - 
        (/root/svy_hay_silage/@hay_waste_quantity_tonnes +
         /root/svy_hay_silage/@hay_fed_quantity_tonnes +
         /root/svy_hay_silage/@hay_allow_quantity_tonnes +
         /root/svy_hay_silage/@hay_sales_quantity_tonnes) > 0)
      then
      /root/svy_hay_silage/@hay_sales_quantity_tonnes



   else 

      if(/root/svy_hay_silage/@hay_op_inv_qty_tonnes - 
           (/root/svy_hay_silage/@hay_waste_quantity_tonnes +
            /root/svy_hay_silage/@hay_fed_quantity_tonnes +
            /root/svy_hay_silage/@hay_allow_quantity_tonnes) > 0)
         then
            /root/svy_hay_silage/@hay_op_inv_qty_tonnes - 
               (/root/svy_hay_silage/@hay_waste_quantity_tonnes +                        /root/svy_hay_silage/@hay_fed_quantity_tonnes +
                /root/svy_hay_silage/@hay_allow_quantity_tonnes)
      else
      0

else 0
)

   -------------------------- */




replace `this_file_calculates' = 0 /// 
   if missing(`this_file_calculates')



* Add required variables to global list of required vars
global required_vars "$required_vars "

* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars)



cd `startdir' // return Stata to previous directory

