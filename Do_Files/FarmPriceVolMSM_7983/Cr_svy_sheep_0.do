*******************************************
* Create svy_sheep_0
*******************************************





*i_sheep_lu_home_grazing (d_sheep_livestock_units, d_sheep_lu_boarding_out_no, d_sheep_lu_boarding_in_no)
*----------------------------------------------------------------------------------------------------------


* CHANGE-7983: no D_SLS_SHEP_ONLY_INCL_HSE_CONS_EU (no rename)
*rename var90 D_SLS_SHEP_ONLY_INCL_HSE_CONS_EU


*d_sheep_livestock_units (i_lu_of_lambs_after, i_lu_of_sheep_gt1yr, i_lu_of_ewe, i_lu_of_ram)

gen i_lu_of_lambs_after = 0
replace i_lu_of_lambs_after = 0.1 if HILL_LOWLAND_CODE == 1
replace i_lu_of_lambs_after = 0.12 if HILL_LOWLAND_CODE == 2  

gen i_lu_of_sheep_gt1yr = 0
replace i_lu_of_sheep_gt1yr = 0.1 if HILL_LOWLAND_CODE == 1
replace i_lu_of_sheep_gt1yr = 0.15 if HILL_LOWLAND_CODE == 2 

gen i_lu_of_ewe = 0
replace i_lu_of_ewe = 0.14 if HILL_LOWLAND_CODE == 1
replace i_lu_of_ewe = 0.2 if HILL_LOWLAND_CODE == 2 

gen i_lu_of_ram = 0
replace i_lu_of_ram = 0.14 if HILL_LOWLAND_CODE == 1
replace i_lu_of_ram = 0.2 if HILL_LOWLAND_CODE == 2 

gen d_sheep_livestock_units = ((MTH12_TOTAL_LAMBS_LT1YR_NO * i_lu_of_lambs_after) + ((MTH12_TOTAL_SHEEP_GT2YRS_NO + MTH12_TOTAL_SHEEP_1_2YRS_NO) * i_lu_of_sheep_gt1yr) + (MTH12_TOTAL_LAMBS_PRE_WEANING_NO * 0) + (MTH12_TOTAL_EWES_BREEDING_NO * i_lu_of_ewe) + (MTH12_TOTAL_RAMS_NO * i_lu_of_ram))/12
replace d_sheep_livestock_units = 0 if d_sheep_livestock_units == .
