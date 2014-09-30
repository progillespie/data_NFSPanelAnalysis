*******************************************
* Create Hay and Silage Fed
*******************************************

** silage 9230 and 9231 - i_total_and_home_grown_seed_eu
gen sil_0_i_tot_hme_grsd_eu = i_total_and_home_grown_seed_eu if CROP_CODE == 9230
replace sil_0_i_tot_hme_grsd_eu = 0 if sil_0_i_tot_hme_grsd_eu == . 

gen sil_1_i_tot_hme_grsd_eu = i_total_and_home_grown_seed_eu if CROP_CODE == 9231
replace sil_1_i_tot_hme_grsd_eu = 0 if sil_1_i_tot_hme_grsd_eu == . 

** silage 9230 and 9231 - FED_TOTAL_TONNES_HA
gen sil_0_fed_tot_tns_ha = FED_TOTAL_TONNES_HA if CROP_CODE == 9230
replace sil_0_fed_tot_tns_ha = 0 if sil_0_fed_tot_tns_ha == . 

gen sil_1_fed_tot_tns_ha = FED_TOTAL_TONNES_HA if CROP_CODE == 9231
replace sil_1_fed_tot_tns_ha = 0 if sil_1_fed_tot_tns_ha == . 

** silage - casual labour
gen lab_alloc_to_sil = ALLOCATED_TO_CROP_EU if CROP_CODE == 9231
replace lab_alloc_to_sil = 0 if lab_alloc_to_sil == .

** hay 9221 - i_total_and_home_grown_seed_eu
gen hay_1_i_tot_hme_grsd_eu = i_total_and_home_grown_seed_eu if CROP_CODE == 9221
replace hay_1_i_tot_hme_grsd_eu = 0 if hay_1_i_tot_hme_grsd_eu == .

** hay 9220 and 9221 - FED_TOTAL_TONNES_HA
gen hay_0_fed_tot_tns_ha = FED_TOTAL_TONNES_HA if CROP_CODE == 9220
replace hay_0_fed_tot_tns_ha= 0 if hay_0_fed_tot_tns_ha == . 

gen hay_1_fed_tot_tns_ha = FED_TOTAL_TONNES_HA if CROP_CODE == 9221
replace hay_1_fed_tot_tns_ha = 0 if hay_1_fed_tot_tns_ha == . 

