*******************************************
* Create svy_hay_silage_1
*******************************************

replace d_sil_fertiliser_cost_eu = 0 if d_sil_fertiliser_cost_eu  ==.

** d_sil_total_direct_cost_eu 

gen d_sil_total_direct_cost_eu = d_sil_fertiliser_cost_eu + s_lab_alloc_to_sil + s_sil_1_i_tot_hme_grsd_eu
replace d_sil_total_direct_cost_eu = 0 if d_sil_total_direct_cost_eu  == .

** d_hay_total_direct_cost_eu 

gen d_hay_total_direct_cost_eu = d_hay_fertiliser_cost_eu + s_lab_alloc_to_hay + s_hay_1_i_tot_hme_grsd_eu
replace d_hay_total_direct_cost_eu = 0 if d_hay_total_direct_cost_eu  == .


gen temp_unit_cost_1 = 0
replace temp_unit_cost_1 = s_sil_0_fed_tot_tns_ha / SIL_OP_INV_QTY_TONNES if sil_fed_cond_3 == 1

gen temp_unit_cost_2 = 0
replace temp_unit_cost_2 = (d_sil_total_direct_cost_eu / SIL_TOTAL_YIELD_TONNES) * s_sil_1_fed_tot_tns_ha if sil_fed_cond_4 == 1

gen temp_unit_cost_3 = 0
replace temp_unit_cost_3 = s_hay_0_fed_tot_tns_ha / HAY_OP_INV_QTY_TONNES if hay_fed_cond_3 == 1

gen temp_unit_cost_4 = 0
replace temp_unit_cost_4 = (d_hay_total_direct_cost_eu / HAY_TOTAL_YIELD_TONNES) * s_hay_1_fed_tot_tns_ha if hay_fed_cond_4 == 1



*********************
*********************
*Fodder Direct Cost i_variables:
*********************
*********************

*i_hay_sales_op_qty
*i_hay_op_val_eu
*i_sil_sales_op_qty
*i_sil_op_val_eu


*i_hay_sales_op_qty

gen hay_sal_cond_1 = 1 if  HAY_OP_INV_QTY_TONNES > 0 & HAY_SALES_QUANTITY_TONNES > 0
replace hay_sal_cond_1 = 0 if hay_sal_cond_1 == .

gen hay_sal_cond_2 = 1 if (HAY_OP_INV_QTY_TONNES - (HAY_WASTE_QUANTITY_TONNES+HAY_FED_QUANTITY_TONNES+HAY_ALLOW_QUANTITY_TONNES+HAY_SALES_QUANTITY_TONNES)) > 0 & hay_sal_cond_1 == 1
replace hay_sal_cond_2 = 0 if hay_sal_cond_2 == .

gen hay_sal_cond_3 = 1 if (HAY_OP_INV_QTY_TONNES - (HAY_WASTE_QUANTITY_TONNES+HAY_FED_QUANTITY_TONNES+HAY_ALLOW_QUANTITY_TONNES)) > 0 & hay_sal_cond_1 == 1 & hay_sal_cond_2 != 1
replace hay_sal_cond_3 = 0 if hay_sal_cond_3 == .

gen i_hay_sales_op_qty = 0

replace i_hay_sales_op_qty = HAY_SALES_QUANTITY_TONNES if hay_sal_cond_2 ==1 
replace i_hay_sales_op_qty = HAY_OP_INV_QTY_TONNES - (HAY_WASTE_QUANTITY_TONNES + HAY_FED_QUANTITY_TONNES + HAY_ALLOW_QUANTITY_TONNES) if hay_sal_cond_3 ==1 


*i_hay_op_val_eu

gen hay_op_cond_1 = 1 if  HAY_OP_INV_QTY_TONNES > 0 &  HAY_OP_INV_TOTAL_VALUE_EU == 0 & HAY_TOTAL_YIELD_TONNES == 0
replace hay_op_cond_1 = 0 if hay_op_cond_1 == .

gen hay_op_cond_2 = 1 if HAY_OP_INV_TOTAL_VALUE_EU <= 0
replace hay_op_cond_1 = 0 if hay_op_cond_1 == .

gen hay_op_cond_3 = 1 if HAY_TOTAL_YIELD_TONNES == 0
replace hay_op_cond_3 = 0 if hay_op_cond_3 == .

