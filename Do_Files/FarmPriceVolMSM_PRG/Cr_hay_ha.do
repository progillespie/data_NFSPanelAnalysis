*******************************************
* Create hay_ha
*******************************************

capture drop CROP_CODE
gen CROP_CODE = 9221

keep FARM_CODE YE_AR CROP_CODE d_adjusted_hectarage_of_hay_ha

