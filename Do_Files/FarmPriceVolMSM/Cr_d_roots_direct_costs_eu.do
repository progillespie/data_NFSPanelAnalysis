*******************************************
* Create d_roots_direct_costs_eu
*******************************************
sort FARM_CODE YE_AR  CROP_CODE
by FARM_CODE YE_AR  :egen rnk =rank(CROP_CODE), unique
keep if rnk == 1

drop rnk

*keep FARM_CODE YE_AR s_sgr_bt_opfed_sheep_eu s_sgr_bt_cyfed_sheep_eu s_fdr_beet_fed_sheep_op_eu s_fdr_beet_fed_sheep_cu_eu s_trnps_mgls_fedsheep_op_inv_eu  s_trnps_mgls_fedsheep_cu_eu  mgolds_fed_sheep_tns_ha_1 


gen d_roots_direct_costs_eu = s_sgr_bt_opfed_sheep_eu + s_sgr_bt_cyfed_sheep_eu + s_fdr_beet_fed_sheep_op_eu + s_fdr_beet_fed_sheep_cu_eu + s_trnps_mgls_fedsheep_op_inv_eu  + s_trnps_mgls_fedsheep_cu_eu + (i_mangolds_fed_unit_cost * mgolds_fed_sheep_tns_ha_1) 
replace d_roots_direct_costs_eu = 0 if d_roots_direct_costs_eu  == .

keep FARM_CODE YE_AR d_roots_direct_costs_eu s_sgr_bt_opfed_sheep_eu s_sgr_bt_cyfed_sheep_eu s_fdr_beet_fed_sheep_op_eu s_fdr_beet_fed_sheep_cu_eu s_trnps_mgls_fedsheep_op_inv_eu  s_trnps_mgls_fedsheep_cu_eu  mgolds_fed_sheep_tns_ha_1 