gen i_hay_op_val_eu = HAY_OP_INV_TOTAL_VALUE_EU
replace i_hay_op_val_eu = HAY_OP_INV_QTY_TONNES * 15 if hay_op_cond_1 == 1
replace i_hay_op_val_eu = 0 if hay_op_cond_2 == 1 & hay_op_cond_3 == 1 & hay_op_cond_1 != 1
replace i_hay_op_val_eu = (HAY_OP_INV_QTY_TONNES / HAY_TOTAL_YIELD_TONNES) *  d_hay_total_direct_cost_eu if hay_op_cond_2 == 1 & HAY_TOTAL_YIELD_TONNES != 0


*i_sil_sales_op_qty

gen sil_sal_cond_1 = 1 if  SIL_OP_INV_QTY_TONNES > 0 & SIL_SALES_QUANTITY_TONNES > 0
replace sil_sal_cond_1 = 0 if sil_sal_cond_1 == .

gen sil_sal_cond_2 = 1 if (SIL_OP_INV_QTY_TONNES - (SIL_WASTE_QUANTITY_TONNES+SIL_FED_QUANTITY_TONNES+SIL_ALLOW_QUANTITY_TONNES+SIL_SALES_QUANTITY_TONNES)) > 0 & sil_sal_cond_1 == 1
replace sil_sal_cond_2 = 0 if sil_sal_cond_2 == .

gen sil_sal_cond_3 = 1 if (SIL_OP_INV_QTY_TONNES - (SIL_WASTE_QUANTITY_TONNES+SIL_FED_QUANTITY_TONNES+SIL_ALLOW_QUANTITY_TONNES)) > 0 & sil_sal_cond_1 == 1 & sil_sal_cond_2 != 1
replace sil_sal_cond_3 = 0 if sil_sal_cond_3 == .

gen i_sil_sales_op_qty = 0

replace i_sil_sales_op_qty = SIL_SALES_QUANTITY_TONNES if sil_sal_cond_2 ==1 
replace i_sil_sales_op_qty = SIL_OP_INV_QTY_TONNES - (SIL_WASTE_QUANTITY_TONNES + SIL_FED_QUANTITY_TONNES + SIL_ALLOW_QUANTITY_TONNES) if sil_sal_cond_3 ==1 


*i_sil_op_val_eu

gen sil_op_cond_1 = 1 if  SIL_OP_INV_QTY_TONNES > 0 &  SIL_OP_INV_TOTAL_VALUE_EU == 0 & SIL_TOTAL_YIELD_TONNES == 0
replace sil_op_cond_1 = 0 if sil_op_cond_1 == .

gen sil_op_cond_2 = 1 if SIL_OP_INV_TOTAL_VALUE_EU <= 0
replace sil_op_cond_1 = 0 if sil_op_cond_1 == .

gen sil_op_cond_3 = 1 if SIL_TOTAL_YIELD_TONNES == 0
replace sil_op_cond_3 = 0 if sil_op_cond_3 == .

gen i_sil_op_val_eu = SIL_OP_INV_TOTAL_VALUE_EU
replace i_sil_op_val_eu = SIL_OP_INV_QTY_TONNES * 5 if sil_op_cond_1 == 1
replace i_sil_op_val_eu = 0 if sil_op_cond_2 == 1 & sil_op_cond_3 == 1 & sil_op_cond_1 != 1
replace i_sil_op_val_eu = (SIL_OP_INV_QTY_TONNES / SIL_TOTAL_YIELD_TONNES) *  d_sil_total_direct_cost_eu if sil_op_cond_2 == 1 & SIL_TOTAL_YIELD_TONNES != 0



gen i_silage_fed_unit_cost = 0
replace i_silage_fed_unit_cost = (i_sil_op_val_eu + s_sil_0_i_tot_hme_grsd_eu - SIL_WASTE_QUANTITY_TONNES) / SIL_OP_INV_QTY_TONNES if sil_fed_cond_1 == 1
replace i_silage_fed_unit_cost = (((i_sil_op_val_eu + s_sil_0_i_tot_hme_grsd_eu) * temp_unit_cost_1) / SIL_FED_QUANTITY_TONNES) + (temp_unit_cost_2 / SIL_FED_QUANTITY_TONNES) if sil_fed_cond_2 == 1

