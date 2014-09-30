*******************************************
* Create merged_crop_tables_0
*******************************************


drop if CROP_CODE == .

****IN ORDER TO ADD THE HECTARES FOR PASTURE, HAY AND SILAGE FROM ABOVE TO CY_HECTARES_HA: 

replace CY_HECTARES_HA = pas_hay_sil_ha if  CROP_CODE == 9211 | CROP_CODE == 9221 | CROP_CODE == 9231

drop enter_nfs exit_nfs
capture drop temp
gen temp=1






