*******************************************
* Create merged_crop_tables_2
*******************************************




** I_CONCENTRATES_FED_DAIRY

gen temp_conc_fed = 1 if CROP_CODE == 1110 | CROP_CODE == 1111 | CROP_CODE == 1112 | CROP_CODE == 1113 | CROP_CODE == 1116 | CROP_CODE == 1117 | CROP_CODE == 1130 | CROP_CODE == 1131 | CROP_CODE == 1133 | CROP_CODE == 1140 | CROP_CODE == 1141 | CROP_CODE == 1146 | CROP_CODE == 1147 | CROP_CODE == 1150 | CROP_CODE == 1151 | CROP_CODE == 1153 | CROP_CODE == 1156 | CROP_CODE == 1157 | CROP_CODE == 1160 | CROP_CODE == 1161 | CROP_CODE == 1166 | CROP_CODE == 1190 | CROP_CODE == 1191 | CROP_CODE == 1196 | CROP_CODE == 1570 | CROP_CODE == 1571 | CROP_CODE == 1576 | CROP_CODE == 1577 | CROP_CODE == 1280 | CROP_CODE == 1281 | CROP_CODE == 1283 | CROP_CODE == 1286   
replace temp_conc_fed = 0 if temp_conc_fed == .

gen i_concentrates_fed_dairy = (FED_DAIRY_TONNES_HA / FED_TOTAL_TONNES_HA) * (OP_INV_FED_VALUE_EU + CY_FED_VALUE_EU) if temp_conc_fed == 1 
replace i_concentrates_fed_dairy = 0 if i_concentrates_fed_dairy  == .

foreach var in  FED_DAIRY_TONNES_HA FED_TOTAL_TONNES_HA OP_INV_FED_VALUE_EU CY_FED_VALUE_EU I_CONCENTRATES_FED_DAIRY {
	replace `var' = 0 if `var' == .
}


** I_CONCENTRATES_FED_CATTLE

gen i_concentrates_fed_cattle = (FED_CATTLE_TONNES_HA / FED_TOTAL_TONNES_HA) * (OP_INV_FED_VALUE_EU + CY_FED_VALUE_EU) if temp_conc_fed == 1 
replace i_concentrates_fed_cattle = 0 if i_concentrates_fed_cattle == .

replace FED_CATTLE_TONNES_HA = 0 if FED_CATTLE_TONNES_HA == .
replace I_CONCENTRATES_FED_CATTLE = 0 if I_CONCENTRATES_FED_CATTLE == .


** I_CONCENTRATES_FED_SHEEP

gen i_concentrates_fed_sheep = (FED_SHEEP_TONNES_HA / FED_TOTAL_TONNES_HA) * (OP_INV_FED_VALUE_EU + CY_FED_VALUE_EU) if temp_conc_fed == 1 
replace i_concentrates_fed_sheep = 0 if i_concentrates_fed_sheep == .

replace FED_SHEEP_TONNES_HA = 0 if FED_SHEEP_TONNES_HA == .
replace I_CONCENTRATES_FED_SHEEP = 0 if I_CONCENTRATES_FED_SHEEP == .


** I_CONCENTRATES_FED_PIGS

gen i_concentrates_fed_pigs = (FED_PIGS_TONNES_HA / FED_TOTAL_TONNES_HA) * (OP_INV_FED_VALUE_EU + CY_FED_VALUE_EU) if temp_conc_fed == 1 | CROP_CODE == 1270 | CROP_CODE == 1271 | CROP_CODE == 1273 | CROP_CODE == 1276 | CROP_CODE == 1277 
replace i_concentrates_fed_pigs = 0 if i_concentrates_fed_pigs == .

replace FED_PIGS_TONNES_HA = 0 if FED_PIGS_TONNES_HA == .
replace I_CONCENTRATES_FED_PIGS = 0 if I_CONCENTRATES_FED_PIGS == .


** I_CONCENTRATES_FED_POULTRY

gen i_concentrates_fed_poultry = (FED_POULTRY_TONNES_HA / FED_TOTAL_TONNES_HA) * (OP_INV_FED_VALUE_EU + CY_FED_VALUE_EU) if temp_conc_fed == 1 
replace i_concentrates_fed_poultry = 0 if i_concentrates_fed_poultry == .

replace FED_POULTRY_TONNES_HA = 0 if FED_POULTRY_TONNES_HA == .
replace I_CONCENTRATES_FED_POULTRY= 0 if I_CONCENTRATES_FED_POULTRY== .


** I_CONCENTRATES_FED_HORSES

gen i_concentrates_fed_horses = (FED_HORSES_TONNES_HA / FED_TOTAL_TONNES_HA) * (OP_INV_FED_VALUE_EU + CY_FED_VALUE_EU) if temp_conc_fed == 1 
replace i_concentrates_fed_horses = 0 if i_concentrates_fed_horses == .

replace FED_HORSES_TONNES_HA = 0 if FED_HORSES_TONNES_HA == .
replace I_CONCENTRATES_FED_HORSES = 0 if I_CONCENTRATES_FED_HORSES == .



** I_TOTAL_AND_HOME_GROWN_SEED_EU

gen i_total_and_home_grown_seed_eu = total_eu +  HOME_GROWN_SEED_VALUE_EU
replace i_total_and_home_grown_seed_eu = 0 if i_total_and_home_grown_seed_eu == .


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

** silage - casual labour
gen lab_alloc_to_hay = ALLOCATED_TO_CROP_EU if CROP_CODE == 9221
replace lab_alloc_to_hay = 0 if lab_alloc_to_hay == .


** D_GRAZING_TOTAL_DIRECT_COSTS_EU

foreach var in s_c_FERT_USED_VALUE_EU  ALLOCATED_TO_CROP_EU  i_total_and_home_grown_seed_eu s_c_ORIGINAL_QUANTITY_50KGBAGS  {
	replace `var' = 0 if `var' == .
}


gen grazing_total_dc_eu = s_c_FERT_USED_VALUE_EU + ALLOCATED_TO_CROP_EU + i_total_and_home_grown_seed_eu if CROP_CODE == 9211
replace grazing_total_dc_eu = 0 if grazing_total_dc_eu == .


**D_SIL_FERTILISER_COST_EU
gen sil_fert_cost = s_c_FERT_USED_VALUE_EU if CROP_CODE == 9231
replace sil_fert_cost = 0 if sil_fert_cost == .

**D_HAY_FERTILISER_COST_EU
gen hay_fert_cost = s_c_FERT_USED_VALUE_EU if CROP_CODE == 9221
replace hay_fert_cost = 0 if hay_fert_cost == .

**D_TOTAL_DIRECT_COST_EU
gen d_total_direct_cost_eu = s_c_FERT_USED_VALUE_EU + ALLOCATED_TO_CROP_EU + i_total_and_home_grown_seed_eu if CROP_CODE != 1171 & CROP_CODE != 1327 & CROP_CODE != 1461 & CROP_CODE != 1463 & CROP_CODE != 7211 & CROP_CODE != 9210 & CROP_CODE != 9211 & CROP_CODE != 9212 & CROP_CODE != 9221 & CROP_CODE != 9223 & CROP_CODE != 9230 & CROP_CODE != 9231 
replace d_total_direct_cost_eu = 0 if d_total_direct_cost_eu == .


** I_OP_INV_VAL_EU

gen op_inv_val_0 = 1 if CROP_CODE == 9010 
replace op_inv_val_0 = 2 if CROP_CODE == 9020 
replace op_inv_val_0 = 3 if CROP_CODE == 9030
replace op_inv_val_0 = 4 if CROP_CODE == 9040
replace op_inv_val_0 = 5 if CROP_CODE == 9050
replace op_inv_val_0 = 6 if CROP_CODE == 9060
replace op_inv_val_0 = 7 if CROP_CODE == 9070
replace op_inv_val_0 = 8 if CROP_CODE == 9080
replace op_inv_val_0 = 9 if CROP_CODE == 9090
replace op_inv_val_0 = 10 if CROP_CODE == 9120
replace op_inv_val_0 = 11 if CROP_CODE == 9210
replace op_inv_val_0 = 12 if CROP_CODE == 9220
replace op_inv_val_0 = 13 if CROP_CODE == 9230
replace op_inv_val_0 = 14 if CROP_CODE == 8110
replace op_inv_val_0 = 15 if CROP_CODE == 8120

gen op_inv_val_1 = 1 if CROP_CODE == 9011
replace op_inv_val_1 = 2 if CROP_CODE == 9021
replace op_inv_val_1 = 3 if CROP_CODE == 9031
replace op_inv_val_1 = 4 if CROP_CODE == 9041
replace op_inv_val_1 = 5 if CROP_CODE == 9051
replace op_inv_val_1 = 6 if CROP_CODE == 9061
replace op_inv_val_1 = 7 if CROP_CODE == 9071
replace op_inv_val_1 = 8 if CROP_CODE == 9081
replace op_inv_val_1 = 9 if CROP_CODE == 9091
replace op_inv_val_1 = 10 if CROP_CODE == 9121
replace op_inv_val_1 = 11 if CROP_CODE == 9211
replace op_inv_val_1 = 12 if CROP_CODE == 9221
replace op_inv_val_1 = 13 if CROP_CODE == 9231
replace op_inv_val_1 = 14 if CROP_CODE == 8111
replace op_inv_val_1 = 15 if CROP_CODE == 8121

gen op_inv_val_2 = 8 if CROP_CODE == 9083


gen crop_code1 = int( CROP_CODE/10)

sort FARM_CODE YE_AR crop_code1


by  FARM_CODE YE_AR crop_code1: egen m_op_inv_val_1 = sum(op_inv_val_1)

gen op_inv_val_cond1 = 1 if CROP_CODE == 9010 | CROP_CODE == 9020  | CROP_CODE == 9030  | CROP_CODE == 9040  | CROP_CODE == 9050  | CROP_CODE == 9060  | CROP_CODE == 9070  | CROP_CODE == 9080  | CROP_CODE == 9090  | CROP_CODE == 9120  | CROP_CODE == 9210  | CROP_CODE == 9220  | CROP_CODE == 9230

gen op_inv_val_cond2 = 1 if  OP_INV_QTY_TONNES_HA > 0 & OP_INV_VALUE_EU == 0 & op_inv_val_0 == m_op_inv_val_1


gen cy_total_yeild_1 =  CY_TOTAL_YIELD if CROP_CODE == 9011 | CROP_CODE == 9021  | CROP_CODE == 9031  | CROP_CODE == 9041  | CROP_CODE == 9051  | CROP_CODE == 9061  | CROP_CODE == 9071  | CROP_CODE == 9081  | CROP_CODE == 9091  | CROP_CODE == 9121  | CROP_CODE == 9211  | CROP_CODE == 9221  | CROP_CODE == 9231 | CROP_CODE == 9083 | CROP_CODE == 8111

by  FARM_CODE YE_AR crop_code1: egen m_cy_total_yeild_1 = sum(cy_total_yeild_1)

gen cy_wst_tons_ha_1 =  CY_WASTE_TONNES_HA if CROP_CODE == 9011 | CROP_CODE == 9021  | CROP_CODE == 9031  | CROP_CODE == 9041  | CROP_CODE == 9051  | CROP_CODE == 9061  | CROP_CODE == 9071  | CROP_CODE == 9081  | CROP_CODE == 9091  | CROP_CODE == 9121  | CROP_CODE == 9211  | CROP_CODE == 9221  | CROP_CODE == 9231 | CROP_CODE == 9083 | CROP_CODE == 8111

by  FARM_CODE YE_AR crop_code1: egen m_cy_wst_tons_ha_1 = sum(cy_wst_tons_ha_1)

gen d_total_direct_cost_eu_1 = d_total_direct_cost_eu if CROP_CODE == 9011 | CROP_CODE == 9021  | CROP_CODE == 9031  | CROP_CODE == 9041  | CROP_CODE == 9051  | CROP_CODE == 9061  | CROP_CODE == 9071  | CROP_CODE == 9081  | CROP_CODE == 9091  | CROP_CODE == 9121  | CROP_CODE == 9211  | CROP_CODE == 9221  | CROP_CODE == 9231 | CROP_CODE == 9083 | CROP_CODE == 8111

by  FARM_CODE YE_AR crop_code1: egen m_d_total_direct_cost_eu_1 = sum(d_total_direct_cost_eu_1)

gen op_inv_val_cond3 = 1 if m_cy_total_yeild_1 == 0
gen op_inv_val_cond4 = 1 if  OP_INV_QTY_TONNES_HA > 0 & OP_INV_VALUE_EU == 0

