



use "`OutData'\merged_crop_tables.dta", clear

***************************************************************
* Create statistics Crop GO
***************************************************************
*Crops GO
***************************************************************
* Tabulations
***************************************************************

do `dodir'\CreateStatsCropsGO_vars2.do
sort YE_AR

log using `OutData'\Logs\crops_gross_output_vars_`volchange'`pricechange'.log, replace
do `dodir'\TabCropsGO_vars.do

log close




***************************************************************
* Create statistics Crop Expenses
***************************************************************

** Derive the TOTAL_EU raw variable so we can change its components with scalars
*-------------------------------------------------------------------------------

*replace CROP_PROTECTION_EU = CROP_PROTECTION_EU * sc_p_crppro
*replace PURCHASED_SEED_EU = PURCHASED_SEED_EU * sc_p_pursed
*replace MACHINERY_HIRE_EU = MACHINERY_HIRE_EU * sc_p_machir
*replace MISCELLANEOUS_EU = MISCELLANEOUS_EU * sc_p_misccp


* Variable List

global vlist1 = "CROP_PROTECTION PURCHASED_SEED TRANSPORT_GROSS_COST TRANSPORT_SUBSIDY MACHINERY_HIRE MISCELLANEOUS"


scalar sc_iteration = 14
do `dodir'\CreateStatsCropExpnses_vars2.do


***************************************************************
* Tabulations
***************************************************************
sort YE_AR

log using `OutData'\Logs\crop_protect_seeds_etc_`volchange'`pricechange'.log, replace

do `dodir'\TabCropExpnses_vars.do

log close



***************************************
* Animal
***************************************


 


use "D:\DATA\Data_NFSPanelANalysis\OutData\CreateNewPanel\pvAdjust_model\svy_sheep_0.dta", clear
* Variable List
global vlist1 = "FAT_LAMBS_SALES STORE_LAMBS_SALES FAT_HOGGETS_SALES BREEDING_HOGGETS_SALES CULL_EWES_RAMS_SALES BREEDING_EWES_SALES USED_IN_HOUSE STORE_LAMBS_PURCHASES EWES_RAMS_PURCHASES BREEDING_HOGGETS_PURCHASES"

scalar sc_iteration = 1
do D:\DATA\Data_NFSPanelANalysis\Do_Files\CreateNewPanel\pvAdjust_model\CreateStatsTest.do

***************************************************************
* Tabulations
***************************************************************
local volchange = sc_volchange

local pricechange = sc_pricechange

log using D:\DATA\Data_NFSPanelANalysis\OutData\CreateNewPanel\pvAdjust_model\Logs\sheep_sales_purch_`volchange'`pricechange'.log, replace

do D:\DATA\Data_NFSPanelANalysis\Do_Files\CreateNewPanel\pvAdjust_model\TabTest.do

*Fat Lamb Sales

replace FAT_LAMBS_SALES_EU = FAT_LAMBS_SALES_test2


*Store Lamb Sales

replace STORE_LAMBS_SALES_EU = STORE_LAMBS_SALES_test2


*Hogget sales

replace FAT_HOGGETS_SALES_EU = FAT_HOGGETS_SALES_test2


*Breeding hoggets sales

replace BREEDING_HOGGETS_SALES_EU = BREEDING_HOGGETS_SALES_test2


*Cull ewes and rams sale

replace CULL_EWES_RAMS_SALES_EU = CULL_EWES_RAMS_SALES_test2


*Breeding ewe sales

replace BREEDING_EWES_SALES_EU = BREEDING_EWES_SALES_test2


*Sheep consumed in house

replace USED_IN_HOUSE_EU = USED_IN_HOUSE_test2


*Store lamb purchases

replace STORE_LAMBS_PURCHASES_EU = STORE_LAMBS_PURCHASES_test2


*Ewes Rams Purchases

replace EWES_RAMS_PURCHASES_EU = EWES_RAMS_PURCHASES_test2


*Breeding hoggets purchases

