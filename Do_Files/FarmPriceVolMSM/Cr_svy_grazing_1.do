*******************************************
* Create svy_grazing_1
*******************************************
*mvencode i_*, mv(0) override
*gen i_total_lu_home_grazing = i_horses_lu_home_grazing + i_sheep_lu_home_grazing + i_cattle_lu_home_grazing + i_dairy_lu_home_grazing + d_deer_livestock_units
sort FARM_CODE YE_AR

