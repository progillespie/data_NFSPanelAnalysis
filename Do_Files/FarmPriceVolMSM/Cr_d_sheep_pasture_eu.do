*******************************************
* Create d_sheep_pasture_eu
*******************************************

gen d_sheep_pasture_eu = ((i_sheep_lu_home_grazing - d_sheep_lu_boarding_in_no) / i_total_lu_home_grazing) * d_grazing_total_direct_costs_eu + (BOARDING_OUT_SHEEP1_EU + BOARDING_OUT_SHEEP2_EU) if i_total_lu_home_grazing > 0
replace d_sheep_pasture_eu = 0 if d_sheep_pasture_eu == .


keep FARM_CODE YE_AR i_sheep_lu_home_grazing i_total_lu_home_grazing d_grazing_total_direct_costs_eu D_SHEEP_PASTURE_EU d_sheep_pasture_eu 

sort FARM_CODE YE_AR
