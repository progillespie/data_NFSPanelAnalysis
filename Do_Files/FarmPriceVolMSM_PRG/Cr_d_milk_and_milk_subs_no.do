*******************************************
* Create d_milk_and_milk_subs_no
*******************************************

sort FARM_CODE YE_AR
* CHANGE-7983: Hard coded filepath
local OutData "$OutData1"
merge FARM_CODE YE_AR using `OutData'\svy_dairy_produce_1.dta
*merge FARM_CODE YE_AR using D:\DATA\Data_NFSPanelANalysis\OutData\FarmPriceVolMSM\svy_dairy_produce_1.dta
drop _merge

keep FARM_CODE YE_AR CONC_MLK_SUB_FED_CLVS_50KGBGS_EU d_milk_fed_to_livestock_eu

gen d_milk_and_milk_substitutes_no = CONC_MLK_SUB_FED_CLVS_50KGBGS_EU + d_milk_fed_to_livestock_eu
replace d_milk_and_milk_substitutes_no = 0 if d_milk_and_milk_substitutes_no == .

sort FARM_CODE YE_AR

