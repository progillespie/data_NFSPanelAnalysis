*******************************************
* Create svy_crops_fodder_dc
*******************************************

sort FARM_CODE YE_AR

keep FARM_CODE YE_AR s_fodd_op_inv_sls_dc s_fodd_op_inv_wst_dc s_fodd_cy_sls_dc s_fodd_cy_wst_dc s_fodd_stw_dc

by  FARM_CODE YE_AR: egen rnk = rank( YE_AR),unique
keep if rnk == 1
drop rnk


