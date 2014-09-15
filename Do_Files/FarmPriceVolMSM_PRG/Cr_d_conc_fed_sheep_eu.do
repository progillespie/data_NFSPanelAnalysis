*******************************************
* Create d_conc_fed_sheep_eu
*******************************************


replace CONC_ALLOC_SHEEP_50KGBAGS_EU = CONC_ALLOC_SHEEP_50KGBAGS_test2


keep FARM_CODE YE_AR s_i_concentrates_fed_sheep CONC_ALLOC_SHEEP_50KGBAGS_EU

gen d_concentrates_fed_sheep_eu = CONC_ALLOC_SHEEP_50KGBAGS_EU + s_i_concentrates_fed_sheep
replace d_concentrates_fed_sheep_eu = 0 if d_concentrates_fed_sheep_eu == .

sort FARM_CODE YE_AR