gen i_hay_fed_unit_cost = 0
replace i_hay_fed_unit_cost = (i_hay_op_val_eu - HAY_WASTE_QUANTITY_TONNES) / HAY_OP_INV_QTY_TONNES if hay_fed_cond_1 == 1
replace i_hay_fed_unit_cost = ((i_hay_op_val_eu * temp_unit_cost_3) / HAY_FED_QUANTITY_TONNES) + (temp_unit_cost_4 / HAY_FED_QUANTITY_TONNES) if hay_fed_cond_2 == 1


*D_DIRECT_COSTS_FODDER_CROPS_SOLD_EU

gen fodd_hay_op =  (i_hay_sales_op_qty/HAY_OP_INV_QTY_TONNES) * i_hay_op_val_eu if i_hay_sales_op_qty >0
replace fodd_hay_op = 0 if fodd_hay_op == .

gen fodd_hay_cy = ((HAY_SALES_QUANTITY_TONNES - i_hay_sales_op_qty) / HAY_TOTAL_YIELD_TONNES) * d_hay_total_direct_cost_eu if HAY_TOTAL_YIELD_TONNES >0
replace fodd_hay_cy = 0 if fodd_hay_cy == .

gen fodd_sil_op =  (i_sil_sales_op_qty/SIL_OP_INV_QTY_TONNES) * i_sil_op_val_eu if i_sil_sales_op_qty >0
replace fodd_sil_op = 0 if fodd_sil_op == .

gen fodd_sil_cy = ((SIL_SALES_QUANTITY_TONNES - i_sil_sales_op_qty) / SIL_TOTAL_YIELD_TONNES) * d_sil_total_direct_cost_eu if SIL_TOTAL_YIELD_TONNES >0
replace fodd_sil_cy = 0 if fodd_sil_cy == .

gen fodd_hay_sil_dc = fodd_hay_op + fodd_hay_cy + fodd_sil_op + fodd_sil_cy

*** COST OF WASTE HAY

gen hay_waste_1 = 1 if HAY_WASTE_QUANTITY_TONNES > 0
replace hay_waste_1 = 0 if hay_waste_1 == .

gen hay_waste_2 = 1 if  (HAY_OP_INV_QTY_TONNES - HAY_WASTE_QUANTITY_TONNES) >= 0
replace hay_waste_2 = 0 if hay_waste_2 == .

gen hay_waste_3 = 1 if  HAY_OP_INV_QTY_TONNES > 0
replace hay_waste_3 = 0 if hay_waste_3 == .

gen hay_waste_4 = 1 if  (HAY_OP_INV_QTY_TONNES - HAY_WASTE_QUANTITY_TONNES) < 0
replace hay_waste_4 = 0 if hay_waste_4 == .

gen hay_waste_5 = 1 if  HAY_OP_INV_QTY_TONNES == 0
replace hay_waste_5 = 0 if hay_waste_5 == .

gen waste_hay_dc = (HAY_WASTE_QUANTITY_TONNES / HAY_OP_INV_QTY_TONNES) * HAY_OP_INV_TOTAL_VALUE_EU if hay_waste_1 == 1 & hay_waste_2 == 1
replace waste_hay_dc = (((HAY_WASTE_QUANTITY_TONNES - (HAY_WASTE_QUANTITY_TONNES - HAY_OP_INV_QTY_TONNES)) / HAY_OP_INV_QTY_TONNES) * HAY_OP_INV_TOTAL_VALUE_EU) + ((HAY_WASTE_QUANTITY_TONNES - HAY_OP_INV_QTY_TONNES) / HAY_TOTAL_YIELD_TONNES) * d_hay_total_direct_cost_eu if hay_waste_1 == 1 & hay_waste_3 == 1 & hay_waste_4 == 1 & waste_hay_dc == .
replace waste_hay_dc = (HAY_WASTE_QUANTITY_TONNES / HAY_TOTAL_YIELD_TONNES) * d_hay_total_direct_cost_eu if hay_waste_1 == 1 & hay_waste_5 & waste_hay_dc == .
replace waste_hay_dc = 0 if waste_hay_dc == .


*** COST OF WASTE SILAGE

gen sil_waste_1 = 1 if SIL_WASTE_QUANTITY_TONNES > 0
replace sil_waste_1 = 0 if sil_waste_1 == .

gen sil_waste_2 = 1 if  (SIL_OP_INV_QTY_TONNES - SIL_WASTE_QUANTITY_TONNES) >= 0
replace sil_waste_2 = 0 if sil_waste_2 == .

gen sil_waste_3 = 1 if  SIL_OP_INV_QTY_TONNES > 0
replace sil_waste_3 = 0 if sil_waste_3 == .

