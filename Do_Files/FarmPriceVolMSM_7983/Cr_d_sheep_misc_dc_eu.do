*******************************************
* Create d_sheep_misc_dc_eu
*******************************************


replace TRANSPORT_ALLOC_SHEEP_EU = TRANSPORT_ALLOC_SHEEP_test2
replace VET_MED_ALLOC_SHEEP_EU = VET_MED_ALLOC_SHEEP_test2
replace AI_SER_FEES_ALLOC_SHEEP_EU = AI_SER_FEES_ALLOC_SHEEP_test2
replace MISCELLANEOUS_ALLOC_SHEEP_EU = MISCELLANEOUS_ALLOC_SHEEP_test2
*replace CASUAL_LABOUR_ALLOC_SHEEP_EU = CASUAL_LABOUR_ALLOC_SHEEP_EU * sc_p_caslab_sheep


gen d_sheep_misc_direct_costs_eu = VET_MED_ALLOC_SHEEP_EU + AI_SER_FEES_ALLOC_SHEEP_EU + TRANSPORT_ALLOC_SHEEP_EU + MISCELLANEOUS_ALLOC_SHEEP_EU + CASUAL_LABOUR_ALLOC_SHEEP_EU
replace d_sheep_misc_direct_costs_eu = 0 if d_sheep_misc_direct_costs_eu == .

keep FARM_CODE YE_AR VET_MED_ALLOC_SHEEP_EU AI_SER_FEES_ALLOC_SHEEP_EU TRANSPORT_ALLOC_SHEEP_EU MISCELLANEOUS_ALLOC_SHEEP_EU CASUAL_LABOUR_ALLOC_SHEEP_EU d_sheep_misc_direct_costs_eu

sort FARM_CODE YE_AR
