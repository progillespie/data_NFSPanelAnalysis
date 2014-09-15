*******************************************
* Create d_horse_pasture_eu
*******************************************


gen d_horse_pasture_eu = (d_horses_livestock_units / i_total_lu_home_grazing) * d_grazing_total_direct_costs_eu + BOARDING_OUT_HORSES_EU
replace d_horse_pasture_eu = 0 if d_horse_pasture_eu == .

* CHANGE-7983: assign Stata calc var to sys var
capture gen double D_HORSE_PASTURE_EU = d_horse_pasture_eu 


keep FARM_CODE YE_AR d_horses_livestock_units i_total_lu_home_grazing d_grazing_total_direct_costs_eu D_HORSE_PASTURE_EU d_horse_pasture_eu  

sort FARM_CODE YE_AR
