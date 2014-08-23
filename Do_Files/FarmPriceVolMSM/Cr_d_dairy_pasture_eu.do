*******************************************
* Create d_dairy_pasture_eu
*******************************************

capture gen i_total_lu_home_grazing = i_horses_lu_home_grazing + i_sheep_lu_home_grazing + i_cattle_lu_home_grazing + i_dairy_lu_home_grazing + d_deer_livestock_units

gen d_dairy_pasture_eu = (i_dairy_lu_home_grazing / i_total_lu_home_grazing) * d_grazing_total_direct_costs_eu + BOARDING_OUT_DAIRY_EU - BOARDING_IN_DAIRY_EU
replace d_dairy_pasture_eu = 0 if d_dairy_pasture_eu  == .

keep FARM_CODE YE_AR i_dairy_lu_home_grazing i_total_lu_home_grazing d_grazing_total_direct_costs_eu BOARDING_OUT_DAIRY_EU BOARDING_IN_DAIRY_EU D_DAIRY_PASTURE_EU d_dairy_pasture_eu 
