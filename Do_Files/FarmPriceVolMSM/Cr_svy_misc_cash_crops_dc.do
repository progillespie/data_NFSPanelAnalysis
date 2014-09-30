*******************************************
* Create svy_misc_cash_crops_dc
*******************************************

sort FARM_CODE YE_AR

keep FARM_CODE YE_AR s_inv_misc_csh_crop

by  FARM_CODE YE_AR: egen rnk = rank( YE_AR),unique
keep if rnk == 1
drop rnk
gen d_dc_inv_misc_csh_crop = s_inv_misc_csh_crop
drop s_inv_misc_csh_crop


sort FARM_CODE YE_AR