replace BREEDING_HOGGETS_PURCHASES_EU = BREEDING_HOGGETS_PURCHASES_test2



sort  FARM_CODE YE_AR 
save "D:\DATA\Data_NFSPanelANalysis\OutData\CreateNewPanel\pvAdjust_model\svy_sheep_1.dta", replace


***************************************************************
* End of File
***************************************************************

keep FARM_CODE YE_AR nonzero* hasvar*
sort FARM_CODE YE_AR
save "D:\DATA\Data_NFSPanelANalysis\OutData\CreateNewPanel\pvAdjust_model\sheep_sales_purch_count.dta", replace
log close





use "D:\DATA\Data_NFSPanelANalysis\OutData\CreateNewPanel\pvAdjust_model\svy_cattle_1.dta", clear

* Variable List - have to split the original variable list into three as there is a limit to the number of vars that can be passed from global to local.

*List 1

global vlist1 = "DAIRY_CALVES_TRANSFER DAIRY_CALVES_SALES DY_COWS_SH_BULS_TRNSFR_OUT DY_COWS_SH_BULLS_PURCHASES DY_COWS_SH_BULS_TRNSFR_IN CATTLE_CALVES_SALES CATTLE_WEANLINGS_SALES"

***************************************************************
* Create statistics
***************************************************************

scalar sc_iteration = 2
do D:\DATA\Data_NFSPanelANalysis\Do_Files\CreateNewPanel\pvAdjust_model\CreateStatsTest.do


***************************************************************
* Tabulations
***************************************************************
log using D:\DATA\Data_NFSPanelANalysis\OutData\CreateNewPanel\pvAdjust_model\Logs\cattle_sales_purch_1_`volchange'`pricechange'.log, replace

do D:\DATA\Data_NFSPanelANalysis\Do_Files\CreateNewPanel\pvAdjust_model\TabTest.do
drop enter_nfs exit_nfs
log close

*List 2

* Variable List
global vlist1 = "CATTLE_STORES_MALE_SALES CATTLE_STORES_FEMALE_SALES CATTLE_FINISHED_MALE_SALES CTL_FINISHED_FEMALE_SALES CTL_BREEDING_ANIMALS_SALES CATTLE_OTHER_SALES CTL_BREDING_HRD_CULS_SALES"


***************************************************************
* Create statistics
***************************************************************

scalar sc_iteration = 3
do D:\DATA\Data_NFSPanelANalysis\Do_Files\CreateNewPanel\pvAdjust_model\CreateStatsTest.do

***************************************************************
* Tabulations
***************************************************************
log using D:\DATA\Data_NFSPanelANalysis\OutData\CreateNewPanel\pvAdjust_model\Logs\cattle_sales_purch_2_`volchange'`pricechange'.log, replace

do D:\DATA\Data_NFSPanelANalysis\Do_Files\CreateNewPanel\pvAdjust_model\TabTest.do
drop enter_nfs exit_nfs
log close


*List 3

* Variable List
global vlist1 = "CATTLE_CALVES_PURCHASES CATTLE_WEANLINGS_PURCHASES CTL_STORES_MALE_PURCHASES CTL_STORES_FMALE_PURCHASES CTL_BREED_REPLCMENTS_PURCH CATTLE_OTHER_PURCHASES"


***************************************************************
* Create statistics
***************************************************************

scalar sc_iteration = 4
do D:\DATA\Data_NFSPanelANalysis\Do_Files\CreateNewPanel\pvAdjust_model\CreateStatsTest.do

***************************************************************
* Tabulations
***************************************************************
log using D:\DATA\Data_NFSPanelANalysis\OutData\CreateNewPanel\pvAdjust_model\Logs\cattle_sales_purch_3_`volchange'`pricechange'.log, replace

do D:\DATA\Data_NFSPanelANalysis\Do_Files\CreateNewPanel\pvAdjust_model\TabTest.do
log close




*Dairy herd - calf transfers

replace DAIRY_CALVES_TRANSFER_EU = DAIRY_CALVES_TRANSFER_test2

