*******************************************
* Create sum_svy_crop_fertilizer_bycrop
*******************************************

*keep if temp==1
*drop temp

sort FARM_CODE CROP_CODE YE_AR

** Lag volume
by FARM_CODE CROP_CODE: gen QUANTITY_ALLOCATED_50KGBAGS_p1 = s_c_QUANTITY_ALLOCATED_50KGBAGS[_n+1] if YE_AR[_n+1] == YE_AR+1
** Lag value
by FARM_CODE CROP_CODE: gen FERT_USED_VALUE_EU_p1 = s_c_FERT_USED_VALUE_EU[_n+1] if YE_AR[_n+1] == YE_AR+1

* Have product in both years
gen QUANTITY_ALLOCATED_50KGBAGS_b = s_c_QUANTITY_ALLOCATED_50KGBAGS > 0 & s_c_QUANTITY_ALLOCATED_50KGBAGS != . & QUANTITY_ALLOCATED_50KGBAGS_p1 > 0 & QUANTITY_ALLOCATED_50KGBAGS_p1 != .
* 1 have produce in first year but not in second and 2 where have produce in first year, but missing in second
gen QUANTITY_ALLOCATED_50KGBAGS_12 = 1*(s_c_QUANTITY_ALLOCATED_50KGBAGS > 0 & s_c_QUANTITY_ALLOCATED_50KGBAGS != . & QUANTITY_ALLOCATED_50KGBAGS_p1 == 0 & QUANTITY_ALLOCATED_50KGBAGS_p1 != . & exit_nfs == 1) + 2*(s_c_QUANTITY_ALLOCATED_50KGBAGS > 0 & s_c_QUANTITY_ALLOCATED_50KGBAGS != . & exit_nfs == 0)

* 1 have produce in second year but not in first and 2 where have produce in second year, but missing in first
*gen `var'_QTY_21a = 1*(`var'_QTY == 0 & `var'_QTY != . & `var'_QTY_p1 > 0 & `var'_QTY_p1 != .) 
*by FARM_CODE: gen `var'_QTY_21b = 2*(`var'_QTY[_n-1] == . & `var'_QTY > 0 & `var'_QTY != .)



