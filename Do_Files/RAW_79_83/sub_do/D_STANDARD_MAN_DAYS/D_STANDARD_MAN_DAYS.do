* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.


local startdir: pwd // Save current working directory location


* Move into the root of the variable's directory
local this_file_calculates "D_STANDARD_MAN_DAYS"
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




* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
* Raw data doesn't have sexed MTH12 totals for cattle. Using average 
*  of open and closing stock as a (possibly poor) substitute.
* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
capture drop MTH12_TOTAL_CATTLE_FEMALE_1_2_NO  
gen MTH12_TOTAL_CATTLE_FEMALE_1_2_NO  = ///
  (                                  ///
    CATTLE_FEMALE_1_2YRS_OP_INV_NO    + ///
    CATTLE_FEMALE_1_2YRS_CLOS_INV_NO    ///
  )                / 2

capture drop MTH12_TOTAL_CATTLE_FEMALE_GT2_NO  
gen MTH12_TOTAL_CATTLE_FEMALE_GT2_NO  = ///
  (                                  ///
    CATTLE_FEMALE_2_3YRS_OP_INV_NO    + ///
    CATTLE_FEMALE_2_3YRS_CLOS_INV_NO    ///
  )                / 2
* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -



* We're going to need a list of crop_codes
qui ds CY_HECTARES_HA????
local vlist "`r(varlist)'"
foreach var of local vlist {

	local code = substr("`var'", -4, .)
	local crop_codes "`crop_codes' `code'"
	
}

* Make sure codes enter list only once and sort them
local crop_codes: list uniq crop_codes 
local crop_codes: list sort crop_codes 



* Initialise summing variable
capture drop CerealsCYHA 
gen double CerealsCYHA = 0
label var CerealsCYHA "CY_HECTARES_HA for all cereal crops."

