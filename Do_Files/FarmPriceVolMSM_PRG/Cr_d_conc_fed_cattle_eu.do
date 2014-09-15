*******************************************
* Create d_conc_fed_cattle_eu
*******************************************


replace CONC_ALLOC_CATTLE_50KGBAGS_EU = CONC_ALLOC_CATTLE_50KGBAGS_test2

sort FARM_CODE YE_AR 
* CHANGE-7983: Hard coded filepath
local OutData "$OutData1"
merge FARM_CODE YE_AR using `OutData'\sum_i_conc_fed_cattle.dta
*merge FARM_CODE YE_AR using D:\DATA\Data_NFSPanelANalysis\OutData\FarmPriceVolMSM\sum_i_conc_fed_cattle.dta
drop _merge

keep FARM_CODE YE_AR s_i_concentrates_fed_cattle CONC_ALLOC_CATTLE_50KGBAGS_EU

gen d_concentrates_fed_cattle_eu = CONC_ALLOC_CATTLE_50KGBAGS_EU + s_i_concentrates_fed_cattle
replace d_concentrates_fed_cattle_eu = 0 if d_concentrates_fed_cattle_eu == .

sort FARM_CODE YE_AR
