*******************************************
* Create pasture_hay_silage_ha
*******************************************

order FARM_CODE YE_AR CROP_CODE d_pasture_adj_for_hay_silage_ha d_adjusted_hectarage_of_hay_ha d_adj_hectarage_of_silage_ha

sort FARM_CODE YE_AR CROP_CODE


gen pas_hay_sil_ha = d_pasture_adj_for_hay_silage_ha if CROP_CODE== 9211

replace pas_hay_sil_ha = d_adjusted_hectarage_of_hay_ha if CROP_CODE== 9221

replace pas_hay_sil_ha = d_adj_hectarage_of_silage_ha if CROP_CODE== 9231


keep FARM_CODE YE_AR CROP_CODE pas_hay_sil_ha


