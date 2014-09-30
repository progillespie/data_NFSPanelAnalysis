*******************************************
* Create d_inter_enterpise_transfers_eu
*******************************************

sort FARM_CODE YE_AR
by  FARM_CODE YE_AR: egen rnk = rank(YE_AR),unique

keep if rnk == 1

drop rnk

sort FARM_CODE YE_AR 

keep FARM_CODE YE_AR csh_crp_op_inv_fed_eu_1 csh_crp_cy_fed_eu_1 s_home_grown_seed_value_eu d_milk_fed_to_livestock_eu

sort FARM_CODE YE_AR

gen d_inter_enterpise_transfers_eu = 0

replace d_inter_enterpise_transfers_eu = d_milk_fed_to_livestock_eu + (csh_crp_op_inv_fed_eu_1 + csh_crp_cy_fed_eu_1) + s_home_grown_seed_value_eu

sort FARM_CODE YE_AR

