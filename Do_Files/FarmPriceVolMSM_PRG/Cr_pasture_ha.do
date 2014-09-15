*******************************************
* Create pasture_ha
*******************************************
gen d_total_pasture_ha = TOTAL_PASTURE_LEY_HA + TOTAL_PASTURE_PERMANENT_HA

gen d_pasture_adj_for_hay_silage_ha = (d_total_pasture_ha + PASTURE_EQUIV_ROUGH_HA) - (d_adj_hectarage_of_silage_ha +  d_adjusted_hectarage_of_hay_ha)

capture drop CROP_CODE
gen CROP_CODE = 9211

keep FARM_CODE YE_AR CROP_CODE d_pasture_adj_for_hay_silage_ha