gen i_op_inv_val_eu = 0 if op_inv_val_cond1 == 1 & op_inv_val_cond2 == 1 & op_inv_val_cond3 == 1
replace i_op_inv_val_eu = (OP_INV_QTY_TONNES_HA / m_cy_total_yeild_1) * m_d_total_direct_cost_eu_1 if op_inv_val_cond1 == 1 & op_inv_val_cond2 == 1 & i_op_inv_val_eu == .
replace i_op_inv_val_eu = OP_INV_QTY_TONNES_HA * 55 if op_inv_val_cond1 == 1 & op_inv_val_cond4 == 1 & (CROP_CODE == 9020 | CROP_CODE == 9030) & i_op_inv_val_eu == .
replace i_op_inv_val_eu = OP_INV_QTY_TONNES_HA * 40 if op_inv_val_cond1 == 1 & op_inv_val_cond4 == 1 & (CROP_CODE == 9040  | CROP_CODE == 9050  | CROP_CODE == 9060  | CROP_CODE == 9070  | CROP_CODE == 9080  | CROP_CODE == 9090) & i_op_inv_val_eu == .
replace i_op_inv_val_eu = OP_INV_QTY_TONNES_HA * 25 if op_inv_val_cond1 == 1 & op_inv_val_cond4 == 1 & i_op_inv_val_eu == .
replace i_op_inv_val_eu = OP_INV_VALUE_EU if op_inv_val_cond1 == 1 & i_op_inv_val_eu == .
replace i_op_inv_val_eu = 0 if i_op_inv_val_eu == .

replace I_OP_INV_VAL_EU = 0 if I_OP_INV_VAL_EU == .

by  FARM_CODE YE_AR crop_code1 : egen opening = sum(op_inv_val_0) 
by  FARM_CODE YE_AR crop_code1 : egen curryld = sum(op_inv_val_1) 
by  FARM_CODE YE_AR crop_code1 : egen curryld_1 = sum(op_inv_val_2)


gen cy_fed_qty_tonnes_ha_1 =  CY_FED_QTY_TONNES_HA if CROP_CODE == 9011 | CROP_CODE == 9021  | CROP_CODE == 9031  | CROP_CODE == 9041  | CROP_CODE == 9051  | CROP_CODE == 9061  | CROP_CODE == 9071  | CROP_CODE == 9081  | CROP_CODE == 9091  | CROP_CODE == 9121  | CROP_CODE == 9211  | CROP_CODE == 9221  | CROP_CODE == 9231 | CROP_CODE == 9083 | CROP_CODE == 8111
by  FARM_CODE YE_AR crop_code1: egen m_cy_fed_qty_tonnes_ha_1 = sum(cy_fed_qty_tonnes_ha_1)

gen fed_total_tonnes_ha_1 =  FED_TOTAL_TONNES_HA if CROP_CODE == 9011 | CROP_CODE == 9021  | CROP_CODE == 9031  | CROP_CODE == 9041  | CROP_CODE == 9051  | CROP_CODE == 9061  | CROP_CODE == 9071  | CROP_CODE == 9081  | CROP_CODE == 9091  | CROP_CODE == 9121  | CROP_CODE == 9211  | CROP_CODE == 9221  | CROP_CODE == 9231 | CROP_CODE == 9083 | CROP_CODE == 8111
by  FARM_CODE YE_AR crop_code1: egen m_fed_total_tonnes_ha_1 = sum(fed_total_tonnes_ha_1)

gen cy_and_op_fed = CY_FED_QTY_TONNES_HA + OP_INV_FED_QTY_TONNES_HA
by  FARM_CODE YE_AR crop_code1: egen s_cy_and_op_fed = sum(cy_and_op_fed)

** I_ARABLE_SILAGE_FED_UNIT_COST

gen a_sil_cond1 = 1 if OP_INV_FED_QTY_TONNES_HA > 0 & m_cy_fed_qty_tonnes_ha_1 == 0 & CROP_CODE == 9030 & opening == 3

gen a_sil_fed_unit_cost = i_op_inv_val_eu / OP_INV_QTY_TONNES_HA if a_sil_cond1 == 1

replace a_sil_fed_unit_cost = (i_op_inv_val_eu + (m_d_total_direct_cost_eu_1 / m_cy_total_yeild_1) * m_fed_total_tonnes_ha_1) / s_cy_and_op_fed if m_cy_total_yeild_1 > 0 & CROP_CODE == 9030 & opening == 3 & curryld == 3 & a_sil_fed_unit_cost == .

replace a_sil_fed_unit_cost = i_op_inv_val_eu / s_cy_and_op_fed if CROP_CODE == 9030 & opening == 3 & curryld != 3 & a_sil_fed_unit_cost == .

replace a_sil_fed_unit_cost = ((m_d_total_direct_cost_eu_1 / m_cy_total_yeild_1) * m_fed_total_tonnes_ha_1) / s_cy_and_op_fed if m_cy_total_yeild_1 > 0 & CROP_CODE == 9031 & opening != 3 & curryld == 3 & a_sil_fed_unit_cost == .

replace a_sil_fed_unit_cost = 0 if a_sil_fed_unit_cost == .



** I_FODDER_BEET_FED_UNIT_COST

gen a_fdrbt_cond1 = 1 if OP_INV_FED_QTY_TONNES_HA > 0 & m_cy_fed_qty_tonnes_ha_1 == 0 & CROP_CODE == 9060 & opening == 6

gen fdrbt_fed_unit_cost = i_op_inv_val_eu / OP_INV_QTY_TONNES_HA if a_fdrbt_cond1 == 1

replace fdrbt_fed_unit_cost = (OP_INV_FED_VALUE_EU + (m_d_total_direct_cost_eu_1 / m_cy_total_yeild_1) * m_fed_total_tonnes_ha_1) / s_cy_and_op_fed if m_cy_total_yeild_1 > 0 & CROP_CODE == 9060 & opening == 6 & curryld == 6 & fdrbt_fed_unit_cost == .


replace fdrbt_fed_unit_cost = OP_INV_FED_VALUE_EU / s_cy_and_op_fed if CROP_CODE == 9060 & opening == 6 & curryld != 6 & fdrbt_fed_unit_cost == .

replace fdrbt_fed_unit_cost= ((m_d_total_direct_cost_eu_1 / m_cy_total_yeild_1) * m_fed_total_tonnes_ha_1) / s_cy_and_op_fed if m_cy_total_yeild_1 > 0 & CROP_CODE == 9061 & opening != 6 & curryld == 6 & fdrbt_fed_unit_cost == .

replace fdrbt_fed_unit_cost = 0 if fdrbt_fed_unit_cost == .


** I_SUGAR_BEET_FED_UNIT_COST

gen sgrbt_fed_unit_cost = OP_INV_VALUE_EU / s_cy_and_op_fed if CROP_CODE == 1320
replace sgrbt_fed_unit_cost = 0 if sgrbt_fed_unit_cost  == .


** I_MAIZE_SILAGE_FED_UNIT_COST

gen mz_sil_cond1 = 1 if OP_INV_FED_QTY_TONNES_HA > 0 & m_cy_fed_qty_tonnes_ha_1 == 0 & CROP_CODE == 9020 & opening == 2

gen mz_sil_fed_unit_cost = i_op_inv_val_eu / OP_INV_QTY_TONNES_HA if mz_sil_cond1 == 1

replace mz_sil_fed_unit_cost = (i_op_inv_val_eu + (m_d_total_direct_cost_eu_1 / m_cy_total_yeild_1) * m_fed_total_tonnes_ha_1) / s_cy_and_op_fed if m_cy_total_yeild_1 > 0 & CROP_CODE == 9020 & opening == 2 & curryld == 2 & mz_sil_fed_unit_cost == .

replace mz_sil_fed_unit_cost = i_op_inv_val_eu / s_cy_and_op_fed if CROP_CODE == 9020 & opening == 2 & curryld != 2 & mz_sil_fed_unit_cost == .

replace mz_sil_fed_unit_cost = ((m_d_total_direct_cost_eu_1 / m_cy_total_yeild_1) * m_fed_total_tonnes_ha_1) / s_cy_and_op_fed if m_cy_total_yeild_1 > 0 & CROP_CODE == 9021 & opening != 2 & curryld == 2 & mz_sil_fed_unit_cost == .

replace mz_sil_fed_unit_cost = 0 if mz_sil_fed_unit_cost == .



** I_OATS_IN_SHEAF_FED_UNIT_COST

gen ots_shf_cond1 = 1 if OP_INV_FED_QTY_TONNES_HA > 0 & m_cy_fed_qty_tonnes_ha_1 == 0 & CROP_CODE == 9010 & opening == 1

gen ots_shf_fed_unit_cost = i_op_inv_val_eu / OP_INV_QTY_TONNES_HA if ots_shf_cond1 == 1

replace ots_shf_fed_unit_cost = (i_op_inv_val_eu + (m_d_total_direct_cost_eu_1 / m_cy_total_yeild_1) * m_fed_total_tonnes_ha_1) / s_cy_and_op_fed if m_cy_total_yeild_1 > 0 & CROP_CODE == 9010 & opening == 1 & curryld == 1 & ots_shf_fed_unit_cost == .

replace ots_shf_fed_unit_cost = i_op_inv_val_eu / s_cy_and_op_fed if CROP_CODE == 9010 & opening == 1 & curryld != 1 & ots_shf_fed_unit_cost == .

replace ots_shf_fed_unit_cost = ((m_d_total_direct_cost_eu_1 / m_cy_total_yeild_1) * m_fed_total_tonnes_ha_1) / s_cy_and_op_fed if m_cy_total_yeild_1 > 0 & CROP_CODE == 9011 & opening != 1 & curryld == 1 & ots_shf_fed_unit_cost == .

replace ots_shf_fed_unit_cost = 0 if ots_shf_fed_unit_cost == .


** I_MANGOLDS_FED_UNIT_COST

gen mgolds_cond1 = 1 if OP_INV_FED_QTY_TONNES_HA > 0 & m_cy_fed_qty_tonnes_ha_1 == 0 & CROP_CODE == 9050 & opening == 5

gen mgolds_fed_unit_cost = i_op_inv_val_eu / OP_INV_QTY_TONNES_HA if mgolds_cond1 == 1

replace mgolds_fed_unit_cost = (i_op_inv_val_eu + (m_d_total_direct_cost_eu_1 / m_cy_total_yeild_1) * m_fed_total_tonnes_ha_1) / s_cy_and_op_fed if m_cy_total_yeild_1 > 0 & CROP_CODE == 9050 & opening == 5 & curryld == 5 & mgolds_fed_unit_cost == .

replace mgolds_fed_unit_cost = i_op_inv_val_eu / s_cy_and_op_fed if CROP_CODE == 9050 & opening == 5 & curryld != 5 & mgolds_fed_unit_cost == .

replace mgolds_fed_unit_cost = ((m_d_total_direct_cost_eu_1 / m_cy_total_yeild_1) * m_fed_total_tonnes_ha_1) / s_cy_and_op_fed if m_cy_total_yeild_1 > 0 & CROP_CODE == 9051 & opening != 5 & curryld == 5 & mgolds_fed_unit_cost == .

replace mgolds_fed_unit_cost = 0 if mgolds_fed_unit_cost == .


** I_RAPE_SEED_FED_UNIT_COST

gen rseed_cond1 = 1 if OP_INV_FED_QTY_TONNES_HA > 0 & m_cy_fed_qty_tonnes_ha_1 == 0 & CROP_CODE == 9080 & opening == 8 & (curryld == 8 |curryld_1 == 8) 

gen rseed_fed_unit_cost = i_op_inv_val_eu / OP_INV_QTY_TONNES_HA if rseed_cond1 == 1

replace rseed_fed_unit_cost = (i_op_inv_val_eu + (m_d_total_direct_cost_eu_1 / m_cy_total_yeild_1) * m_fed_total_tonnes_ha_1) / s_cy_and_op_fed if m_cy_total_yeild_1 > 0 & CROP_CODE == 9080 & opening == 8 & (curryld == 8 |curryld_1 == 8)  & rseed_fed_unit_cost == .

replace rseed_fed_unit_cost = i_op_inv_val_eu / s_cy_and_op_fed if CROP_CODE == 9080 & opening == 8 & curryld != 8 & curryld_1 != 8 & rseed_fed_unit_cost == .

replace rseed_fed_unit_cost = ((m_d_total_direct_cost_eu_1 / (m_cy_total_yeild_1 - m_cy_wst_tons_ha_1)) * m_fed_total_tonnes_ha_1) / s_cy_and_op_fed if m_cy_total_yeild_1 > 0 & (CROP_CODE == 9081 | CROP_CODE == 9083) & opening != 8 & (curryld == 8 | curryld_1 == 8) & rseed_fed_unit_cost == .