*Dairy herd - calf sales

replace DAIRY_CALVES_SALES_EU = DAIRY_CALVES_SALES_test2

*Dairy Transfers out cows hfrs bulls

replace DY_COWS_SH_BULS_TRNSFR_OUT_EU = DY_COWS_SH_BULS_TRNSFR_OUT_test2


*Dairy purchases-cows heifers bulls

replace DY_COWS_SH_BULLS_PURCHASES_EU = DY_COWS_SH_BULLS_PURCHASES_test2


*Dairy Transfers in cows hfrs bulls

replace DY_COWS_SH_BULS_TRNSFR_IN_EU = DY_COWS_SH_BULS_TRNSFR_IN_test2


*Cattle Calves sold - Value

replace CATTLE_CALVES_SALES_EU = CATTLE_CALVES_SALES_test2


*Cattle Weanlings sold - Value

replace CATTLE_WEANLINGS_SALES_EU = CATTLE_WEANLINGS_SALES_test2


*Store cattle sales - male

replace CATTLE_STORES_MALE_SALES_EU = CATTLE_STORES_MALE_SALES_test2


*Store cattle sales - female

replace CATTLE_STORES_FEMALE_SALES_EU = CATTLE_STORES_FEMALE_SALES_test2


*Finished cattle sales - male

replace CATTLE_FINISHED_MALE_SALES_EU = CATTLE_FINISHED_MALE_SALES_test2


*Finished cattle sales - female

replace CTL_FINISHED_FEMALE_SALES_EU = CTL_FINISHED_FEMALE_SALES_test2


*Breeding herd Sold

replace CTL_BREEDING_ANIMALS_SALES_EU = CTL_BREEDING_ANIMALS_SALES_test2


*Other Cattle Sold

replace CATTLE_OTHER_SALES_EU = CATTLE_OTHER_SALES_test2


*Breeding Herd Cull sales

replace CTL_BREDING_HRD_CULS_SALES_EU = CTL_BREDING_HRD_CULS_SALES_test2

*CATTLE_TOTAL_SALES_EU
replace CATTLE_TOTAL_SALES_EU = CATTLE_CALVES_SALES_EU + CATTLE_WEANLINGS_SALES_EU + CATTLE_STORES_MALE_SALES_EU + CATTLE_STORES_FEMALE_SALES_EU + CATTLE_FINISHED_MALE_SALES_EU + CTL_FINISHED_FEMALE_SALES_EU + CTL_BREEDING_ANIMALS_SALES_EU + CATTLE_OTHER_SALES_EU + CTL_BREDING_HRD_CULS_SALES_EU


*Calves purchased - cost

replace CATTLE_CALVES_PURCHASES_EU = CATTLE_CALVES_PURCHASES_test2


*Cattle Weanlings purchased - cost

replace CATTLE_WEANLINGS_PURCHASES_EU = CATTLE_WEANLINGS_PURCHASES_test2


*Store cattle purchases - male

replace CTL_STORES_MALE_PURCHASES_EU = CTL_STORES_MALE_PURCHASES_test2


*Store cattle purchases - female

replace CTL_STORES_FMALE_PURCHASES_EU = CTL_STORES_FMALE_PURCHASES_test2


*Breeding herd purchased 

replace CTL_BREED_REPLCMENTS_PURCH_EU= CTL_BREED_REPLCMENTS_PURCH_test2


*Other Cattle Purchased

replace CATTLE_OTHER_PURCHASES_EU = CATTLE_OTHER_PURCHASES_test2


*CATTLE_TOTAL_PURCHASES_EU
replace CATTLE_TOTAL_PURCHASES_EU = CATTLE_CALVES_PURCHASES_EU + CATTLE_WEANLINGS_PURCHASES_EU + CTL_STORES_MALE_PURCHASES_EU + CTL_STORES_FMALE_PURCHASES_EU + CTL_BREED_REPLCMENTS_PURCH_EU + CATTLE_OTHER_PURCHASES_EU


