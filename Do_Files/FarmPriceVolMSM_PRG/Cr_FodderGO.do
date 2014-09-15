*******************************************
* Create Fodder GO
*******************************************


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