replace rseed_fed_unit_cost = 0 if rseed_fed_unit_cost == .


** I_STRAW_FED_UNIT_COST

gen stw_cond1 = 1 if OP_INV_FED_QTY_TONNES_HA > 0 & m_cy_fed_qty_tonnes_ha_1 == 0 & CROP_CODE == 8110 & opening == 14

gen stw_fed_unit_cost = OP_INV_VALUE_EU / OP_INV_QTY_TONNES_HA if stw_cond1 == 1

replace stw_fed_unit_cost = (OP_INV_FED_VALUE_EU + (m_d_total_direct_cost_eu_1 / m_cy_total_yeild_1) * m_fed_total_tonnes_ha_1) / s_cy_and_op_fed if m_cy_total_yeild_1 > 0 & CROP_CODE == 8110 & opening == 14 & curryld == 14 & stw_fed_unit_cost == .

replace stw_fed_unit_cost = OP_INV_FED_VALUE_EU / s_cy_and_op_fed if CROP_CODE == 8110 & opening == 14 & curryld != 14 & stw_fed_unit_cost == .

replace stw_fed_unit_cost = ((m_d_total_direct_cost_eu_1 / m_cy_total_yeild_1) * m_fed_total_tonnes_ha_1) / s_cy_and_op_fed if m_cy_total_yeild_1 > 0 & CROP_CODE == 8111 & opening != 14 & curryld == 14 & stw_fed_unit_cost == .

replace stw_fed_unit_cost = 0 if stw_fed_unit_cost == .


** I_SUGAR_FED_UNIT_COST

gen sug_cond1 = 1 if OP_INV_FED_QTY_TONNES_HA > 0 & m_cy_fed_qty_tonnes_ha_1 == 0 & CROP_CODE == 8120 & opening == 15

gen sug_fed_unit_cost = OP_INV_VALUE_EU / OP_INV_QTY_TONNES_HA if sug_cond1 == 1

replace sug_fed_unit_cost = (OP_INV_FED_VALUE_EU + (m_d_total_direct_cost_eu_1 / m_cy_total_yeild_1) * m_fed_total_tonnes_ha_1) / s_cy_and_op_fed if m_cy_total_yeild_1 > 0 & CROP_CODE == 8120 & opening == 15 & curryld == 15 & sug_fed_unit_cost == .

replace sug_fed_unit_cost = OP_INV_FED_VALUE_EU / s_cy_and_op_fed if CROP_CODE == 8120 & opening == 15 & curryld != 15 & sug_fed_unit_cost == .

replace sug_fed_unit_cost = ((m_d_total_direct_cost_eu_1 / m_cy_total_yeild_1) * m_fed_total_tonnes_ha_1) / s_cy_and_op_fed if m_cy_total_yeild_1 > 0 & CROP_CODE == 8121 & opening != 15 & curryld == 15 & sug_fed_unit_cost == .

replace sug_fed_unit_cost = 0 if sug_fed_unit_cost == .


** I_KALE_FED_UNIT_COST

gen kale_cond1 = 1 if OP_INV_FED_QTY_TONNES_HA > 0 & m_cy_fed_qty_tonnes_ha_1 == 0 & CROP_CODE == 9070 & opening == 7

gen kale_fed_unit_cost = OP_INV_VALUE_EU / OP_INV_QTY_TONNES_HA if kale_cond1 == 1

replace kale_fed_unit_cost = (OP_INV_FED_VALUE_EU + (m_d_total_direct_cost_eu_1 / m_cy_total_yeild_1) * m_fed_total_tonnes_ha_1) / s_cy_and_op_fed if m_cy_total_yeild_1 > 0 & CROP_CODE == 9070 & opening == 7 & curryld == 7 & kale_fed_unit_cost == .

replace kale_fed_unit_cost = OP_INV_FED_VALUE_EU / s_cy_and_op_fed if CROP_CODE == 9070 & opening == 7 & curryld != 7 & kale_fed_unit_cost == .

replace kale_fed_unit_cost = ((m_d_total_direct_cost_eu_1 / m_cy_total_yeild_1) * m_fed_total_tonnes_ha_1) / s_cy_and_op_fed if m_cy_total_yeild_1 > 0 & CROP_CODE == 9071 & opening != 7 & curryld == 7 & kale_fed_unit_cost == .

replace kale_fed_unit_cost = 0 if kale_fed_unit_cost == .


** winter forage fed to dairy**

by  FARM_CODE YE_AR : egen sil_fed_dairy_tns_ha = sum(FED_DAIRY_TONNES_HA) if CROP_CODE == 9230 | CROP_CODE == 9231 
replace sil_fed_dairy_tns_ha = 0 if sil_fed_dairy_tns_ha == .
by  FARM_CODE YE_AR : egen sil_fed_dairy_tns_ha_1 = max(sil_fed_dairy_tns_ha)

by  FARM_CODE YE_AR : egen hay_fed_dairy_tns_ha = sum(FED_DAIRY_TONNES_HA) if CROP_CODE == 9220 | CROP_CODE == 9221 
replace hay_fed_dairy_tns_ha = 0 if hay_fed_dairy_tns_ha == .
by  FARM_CODE YE_AR : egen hay_fed_dairy_tns_ha_1 = max(hay_fed_dairy_tns_ha)

by  FARM_CODE YE_AR : egen asil_fed_dairy_tns_ha = sum(FED_DAIRY_TONNES_HA) if CROP_CODE == 9030 | CROP_CODE == 9031 
replace asil_fed_dairy_tns_ha = 0 if asil_fed_dairy_tns_ha == .
by  FARM_CODE YE_AR : egen asil_fed_dairy_tns_ha_1 = max(asil_fed_dairy_tns_ha)

by  FARM_CODE YE_AR : egen fdrbt_fed_dairy_tns_ha = sum (FED_DAIRY_TONNES_HA) if CROP_CODE == 9060 | CROP_CODE == 9061
replace fdrbt_fed_dairy_tns_ha = 0 if fdrbt_fed_dairy_tns_ha == .
by  FARM_CODE YE_AR : egen fdrbt_fed_dairy_tns_ha_1 = max(fdrbt_fed_dairy_tns_ha)

by  FARM_CODE YE_AR : egen sgrbt_fed_dairy_tns_ha = sum (FED_DAIRY_TONNES_HA) if CROP_CODE == 1320 | CROP_CODE == 1321
replace sgrbt_fed_dairy_tns_ha = 0 if sgrbt_fed_dairy_tns_ha == .
by  FARM_CODE YE_AR : egen sgrbt_fed_dairy_tns_ha_1 = max(sgrbt_fed_dairy_tns_ha)

by  FARM_CODE YE_AR : egen mz_sil_fed_dairy_tns_ha = sum (FED_DAIRY_TONNES_HA) if CROP_CODE == 9020 | CROP_CODE == 9021
replace mz_sil_fed_dairy_tns_ha = 0 if mz_sil_fed_dairy_tns_ha == .
by  FARM_CODE YE_AR : egen mz_sil_fed_dairy_tns_ha_1 = max(mz_sil_fed_dairy_tns_ha)

by  FARM_CODE YE_AR : egen ots_shf_fed_dairy_tns_ha = sum (FED_DAIRY_TONNES_HA) if CROP_CODE == 9010 | CROP_CODE == 9011
replace ots_shf_fed_dairy_tns_ha = 0 if ots_shf_fed_dairy_tns_ha == .
by  FARM_CODE YE_AR : egen ots_shf_fed_dairy_tns_ha_1 = max(ots_shf_fed_dairy_tns_ha)

by  FARM_CODE YE_AR : egen mgolds_fed_dairy_tns_ha = sum (FED_DAIRY_TONNES_HA) if CROP_CODE == 9050 | CROP_CODE == 9051
replace mgolds_fed_dairy_tns_ha = 0 if mgolds_fed_dairy_tns_ha == .
by  FARM_CODE YE_AR : egen mgolds_fed_dairy_tns_ha_1 = max(mgolds_fed_dairy_tns_ha)

by  FARM_CODE YE_AR : egen rseed_fed_dairy_tns_ha = sum (FED_DAIRY_TONNES_HA) if CROP_CODE == 9080 | CROP_CODE == 9081 | CROP_CODE == 9083
replace rseed_fed_dairy_tns_ha = 0 if rseed_fed_dairy_tns_ha == .
by  FARM_CODE YE_AR : egen rseed_fed_dairy_tns_ha_1 = max(rseed_fed_dairy_tns_ha)

by  FARM_CODE YE_AR : egen stw_fed_dairy_tns_ha = sum (FED_DAIRY_TONNES_HA) if CROP_CODE == 8110 | CROP_CODE == 8111
replace stw_fed_dairy_tns_ha = 0 if stw_fed_dairy_tns_ha == .
by  FARM_CODE YE_AR : egen stw_fed_dairy_tns_ha_1 = max(stw_fed_dairy_tns_ha)

by  FARM_CODE YE_AR : egen sug_fed_dairy_tns_ha = sum (FED_DAIRY_TONNES_HA) if CROP_CODE == 8120 | CROP_CODE == 8121
replace sug_fed_dairy_tns_ha = 0 if sug_fed_dairy_tns_ha == .
by  FARM_CODE YE_AR : egen sug_fed_dairy_tns_ha_1 = max(sug_fed_dairy_tns_ha)

by  FARM_CODE YE_AR : egen kale_fed_dairy_tns_ha = sum (FED_DAIRY_TONNES_HA) if CROP_CODE == 9070 | CROP_CODE == 9071
replace kale_fed_dairy_tns_ha = 0 if kale_fed_dairy_tns_ha == .
by  FARM_CODE YE_AR : egen kale_fed_dairy_tns_ha_1 = max(kale_fed_dairy_tns_ha)


** Protein Beans, Protein Peas fed to dairy

by  FARM_CODE YE_AR : egen ptn_beans_peas_op_fed_eu = sum (OP_INV_FED_VALUE_EU) if CROP_CODE == 1270 | CROP_CODE == 1290
replace ptn_beans_peas_op_fed_eu = 0 if ptn_beans_peas_op_fed_eu == .
by  FARM_CODE YE_AR : egen ptn_beans_peas_op_fed_eu_1 = max(ptn_beans_peas_op_fed_eu)


by  FARM_CODE YE_AR : egen ptn_beans_peas_cy_fed_eu = sum (CY_FED_VALUE_EU) if CROP_CODE == 1271 | CROP_CODE == 1291
replace ptn_beans_peas_cy_fed_eu = 0 if ptn_beans_peas_cy_fed_eu == .
by  FARM_CODE YE_AR : egen ptn_beans_peas_cy_fed_eu_1 = max(ptn_beans_peas_cy_fed_eu)

gen tot_ptn_beans_peas_fed_eu = ptn_beans_peas_op_fed_eu_1 + ptn_beans_peas_cy_fed_eu_1 if CROP_CODE == 1270 | CROP_CODE == 1271 | CROP_CODE == 1273 | CROP_CODE == 1276 | CROP_CODE == 1277 | CROP_CODE == 1290 | CROP_CODE == 1291 | CROP_CODE == 1292 | CROP_CODE == 1296 | CROP_CODE == 1297

gen ptn_beans_peas_cond1 = 1 if CROP_CODE == 1270 | CROP_CODE == 1271 | CROP_CODE == 1273 | CROP_CODE == 1276 | CROP_CODE == 1277 | CROP_CODE == 1290 | CROP_CODE == 1291 | CROP_CODE == 1292 | CROP_CODE == 1296 | CROP_CODE == 1297

gen ptn_beans_peas_fed_dairy = 0 if FED_TOTAL_TONNES_HA == 0 & ptn_beans_peas_cond1 == 1

replace ptn_beans_peas_fed_dairy = (FED_DAIRY_TONNES_HA / FED_TOTAL_TONNES_HA) * tot_ptn_beans_peas_fed_eu  if ptn_beans_peas_cond1 == 1 & ptn_beans_peas_fed_dairy == .
replace ptn_beans_peas_fed_dairy = 0 if ptn_beans_peas_fed_dairy == .

by  FARM_CODE YE_AR : egen ptn_beans_peas_fed_dairy_1 = sum(ptn_beans_peas_fed_dairy)
by  FARM_CODE YE_AR : egen ptn_beans_peas_fed_dairy_2 = max(ptn_beans_peas_fed_dairy_1)

** Potatoes fed to dairy


by  FARM_CODE YE_AR : egen potato_op_fed_eu = sum (OP_INV_FED_VALUE_EU) if CROP_CODE == 1310
replace potato_op_fed_eu = 0 if potato_op_fed_eu == .
by  FARM_CODE YE_AR : egen potato_op_fed_eu_1 = max(potato_op_fed_eu) 

