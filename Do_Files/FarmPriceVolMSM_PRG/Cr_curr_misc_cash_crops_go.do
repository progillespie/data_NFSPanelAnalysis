*******************************************
* Create curr_misc_cash_crops_go
*******************************************

sort FARM_CODE YE_AR

by  FARM_CODE YE_AR: egen rnk = rank(YE_AR),unique
keep if rnk == 1
drop rnk

sort FARM_CODE YE_AR

keep FARM_CODE YE_AR s_curr_cash_crp_go d_arable_aid PROTEIN_PAYMENTS_TOTAL_EU

gen d_output_from_cur_misc_cash_crop = s_curr_cash_crp_go + d_arable_aid + PROTEIN_PAYMENTS_TOTAL_EU
replace d_output_from_cur_misc_cash_crop = 0 if d_output_from_cur_misc_cash_crop == . 



