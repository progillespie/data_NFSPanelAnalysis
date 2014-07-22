local this_file_calculates "D_TOTAL_LIVESTOCK_GROSS_OUTPUT"

local nonexist_vlist "`nonexist_vlist' D_DAIRY_GROSS_OUTPUT_EU"
local nonexist_vlist "`nonexist_vlist' D_GROSS_OUTPUT_CATTLE_EU"
local nonexist_vlist "`nonexist_vlist' D_GROSS_OUTPUT_PIGS_EU"
local nonexist_vlist "`nonexist_vlist' D_POULTRY_GROSS_OUTPUT_EU"
local nonexist_vlist "`nonexist_vlist' D_GROSS_OUTPUT_HORSES_EU"
local nonexist_vlist "`nonexist_vlist' D_OTHER_GROSS_OUTPUT_EU"

replace D_DAIRY_GROSS_OUTPUT_EU = 0 /// 
   if missing(D_DAIRY_GROSS_OUTPUT_EU)
replace D_GROSS_OUTPUT_CATTLE_EU = 0 /// 
   if missing(D_GROSS_OUTPUT_CATTLE_EU)
replace D_GROSS_OUTPUT_PIGS_EU = 0 /// 
   if missing(D_GROSS_OUTPUT_PIGS_EU)
replace D_POULTRY_GROSS_OUTPUT_EU = 0 /// 
   if missing(D_POULTRY_GROSS_OUTPUT_EU)
replace D_GROSS_OUTPUT_HORSES_EU = 0 /// 
   if missing(D_GROSS_OUTPUT_HORSES_EU)
replace D_OTHER_GROSS_OUTPUT_EU = 0 /// 
   if missing(D_OTHER_GROSS_OUTPUT_EU)


capture drop `this_file_calculates'
gen  `this_file_calculates' =             ///
 D_DAIRY_GROSS_OUTPUT_EU          +  ///
 D_GROSS_OUTPUT_CATTLE_EU         +  ///
 D_GROSS_OUTPUT_PIGS_EU           +  ///
 D_POULTRY_GROSS_OUTPUT_EU        +  ///
 D_GROSS_OUTPUT_HORSES_EU         +  ///
 D_OTHER_GROSS_OUTPUT_EU 


foreach var of local nonexist_vlist{
	count if missing(`var')
} 

count if missing(`this_file_calculates')
summ `this_file_calculates'
