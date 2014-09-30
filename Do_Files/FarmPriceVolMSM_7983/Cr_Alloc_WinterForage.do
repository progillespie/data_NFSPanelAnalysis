*******************************************
* Create Allocate Winter Forage to animals
*******************************************


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

