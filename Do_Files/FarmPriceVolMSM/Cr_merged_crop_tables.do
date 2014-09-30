*******************************************
* Create merged_crop_tables
*******************************************

keep if temp==1
drop temp

*replace ALLOCATED_TO_CROP_EU = ALLOCATED_TO_CROP_EU * sc_p_caslab_crop

gen CY_TOTAL_YIELD_8111 = CY_TOTAL_YIELD

* derive CY_TOTAL_YIELD so we can allow for change in Yeild in Tonnes per Ha

*replace CY_SALES_QTY_TONNES_HA = CY_SALES_QTY_TONNES_HA * sc_q_yield_tns_ha
*replace CY_FED_QTY_TONNES_HA = CY_FED_QTY_TONNES_HA * sc_q_yield_tns_ha
*replace CY_CLOSING_QTY_TONNES_HA = CY_CLOSING_QTY_TONNES_HA * sc_q_yield_tns_ha 
*NOTE IN THE ABOVE LINEs, INCLUDE THE MAIN CROPS THEY WANT CHANGED, SO IT WOULD BE if CROP_CODE != 8111 & (CROP_CODE == 1111 | CROP_CODE == 1116 | CROP_CODE == 1141 | CROP_CODE == 1146 | CROP_CODE == 1151 | CROP_CODE == 1156 | CROP_CODE == 1571)
*WE EXCLUDE STRAW (!= 8111) AS BRIAN SAYS ITS ALWAYS BEEN PROBLEMATIC AND WILL THROW OFF THE CALCULATION