by  FARM_CODE YE_AR : egen potato_cy_fed_eu = sum (CY_FED_VALUE_EU) if CROP_CODE == 1311
replace potato_cy_fed_eu = 0 if potato_cy_fed_eu == .
by  FARM_CODE YE_AR : egen potato_cy_fed_eu_1 = max(potato_cy_fed_eu)

gen tot_potato_op_fed_eu = potato_op_fed_eu_1 + potato_cy_fed_eu_1 if CROP_CODE == 1310 | CROP_CODE == 1311 | CROP_CODE == 1317 | CROP_CODE == 1318 | CROP_CODE == 1319

gen potato_cond1 = 1 if CROP_CODE == 1310 | CROP_CODE == 1311 | CROP_CODE == 1317 | CROP_CODE == 1318 | CROP_CODE == 1319

gen potato_fed_dairy = 0 if FED_TOTAL_TONNES_HA == 0 & potato_cond1 == 1

replace potato_fed_dairy = (FED_DAIRY_TONNES_HA / FED_TOTAL_TONNES_HA) * tot_potato_op_fed_eu if potato_cond1 == 1 & potato_fed_dairy == .
replace potato_fed_dairy = 0 if potato_fed_dairy == .

by  FARM_CODE YE_AR : egen potato_fed_dairy_1 = sum(potato_fed_dairy)
by  FARM_CODE YE_AR : egen potato_fed_dairy_2 = max(potato_fed_dairy_1)


** winter forage fed to cattle**

by  FARM_CODE YE_AR : egen sil_fed_cattle_tns_ha = sum(FED_CATTLE_TONNES_HA) if CROP_CODE == 9230 | CROP_CODE == 9231 
replace sil_fed_cattle_tns_ha = 0 if sil_fed_cattle_tns_ha == .
by  FARM_CODE YE_AR : egen sil_fed_cattle_tns_ha_1 = max(sil_fed_cattle_tns_ha)

by  FARM_CODE YE_AR : egen hay_fed_cattle_tns_ha = sum(FED_CATTLE_TONNES_HA) if CROP_CODE == 9220 | CROP_CODE == 9221 
replace hay_fed_cattle_tns_ha = 0 if hay_fed_cattle_tns_ha == .
by  FARM_CODE YE_AR : egen hay_fed_cattle_tns_ha_1 = max(hay_fed_cattle_tns_ha)

by  FARM_CODE YE_AR : egen asil_fed_cattle_tns_ha = sum(FED_CATTLE_TONNES_HA) if CROP_CODE == 9030 | CROP_CODE == 9031 
replace asil_fed_cattle_tns_ha = 0 if asil_fed_cattle_tns_ha == .
by  FARM_CODE YE_AR : egen asil_fed_cattle_tns_ha_1 = max(asil_fed_cattle_tns_ha)

by  FARM_CODE YE_AR : egen fdrbt_fed_cattle_tns_ha = sum (FED_CATTLE_TONNES_HA) if CROP_CODE == 9060 | CROP_CODE == 9061
replace fdrbt_fed_cattle_tns_ha = 0 if fdrbt_fed_cattle_tns_ha == .
by  FARM_CODE YE_AR : egen fdrbt_fed_cattle_tns_ha_1 = max(fdrbt_fed_cattle_tns_ha)

by  FARM_CODE YE_AR : egen sgrbt_fed_cattle_tns_ha = sum (FED_CATTLE_TONNES_HA) if CROP_CODE == 1320 | CROP_CODE == 1321
replace sgrbt_fed_cattle_tns_ha = 0 if sgrbt_fed_cattle_tns_ha == .
by  FARM_CODE YE_AR : egen sgrbt_fed_cattle_tns_ha_1 = max(sgrbt_fed_cattle_tns_ha)

by  FARM_CODE YE_AR : egen mz_sil_fed_cattle_tns_ha = sum (FED_CATTLE_TONNES_HA) if CROP_CODE == 9020 | CROP_CODE == 9021
replace mz_sil_fed_cattle_tns_ha = 0 if mz_sil_fed_cattle_tns_ha == .
by  FARM_CODE YE_AR : egen mz_sil_fed_cattle_tns_ha_1 = max(mz_sil_fed_cattle_tns_ha)

by  FARM_CODE YE_AR : egen ots_shf_fed_cattle_tns_ha = sum (FED_CATTLE_TONNES_HA) if CROP_CODE == 9010 | CROP_CODE == 9011
replace ots_shf_fed_cattle_tns_ha = 0 if ots_shf_fed_cattle_tns_ha == .
by  FARM_CODE YE_AR : egen ots_shf_fed_cattle_tns_ha_1 = max(ots_shf_fed_cattle_tns_ha)

by  FARM_CODE YE_AR : egen mgolds_fed_cattle_tns_ha = sum (FED_CATTLE_TONNES_HA) if CROP_CODE == 9050 | CROP_CODE == 9051
replace mgolds_fed_cattle_tns_ha = 0 if mgolds_fed_cattle_tns_ha == .
by  FARM_CODE YE_AR : egen mgolds_fed_cattle_tns_ha_1 = max(mgolds_fed_cattle_tns_ha)

by  FARM_CODE YE_AR : egen rseed_fed_cattle_tns_ha = sum (FED_CATTLE_TONNES_HA) if CROP_CODE == 9080 | CROP_CODE == 9081 | CROP_CODE == 9083
replace rseed_fed_cattle_tns_ha = 0 if rseed_fed_cattle_tns_ha == .
by  FARM_CODE YE_AR : egen rseed_fed_cattle_tns_ha_1 = max(rseed_fed_cattle_tns_ha)

by  FARM_CODE YE_AR : egen stw_fed_cattle_tns_ha = sum (FED_CATTLE_TONNES_HA) if CROP_CODE == 8110 | CROP_CODE == 8111
replace stw_fed_cattle_tns_ha = 0 if stw_fed_cattle_tns_ha == .
by  FARM_CODE YE_AR : egen stw_fed_cattle_tns_ha_1 = max(stw_fed_cattle_tns_ha)

by  FARM_CODE YE_AR : egen sug_fed_cattle_tns_ha = sum (FED_CATTLE_TONNES_HA) if CROP_CODE == 8120 | CROP_CODE == 8121
replace sug_fed_cattle_tns_ha = 0 if sug_fed_cattle_tns_ha == .
by  FARM_CODE YE_AR : egen sug_fed_cattle_tns_ha_1 = max(sug_fed_cattle_tns_ha)

by  FARM_CODE YE_AR : egen kale_fed_cattle_tns_ha = sum (FED_CATTLE_TONNES_HA) if CROP_CODE == 9070 | CROP_CODE == 9071
replace kale_fed_cattle_tns_ha = 0 if kale_fed_cattle_tns_ha == .
by  FARM_CODE YE_AR : egen kale_fed_cattle_tns_ha_1 = max(kale_fed_cattle_tns_ha)


** Protein Beans, Protein Peas fed to cattle

gen ptn_beans_peas_fed_cattle = 0 if FED_TOTAL_TONNES_HA == 0 & ptn_beans_peas_cond1 == 1

replace ptn_beans_peas_fed_cattle = (FED_CATTLE_TONNES_HA / FED_TOTAL_TONNES_HA) * tot_ptn_beans_peas_fed_eu  if ptn_beans_peas_cond1 == 1 & ptn_beans_peas_fed_cattle == .
replace ptn_beans_peas_fed_cattle = 0 if ptn_beans_peas_fed_cattle == .

by  FARM_CODE YE_AR : egen ptn_beans_peas_fed_cattle_1 = sum(ptn_beans_peas_fed_cattle)
by  FARM_CODE YE_AR : egen ptn_beans_peas_fed_cattle_2 = max(ptn_beans_peas_fed_cattle_1)

** Potatoes fed to cattle

gen potato_fed_cattle = 0 if FED_TOTAL_TONNES_HA == 0 & potato_cond1 == 1

replace potato_fed_cattle = (FED_CATTLE_TONNES_HA / FED_TOTAL_TONNES_HA) * tot_potato_op_fed_eu if potato_cond1 == 1 & potato_fed_cattle == .
replace potato_fed_cattle = 0 if potato_fed_cattle == .

by  FARM_CODE YE_AR : egen potato_fed_cattle_1 = sum(potato_fed_cattle)
by  FARM_CODE YE_AR : egen potato_fed_cattle_2 = max(potato_fed_cattle_1)

***The formula for D_CATTLE_WINTER_FORAGE_EU as regards potatoes fed to cattle changed in 2011 - so now add in the following lines

gen potato_fed_cattle_op_2011 = 0 if FED_TOTAL_TONNES_HA == 0 & CROP_CODE == 1310
gen potato_fed_cattle_cy_2011 = 0 if FED_TOTAL_TONNES_HA == 0 & CROP_CODE == 1311


replace potato_fed_cattle_op_2011 = (FED_CATTLE_TONNES_HA / FED_TOTAL_TONNES_HA) * potato_op_fed_eu_1 if CROP_CODE == 1310 & YE_AR>2009

replace potato_fed_cattle_cy_2011 = (FED_CATTLE_TONNES_HA / FED_TOTAL_TONNES_HA) * potato_cy_fed_eu_1 if CROP_CODE == 1311 & YE_AR>2009

by  FARM_CODE YE_AR : egen potato_fed_cattle_op_2011_1 = sum(potato_fed_cattle_op_2011)
by  FARM_CODE YE_AR : egen potato_fed_cattle_op_2011_2 = max(potato_fed_cattle_op_2011_1)

by  FARM_CODE YE_AR : egen potato_fed_cattle_cy_2011_1 = sum(potato_fed_cattle_cy_2011)
by  FARM_CODE YE_AR : egen potato_fed_cattle_cy_2011_2 = max(potato_fed_cattle_cy_2011_1)


** winter forage fed to sheep**

by  FARM_CODE YE_AR : egen sil_fed_sheep_tns_ha = sum(FED_SHEEP_TONNES_HA) if CROP_CODE == 9230 | CROP_CODE == 9231 
replace sil_fed_sheep_tns_ha = 0 if sil_fed_sheep_tns_ha == .
by  FARM_CODE YE_AR : egen sil_fed_sheep_tns_ha_1 = max(sil_fed_sheep_tns_ha)

by  FARM_CODE YE_AR : egen hay_fed_sheep_tns_ha = sum(FED_SHEEP_TONNES_HA) if CROP_CODE == 9220 | CROP_CODE == 9221 
replace hay_fed_sheep_tns_ha = 0 if hay_fed_sheep_tns_ha == .
by  FARM_CODE YE_AR : egen hay_fed_sheep_tns_ha_1 = max(hay_fed_sheep_tns_ha)

by  FARM_CODE YE_AR : egen asil_fed_sheep_tns_ha = sum(FED_SHEEP_TONNES_HA) if CROP_CODE == 9030 | CROP_CODE == 9031 
replace asil_fed_sheep_tns_ha = 0 if asil_fed_sheep_tns_ha == .
by  FARM_CODE YE_AR : egen asil_fed_sheep_tns_ha_1 = max(asil_fed_sheep_tns_ha)

by  FARM_CODE YE_AR : egen mz_sil_fed_sheep_tns_ha = sum (FED_SHEEP_TONNES_HA) if CROP_CODE == 9020 | CROP_CODE == 9021
replace mz_sil_fed_sheep_tns_ha = 0 if mz_sil_fed_sheep_tns_ha == .
by  FARM_CODE YE_AR : egen mz_sil_fed_sheep_tns_ha_1 = max(mz_sil_fed_sheep_tns_ha)

by  FARM_CODE YE_AR : egen ots_shf_fed_sheep_tns_ha = sum (FED_SHEEP_TONNES_HA) if CROP_CODE == 9010 | CROP_CODE == 9011
replace ots_shf_fed_sheep_tns_ha = 0 if ots_shf_fed_sheep_tns_ha == .
by  FARM_CODE YE_AR : egen ots_shf_fed_sheep_tns_ha_1 = max(ots_shf_fed_sheep_tns_ha)

by  FARM_CODE YE_AR : egen rseed_fed_sheep_tns_ha = sum (FED_SHEEP_TONNES_HA) if CROP_CODE == 9080 | CROP_CODE == 9081 | CROP_CODE == 9083
replace rseed_fed_sheep_tns_ha = 0 if rseed_fed_sheep_tns_ha == .
by  FARM_CODE YE_AR : egen rseed_fed_sheep_tns_ha_1 = max(rseed_fed_sheep_tns_ha)

by  FARM_CODE YE_AR : egen stw_fed_sheep_tns_ha = sum (FED_SHEEP_TONNES_HA) if CROP_CODE == 8110 | CROP_CODE == 8111
replace stw_fed_sheep_tns_ha = 0 if stw_fed_sheep_tns_ha == .
by  FARM_CODE YE_AR : egen stw_fed_sheep_tns_ha_1 = max(stw_fed_sheep_tns_ha)

