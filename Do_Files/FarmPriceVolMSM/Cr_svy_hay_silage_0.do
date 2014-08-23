*******************************************
* Create svy_hay_silage_0
*******************************************

gen sil_fed_cond_1 = 1 if SIL_OP_INV_QTY_TONNES >= SIL_FED_QUANTITY_TONNES & SIL_OP_INV_QTY_TONNES > 0
replace sil_fed_cond_1 = 0 if sil_fed_cond_1 == .

gen sil_fed_cond_2 = 1 if SIL_FED_QUANTITY_TONNES > 0 & sil_fed_cond_1 != 1
replace sil_fed_cond_2 = 0 if sil_fed_cond_2 == .

gen sil_fed_cond_3 = 1 if SIL_OP_INV_QTY_TONNES > 0 & sil_fed_cond_2 == 1
replace sil_fed_cond_3 = 0 if sil_fed_cond_3 == .

gen sil_fed_cond_4 = 1 if SIL_TOTAL_YIELD_TONNES > 0 & sil_fed_cond_2 == 1
replace sil_fed_cond_4 = 0 if sil_fed_cond_4 == .

gen hay_fed_cond_1 = 1 if HAY_OP_INV_QTY_TONNES >= HAY_FED_QUANTITY_TONNES & HAY_OP_INV_QTY_TONNES > 0
replace hay_fed_cond_1 = 0 if hay_fed_cond_1 == .

gen hay_fed_cond_2 = 1 if HAY_FED_QUANTITY_TONNES > 0 & hay_fed_cond_1 != 1
replace hay_fed_cond_2 = 0 if hay_fed_cond_2 == .

gen hay_fed_cond_3 = 1 if HAY_OP_INV_QTY_TONNES > 0 & hay_fed_cond_2 == 1
replace hay_fed_cond_3 = 0 if hay_fed_cond_3 == .

gen hay_fed_cond_4 = 1 if HAY_TOTAL_YIELD_TONNES > 0 & hay_fed_cond_2 == 1
replace hay_fed_cond_4 = 0 if hay_fed_cond_4 == .


