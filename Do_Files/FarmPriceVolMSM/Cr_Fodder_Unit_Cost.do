*******************************************
* Create Unit Cost
*******************************************


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
