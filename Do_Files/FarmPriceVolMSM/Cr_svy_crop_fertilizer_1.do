*******************************************
* Create svy_crop_fertilizer_1
*******************************************

sort FARM_CODE YE_AR

*replace ORIGINAL_COST_EU = ORIGINAL_COST_EU * sc_p_fert_orig_cost

capture drop FERT_USED_VALUE_EU 
gen FERT_USED_VALUE_EU = ( QUANTITY_ALLOCATED_50KGBAGS / ORIGINAL_QUANTITY_50KGBAGS)* ORIGINAL_COST_EU

****The following sums by crop code so it can be merged with the other crop multicard tables

sort  FARM_CODE YE_AR CROP_CODE
foreach var in  ANALYSIS_N ANALYSIS_P ANALYSIS_K QUANTITY_ALLOCATED_50KGBAGS ORIGINAL_COST_EU ORIGINAL_QUANTITY_50KGBAGS FERT_USED_VALUE_EU {
	by FARM_CODE YE_AR CROP_CODE: egen s_c_`var' = sum(`var')
}

by  FARM_CODE YE_AR CROP_CODE: egen rnk = rank( YE_AR),unique

keep if rnk == 1

drop rnk ANALYSIS_N ANALYSIS_P ANALYSIS_K QUANTITY_ALLOCATED_50KGBAGS ORIGINAL_COST_EU ORIGINAL_QUANTITY_50KGBAGS FERT_USED_VALUE_EU

gen temp=1



