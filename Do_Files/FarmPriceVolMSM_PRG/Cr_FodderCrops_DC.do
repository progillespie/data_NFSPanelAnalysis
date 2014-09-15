*******************************************
* Create FodderCrops_DC
*******************************************

gen fodd_op_dc = s_fodd_op_inv_sls_dc + s_fodd_op_inv_wst_dc
replace fodd_op_dc = 0 if fodd_op_dc == .

gen fodd_cy_dc = s_fodd_cy_sls_dc + s_fodd_cy_wst_dc
replace fodd_cy_dc = 0 if fodd_cy_dc == .

gen fodd_graz_dc = (d_farm_total_lu_boarding_in / i_total_lu_home_grazing)* d_grazing_total_direct_costs_eu
replace fodd_graz_dc = 0 if fodd_graz_dc == .

replace s_fodd_stw = 0 if s_fodd_stw == .

replace fodd_hay_sil_dc = 0 if fodd_hay_sil_dc == .

gen dc_fodder_crops_sold_eu = fodd_op_dc + fodd_cy_dc + s_fodd_stw + fodd_hay_sil_dc + fodd_graz_dc
replace dc_fodder_crops_sold_eu = 0 if dc_fodder_crops_sold_eu == .

sort FARM_CODE YE_AR