sort  FARM_CODE YE_AR 
save "D:\DATA\Data_NFSPanelANalysis\OutData\CreateNewPanel\pvAdjust_model\svy_cattle_1.dta", replace


***************************************************************
* End of File
***************************************************************

keep FARM_CODE YE_AR nonzero* hasvar*
sort FARM_CODE YE_AR
save "D:\DATA\Data_NFSPanelANalysis\OutData\CreateNewPanel\pvAdjust_model\cattle_sales_purch_count.dta", replace





* Variable List
global vlist1 = "s_b_ALLOC_DAIRY_HERD s_b_ALLOC_CATTLE s_b_ALLOC_SHEEP s_b_ALLOC_HORSES s_b_ALLOC_DEER s_b_ALLOC_GOATS"


* Price Simulation3
use `OutData'\bulkyfeed_fedto_livestock_eu_2, clear
***************************************************************
* Create statistics
***************************************************************

scalar sc_iteration = 5
do D:\DATA\Data_NFSPanelANalysis\Do_Files\CreateNewPanel\pvAdjust_model\CreateStatsBulkyFeed.do


***************************************************************
* Tabulations
***************************************************************
sort YE_AR

log using D:\DATA\Data_NFSPanelANalysis\OutData\CreateNewPanel\pvAdjust_model\Logs\bulkyfeed_fedto_lvstock_1_`volchange'`pricechange'.log, replace

do D:\DATA\Data_NFSPanelANalysis\Do_Files\CreateNewPanel\pvAdjust_model\TabBulkyFeed.do


replace s_b_ALLOC_DAIRY_HERD_EU = s_b_ALLOC_DAIRY_HERD_test2
replace s_b_ALLOC_CATTLE_EU = s_b_ALLOC_CATTLE_test2
replace s_b_ALLOC_SHEEP_EU = s_b_ALLOC_SHEEP_test2
replace s_b_ALLOC_HORSES_EU = s_b_ALLOC_HORSES_test2
replace s_b_ALLOC_DEER_EU = s_b_ALLOC_DEER_test2
replace s_b_ALLOC_GOATS_EU = s_b_ALLOC_GOATS_test2

keep FARM_CODE YE_AR BULKYFEED_CODE s_b_ALLOC_DAIRY_HERD_EU s_b_ALLOC_CATTLE_EU s_b_ALLOC_SHEEP_EU s_b_ALLOC_HORSES_EU s_b_ALLOC_DEER_EU s_b_ALLOC_GOATS_EU nonzero* hasvar*

sort FARM_CODE YE_AR


save "D:\DATA\Data_NFSPanelANalysis\OutData\CreateNewPanel\pvAdjust_model\Livestock_DC\bulkyfeed_fedto_livestock_eu_3.dta", replace

***************************************************************
* End of File
***************************************************************

keep FARM_CODE YE_AR BULKYFEED_CODE nonzero* hasvar*
sort FARM_CODE YE_AR
save "D:\DATA\Data_NFSPanelANalysis\OutData\CreateNewPanel\pvAdjust_model\bulkyfeed_fedto_livestock_count.dta", replace

log close



use "D:\DATA\Data_NFSPanelANalysis\OutData\CreateNewPanel\pvAdjust_model\svy_livestock_expenses_1.dta", clear

*List 1
*Took out: CONC_ALLOC_DEER_50KGBAGS CONC_ALLOC_GOATS_50KGBAGSCONC_ALLOC_OTHER_50KGBAGS CONC_ALLOC_WASTE_50KGBAGS from the list as they were showing "no observations" error in the tabs

global vlist1 = "CONC_PURCHASED_50KGBAGS CONC_ALLC_DARY_HRD_50KGBGS CONC_ALLOC_CATTLE_50KGBAGS CONC_ALLOC_SHEEP_50KGBAGS CONC_ALLOC_HORSES_50KGBAGS CONC_ALLOC_PIGS_50KGBAGS CONC_ALLOC_PLTRY_50KGBAGS"

