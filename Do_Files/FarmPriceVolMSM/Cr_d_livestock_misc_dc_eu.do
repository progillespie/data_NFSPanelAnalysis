*******************************************
* Create d_livestock_misc_dc_eu
*******************************************

replace TRANSPORT_ALLOC_CATTLE_EU = TRANSPORT_ALLOC_CATTLE_test2
replace VET_MED_ALLOC_CATTLE_EU = VET_MED_ALLOC_CATTLE_test2
replace AI_SER_FEES_ALLOC_CATTLE_EU = AI_SER_FEES_ALLOC_CATTLE_test2
replace MISCELLANEOUS_ALLOC_CATTLE_EU = MISCELLANEOUS_ALLOC_CATTLE_test2
*replace CASUAL_LABOUR_ALLOC_CATTLE_EU = CASUAL_LABOUR_ALLOC_CATTLE_EU * sc_p_caslab_cattle 

gen d_livestock_misc_direct_costs_eu = VET_MED_ALLOC_CATTLE_EU + AI_SER_FEES_ALLOC_CATTLE_EU + TRANSPORT_ALLOC_CATTLE_EU + MISCELLANEOUS_ALLOC_CATTLE_EU + CASUAL_LABOUR_ALLOC_CATTLE_EU
replace d_livestock_misc_direct_costs_eu = 0 if d_livestock_misc_direct_costs_eu == .

keep FARM_CODE YE_AR VET_MED_ALLOC_CATTLE_EU AI_SER_FEES_ALLOC_CATTLE_EU TRANSPORT_ALLOC_CATTLE_EU MISCELLANEOUS_ALLOC_CATTLE_EU CASUAL_LABOUR_ALLOC_CATTLE_EU d_livestock_misc_direct_costs_eu 

sort FARM_CODE YE_AR
