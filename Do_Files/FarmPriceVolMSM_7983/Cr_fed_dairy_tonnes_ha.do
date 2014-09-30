*******************************************
* Create fed_dairy_tonnes_ha
*******************************************


by  FARM_CODE YE_AR: egen rnk = rank(YE_AR),unique

keep if rnk == 1

drop rnk

keep FARM_CODE YE_AR sil_fed_dairy_tns_ha_1 hay_fed_dairy_tns_ha_1 asil_fed_dairy_tns_ha_1 fdrbt_fed_dairy_tns_ha_1 sgrbt_fed_dairy_tns_ha_1 mz_sil_fed_dairy_tns_ha_1 ots_shf_fed_dairy_tns_ha_1 mgolds_fed_dairy_tns_ha_1 rseed_fed_dairy_tns_ha_1 stw_fed_dairy_tns_ha_1 sug_fed_dairy_tns_ha_1 kale_fed_dairy_tns_ha_1 ptn_beans_peas_fed_dairy_2 potato_fed_dairy_2 

sort FARM_CODE YE_AR 
