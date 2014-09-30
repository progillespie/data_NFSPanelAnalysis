*******************************************
* Create d_conc_fed_dairy_eu
*******************************************


replace CONC_ALLC_DARY_HRD_50KGBGS_EU = CONC_ALLC_DARY_HRD_50KGBGS_test2

sort FARM_CODE YE_AR 
* CHANGE-7983: Hard coded filepath
local OutData "$OutData1"
merge FARM_CODE YE_AR using `OutData'\sum_i_conc_fed_dairy.dta
*merge FARM_CODE YE_AR using D:\DATA\Data_NFSPanelANalysis\OutData\FarmPriceVolMSM\sum_i_conc_fed_dairy.dta
drop _merge

keep FARM_CODE YE_AR s_i_concentrates_fed_dairy CONC_ALLC_DARY_HRD_50KGBGS_EU

gen d_concentrates_fed_dairy_eu = CONC_ALLC_DARY_HRD_50KGBGS_EU + s_i_concentrates_fed_dairy
replace d_concentrates_fed_dairy_eu = 0 if d_concentrates_fed_dairy_eu == .

sort FARM_CODE YE_AR
