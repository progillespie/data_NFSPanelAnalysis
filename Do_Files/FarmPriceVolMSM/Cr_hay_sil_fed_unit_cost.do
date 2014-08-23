*******************************************
* Create hay_sil_fed_unit_cost
*******************************************
by  FARM_CODE YE_AR: egen s_sil_0_i_tot_hme_grsd_eu = sum(sil_0_i_tot_hme_grsd_eu)
by  FARM_CODE YE_AR: egen s_sil_1_i_tot_hme_grsd_eu = sum(sil_1_i_tot_hme_grsd_eu)
by  FARM_CODE YE_AR: egen s_sil_0_fed_tot_tns_ha = sum(sil_0_fed_tot_tns_ha)
by  FARM_CODE YE_AR: egen s_sil_1_fed_tot_tns_ha = sum(sil_1_fed_tot_tns_ha)
by  FARM_CODE YE_AR: egen d_sil_fertiliser_cost_eu = sum(sil_fert_cost)
by  FARM_CODE YE_AR: egen s_lab_alloc_to_sil = sum(lab_alloc_to_sil)

by  FARM_CODE YE_AR: egen s_hay_1_i_tot_hme_grsd_eu = sum(hay_1_i_tot_hme_grsd_eu)
by  FARM_CODE YE_AR: egen s_hay_0_fed_tot_tns_ha = sum(hay_0_fed_tot_tns_ha)
by  FARM_CODE YE_AR: egen s_hay_1_fed_tot_tns_ha = sum(hay_1_fed_tot_tns_ha)
by  FARM_CODE YE_AR: egen d_hay_fertiliser_cost_eu = sum(hay_fert_cost)
by  FARM_CODE YE_AR: egen s_lab_alloc_to_hay = sum(lab_alloc_to_hay)


by  FARM_CODE YE_AR: egen rnk = rank(YE_AR),unique

keep if rnk == 1

drop rnk

keep FARM_CODE YE_AR s_sil_0_i_tot_hme_grsd_eu s_sil_1_i_tot_hme_grsd_eu s_sil_0_fed_tot_tns_ha s_sil_1_fed_tot_tns_ha d_sil_fertiliser_cost_eu  s_lab_alloc_to_sil s_hay_0_fed_tot_tns_ha s_hay_1_fed_tot_tns_ha d_hay_fertiliser_cost_eu s_lab_alloc_to_hay s_hay_1_i_tot_hme_grsd_eu

