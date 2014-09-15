*******************************************
* Create svy_sheep_2
*******************************************


gen d_sheep_lu_boarding_out_no = (BOARDING_OUT_SHEEP1_ANIMALS_NO * (BOARDING_OUT_SHEEP1_DAYS_NO / 365) * BOARDING_OUT_SHEEP1_LU_EQUIV) + (BOARDING_OUT_SHEEP2_ANIMALS_NO * (BOARDING_OUT_SHEEP2_DAYS_NO / 365) * BOARDING_OUT_SHEEP2_LU_EQUIV)
replace d_sheep_lu_boarding_out_no = 0 if d_sheep_lu_boarding_out_no == .

gen d_sheep_lu_boarding_in_no = (BOARDING_IN_SHEEP1_ANIMALS_NO * (BOARDING_IN_SHEEP1_DAYS_NO / 365) * BOARDING_IN_SHEEP1_LU_EQUIV) + (BOARDING_IN_SHEEP2_ANIMALS_NO * (BOARDING_IN_SHEEP2_DAYS_NO / 365) * BOARDING_IN_SHEEP2_LU_EQUIV)
replace d_sheep_lu_boarding_in_no = 0 if d_sheep_lu_boarding_in_no == .

gen i_sheep_lu_home_grazing = (d_sheep_livestock_units - (COMMONAGE_SHEEP1_ANIMALS_NO * (COMMONAGE_SHEEP1_DAYS_NO / 365) * COMMONAGE_SHEEP1_LU_EQUIV + COMMONAGE_SHEEP2_ANIMALS_NO * (COMMONAGE_SHEEP2_DAYS_NO / 365) * COMMONAGE_SHEEP2_LU_EQUIV)) - (d_sheep_lu_boarding_out_no - d_sheep_lu_boarding_in_no)


*D_SHEEP_BREEDING_STOCK_SOLD_EU
gen d_sheep_breeding_stock_sold_eu = 0
replace d_sheep_breeding_stock_sold_eu = BREEDING_HOGGETS_SALES_EU + CULL_EWES_RAMS_SALES_EU + BREEDING_EWES_SALES_EU

*D_SHEEP_SALES_EU
gen d_sheep_sales = 0
replace d_sheep_sales = FAT_LAMBS_SALES_EU + STORE_LAMBS_SALES_EU + FAT_HOGGETS_SALES_EU + d_sheep_breeding_stock_sold_eu 

*D_SALES_SHEEP_ONLY_INCL_HSE_CONSUMPTION_EU (D_SLS_SHEP_ONLY_INCL_HSE_CONS_EU)
gen d_sls_shep_only_incl_hse_cons_eu = 0
replace d_sls_shep_only_incl_hse_cons_eu = d_sheep_sales + USED_IN_HOUSE_EU

*D_PURCHASES_SHEEP_ONLY_EU
gen d_purchases_sheep_only_eu = 0
replace d_purchases_sheep_only_eu = EWES_RAMS_PURCHASES_EU + BREEDING_HOGGETS_PURCHASES_EU + STORE_LAMBS_PURCHASES_EU

*D_VALUE_OF_CHANGE_IN_NUMBERS_EU
gen d_value_of_change_in_numbers_eu = 0
replace d_value_of_change_in_numbers_eu = (((EWES_CLOS_INV_NO - EWES_OP_INV_NO) *  EWES_CLOS_INV_EU) + ((LAMBS_PRE_WEANING_CLOS_INV_NO - LAMBS_PRE_WEANING_OP_INV_NO) *  LAMBS_PRE_WEANING_CLOS_INV_EU) + ((LAMBS_LT1YR_CLOS_INV_NO - LAMBS_LT1YR_OP_INV_NO) *  LAMBS_LT1YR_CLOS_INV_EU) + ((SHEEP_1_2YRS_CLOS_INV_NO - SHEEP_1_2YRS_OP_INV_NO) *  SHEEP_1_2YRS_CLOS_INV_EU) + ((SHEEP_GT2YRS_CLOS_INV_NO - SHEEP_GT2YRS_OP_INV_NO) *  SHEEP_GT2YRS_CLOS_INV_EU) + ((RAMS_CLOS_INV_NO - RAMS_OP_INV_NO) *  RAMS_CLOS_INV_EU))