***************************************************************
* Create statistics
***************************************************************

scalar sc_iteration = 6
do D:\DATA\Data_NFSPanelANalysis\Do_Files\CreateNewPanel\pvAdjust_model\CreateStatsTest.do


***************************************************************
* Tabulations
***************************************************************
log using D:\DATA\Data_NFSPanelANalysis\OutData\CreateNewPanel\pvAdjust_model\Logs\conc_alloc_50kgbgs_`volchange'`pricechange'.log, replace

do D:\DATA\Data_NFSPanelANalysis\Do_Files\CreateNewPanel\pvAdjust_model\TabTest.do
log close



*Transport, VET_MED, AI, MISC done only by price change as no quantity variables for them. Again creating smaller lists as there is a limit when local calling global
*List 2

* Variable List
global vlist1 = "TRANSPORT_ALLOC_DAIRY_HERD TRANSPORT_ALLOC_CATTLE TRANSPORT_ALLOC_SHEEP TRANSPORT_ALLOC_HORSES TRANSPORT_ALLOC_PIGS TRANSPORT_ALLOC_POULTRY"


***************************************************************
* Create statistics
***************************************************************

scalar sc_iteration = 7
do D:\DATA\Data_NFSPanelANalysis\Do_Files\CreateNewPanel\pvAdjust_model\CreateStatsTest_priceonly.do

***************************************************************
* Tabulations
***************************************************************
log using D:\DATA\Data_NFSPanelANalysis\OutData\CreateNewPanel\pvAdjust_model\Logs\tran_vetmed_ai_alloc_livestock_1_`volchange'`pricechange'.log, replace

do D:\DATA\Data_NFSPanelANalysis\Do_Files\CreateNewPanel\pvAdjust_model\TabTest_priceonly.do
log close


*List 3
*Took out:  VET_MED_ETC_ALLOC_DEER VET_MED_ETC_ALLOC_GOATS  VET_MED_ETC_ALLOC_OTHER from the list as they were showing "no observations" error in the tabs

* Variable List
global vlist1 = "VET_MED_ALLOC_DAIRY_HERD VET_MED_ALLOC_CATTLE VET_MED_ALLOC_SHEEP VET_MED_ALLOC_HORSES VET_MED_ALLOC_PIGS VET_MED_ETC_ALLOC_POULTRY"


***************************************************************
* Create statistics
***************************************************************

scalar sc_iteration = 8
do D:\DATA\Data_NFSPanelANalysis\Do_Files\CreateNewPanel\pvAdjust_model\CreateStatsTest_priceonly.do

***************************************************************
* Tabulations
***************************************************************
log using D:\DATA\Data_NFSPanelANalysis\OutData\CreateNewPanel\pvAdjust_model\Logs\tran_vetmed_ai_alloc_livestock_2_`volchange'`pricechange'.log, replace

do D:\DATA\Data_NFSPanelANalysis\Do_Files\CreateNewPanel\pvAdjust_model\TabTest_priceonly.do
log close


*List 4

* Variable List
global vlist1 = "AI_SR_FEES_ALOC_DAIRY_HRD AI_SER_FEES_ALLOC_CATTLE AI_SER_FEES_ALLOC_SHEEP AI_SER_FEES_ALLOC_HORSES AI_SER_FEES_ALLOC_PIGS"


***************************************************************
* Create statistics
***************************************************************

scalar sc_iteration = 9
do D:\DATA\Data_NFSPanelANalysis\Do_Files\CreateNewPanel\pvAdjust_model\CreateStatsTest_priceonly.do

***************************************************************
* Tabulations
***************************************************************
log using D:\DATA\Data_NFSPanelANalysis\OutData\CreateNewPanel\pvAdjust_model\Logs\tran_vetmed_ai_alloc_livestock_3_`volchange'`pricechange'.log, replace

do D:\DATA\Data_NFSPanelANalysis\Do_Files\CreateNewPanel\pvAdjust_model\TabTest_priceonly.do
log close


*List 5