by  FARM_CODE YE_AR : egen sug_fed_sheep_tns_ha = sum (FED_SHEEP_TONNES_HA) if CROP_CODE == 8120 | CROP_CODE == 8121
replace sug_fed_sheep_tns_ha = 0 if sug_fed_sheep_tns_ha == .
by  FARM_CODE YE_AR : egen sug_fed_sheep_tns_ha_1 = max(sug_fed_sheep_tns_ha)

by  FARM_CODE YE_AR : egen kale_fed_sheep_tns_ha = sum (FED_SHEEP_TONNES_HA) if CROP_CODE == 9070 | CROP_CODE == 9071
replace kale_fed_sheep_tns_ha = 0 if kale_fed_sheep_tns_ha == .
by  FARM_CODE YE_AR : egen kale_fed_sheep_tns_ha_1 = max(kale_fed_sheep_tns_ha)


** Protein Beans, Protein Peas fed to sheep

gen ptn_beans_peas_fed_sheep = 0 if FED_TOTAL_TONNES_HA == 0 & ptn_beans_peas_cond1 == 1

replace ptn_beans_peas_fed_sheep = (FED_SHEEP_TONNES_HA / FED_TOTAL_TONNES_HA) * tot_ptn_beans_peas_fed_eu  if ptn_beans_peas_cond1 == 1 & ptn_beans_peas_fed_sheep == .
replace ptn_beans_peas_fed_sheep = 0 if ptn_beans_peas_fed_sheep == .

by  FARM_CODE YE_AR : egen ptn_beans_peas_fed_sheep_1 = sum(ptn_beans_peas_fed_sheep)
by  FARM_CODE YE_AR : egen ptn_beans_peas_fed_sheep_2 = max(ptn_beans_peas_fed_sheep_1)

** Potatoes fed to sheep

gen potato_fed_sheep = 0 if FED_TOTAL_TONNES_HA == 0 & potato_cond1 == 1

replace potato_fed_sheep = (FED_SHEEP_TONNES_HA / FED_TOTAL_TONNES_HA) * tot_potato_op_fed_eu if potato_cond1 == 1 & potato_fed_sheep == .
replace potato_fed_sheep = 0 if potato_fed_sheep == .

by  FARM_CODE YE_AR : egen potato_fed_sheep_1 = sum(potato_fed_sheep)
by  FARM_CODE YE_AR : egen potato_fed_sheep_2 = max(potato_fed_sheep_1)



** D_ROOTS_DIRECT_COSTS_EU (D_SHEEP_DIV_TOTAL_NO, D_FODDER_BEET_FED_OP_EU, D_FODDER_BEET_FED_CU_EU, D_TURNIPS_MANGLES_FED_OP_INV_EU, D_TURNIPS_MANGLES_CROPS_FED_CU_EU)
*----------------------------------------------------------------------------------------------------------------------------------------------------------------------

**D_SHEEP_DIV_TOTAL_NO

gen d_sheep_div_total_no = 0
replace d_sheep_div_total_no = FED_SHEEP_TONNES_HA / FED_TOTAL_TONNES_HA 

gen sgr_bt_opfed_sheep_eu = OP_INV_FED_VALUE_EU * d_sheep_div_total_no if CROP_CODE == 1320
by  FARM_CODE YE_AR : egen s_sgr_bt_opfed_sheep_eu = sum(sgr_bt_opfed_sheep_eu)

gen sgr_bt_cyfed_sheep_eu = CY_FED_VALUE_EU * d_sheep_div_total_no if CROP_CODE == 1321
by  FARM_CODE YE_AR : egen s_sgr_bt_cyfed_sheep_eu = sum(sgr_bt_cyfed_sheep_eu)

**D_FODDER_BEET_FED_OP_EU

gen d_fodder_beet_fed_op_eu = (OP_INV_FED_QTY_TONNES_HA / (OP_INV_QTY_TONNES_HA - OP_INV_WASTE_TONNES_HA)) * (OP_INV_VALUE_EU + total_eu) if CROP_CODE == 9060 & (total_eu != 0 | total_eu != .)
replace d_fodder_beet_fed_op_eu = (OP_INV_FED_QTY_TONNES_HA / (OP_INV_QTY_TONNES_HA - OP_INV_WASTE_TONNES_HA)) * (OP_INV_VALUE_EU) if CROP_CODE == 9060 & d_fodder_beet_fed_op_eu == .
replace d_fodder_beet_fed_op_eu = 0 if d_fodder_beet_fed_op_eu == .

gen fdr_beet_fed_sheep_op_eu = d_fodder_beet_fed_op_eu * d_sheep_div_total_no if CROP_CODE == 9060
replace fdr_beet_fed_sheep_op_eu = 0 if fdr_beet_fed_sheep_op_eu  == .

by  FARM_CODE YE_AR : egen s_fdr_beet_fed_sheep_op_eu = sum(fdr_beet_fed_sheep_op_eu)


**D_FODDER_BEET_FED_CU_EU

gen d_fodder_beet_fed_cu_eu = 0
replace d_fodder_beet_fed_cu_eu = (CY_FED_QTY_TONNES_HA / (CY_TOTAL_YIELD - CY_WASTE_TONNES_HA)) * d_total_direct_cost_eu if CROP_CODE == 9061

gen fdr_beet_fed_sheep_cu_eu = d_fodder_beet_fed_cu_eu * d_sheep_div_total_no if CROP_CODE == 9061
replace fdr_beet_fed_sheep_cu_eu = 0 if fdr_beet_fed_sheep_cu_eu == .

by  FARM_CODE YE_AR : egen s_fdr_beet_fed_sheep_cu_eu = sum(fdr_beet_fed_sheep_cu_eu)


**D_TURNIPS_MANGLES_FED_OP_INV_EU

gen d_trnps_mgls_fed_op_inv_eu = 0
replace d_trnps_mgls_fed_op_inv_eu = (OP_INV_FED_QTY_TONNES_HA / (OP_INV_QTY_TONNES_HA - OP_INV_WASTE_TONNES_HA)) * (OP_INV_VALUE_EU + total_eu) if CROP_CODE == 9040 

gen trnps_mgls_fedsheep_op_inv_eu = d_trnps_mgls_fed_op_inv_eu * d_sheep_div_total_no if CROP_CODE == 9040
replace trnps_mgls_fedsheep_op_inv_eu = 0 if trnps_mgls_fedsheep_op_inv_eu == .

by  FARM_CODE YE_AR : egen s_trnps_mgls_fedsheep_op_inv_eu  = sum(trnps_mgls_fedsheep_op_inv_eu)



**D_TURNIPS_MANGLES_CROPS_FED_CU_EU

gen d_trnps_mgls_crp_fed_cu_eu = 0
replace d_trnps_mgls_crp_fed_cu_eu = (CY_FED_QTY_TONNES_HA / (CY_TOTAL_YIELD - CY_WASTE_TONNES_HA)) * d_total_direct_cost_eu if CROP_CODE == 9041

gen trnps_mgls_fedsheep_cu_eu = d_trnps_mgls_crp_fed_cu_eu * d_sheep_div_total_no if CROP_CODE == 9041
replace trnps_mgls_fedsheep_cu_eu = 0 if trnps_mgls_fedsheep_cu_eu == .

by  FARM_CODE YE_AR : egen s_trnps_mgls_fedsheep_cu_eu  = sum(trnps_mgls_fedsheep_cu_eu)

*mangolds fed to sheep

by  FARM_CODE YE_AR : egen mgolds_fed_sheep_tns_ha = sum (FED_SHEEP_TONNES_HA) if CROP_CODE == 9050 | CROP_CODE == 9051
replace mgolds_fed_sheep_tns_ha = 0 if mgolds_fed_sheep_tns_ha == .
by  FARM_CODE YE_AR : egen mgolds_fed_sheep_tns_ha_1 = max(mgolds_fed_sheep_tns_ha)


** winter forage fed to horses**

by  FARM_CODE YE_AR : egen sil_fed_horses_tns_ha = sum(FED_HORSES_TONNES_HA) if CROP_CODE == 9230 | CROP_CODE == 9231 
replace sil_fed_horses_tns_ha = 0 if sil_fed_horses_tns_ha == .
by  FARM_CODE YE_AR : egen sil_fed_horses_tns_ha_1 = max(sil_fed_horses_tns_ha)

by  FARM_CODE YE_AR : egen hay_fed_horses_tns_ha = sum(FED_HORSES_TONNES_HA) if CROP_CODE == 9220 | CROP_CODE == 9221 
replace hay_fed_horses_tns_ha = 0 if hay_fed_horses_tns_ha == .
by  FARM_CODE YE_AR : egen hay_fed_horses_tns_ha_1 = max(hay_fed_horses_tns_ha)

by  FARM_CODE YE_AR : egen asil_fed_horses_tns_ha = sum(FED_HORSES_TONNES_HA) if CROP_CODE == 9030 | CROP_CODE == 9031 
replace asil_fed_horses_tns_ha = 0 if asil_fed_horses_tns_ha == .
by  FARM_CODE YE_AR : egen asil_fed_horses_tns_ha_1 = max(asil_fed_horses_tns_ha)

by  FARM_CODE YE_AR : egen fdrbt_fed_horses_tns_ha = sum (FED_HORSES_TONNES_HA) if CROP_CODE == 9060 | CROP_CODE == 9061
replace fdrbt_fed_horses_tns_ha = 0 if fdrbt_fed_horses_tns_ha == .
by  FARM_CODE YE_AR : egen fdrbt_fed_horses_tns_ha_1 = max(fdrbt_fed_horses_tns_ha)

by  FARM_CODE YE_AR : egen sgrbt_fed_horses_tns_ha = sum (FED_HORSES_TONNES_HA) if CROP_CODE == 1320 | CROP_CODE == 1321
replace sgrbt_fed_horses_tns_ha = 0 if sgrbt_fed_horses_tns_ha == .
by  FARM_CODE YE_AR : egen sgrbt_fed_horses_tns_ha_1 = max(sgrbt_fed_horses_tns_ha)

by  FARM_CODE YE_AR : egen mz_sil_fed_horses_tns_ha = sum (FED_HORSES_TONNES_HA) if CROP_CODE == 9020 | CROP_CODE == 9021
replace mz_sil_fed_horses_tns_ha = 0 if mz_sil_fed_horses_tns_ha == .
by  FARM_CODE YE_AR : egen mz_sil_fed_horses_tns_ha_1 = max(mz_sil_fed_horses_tns_ha)

by  FARM_CODE YE_AR : egen ots_shf_fed_horses_tns_ha = sum (FED_HORSES_TONNES_HA) if CROP_CODE == 9010 | CROP_CODE == 9011
replace ots_shf_fed_horses_tns_ha = 0 if ots_shf_fed_horses_tns_ha == .
by  FARM_CODE YE_AR : egen ots_shf_fed_horses_tns_ha_1 = max(ots_shf_fed_horses_tns_ha)

by  FARM_CODE YE_AR : egen mgolds_fed_horses_tns_ha = sum (FED_HORSES_TONNES_HA) if CROP_CODE == 9050 | CROP_CODE == 9051
replace mgolds_fed_horses_tns_ha = 0 if mgolds_fed_horses_tns_ha == .
by  FARM_CODE YE_AR : egen mgolds_fed_horses_tns_ha_1 = max(mgolds_fed_horses_tns_ha)

by  FARM_CODE YE_AR : egen rseed_fed_horses_tns_ha = sum (FED_HORSES_TONNES_HA) if CROP_CODE == 9080 | CROP_CODE == 9081 | CROP_CODE == 9083
replace rseed_fed_horses_tns_ha = 0 if rseed_fed_horses_tns_ha == .
by  FARM_CODE YE_AR : egen rseed_fed_horses_tns_ha_1 = max(rseed_fed_horses_tns_ha)

by  FARM_CODE YE_AR : egen stw_fed_horses_tns_ha = sum (FED_HORSES_TONNES_HA) if CROP_CODE == 8110 | CROP_CODE == 8111
replace stw_fed_horses_tns_ha = 0 if stw_fed_horses_tns_ha == .
by  FARM_CODE YE_AR : egen stw_fed_horses_tns_ha_1 = max(stw_fed_horses_tns_ha)

by  FARM_CODE YE_AR : egen sug_fed_horses_tns_ha = sum (FED_HORSES_TONNES_HA) if CROP_CODE == 8120 | CROP_CODE == 8121
replace sug_fed_horses_tns_ha = 0 if sug_fed_horses_tns_ha == .
by  FARM_CODE YE_AR : egen sug_fed_horses_tns_ha_1 = max(sug_fed_horses_tns_ha)

