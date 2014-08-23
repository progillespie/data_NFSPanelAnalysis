*******************************************
* Create d_total_pasture_eu
*******************************************


gen d_total_pasture_eu = (((i_cattle_lu_home_grazing - ((BOARDING_IN_CATTLE1_ANIMALS_NO * (BOARDING_IN_CATTLE1_DAYS_NO / 365) * BOARDING_IN_CATTLE1_LU_EQUIV) + (BOARDING_IN_CATTLE2_ANIMALS_NO * (BOARDING_IN_CATTLE2_DAYS_NO / 365) * BOARDING_IN_CATTLE2_LU_EQUIV))) / i_total_lu_home_grazing) * d_grazing_total_direct_costs_eu) + (BOARDING_OUT_CATTLE1_EU + BOARDING_OUT_CATTLE2_EU) if i_total_lu_home_grazing > 0
replace d_total_pasture_eu = 0 if d_total_pasture_eu == .


keep FARM_CODE YE_AR i_cattle_lu_home_grazing i_total_lu_home_grazing d_grazing_total_direct_costs_eu D_TOTAL_PASTURE_EU d_total_pasture_eu 

sort FARM_CODE YE_AR