* Variable List
global vlist1 = "MISC_ALLOC_DAIRY_HERD MISCELLANEOUS_ALLOC_CATTLE MISCELLANEOUS_ALLOC_SHEEP MISCELLANEOUS_ALLOC_HORSES MISCELLANEOUS_ALLOC_PIGS MISC_ALLOC_POULTRY"

***************************************************************
* Create statistics
***************************************************************

scalar sc_iteration = 10
do D:\DATA\Data_NFSPanelANalysis\Do_Files\CreateNewPanel\pvAdjust_model\CreateStatsTest_priceonly.do

***************************************************************
* Tabulations
***************************************************************
log using D:\DATA\Data_NFSPanelANalysis\OutData\CreateNewPanel\pvAdjust_model\Logs\tran_vetmed_ai_alloc_livestock_4_`volchange'`pricechange'.log, replace

do D:\DATA\Data_NFSPanelANalysis\Do_Files\CreateNewPanel\pvAdjust_model\TabTest_priceonly.do
log close


sort FARM_CODE YE_AR

save "D:\DATA\Data_NFSPanelANalysis\OutData\CreateNewPanel\pvAdjust_model\svy_livestock_expenses_2.dta", replace

***************************************************************
* End of File
***************************************************************

keep FARM_CODE YE_AR nonzero* hasvar*
sort FARM_CODE YE_AR
save "D:\DATA\Data_NFSPanelANalysis\OutData\CreateNewPanel\pvAdjust_model\livestock_expenses_count.dta", replace





use "D:\DATA\Data_NFSPanelANalysis\OutData\CreateNewPanel\pvAdjust_model\svy_dairy_produce_1.dta", clear


* Variable List
global vlist1 = "WHLE_MILK_SOLD_TO_CREAMERY LQDMLK_SOLD_WSALE_RETAIL"

***************************************************************
* Create statistics
***************************************************************

scalar sc_iteration = 11
do D:\DATA\Data_NFSPanelANalysis\Do_Files\CreateNewPanel\pvAdjust_model\CreateStatsTest_milk.do

***************************************************************
* Tabulations
***************************************************************
log using D:\DATA\Data_NFSPanelANalysis\OutData\CreateNewPanel\pvAdjust_model\Logs\milk_sold_`volchange'`pricechange'.log, replace

do D:\DATA\Data_NFSPanelANalysis\Do_Files\CreateNewPanel\pvAdjust_model\TabTest_milk.do

log close


sort FARM_CODE YE_AR


*gen lmilk_sld_wslrtl_eu_per_ltr =  LQDMLK_SOLD_WSALE_RETAIL_EU / LQDMLK_SOLD_WSALE_RETAIL_LT
*replace lmilk_sld_wslrtl_eu_per_ltr = 0 if lmilk_sld_wslrtl_eu_per_ltr == .
*replace lmilk_sld_wslrtl_eu_per_ltr = lmilk_sld_wslrtl_eu_per_ltr * sc_p_mlksldwslrtl
*replace LQDMLK_SOLD_WSALE_RETAIL_EU = LQDMLK_SOLD_WSALE_RETAIL_LT * lmilk_sld_wslrtl_eu_per_ltr

replace WHLE_MILK_SOLD_TO_CREAMERY_EU = WHLE_MILK_SOLD_TO_CREAMERY_test2
replace LQDMLK_SOLD_WSALE_RETAIL_EU = LQDMLK_SOLD_WSALE_RETAIL_test2


sort FARM_CODE YE_AR

