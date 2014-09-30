***********************************
* Create select_crops_dc
***********************************

sort FARM_CODE YE_AR

keep FARM_CODE YE_AR m_d_total_direct_cost_eu_2

by  FARM_CODE YE_AR: egen rnk = rank( YE_AR),unique
keep if rnk == 1
drop rnk
gen d_dc_select_crops = m_d_total_direct_cost_eu_2
drop m_d_total_direct_cost_eu_2


sort FARM_CODE YE_AR
