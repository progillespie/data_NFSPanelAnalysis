*******************************************
* Create Opening Inventory
*******************************************



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

* CHANGE-7983: assign Stata derived var (no sys. var to test against)
gen I_OP_INV_VAL_EU = i_op_inv_val_eu 




by  FARM_CODE YE_AR crop_code1 : egen opening = sum(op_inv_val_0) 
by  FARM_CODE YE_AR crop_code1 : egen curryld = sum(op_inv_val_1) 
by  FARM_CODE YE_AR crop_code1 : egen curryld_1 = sum(op_inv_val_2)


gen cy_fed_qty_tonnes_ha_1 =  CY_FED_QTY_TONNES_HA if CROP_CODE == 9011 | CROP_CODE == 9021  | CROP_CODE == 9031  | CROP_CODE == 9041  | CROP_CODE == 9051  | CROP_CODE == 9061  | CROP_CODE == 9071  | CROP_CODE == 9081  | CROP_CODE == 9091  | CROP_CODE == 9121  | CROP_CODE == 9211  | CROP_CODE == 9221  | CROP_CODE == 9231 | CROP_CODE == 9083 | CROP_CODE == 8111
by  FARM_CODE YE_AR crop_code1: egen m_cy_fed_qty_tonnes_ha_1 = sum(cy_fed_qty_tonnes_ha_1)

gen fed_total_tonnes_ha_1 =  FED_TOTAL_TONNES_HA if CROP_CODE == 9011 | CROP_CODE == 9021  | CROP_CODE == 9031  | CROP_CODE == 9041  | CROP_CODE == 9051  | CROP_CODE == 9061  | CROP_CODE == 9071  | CROP_CODE == 9081  | CROP_CODE == 9091  | CROP_CODE == 9121  | CROP_CODE == 9211  | CROP_CODE == 9221  | CROP_CODE == 9231 | CROP_CODE == 9083 | CROP_CODE == 8111
by  FARM_CODE YE_AR crop_code1: egen m_fed_total_tonnes_ha_1 = sum(fed_total_tonnes_ha_1)

gen cy_and_op_fed = CY_FED_QTY_TONNES_HA + OP_INV_FED_QTY_TONNES_HA
by  FARM_CODE YE_AR crop_code1: egen s_cy_and_op_fed = sum(cy_and_op_fed)


