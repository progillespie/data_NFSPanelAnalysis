*******************************************
* Create sum_grazing_total_dc_eu
*******************************************

**d_grazing_total_direct_costs_eu
*---------------------------------

by  FARM_CODE YE_AR: egen s_grazing_total_dc_eu = sum(grazing_total_dc_eu)

by  FARM_CODE YE_AR: egen rnk = rank(YE_AR),unique

keep if rnk == 1

gen d_grazing_total_direct_costs_eu = s_grazing_total_dc_eu
replace d_grazing_total_direct_costs_eu = 0 if d_grazing_total_direct_costs_eu == .

drop rnk s_grazing_total_dc_eu 

keep FARM_CODE YE_AR d_grazing_total_direct_costs_eu


