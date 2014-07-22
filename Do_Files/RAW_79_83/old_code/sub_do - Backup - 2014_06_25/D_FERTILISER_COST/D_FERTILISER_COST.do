* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.

* D_FERTILISER_COST was calculated in convertSheet12.do (i.e. the 
*  do file that prepared the raw data from card 12 for merging).

* Calculations should be done once all the data is merged generally, 
*  but in this instance calculating brought that data back down to the 
*  appropriate panel structure (1 row per farm, per year) 

* The formula which would have been applied is pasted (and commented
*  out) below. Something similar is in convertSheet12, although the
*  variable names are slightly different (used the existing names).  
/*!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
foreach code of crop_codes {
capture drop `this_file_calculates'
gen  `this_file_calculates' =    ///
QUANTITY_ALLOCATED_50KGBAGS / ///
(                          ///
ORIGINAL_QUANTITY_50KGBAGS  * ///
ORIGINAL_COST_EU              ///
)
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!*/
