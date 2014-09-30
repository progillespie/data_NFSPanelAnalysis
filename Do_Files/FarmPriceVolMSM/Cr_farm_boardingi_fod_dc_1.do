*******************************************
* Create farm_boarding_in_fodder_dc_1
*******************************************


sort FARM_CODE YE_AR

keep FARM_CODE YE_AR d_dairy_lu_boarding_in d_cattle_lu_boarding_in d_sheep_lu_boarding_in_no d_horses_lu_boarding_in

gen d_farm_total_lu_boarding_in = d_dairy_lu_boarding_in + d_cattle_lu_boarding_in + d_sheep_lu_boarding_in_no + d_horses_lu_boarding_in
replace d_farm_total_lu_boarding_in = 0 if d_farm_total_lu_boarding_in == .

sort FARM_CODE YE_AR	

