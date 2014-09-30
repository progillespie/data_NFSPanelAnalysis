*******************************************
* Create d_poultry_total_dc_eu
*******************************************

replace CONC_ALLOC_PLTRY_50KGBAGS_EU = CONC_ALLOC_PLTRY_50KGBAGS_test2
replace TRANSPORT_ALLOC_POULTRY_EU = TRANSPORT_ALLOC_POULTRY_test2
replace VET_MED_ETC_ALLOC_POULTRY_EU = VET_MED_ETC_ALLOC_POULTRY_test2
replace MISC_ALLOC_POULTRY_EU = MISC_ALLOC_POULTRY_test2
*replace CASUAL_LABOUR_ALLOC_POULTRY_EU = CASUAL_LABOUR_ALLOC_POULTRY_EU * sc_p_caslab_poultry


keep FARM_CODE YE_AR s_i_concentrates_fed_poultry CONC_ALLOC_PLTRY_50KGBAGS_EU VET_MED_ETC_ALLOC_POULTRY_EU TRANSPORT_ALLOC_POULTRY_EU MISC_ALLOC_POULTRY_EU CASUAL_LABOUR_ALLOC_POULTRY_EU

gen d_poultry_total_direct_costs_eu = s_i_concentrates_fed_poultry + CONC_ALLOC_PLTRY_50KGBAGS_EU + VET_MED_ETC_ALLOC_POULTRY_EU + TRANSPORT_ALLOC_POULTRY_EU + MISC_ALLOC_POULTRY_EU + CASUAL_LABOUR_ALLOC_POULTRY_EU
replace d_poultry_total_direct_costs_eu = 0 if d_poultry_total_direct_costs_eu == .

sort FARM_CODE YE_AR