by  FARM_CODE YE_AR : egen kale_fed_horses_tns_ha = sum (FED_HORSES_TONNES_HA) if CROP_CODE == 9070 | CROP_CODE == 9071
replace kale_fed_horses_tns_ha = 0 if kale_fed_horses_tns_ha == .
by  FARM_CODE YE_AR : egen kale_fed_horses_tns_ha_1 = max(kale_fed_horses_tns_ha)



** winter forage fed to deer**

by  FARM_CODE YE_AR : egen sil_fed_deer_tns_ha = sum(FED_DEER_TONNES_HA) if CROP_CODE == 9230 | CROP_CODE == 9231 
replace sil_fed_deer_tns_ha = 0 if sil_fed_deer_tns_ha == .
by  FARM_CODE YE_AR : egen sil_fed_deer_tns_ha_1 = max(sil_fed_deer_tns_ha)

by  FARM_CODE YE_AR : egen hay_fed_deer_tns_ha = sum(FED_DEER_TONNES_HA) if CROP_CODE == 9220 | CROP_CODE == 9221 
replace hay_fed_deer_tns_ha = 0 if hay_fed_deer_tns_ha == .
by  FARM_CODE YE_AR : egen hay_fed_deer_tns_ha_1 = max(hay_fed_deer_tns_ha)

by  FARM_CODE YE_AR : egen asil_fed_deer_tns_ha = sum(FED_DEER_TONNES_HA) if CROP_CODE == 9030 | CROP_CODE == 9031 
replace asil_fed_deer_tns_ha = 0 if asil_fed_deer_tns_ha == .
by  FARM_CODE YE_AR : egen asil_fed_deer_tns_ha_1 = max(asil_fed_deer_tns_ha)

by  FARM_CODE YE_AR : egen fdrbt_fed_deer_tns_ha = sum (FED_DEER_TONNES_HA) if CROP_CODE == 9060 | CROP_CODE == 9061
replace fdrbt_fed_deer_tns_ha = 0 if fdrbt_fed_deer_tns_ha == .
by  FARM_CODE YE_AR : egen fdrbt_fed_deer_tns_ha_1 = max(fdrbt_fed_deer_tns_ha)

by  FARM_CODE YE_AR : egen sgrbt_fed_deer_tns_ha = sum (FED_DEER_TONNES_HA) if CROP_CODE == 1320 | CROP_CODE == 1321
replace sgrbt_fed_deer_tns_ha = 0 if sgrbt_fed_deer_tns_ha == .
by  FARM_CODE YE_AR : egen sgrbt_fed_deer_tns_ha_1 = max(sgrbt_fed_deer_tns_ha)

by  FARM_CODE YE_AR : egen mz_sil_fed_deer_tns_ha = sum (FED_DEER_TONNES_HA) if CROP_CODE == 9020 | CROP_CODE == 9021
replace mz_sil_fed_deer_tns_ha = 0 if mz_sil_fed_deer_tns_ha == .
by  FARM_CODE YE_AR : egen mz_sil_fed_deer_tns_ha_1 = max(mz_sil_fed_deer_tns_ha)

by  FARM_CODE YE_AR : egen ots_shf_fed_deer_tns_ha = sum (FED_DEER_TONNES_HA) if CROP_CODE == 9010 | CROP_CODE == 9011
replace ots_shf_fed_deer_tns_ha = 0 if ots_shf_fed_deer_tns_ha == .
by  FARM_CODE YE_AR : egen ots_shf_fed_deer_tns_ha_1 = max(ots_shf_fed_deer_tns_ha)

by  FARM_CODE YE_AR : egen mgolds_fed_deer_tns_ha = sum (FED_DEER_TONNES_HA) if CROP_CODE == 9050 | CROP_CODE == 9051
replace mgolds_fed_deer_tns_ha = 0 if mgolds_fed_deer_tns_ha == .
by  FARM_CODE YE_AR : egen mgolds_fed_deer_tns_ha_1 = max(mgolds_fed_deer_tns_ha)

by  FARM_CODE YE_AR : egen rseed_fed_deer_tns_ha = sum (FED_DEER_TONNES_HA) if CROP_CODE == 9080 | CROP_CODE == 9081 | CROP_CODE == 9083
replace rseed_fed_deer_tns_ha = 0 if rseed_fed_deer_tns_ha == .
by  FARM_CODE YE_AR : egen rseed_fed_deer_tns_ha_1 = max(rseed_fed_deer_tns_ha)

by  FARM_CODE YE_AR : egen stw_fed_deer_tns_ha = sum (FED_DEER_TONNES_HA) if CROP_CODE == 8110 | CROP_CODE == 8111
replace stw_fed_deer_tns_ha = 0 if stw_fed_deer_tns_ha == .
by  FARM_CODE YE_AR : egen stw_fed_deer_tns_ha_1 = max(stw_fed_deer_tns_ha)

by  FARM_CODE YE_AR : egen sug_fed_deer_tns_ha = sum (FED_DEER_TONNES_HA) if CROP_CODE == 8120 | CROP_CODE == 8121
replace sug_fed_deer_tns_ha = 0 if sug_fed_deer_tns_ha == .
by  FARM_CODE YE_AR : egen sug_fed_deer_tns_ha_1 = max(sug_fed_deer_tns_ha)

by  FARM_CODE YE_AR : egen kale_fed_deer_tns_ha = sum (FED_DEER_TONNES_HA) if CROP_CODE == 9070 | CROP_CODE == 9071
replace kale_fed_deer_tns_ha = 0 if kale_fed_deer_tns_ha == .
by  FARM_CODE YE_AR : egen kale_fed_deer_tns_ha_1 = max(kale_fed_deer_tns_ha)


** winter forage fed to goats**

by  FARM_CODE YE_AR : egen sil_fed_goats_tns_ha = sum(FED_GOATS_TONNES_HA) if CROP_CODE == 9230 | CROP_CODE == 9231 
replace sil_fed_goats_tns_ha = 0 if sil_fed_goats_tns_ha == .
by  FARM_CODE YE_AR : egen sil_fed_goats_tns_ha_1 = max(sil_fed_goats_tns_ha)

by  FARM_CODE YE_AR : egen hay_fed_goats_tns_ha = sum(FED_GOATS_TONNES_HA) if CROP_CODE == 9220 | CROP_CODE == 9221 
replace hay_fed_goats_tns_ha = 0 if hay_fed_goats_tns_ha == .
by  FARM_CODE YE_AR : egen hay_fed_goats_tns_ha_1 = max(hay_fed_goats_tns_ha)

by  FARM_CODE YE_AR : egen asil_fed_goats_tns_ha = sum(FED_GOATS_TONNES_HA) if CROP_CODE == 9030 | CROP_CODE == 9031 
replace asil_fed_goats_tns_ha = 0 if asil_fed_goats_tns_ha == .
by  FARM_CODE YE_AR : egen asil_fed_goats_tns_ha_1 = max(asil_fed_goats_tns_ha)

by  FARM_CODE YE_AR : egen fdrbt_fed_goats_tns_ha = sum (FED_GOATS_TONNES_HA) if CROP_CODE == 9060 | CROP_CODE == 9061
replace fdrbt_fed_goats_tns_ha = 0 if fdrbt_fed_goats_tns_ha == .
by  FARM_CODE YE_AR : egen fdrbt_fed_goats_tns_ha_1 = max(fdrbt_fed_goats_tns_ha)

by  FARM_CODE YE_AR : egen sgrbt_fed_goats_tns_ha = sum (FED_GOATS_TONNES_HA) if CROP_CODE == 1320 | CROP_CODE == 1321
replace sgrbt_fed_goats_tns_ha = 0 if sgrbt_fed_goats_tns_ha == .
by  FARM_CODE YE_AR : egen sgrbt_fed_goats_tns_ha_1 = max(sgrbt_fed_goats_tns_ha)

by  FARM_CODE YE_AR : egen mz_sil_fed_goats_tns_ha = sum (FED_GOATS_TONNES_HA) if CROP_CODE == 9020 | CROP_CODE == 9021
replace mz_sil_fed_goats_tns_ha = 0 if mz_sil_fed_goats_tns_ha == .
by  FARM_CODE YE_AR : egen mz_sil_fed_goats_tns_ha_1 = max(mz_sil_fed_goats_tns_ha)

by  FARM_CODE YE_AR : egen ots_shf_fed_goats_tns_ha = sum (FED_GOATS_TONNES_HA) if CROP_CODE == 9010 | CROP_CODE == 9011
replace ots_shf_fed_goats_tns_ha = 0 if ots_shf_fed_goats_tns_ha == .
by  FARM_CODE YE_AR : egen ots_shf_fed_goats_tns_ha_1 = max(ots_shf_fed_goats_tns_ha)

by  FARM_CODE YE_AR : egen mgolds_fed_goats_tns_ha = sum (FED_GOATS_TONNES_HA) if CROP_CODE == 9050 | CROP_CODE == 9051
replace mgolds_fed_goats_tns_ha = 0 if mgolds_fed_goats_tns_ha == .
by  FARM_CODE YE_AR : egen mgolds_fed_goats_tns_ha_1 = max(mgolds_fed_goats_tns_ha)

by  FARM_CODE YE_AR : egen rseed_fed_goats_tns_ha = sum (FED_GOATS_TONNES_HA) if CROP_CODE == 9080 | CROP_CODE == 9081 | CROP_CODE == 9083
replace rseed_fed_goats_tns_ha = 0 if rseed_fed_goats_tns_ha == .
by  FARM_CODE YE_AR : egen rseed_fed_goats_tns_ha_1 = max(rseed_fed_goats_tns_ha)

by  FARM_CODE YE_AR : egen stw_fed_goats_tns_ha = sum (FED_GOATS_TONNES_HA) if CROP_CODE == 8110 | CROP_CODE == 8111
replace stw_fed_goats_tns_ha = 0 if stw_fed_goats_tns_ha == .
by  FARM_CODE YE_AR : egen stw_fed_goats_tns_ha_1 = max(stw_fed_goats_tns_ha)

by  FARM_CODE YE_AR : egen sug_fed_goats_tns_ha = sum (FED_GOATS_TONNES_HA) if CROP_CODE == 8120 | CROP_CODE == 8121
replace sug_fed_goats_tns_ha = 0 if sug_fed_goats_tns_ha == .
by  FARM_CODE YE_AR : egen sug_fed_goats_tns_ha_1 = max(sug_fed_goats_tns_ha)

by  FARM_CODE YE_AR : egen kale_fed_goats_tns_ha = sum (FED_GOATS_TONNES_HA) if CROP_CODE == 9070 | CROP_CODE == 9071
replace kale_fed_goats_tns_ha = 0 if kale_fed_goats_tns_ha == .
by  FARM_CODE YE_AR : egen kale_fed_goats_tns_ha_1 = max(kale_fed_goats_tns_ha)



**D_CASH_CROPS_FED_EU
*---------------------


by  FARM_CODE YE_AR : egen csh_crp_op_inv_fed_eu = sum (OP_INV_FED_VALUE_EU) if CROP_CODE == 1110 | CROP_CODE == 1140 | CROP_CODE == 1150 | CROP_CODE == 1430 | CROP_CODE == 1210 | CROP_CODE == 1560 | CROP_CODE == 1570 | CROP_CODE == 1310 | CROP_CODE == 1320 | CROP_CODE == 1270 | CROP_CODE == 1280 | CROP_CODE == 1290
replace csh_crp_op_inv_fed_eu = 0 if csh_crp_op_inv_fed_eu  == .
by  FARM_CODE YE_AR : egen csh_crp_op_inv_fed_eu_1 = max(csh_crp_op_inv_fed_eu)

by  FARM_CODE YE_AR : egen csh_crp_cy_fed_eu = sum(CY_FED_VALUE_EU) if CROP_CODE == 1116 | CROP_CODE == 1111 | CROP_CODE == 1117 | CROP_CODE == 1146 | CROP_CODE == 1141 | CROP_CODE == 1147 | CROP_CODE == 1571 | CROP_CODE == 1156 | CROP_CODE == 1151 | CROP_CODE == 1431 | CROP_CODE == 1211 | CROP_CODE == 1561 | CROP_CODE == 1311 | CROP_CODE == 1321 | CROP_CODE == 1271 | CROP_CODE == 1281 | CROP_CODE == 1286 | CROP_CODE == 1291
replace csh_crp_cy_fed_eu = 0 if csh_crp_cy_fed_eu == .
by  FARM_CODE YE_AR : egen csh_crp_cy_fed_eu_1 = max(csh_crp_cy_fed_eu)