gen sil_waste_4 = 1 if  (SIL_OP_INV_QTY_TONNES - SIL_WASTE_QUANTITY_TONNES) < 0
replace sil_waste_4 = 0 if sil_waste_4 == .

gen sil_waste_5 = 1 if  SIL_OP_INV_QTY_TONNES == 0
replace sil_waste_5 = 0 if sil_waste_5 == .

gen waste_sil_dc = (SIL_WASTE_QUANTITY_TONNES / SIL_OP_INV_QTY_TONNES) * SIL_OP_INV_TOTAL_VALUE_EU if sil_waste_1 == 1 & sil_waste_2 == 1
replace waste_sil_dc = (((SIL_WASTE_QUANTITY_TONNES - (SIL_WASTE_QUANTITY_TONNES - SIL_OP_INV_QTY_TONNES)) / SIL_OP_INV_QTY_TONNES) * SIL_OP_INV_TOTAL_VALUE_EU) + ((SIL_WASTE_QUANTITY_TONNES - SIL_OP_INV_QTY_TONNES) / SIL_TOTAL_YIELD_TONNES) * d_sil_total_direct_cost_eu if sil_waste_1 == 1 & sil_waste_3 == 1 & sil_waste_4 == 1 & waste_sil_dc == .
replace waste_sil_dc = (SIL_WASTE_QUANTITY_TONNES / SIL_TOTAL_YIELD_TONNES) * d_sil_total_direct_cost_eu if sil_waste_1 == 1 & sil_waste_5 & waste_sil_dc == .
replace waste_sil_dc = 0 if waste_sil_dc == .


**D_GROSS_OUTPUT_FODDER_CROPS_SOLD_EU

* D_HAY_SALES_OP_EU
gen d_hay_sales_op_eu = 0
replace d_hay_sales_op_eu = i_hay_sales_op_qty * (HAY_SALES_VALUE_EU / HAY_SALES_QUANTITY_TONNES) if i_hay_sales_op_qty > 0 & HAY_SALES_QUANTITY_TONNES > 0

* D_HAY_SALES_CU_EU
gen d_hay_sales_cu_eu = HAY_SALES_VALUE_EU
replace d_hay_sales_cu_eu = HAY_SALES_VALUE_EU - (i_hay_sales_op_qty * (HAY_SALES_VALUE_EU / HAY_SALES_QUANTITY_TONNES)) if i_hay_sales_op_qty >= 0 & HAY_SALES_QUANTITY_TONNES > 0
replace d_hay_sales_cu_eu = 0 if d_hay_sales_cu_eu == .

* D_SIL_SALES_OP_EU
gen d_sil_sales_op_eu = 0 if SIL_SALES_QUANTITY_TONNES <= 0 | SIL_FED_QUANTITY_TONNES >= SIL_OP_INV_QTY_TONNES
replace d_sil_sales_op_eu = SIL_SALES_VALUE_EU if (SIL_SALES_QUANTITY_TONNES < (SIL_OP_INV_QTY_TONNES - SIL_FED_QUANTITY_TONNES)) & d_sil_sales_op_eu == .
replace d_sil_sales_op_eu = ((SIL_OP_INV_QTY_TONNES - SIL_FED_QUANTITY_TONNES) / SIL_SALES_QUANTITY_TONNES) * SIL_SALES_VALUE_EU if (SIL_SALES_QUANTITY_TONNES >= (SIL_OP_INV_QTY_TONNES - SIL_FED_QUANTITY_TONNES)) & d_sil_sales_op_eu == .
replace d_sil_sales_op_eu = 0 if d_sil_sales_op_eu == .

* D_SIL_SALES_CU_EU
gen t_sil_sales_cu_eu = 0
replace t_sil_sales_cu_eu = (SIL_OP_INV_QTY_TONNES - SIL_FED_QUANTITY_TONNES) if (SIL_OP_INV_QTY_TONNES - SIL_FED_QUANTITY_TONNES) > 0
gen d_sil_sales_cu_eu = (SIL_SALES_QUANTITY_TONNES - t_sil_sales_cu_eu) * (SIL_SALES_VALUE_EU / SIL_SALES_QUANTITY_TONNES) if SIL_SALES_QUANTITY_TONNES > (SIL_OP_INV_QTY_TONNES - SIL_FED_QUANTITY_TONNES) 
replace d_sil_sales_cu_eu = 0 if d_sil_sales_cu_eu == .

