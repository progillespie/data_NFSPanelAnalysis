*******************************************
* Create setaside_dc
*******************************************

gen setaside_dc = TOTAL_EU if CROP_CODE == 1461
replace setaside_dc = 0 if setaside_dc == .

sort FARM_CODE YE_AR
by FARM_CODE YE_AR : egen s_setaside_dc = sum(setaside_dc)

keep FARM_CODE YE_AR s_setaside_dc

by  FARM_CODE YE_AR: egen rnk = rank( YE_AR),unique
keep if rnk == 1
drop rnk

sort FARM_CODE YE_AR
