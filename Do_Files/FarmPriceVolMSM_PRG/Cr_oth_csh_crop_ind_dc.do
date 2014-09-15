***********************************
* Create oth_csh_crop_ind_dc
***********************************
sort FARM_CODE YE_AR

keep FARM_CODE YE_AR m_d_total_direct_cost_eu_3

by  FARM_CODE YE_AR: egen rnk = rank( YE_AR),unique
keep if rnk == 1
drop rnk
gen oth_csh_crop_dc = m_d_total_direct_cost_eu_3
drop m_d_total_direct_cost_eu_3


sort FARM_CODE YE_AR
