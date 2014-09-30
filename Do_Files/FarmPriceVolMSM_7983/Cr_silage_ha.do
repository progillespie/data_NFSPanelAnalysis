*******************************************
* Create silage_ha
*******************************************


capture drop CROP_CODE
gen CROP_CODE = 9231

keep FARM_CODE YE_AR CROP_CODE d_adj_hectarage_of_silage_ha


