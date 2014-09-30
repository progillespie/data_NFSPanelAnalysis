*******************************************
* Create curr_misc_cash_crops_go_1
*******************************************

sort FARM_CODE YE_AR

keep FARM_CODE YE_AR m_winter_wheat m_spring_wheat s_wheat_op m_winter_barley m_spring_barley s_barley_op s_malt_barley_op m_winter_oats m_spring_oats s_oats_op s_oseed_rape_op_1 s_oseed_rape_op_2 s_oseed_rape_op_inv_val_eu s_oseed_rape_total_eu s_pb_op_1 s_pb_op_2 s_pb_op_inv_val_eu s_pb_total_eu s_linseed_op_1 s_linseed_op_2 s_linseed_op_inv_val_eu s_linseed_total_eu s_potatoes_op s_sugar_beet_op s_other_cash_op

by  FARM_CODE YE_AR: egen rnk = rank(YE_AR),unique
keep if rnk == 1
drop rnk

gen d_ww_gross_output_op_inv_eu = 0 if m_winter_wheat > 0 & m_spring_wheat > 0
replace d_ww_gross_output_op_inv_eu = s_wheat_op if m_winter_wheat > 0 & d_ww_gross_output_op_inv_eu == . 
replace d_ww_gross_output_op_inv_eu = 0 if d_ww_gross_output_op_inv_eu  == .

gen d_sw_gross_output_op_inv_eu = s_wheat_op if m_winter_wheat > 0 & m_spring_wheat > 0
replace d_sw_gross_output_op_inv_eu = 0 if m_winter_wheat > 0 & d_sw_gross_output_op_inv_eu == . 
replace d_sw_gross_output_op_inv_eu = s_wheat_op if d_sw_gross_output_op_inv_eu == .
replace d_sw_gross_output_op_inv_eu = 0 if d_sw_gross_output_op_inv_eu == .

gen d_wb_gross_output_op_inv_eu = 0 if m_winter_barley > 0 & m_spring_barley > 0
replace d_wb_gross_output_op_inv_eu = s_barley_op if m_winter_barley > 0 & d_wb_gross_output_op_inv_eu == . 
replace d_wb_gross_output_op_inv_eu = 0 if d_wb_gross_output_op_inv_eu == .

gen d_sb_gross_output_op_inv_eu = s_barley_op if m_winter_barley > 0 & m_spring_barley > 0
replace d_sb_gross_output_op_inv_eu = 0 if m_winter_barley > 0 & d_sb_gross_output_op_inv_eu == . 
replace d_sb_gross_output_op_inv_eu = s_barley_op if d_sb_gross_output_op_inv_eu == .
replace d_sb_gross_output_op_inv_eu = 0 if d_sb_gross_output_op_inv_eu == .

gen d_mb_gross_output_op_inv_eu = s_malt_barley_op
replace d_mb_gross_output_op_inv_eu = 0 if d_mb_gross_output_op_inv_eu == .

gen d_wo_gross_output_op_inv_eu = 0 if m_winter_oats > 0 & m_spring_oats > 0
replace d_wo_gross_output_op_inv_eu = s_oats_op if m_winter_oats > 0 & d_wo_gross_output_op_inv_eu == . 
replace d_wo_gross_output_op_inv_eu = 0 if d_wo_gross_output_op_inv_eu == .

gen d_so_gross_output_op_inv_eu = s_oats_op if m_winter_oats > 0 & m_spring_oats > 0
replace d_so_gross_output_op_inv_eu = 0 if m_winter_oats > 0 & d_so_gross_output_op_inv_eu == . 
replace d_so_gross_output_op_inv_eu = s_oats_op if d_so_gross_output_op_inv_eu == .
replace d_so_gross_output_op_inv_eu = 0 if d_so_gross_output_op_inv_eu == .

gen d_os_gross_output_op_inv_eu = s_oseed_rape_op_1 / (s_oseed_rape_op_2 * (s_oseed_rape_op_inv_val_eu + s_oseed_rape_total_eu))
replace d_os_gross_output_op_inv_eu = 0 if d_os_gross_output_op_inv_eu == .

gen d_pb_gross_output_op_inv_eu = s_pb_op_1 / (s_pb_op_2 * (s_pb_op_inv_val_eu + s_pb_total_eu))
replace d_pb_gross_output_op_inv_eu = 0 if d_pb_gross_output_op_inv_eu == .

gen d_ls_gross_output_op_inv_eu = s_linseed_op_1 / (s_linseed_op_2 * (s_linseed_op_inv_val_eu + s_linseed_total_eu))
replace d_ls_gross_output_op_inv_eu = 0 if d_ls_gross_output_op_inv_eu == .


gen d_po_gross_output_op_inv_eu = s_potatoes_op
replace d_po_gross_output_op_inv_eu = 0 if d_po_gross_output_op_inv_eu == .

gen d_sbeet_gross_output_op_inv_eu = s_sugar_beet_op
replace d_sbeet_gross_output_op_inv_eu = 0 if d_sbeet_gross_output_op_inv_eu == .

gen d_other_cash_output_op_inv_eu = s_other_cash_op
replace d_other_cash_output_op_inv_eu = 0 if d_other_cash_output_op_inv_eu == .


gen d_go_inv_misc_csh_crop = d_ww_gross_output_op_inv_eu + d_sw_gross_output_op_inv_eu + d_wb_gross_output_op_inv_eu + d_sb_gross_output_op_inv_eu + d_mb_gross_output_op_inv_eu + d_wo_gross_output_op_inv_eu + d_so_gross_output_op_inv_eu + d_os_gross_output_op_inv_eu + d_pb_gross_output_op_inv_eu + d_ls_gross_output_op_inv_eu + d_po_gross_output_op_inv_eu + d_sbeet_gross_output_op_inv_eu + d_other_cash_output_op_inv_eu 

sort FARM_CODE YE_AR