foreach code of local crop_codes {

	if [regexm("`code'", "11[0-9][0-9]") | ///
	    regexm("`code'", "157[0-9]")     ] {

	replace CerealsCYHA = ///
	   CerealsCYHA + CY_HECTARES_HA`code'

	}

}



* Make sure terms of eqation are not missing
local zero_missing "`zero_missing' DAIRY_COWS"
local zero_missing "`zero_missing' MTH12_TOTAL_OTHER_COWS_NO"
local zero_missing "`zero_missing' SUCKLING"
local zero_missing "`zero_missing' MTH12_TOTAL_CALVES_LT6MTHS_NO"
local zero_missing "`zero_missing' CATTLE_LT1YR"
local zero_missing "`zero_missing' MTH12_TOTAL_CALVES_6_12MTHS_NO" 
local zero_missing "`zero_missing' CATTLE_LT1YR"
local zero_missing "`zero_missing' MTH12_TOTAL_CATTLE_FEMALE_1_2_NO"
local zero_missing "`zero_missing' CATTLE_1_2YRS"
local zero_missing "`zero_missing' MTH12_TOTAL_CATTLE_FEMALE_GT2_NO"
local zero_missing "`zero_missing' CATTLE_2_3YRS"
local zero_missing "`zero_missing' MTH12_TOTAL_IN_CALF_HEIFERS_NO"
local zero_missing "`zero_missing' CATTLE_2_3YRS"
local zero_missing "`zero_missing' EWE_LAMBS_TAKING_RAM_NO"
local zero_missing "`zero_missing' SHEEP_EWES"
local zero_missing "`zero_missing' BREEDING_HOGGETS_SALES_NO"
local zero_missing "`zero_missing' SHEEP_HOGGETS"
local zero_missing "`zero_missing' PIGS_SOWS"
local zero_missing "`zero_missing' PIGS_FATTENERS"
local zero_missing "`zero_missing' POULTRY_HENS_LAYERS"
local zero_missing "`zero_missing' POULTRY_TABLE_FOWL"
local zero_missing "`zero_missing' POULTRY_PULLETS"
local zero_missing "`zero_missing' POULTRY_OTHER_FOWL_TURKEYS"
local zero_missing "`zero_missing' MTH12_TOTAL_HORSES_DRAUGHT_NO"
local zero_missing "`zero_missing' MTH12_TOTAL_HORSES_LT2YR_NO"
local zero_missing "`zero_missing' MTH12_TOTAL_HORSES_GT2YR_NO"
local zero_missing "`zero_missing' MTH12_TOTAL_PONIES_NO"
local zero_missing "`zero_missing' MTH12_TOTAL_MULES_JENNETS_NO"
local zero_missing "`zero_missing' MTH12_TOTAL_ASSES_NO"
local zero_missing "`zero_missing' OTHER_LVSTCK_ALLOW_INCL_HOUSE_EU"
local zero_missing "`zero_missing' HORSES_DRAUGHT"
local zero_missing "`zero_missing' CerealsCYHA"
local zero_missing "`zero_missing' CEREALS"
local zero_missing "`zero_missing' CY_HECTARES_HA1321"
local zero_missing "`zero_missing' SUGAR_BEET"
local zero_missing "`zero_missing' CY_HECTARES_HA1311"
local zero_missing "`zero_missing' POTATOES_WARE"
local zero_missing "`zero_missing' CY_HECTARES_HA1311"
local zero_missing "`zero_missing' POTATOES_PROCESSING"
local zero_missing "`zero_missing' SIL_TOTAL_YIELD_TONNES"

foreach var of local zero_missing {

	replace `var' = 0 if missing(`var')

}



capture drop `this_file_calculates'
gen  `this_file_calculates' =    ///
((DAIRY_COWS) * 1)                                        ///
                +                                      ///
(                                                         ///
	(                                                 /// 
		((MTH12_TOTAL_OTHER_COWS_NO *             ///
		   SUCKLING) * .9)                        /// 
		+                                         ///
		((MTH12_TOTAL_CALVES_LT6MTHS_NO *         ///
		  CATTLE_LT1YR) * .2)                     ///
		+                                         ///
		((MTH12_TOTAL_CALVES_6_12MTHS_NO *        ///
		  CATTLE_LT1YR) * .4)                     ///
		+                                         ///
		(((MTH12_TOTAL_CATTLE_FEMALE_1_2_NO) *    ///
			  CATTLE_1_2YRS) * .7)            ///
		+                                         ///
		(((MTH12_TOTAL_CATTLE_FEMALE_GT2_NO) *    ///
			 CATTLE_2_3YRS) * 1)              /// 
		+                                         ///
		((MTH12_TOTAL_IN_CALF_HEIFERS_NO *        ///
			 CATTLE_2_3YRS) * .7)             ///  
	) / 12                                            ///
)                                                         ///
                +                                      /// 
 ((EWE_LAMBS_TAKING_RAM_NO) *                             /// 
 SHEEP_EWES)                                              ///
                +                                      ///  
 ((BREEDING_HOGGETS_SALES_NO) *                           ///
 SHEEP_HOGGETS)                                           ///
                +                                      ///
(                                                         ///             
 	(                                                 /// 
		(PIGS_SOWS)                               ///
 		+                                         ///
		(PIGS_FATTENERS)                          ///    
		+                                         ///    
 		(POULTRY_HENS_LAYERS)                     ///    
 		+                                         ///
 		(POULTRY_TABLE_FOWL)                      ///   
 		+                                         ///
 		(POULTRY_PULLETS)                         ///
 		+                                         ///    
 		(POULTRY_OTHER_FOWL_TURKEYS)              /// 
	) / 12                                            /// 
)                                                         ///   
                +                                      /// 
(                                                         /// 
	(                                                 /// 
		(MTH12_TOTAL_HORSES_DRAUGHT_NO * 10)      ///
 		+                                         ///
		(MTH12_TOTAL_HORSES_LT2YR_NO * 8)         /// 
		+                                         ///     
		(MTH12_TOTAL_HORSES_GT2YR_NO * 10)        ///  
		+                                         ///
		(MTH12_TOTAL_PONIES_NO * 10)              /// 
		+                                         ///
		(MTH12_TOTAL_MULES_JENNETS_NO * 10)       ///
		+                                         ///
		(MTH12_TOTAL_ASSES_NO * 10)               /// 
	) / 12                                            /// 
)                                                         /// 
                +                                      ///    
(OTHER_LVSTCK_ALLOW_INCL_HOUSE_EU* HORSES_DRAUGHT)        ///
                +                                      ///
(CerealsCYHA * CEREALS)                                   ///
                +                                      ///
(CY_HECTARES_HA1321 * SUGAR_BEET)                         ///
                +                                      ///
(CY_HECTARES_HA1311 * POTATOES_WARE)                      ///
                +                                      ///
(CY_HECTARES_HA1311 * POTATOES_PROCESSING)                ///
                +                                      ///
(SIL_TOTAL_YIELD_TONNES * .05)



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
