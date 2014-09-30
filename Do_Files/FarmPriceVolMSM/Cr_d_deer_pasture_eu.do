*******************************************
* Create d_deer_pasture_eu
*******************************************


gen d_deer_pasture_eu = (d_deer_livestock_units / i_total_lu_home_grazing) * d_grazing_total_direct_costs_eu
replace d_deer_pasture_eu = 0 if d_deer_pasture_eu == .

sort FARM_CODE YE_AR CROP_CODE
by FARM_CODE YE_AR: egen rnkc = rank(CROP_CODE)
keep if rnkc == 1
keep FARM_CODE YE_AR d_deer_livestock_units i_total_lu_home_grazing d_grazing_total_direct_costs_eu d_deer_pasture_eu  
*D_DEER_PASTURE_EU 
sort FARM_CODE YE_AR