** home_grown_seed_value_eu
by  FARM_CODE YE_AR : egen s_home_grown_seed_value_eu = sum(HOME_GROWN_SEED_VALUE_EU)
replace s_home_grown_seed_value_eu = 0 if s_home_grown_seed_value_eu == .



***************************************
*VARS USED TO CREATE CROPS DIRECT COSTS
***************************************

*D_DIRECT_COSTS_FODDER_CROPS_SOLD_EU

gen fodd_op = 1 if  OP_INV_QTY_TONNES_HA > 0 & (CROP_CODE == 9060 | CROP_CODE == 9040 | CROP_CODE == 9030 | CROP_CODE == 9020 | CROP_CODE == 9050 | CROP_CODE == 9070 | CROP_CODE == 9080 | CROP_CODE == 8110 | CROP_CODE == 8120)
replace fodd_op = 0 if fodd_op == .

gen fodd_cy = 1 if CY_TOTAL_YIELD > 0 & (CROP_CODE == 9061 | CROP_CODE == 9041 | CROP_CODE == 9031 | CROP_CODE == 9021 | CROP_CODE == 9051 | CROP_CODE == 9071 | CROP_CODE == 9081 | CROP_CODE == 9086 | CROP_CODE == 8111 | CROP_CODE == 8121)
replace fodd_cy = 0 if fodd_cy == .


gen fodd_op_inv_sls_dc = (OP_INV_SALES_QTY_TONNES_HA / OP_INV_QTY_TONNES_HA) * OP_INV_VALUE_EU if fodd_op == 1
replace fodd_op_inv_sls_dc = 0 if fodd_op_inv_sls_dc == .

gen fodd_op_inv_wst_dc = (OP_INV_WASTE_TONNES_HA / OP_INV_QTY_TONNES_HA) * OP_INV_VALUE_EU if fodd_op == 1
replace fodd_op_inv_wst_dc = 0 if fodd_op_inv_wst_dc == .

gen fodd_cy_sls_dc = (CY_SALES_QTY_TONNES_HA / CY_TOTAL_YIELD) * d_total_direct_cost_eu if fodd_cy == 1
replace fodd_cy_sls_dc = 0 if fodd_cy_sls_dc == .

gen fodd_cy_wst_dc = (CY_WASTE_TONNES_HA / CY_TOTAL_YIELD) * d_total_direct_cost_eu if fodd_cy == 1
replace fodd_cy_wst_dc = 0 if fodd_cy_wst_dc == .

sort FARM_CODE YE_AR

by FARM_CODE YE_AR: egen s_fodd_op_inv_sls_dc= sum(fodd_op_inv_sls_dc)
replace s_fodd_op_inv_sls_dc = 0 if s_fodd_op_inv_sls_dc == .

by FARM_CODE YE_AR: egen s_fodd_op_inv_wst_dc= sum(fodd_op_inv_wst_dc)
replace s_fodd_op_inv_wst_dc = 0 if s_fodd_op_inv_wst_dc == .

by FARM_CODE YE_AR: egen s_fodd_cy_sls_dc= sum(fodd_cy_sls_dc)
replace s_fodd_cy_sls_dc = 0 if s_fodd_cy_sls_dc == .

by FARM_CODE YE_AR: egen s_fodd_cy_wst_dc= sum(fodd_cy_wst_dc)
replace s_fodd_cy_wst_dc = 0 if s_fodd_cy_wst_dc == .


*Fodder Straw
gen fodd_stw = 1 if CROP_CODE == 8110 & OP_INV_QTY_TONNES_HA > (OP_INV_SALES_QTY_TONNES_HA + OP_INV_FED_QTY_TONNES_HA + OP_INV_SEED_QTY_TONNES_HA + OP_INV_ALLOW_HOUSE_TONNES_HA + OP_INV_ALLOW_WAGES_TONNES_HA + OP_INV_WASTE_TONNES_HA + OP_INV_CLOSING_QTY_TONNES_HA)
replace fodd_stw = 0 if fodd_stw == .

gen fodd_stw_dc = (OP_INV_QTY_TONNES_HA - (OP_INV_SALES_QTY_TONNES_HA + OP_INV_FED_QTY_TONNES_HA + OP_INV_SEED_QTY_TONNES_HA + OP_INV_CLOSING_QTY_TONNES_HA + OP_INV_ALLOW_HOUSE_TONNES_HA - OP_INV_ALLOW_WAGES_TONNES_HA + OP_INV_WASTE_TONNES_HA)) / OP_INV_QTY_TONNES_HA * OP_INV_VALUE_EU if fodd_stw == 1
replace fodd_stw_dc = 0 if fodd_stw_dc == .

by FARM_CODE YE_AR: egen s_fodd_stw_dc = sum(fodd_stw_dc )
replace s_fodd_stw_dc  = 0 if s_fodd_stw_dc == .


gen i_other_cash_crop_ind_yn = "y"
replace i_other_cash_crop_ind_yn = "n" if CROP_CODE == 1110 | CROP_CODE == 1111 | CROP_CODE == 1112 | CROP_CODE == 1113 | CROP_CODE == 1116 | CROP_CODE == 1117
replace i_other_cash_crop_ind_yn = "n" if CROP_CODE == 1150 | CROP_CODE == 1151 | CROP_CODE == 1153 | CROP_CODE == 1156 | CROP_CODE == 1157
replace i_other_cash_crop_ind_yn = "n" if CROP_CODE == 1140 | CROP_CODE == 1141 | CROP_CODE == 1146 | CROP_CODE == 1147
replace i_other_cash_crop_ind_yn = "n" if CROP_CODE == 1430 | CROP_CODE == 1431 | CROP_CODE == 1433 | CROP_CODE == 1436 | CROP_CODE == 1438
replace i_other_cash_crop_ind_yn = "n" if CROP_CODE == 1570 | CROP_CODE == 1571 | CROP_CODE == 1576 | CROP_CODE == 1577
replace i_other_cash_crop_ind_yn = "n" if CROP_CODE == 1310 | CROP_CODE == 1311 | CROP_CODE == 1317 | CROP_CODE == 1318 | CROP_CODE == 1319
replace i_other_cash_crop_ind_yn = "n" if CROP_CODE == 1320 | CROP_CODE == 1321 | CROP_CODE == 1327 | CROP_CODE == 1329
replace i_other_cash_crop_ind_yn = "n" if CROP_CODE == 1461 | CROP_CODE == 1468
replace i_other_cash_crop_ind_yn = "n" if CROP_CODE == 8110 | CROP_CODE == 8111 | CROP_CODE == 8116
replace i_other_cash_crop_ind_yn = "n" if CROP_CODE == 9210 | CROP_CODE == 9211 | CROP_CODE == 9212 | CROP_CODE == 9213 | CROP_CODE == 9217
replace i_other_cash_crop_ind_yn = "n" if CROP_CODE == 9220 | CROP_CODE == 9221 | CROP_CODE == 9228
replace i_other_cash_crop_ind_yn = "n" if CROP_CODE == 9230 | CROP_CODE == 9231 | CROP_CODE == 9233 | CROP_CODE == 9238 | CROP_CODE == 9239
replace i_other_cash_crop_ind_yn = "n" if CROP_CODE == 9020 | CROP_CODE == 9021 | CROP_CODE == 9023
replace i_other_cash_crop_ind_yn = "n" if CROP_CODE == 9030 | CROP_CODE == 9031 | CROP_CODE == 9032 | CROP_CODE == 9033 | CROP_CODE == 9036
replace i_other_cash_crop_ind_yn = "n" if CROP_CODE == 9040 | CROP_CODE == 9041 | CROP_CODE == 9042 | CROP_CODE == 9043
replace i_other_cash_crop_ind_yn = "n" if CROP_CODE == 9050 | CROP_CODE == 9051
replace i_other_cash_crop_ind_yn = "n" if CROP_CODE == 9060 | CROP_CODE == 9061
replace i_other_cash_crop_ind_yn = "n" if CROP_CODE == 9070 | CROP_CODE == 9071 | CROP_CODE == 9072 | CROP_CODE == 9073
replace i_other_cash_crop_ind_yn = "n" if CROP_CODE == 9080 | CROP_CODE == 9081 | CROP_CODE == 9083 | CROP_CODE == 9086 | CROP_CODE == 9088
replace i_other_cash_crop_ind_yn = "n" if CROP_CODE == 1751 | CROP_CODE == 1752 | CROP_CODE == 1756


***D_DIRECT_COST_INV_MISC_CASH_CROP

gen inv_misc_csh_crop = total_eu if CROP_CODE == 1110 | CROP_CODE == 1130 | CROP_CODE == 1140 | CROP_CODE == 1150 | CROP_CODE == 1160 | CROP_CODE == 1190 | CROP_CODE == 1270 | CROP_CODE == 1280 | CROP_CODE == 1290 | CROP_CODE == 1310 | CROP_CODE == 1320 | CROP_CODE == 1330 | CROP_CODE == 1430 | CROP_CODE == 1440 | CROP_CODE == 1450 | CROP_CODE == 1510 | CROP_CODE == 1550 | CROP_CODE == 1560 | CROP_CODE == 1560 | CROP_CODE == 1570
replace inv_misc_csh_crop = 0 if inv_misc_csh_crop == .
sort FARM_CODE YE_AR
by  FARM_CODE YE_AR: egen s_inv_misc_csh_crop = sum(inv_misc_csh_crop)


***D_TOTAL_DIRECT_COST_EU FOR SELECTED CROP CODES IN THE MAIN TOTAL CROP DIRECT COST FORMULA

gen d_total_direct_cost_eu_2 = d_total_direct_cost_eu if CROP_CODE == 1116 | CROP_CODE == 1111 | CROP_CODE == 1117 | CROP_CODE == 1146 | CROP_CODE == 1141 | CROP_CODE == 1147 | CROP_CODE == 1571 | CROP_CODE == 1577 | CROP_CODE == 1156 | CROP_CODE == 1151 | CROP_CODE == 1157 | CROP_CODE == 1431 | CROP_CODE == 1436 | CROP_CODE == 1211 | CROP_CODE == 1561 | CROP_CODE == 1311 | CROP_CODE == 1321 | CROP_CODE == 1317 | CROP_CODE == 1751
replace d_total_direct_cost_eu_2 = 0 if d_total_direct_cost_eu_2 == .
sort FARM_CODE YE_AR
by FARM_CODE YE_AR : egen m_d_total_direct_cost_eu_2 = sum(d_total_direct_cost_eu_2)

***D_TOTAL_DIRECT_COST_EU FOR OTHER CASH CROPS IN THE MAIN TOTAL CROP DIRECT COST FORMULA

gen d_total_direct_cost_eu_3 = d_total_direct_cost_eu if i_other_cash_crop_ind_yn == "y"
replace d_total_direct_cost_eu_3 = 0 if d_total_direct_cost_eu_3 == .

by FARM_CODE YE_AR : egen m_d_total_direct_cost_eu_3 = sum(d_total_direct_cost_eu_3)


*******************
* GROSS OUTPUT VARS
*******************

***D_GROSS_OUTPUT_FODDER_CROPS_SOLD_EU

gen fodd_op_sls_val = OP_INV_SALES_VALUE_EU if CROP_CODE == 9060 | CROP_CODE == 9040 | CROP_CODE == 9030 | CROP_CODE == 9020 | CROP_CODE == 9050 | CROP_CODE == 9070 | CROP_CODE == 9080 | CROP_CODE == 8110 | CROP_CODE == 8120
replace fodd_op_sls_val = 0 if fodd_op_sls_val == .
by FARM_CODE YE_AR: egen s_fodd_op_sls_val= sum(fodd_op_sls_val)
replace s_fodd_op_sls_val = 0 if s_fodd_op_sls_val == .

gen fodd_cy_sls_val = CY_SALES_VALUE_EU if CROP_CODE == 9021 | CROP_CODE == 9023 | CROP_CODE == 9031 | CROP_CODE == 9032 | CROP_CODE == 9033 | CROP_CODE == 9036 | CROP_CODE == 9041 | CROP_CODE == 9042 | CROP_CODE == 9043 | CROP_CODE == 9051 | CROP_CODE == 9061 | CROP_CODE == 9071 | CROP_CODE == 9072 | CROP_CODE == 9073 | CROP_CODE == 9081 | CROP_CODE == 9083 | CROP_CODE == 9086 | CROP_CODE == 9088 | CROP_CODE == 8111 | CROP_CODE == 8116 | CROP_CODE == 8121 | CROP_CODE == 8123
replace fodd_cy_sls_val = 0 if fodd_cy_sls_val == .
by FARM_CODE YE_AR: egen s_fodd_cy_sls_val = sum(fodd_cy_sls_val )
replace s_fodd_cy_sls_val = 0 if s_fodd_cy_sls_val == .


