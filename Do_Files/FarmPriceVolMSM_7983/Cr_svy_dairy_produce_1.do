*******************************************
* Create svy_dairy_produce_1
*******************************************

* CHANGE-7983: create 0 variables
capture gen var30 = 0
capture gen var31 = 0
capture gen var47 = 0
capture gen var48 = 0
capture gen var59 = 0
capture gen WHOLE_MILK_SOLD_TO_CREAMERY_EU = 0
capture gen WHOLE_MILK_SOLD_TO_CREAMERY_LT = 0
capture gen CREAMERY_BONUSES_EU            = 0
capture gen CREAMERY_PENALTIES_EU          = 0


rename var30 QTY_MLK_ENTRD_NOT_PAID_LT
rename var31 VAL_MLK_ENTRD_NOT_PAID_EU
rename var47 LQDMLK_SOLD_WSALE_RETAIL_LT
rename var48 LQDMLK_SOLD_WSALE_RETAIL_EU
rename var59 D_DAIRY_PROD_MISC_DCOST_EU
rename WHOLE_MILK_SOLD_TO_CREAMERY_EU WHLE_MILK_SOLD_TO_CREAMERY_EU
rename WHOLE_MILK_SOLD_TO_CREAMERY_LT WHLE_MILK_SOLD_TO_CREAMERY_LT

*gen wmilk_sld_cremry_eu_per_ltr =  WHOLE_MILK_SOLD_TO_CREAMERY_EU / WHOLE_MILK_SOLD_TO_CREAMERY_LT
*replace wmilk_sld_cremry_eu_per_ltr = 0 if wmilk_sld_cremry_eu_per_ltr == .
*replace wmilk_sld_cremry_eu_per_ltr = wmilk_sld_cremry_eu_per_ltr * sc_p_mlksldcrem


** D_MILK_FED_TO_LIVESTOCK_EU
gen d_milk_fed_to_livestock_eu = 0

* CHANGE-7983: leave d_milk_fed_to_livestock_eu = 0 (no vars)
*replace d_milk_fed_to_livestock_eu = (CREAMERY_FED_CALVES_LT + CREAMERY_FED_PIGS_LT + CREAMERY_FED_POULTRY_LT) *0.14

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
