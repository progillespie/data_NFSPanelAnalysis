*******************************************
* Create merged_crop_tables_2
*******************************************

** D_GRAZING_TOTAL_DIRECT_COSTS_EU


** silage - casual labour
gen lab_alloc_to_hay = ALLOCATED_TO_CROP_EU if CROP_CODE == 9221
replace lab_alloc_to_hay = 0 if lab_alloc_to_hay == .


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
