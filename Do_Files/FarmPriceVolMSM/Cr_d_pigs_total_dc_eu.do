*******************************************
* Create d_pigs_total_dc_eu
*******************************************

replace CONC_ALLOC_PIGS_50KGBAGS_EU = CONC_ALLOC_PIGS_50KGBAGS_test2
replace TRANSPORT_ALLOC_PIGS_EU = TRANSPORT_ALLOC_PIGS_test2
replace VET_MED_ALLOC_PIGS_EU = VET_MED_ALLOC_PIGS_test2
replace MISCELLANEOUS_ALLOC_PIGS_EU = MISCELLANEOUS_ALLOC_PIGS_test2
*replace CASUAL_LABOUR_ALLOC_PIGS_EU = CASUAL_LABOUR_ALLOC_PIGS_EU * sc_p_caslab_pigs



keep FARM_CODE YE_AR s_i_concentrates_fed_pigs VET_MED_ALLOC_PIGS_EU TRANSPORT_ALLOC_PIGS_EU CONC_ALLOC_PIGS_50KGBAGS_EU MISCELLANEOUS_ALLOC_PIGS_EU CASUAL_LABOUR_ALLOC_PIGS_EU AI_SER_FEES_ALLOC_PIGS_EU

gen d_pigs_total_direct_costs_eu = (CONC_ALLOC_PIGS_50KGBAGS_EU + s_i_concentrates_fed_pigs) + VET_MED_ALLOC_PIGS_EU + TRANSPORT_ALLOC_PIGS_EU + (MISCELLANEOUS_ALLOC_PIGS_EU + CASUAL_LABOUR_ALLOC_PIGS_EU) + AI_SER_FEES_ALLOC_PIGS_EU
replace d_pigs_total_direct_costs_eu = 0 if d_pigs_total_direct_costs_eu  == .

sort FARM_CODE YE_AR