foreach var in  CREAMERY_FED_CALVES CREAMERY_FED_PIGS CREAMERY_FED_POULTRY {
	
*Volume

	gen v`var' = `var'_LT

	sort FARM_CODE YE_AR

	sort YE_AR

	by YE_AR: egen tmv`var' = mean(v`var') if v`var'  > 0 & v`var'  != .

	replace tmv`var' = 0 if tmv`var' == .

	by YE_AR: egen mv`var' = max(tmv`var')

	replace v`var' = mv`var' if v`var' == .

	sort FARM_CODE YE_AR

	by FARM_CODE: gen v`var'_p1 = v`var'[_n+1]

	gen dv`var' = v`var'_p1/v`var'

	sort YE_AR

	by YE_AR: egen tmvd`var' = mean(dv`var' ) if dv`var'  > 0 & dv`var' != .

	replace tmvd`var' = 0 if tmvd`var' == .

	by YE_AR: egen mvd`var' = max(tmvd`var')

	replace dv`var' = mvd`var' if dv`var' == .


** Lag volume

sort FARM_CODE YE_AR
by FARM_CODE: gen `var'_LT_p1 = `var'_LT[_n+1] if YE_AR[_n+1] == YE_AR+1

gen `var'_LT_b = `var'_LT > 0 & `var'_LT != . & `var'_LT_p1 > 0 & `var'_LT_p1 != .


**TEST**

* Volume (Ltr) change
gen `var'_test = `var'_LT * dv`var'


}



log using D:\DATA\Data_NFSPanelANalysis\OutData\CreateNewPanel\pvAdjust_model\Logs\milk_fed_livestock_`volchange'`pricechange'.log, replace

foreach var in CREAMERY_FED_CALVES CREAMERY_FED_PIGS CREAMERY_FED_POULTRY {


* Compare Simulated with actual next year if in both years
tab YE_AR if `var'_LT_b == 1, sum(`var'_test)
tab YE_AR if `var'_LT_b == 1, sum(`var'_LT_p1)

* Compare Simulated with actual next year for all farms in current year
tab YE_AR if `var'_test > 0, sum(`var'_test)
tab YE_AR if `var'_LT > 0, sum(`var'_LT)


}

log close


replace CREAMERY_FED_CALVES_LT = CREAMERY_FED_CALVES_test
replace CREAMERY_FED_PIGS_LT = CREAMERY_FED_PIGS_test
replace CREAMERY_FED_POULTRY_LT = CREAMERY_FED_POULTRY_test


** D_MILK_FED_TO_LIVESTOCK_EU
gen d_milk_fed_to_livestock_eu = 0
replace d_milk_fed_to_livestock_eu = (CREAMERY_FED_CALVES_LT + CREAMERY_FED_PIGS_LT + CREAMERY_FED_POULTRY_LT) *0.14

*D_MILK_SOLD_EU
gen d_milk_sold_eu = 0
replace d_milk_sold_eu = (LQDMLK_SOLD_WSALE_RETAIL_EU + WHLE_MILK_SOLD_TO_CREAMERY_EU + CREAMERY_BONUSES_EU) - CREAMERY_PENALTIES_EU

*D_MILK_ALLOWANCES_EU
gen d_milk_allowances_eu = 0
replace d_milk_allowances_eu = ALLOW_WHOLE_MILK_HOUSE_EU + ALLOW_WHOLE_MILK_WAGES_EU + ALLOW_WHOLE_MILK_OTHER_EU + ALLOW_BUTTER_HOUSE_EU + ALLOW_BUTTER_WAGES_EU + ALLOW_BUTTER_OTHER_EU + ALLOW_OTHER_DAIRY_HOUSE_EU + ALLOW_OTHER_DAIRY_WAGES_EU

*D_TOTAL_MILK_PRODUCTION_EU
gen d_total_milk_production_eu = 0
replace d_total_milk_production_eu = d_milk_sold_eu + d_milk_fed_to_livestock_eu + d_milk_allowances_eu



sort FARM_CODE YE_AR

save "D:\DATA\Data_NFSPanelANalysis\OutData\CreateNewPanel\pvAdjust_model\svy_dairy_produce_2.dta", replace


***************************************************************
* End of File
***************************************************************

keep FARM_CODE YE_AR nonzero* hasvar*
sort FARM_CODE YE_AR
save "D:\DATA\Data_NFSPanelANalysis\OutData\CreateNewPanel\pvAdjust_model\milk_sold_count.dta", replace