**D_OUTPUT_FROM_INV_MISC_CASH_CROP_EU

*D_ALLOWANCES_OP_TONNES_HA
gen d_allowances_op_tonnes_ha = 0
replace d_allowances_op_tonnes_ha = ((OP_INV_SALES_VALUE_EU +  OP_INV_FED_VALUE_EU + OP_INV_SEED_VALUE_EU + OP_INV_CLOSING_VALUE_EU) / (OP_INV_SALES_QTY_TONNES_HA + OP_INV_FED_QTY_TONNES_HA + OP_INV_SEED_QTY_TONNES_HA + OP_INV_CLOSING_QTY_TONNES_HA)) * (OP_INV_ALLOW_HOUSE_TONNES_HA + OP_INV_ALLOW_WAGES_TONNES_HA)
replace d_allowances_op_tonnes_ha = 0 if d_allowances_op_tonnes_ha == .


*D_WW_GROSS_OUTPUT_OP_INV_EU, D_SW_GROSS_OUTPUT_OP_INV_EU
gen winter_wheat = 1 if CROP_CODE == 1116
replace winter_wheat = 0 if winter_wheat == .
by  FARM_CODE YE_AR: egen m_winter_wheat = max(winter_wheat)

gen spring_wheat = 1 if CROP_CODE == 1111
replace spring_wheat = 0 if spring_wheat == .
by  FARM_CODE YE_AR: egen m_spring_wheat  = max(spring_wheat)

gen wheat_op = OP_INV_SALES_VALUE_EU +  OP_INV_FED_VALUE_EU + OP_INV_SEED_VALUE_EU + OP_INV_CLOSING_VALUE_EU - OP_INV_VALUE_EU + d_allowances_op_tonnes_ha if CROP_CODE == 1110
replace wheat_op = 0 if wheat_op == .
by  FARM_CODE YE_AR: egen s_wheat_op  = sum(wheat_op)


*D_WB_GROSS_OUTPUT_OP_INV_EU, D_SB_GROSS_OUTPUT_OP_INV_EU
gen winter_barley = 1 if CROP_CODE == 1146
replace winter_barley = 0 if winter_barley == .
by  FARM_CODE YE_AR: egen m_winter_barley  = max(winter_barley)

gen spring_barley = 1 if CROP_CODE == 1141
replace spring_barley = 0 if spring_barley == .
by  FARM_CODE YE_AR: egen m_spring_barley = max(spring_barley)

gen barley_op = OP_INV_SALES_VALUE_EU +  OP_INV_FED_VALUE_EU + OP_INV_SEED_VALUE_EU + OP_INV_CLOSING_VALUE_EU - OP_INV_VALUE_EU + d_allowances_op_tonnes_ha if CROP_CODE == 1140
replace barley_op = 0 if barley_op == .
by  FARM_CODE YE_AR: egen s_barley_op = sum(barley_op)


*D_MB_GROSS_OUTPUT_OP_INV_EU
gen malt_barley_op = OP_INV_SALES_VALUE_EU + OP_INV_FED_VALUE_EU + OP_INV_SEED_VALUE_EU + OP_INV_CLOSING_VALUE_EU - OP_INV_VALUE_EU + d_allowances_op_tonnes_ha if CROP_CODE == 1570
replace malt_barley_op= 0 if malt_barley_op== .
by  FARM_CODE YE_AR: egen s_malt_barley_op = sum(malt_barley_op)

*D_WO_GROSS_OUTPUT_OP_INV_EU, D_SO_GROSS_OUTPUT_OP_INV_EU

gen winter_oats = 1 if CROP_CODE == 1156
replace winter_oats = 0 if winter_oats == .
by  FARM_CODE YE_AR: egen m_winter_oats = max(winter_oats)

gen spring_oats = 1 if CROP_CODE == 1151
replace spring_oats = 0 if spring_oats == .
by  FARM_CODE YE_AR: egen m_spring_oats = max(spring_oats)

gen oats_op = OP_INV_SALES_VALUE_EU + OP_INV_FED_VALUE_EU + OP_INV_SEED_VALUE_EU + OP_INV_CLOSING_VALUE_EU - OP_INV_VALUE_EU + d_allowances_op_tonnes_ha if CROP_CODE == 1150
replace oats_op = 0 if oats_op == .
by  FARM_CODE YE_AR: egen s_oats_op = sum(oats_op)


*D_OS_GROSS_OUTPUT_OP_INV_EU
gen oseed_rape_op_1 = (OP_INV_SALES_VALUE_EU + OP_INV_FED_VALUE_EU + OP_INV_SEED_VALUE_EU + OP_INV_CLOSING_VALUE_EU - OP_INV_VALUE_EU + d_allowances_op_tonnes_ha) if CROP_CODE == 1430
replace oseed_rape_op_1 = 0 if oseed_rape_op_1 == .
by  FARM_CODE YE_AR: egen s_oseed_rape_op_1 = sum(oseed_rape_op_1)
			 

gen oseed_rape_op_2 = (OP_INV_CLOSING_QTY_TONNES_HA - OP_INV_WASTE_TONNES_HA) if CROP_CODE == 1430
replace oseed_rape_op_2 = 0 if oseed_rape_op_2 == .
by  FARM_CODE YE_AR: egen s_oseed_rape_op_2 = sum(oseed_rape_op_2)

gen oseed_rape_op_inv_val_eu = OP_INV_VALUE_EU if CROP_CODE == 1430
replace oseed_rape_op_inv_val_eu  = 0 if oseed_rape_op_inv_val_eu  == .
by  FARM_CODE YE_AR: egen s_oseed_rape_op_inv_val_eu = sum(oseed_rape_op_inv_val_eu)

gen oseed_rape_total_eu = total_eu if CROP_CODE == 1431
replace oseed_rape_total_eu = 0 if oseed_rape_total_eu == .
by  FARM_CODE YE_AR: egen s_oseed_rape_total_eu = sum(oseed_rape_total_eu)


*D_PB_GROSS_OUTPUT_OP_INV_EU
gen pb_op_1 = (OP_INV_SALES_VALUE_EU + OP_INV_FED_VALUE_EU + OP_INV_SEED_VALUE_EU + OP_INV_CLOSING_VALUE_EU - OP_INV_VALUE_EU + d_allowances_op_tonnes_ha) if CROP_CODE == 1210
replace pb_op_1 = 0 if pb_op_1 == .
by  FARM_CODE YE_AR: egen s_pb_op_1 = sum(pb_op_1)
			 

gen pb_op_2 = (OP_INV_CLOSING_QTY_TONNES_HA - OP_INV_WASTE_TONNES_HA) if CROP_CODE == 1210
replace pb_op_2 = 0 if pb_op_2 == .
by  FARM_CODE YE_AR: egen s_pb_op_2 = sum(pb_op_2)

gen pb_op_inv_val_eu = OP_INV_VALUE_EU if CROP_CODE == 1210
replace pb_op_inv_val_eu = 0 if pb_op_inv_val_eu == .
by  FARM_CODE YE_AR: egen s_pb_op_inv_val_eu = sum(pb_op_inv_val_eu)

gen pb_total_eu = total_eu if CROP_CODE == 1211
replace pb_total_eu = 0 if pb_total_eu == .
by  FARM_CODE YE_AR: egen s_pb_total_eu = sum(pb_total_eu)


*D_LS_GROSS_OUTPUT_OP_INV_EU
gen linseed_op_1 = (OP_INV_SALES_VALUE_EU + OP_INV_FED_VALUE_EU + OP_INV_SEED_VALUE_EU + OP_INV_CLOSING_VALUE_EU - OP_INV_VALUE_EU + d_allowances_op_tonnes_ha) if CROP_CODE == 1560
replace linseed_op_1 = 0 if linseed_op_1 == .
by  FARM_CODE YE_AR: egen s_linseed_op_1 = sum(linseed_op_1)
			 

gen linseed_op_2 = (OP_INV_CLOSING_QTY_TONNES_HA - OP_INV_WASTE_TONNES_HA) if CROP_CODE == 1560
replace linseed_op_2 = 0 if linseed_op_2 == .
by  FARM_CODE YE_AR: egen s_linseed_op_2 = sum(linseed_op_2)

gen linseed_op_inv_val_eu = OP_INV_VALUE_EU if CROP_CODE == 1560
replace linseed_op_inv_val_eu = 0 if linseed_op_inv_val_eu == .
by  FARM_CODE YE_AR: egen s_linseed_op_inv_val_eu = sum(linseed_op_inv_val_eu)

gen linseed_total_eu = total_eu if CROP_CODE == 1561
replace linseed_total_eu = 0 if linseed_total_eu == .
by  FARM_CODE YE_AR: egen s_linseed_total_eu = sum(linseed_total_eu)


*D_PO_GROSS_OUTPUT_OP_INV_EU
gen potatoes_op = OP_INV_SALES_VALUE_EU + OP_INV_FED_VALUE_EU + OP_INV_SEED_VALUE_EU + OP_INV_CLOSING_VALUE_EU - OP_INV_VALUE_EU + d_allowances_op_tonnes_ha if CROP_CODE == 1310
replace potatoes_op = 0 if potatoes_op == .
by  FARM_CODE YE_AR: egen s_potatoes_op = sum(potatoes_op)


*D_MB_GROSS_OUTPUT_OP_INV_EU
gen sugar_beet_op = OP_INV_SALES_VALUE_EU + OP_INV_FED_VALUE_EU + OP_INV_SEED_VALUE_EU + OP_INV_CLOSING_VALUE_EU - OP_INV_VALUE_EU + d_allowances_op_tonnes_ha if CROP_CODE == 1320
replace sugar_beet_op = 0 if sugar_beet_op == .
by  FARM_CODE YE_AR: egen s_sugar_beet_op = sum(sugar_beet_op)


*D_OTHER_CASH_GROSS_OUTPUT_OP_INV_EU
gen other_cash_op = (OP_INV_SALES_VALUE_EU + OP_INV_FED_VALUE_EU + OP_INV_SEED_VALUE_EU + OP_INV_CLOSING_VALUE_EU - OP_INV_VALUE_EU + d_allowances_op_tonnes_ha) / ((OP_INV_CLOSING_QTY_TONNES_HA - OP_INV_WASTE_TONNES_HA) * (OP_INV_VALUE_EU + total_eu))  if i_other_cash_crop_ind_yn == "y"
replace other_cash_op = 0 if other_cash_op == .
by  FARM_CODE YE_AR: egen s_other_cash_op = sum(other_cash_op)


*D_GROSS_OUTPUT_EU
gen d_gross_output_eu_1 = (CY_ALLOW_HOUSE_TONNES_HA + CY_ALLOW_WAGES_TONNES_HA) / (CY_CLOSING_VALUE_EU - CY_WASTE_TONNES_HA) if (CY_CLOSING_VALUE_EU - CY_WASTE_TONNES_HA) > 0
replace d_gross_output_eu_1 = 0 if d_gross_output_eu_1 == .
gen d_gross_output_eu = (CY_SALES_VALUE_EU + CY_FED_VALUE_EU + CY_CLOSING_VALUE_EU) + (d_gross_output_eu_1 * d_total_direct_cost_eu)
replace d_gross_output_eu = 0 if d_gross_output_eu == .

gen curr_cash_crp_go = d_gross_output_eu if crop_code1 != 111 & crop_code1 != 115 & crop_code1 != 114 & crop_code1 != 157 & crop_code1 != 131 & crop_code1 != 132 & crop_code1 != 143 & crop_code1 != 146 & crop_code1 != 811 & crop_code1 != 921 & crop_code1 != 922 & crop_code1 != 923 & crop_code1 != 902 & crop_code1 != 903 & crop_code1 != 904& crop_code1 != 905 & crop_code1 != 906 & crop_code1 != 907 & crop_code1 != 908 & crop_code1 != 175
replace curr_cash_crp_go = d_gross_output_eu if CROP_CODE == 1116 | CROP_CODE == 1111 | CROP_CODE == 1117 | CROP_CODE == 1146 | CROP_CODE == 1141 | CROP_CODE == 1147 | CROP_CODE == 1571 | CROP_CODE == 1577 | CROP_CODE == 1156 | CROP_CODE == 1151 | CROP_CODE == 1157 | CROP_CODE == 1431 | CROP_CODE == 1436 | CROP_CODE == 1211 | CROP_CODE == 1561 | CROP_CODE == 1311 | CROP_CODE == 1317 | CROP_CODE == 1321 | CROP_CODE == 1751 
replace curr_cash_crp_go = 0 if curr_cash_crp_go == .
by  FARM_CODE YE_AR: egen s_curr_cash_crp_go = sum(curr_cash_crp_go)



