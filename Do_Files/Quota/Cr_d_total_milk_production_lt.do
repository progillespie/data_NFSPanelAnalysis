replace LQDMLK_SOLD_WSALE_RETAIL_LT = /// 
 LqMilkSoldWSALE_LT  + ///
 LqMilkSoldRETAIL_LT   ///
 if YE_AR < 1984


capture gen double d_total_milk_production_lt = 0 
replace d_total_milk_production_lt =   ///
  WHLE_MILK_SOLD_TO_CREAMERY_LT       +  ///
  CREAMERY_FED_CALVES_LT              +  ///
  CREAMERY_FED_PIGS_LT                +  ///
  CREAMERY_FED_POULTRY_LT             +  ///
  LQDMLK_SOLD_WSALE_RETAIL_LT         +  ///
  ALLOW_WHOLE_MILK_HOUSE_LT           +  ///
  ALLOW_WHOLE_MILK_WAGES_LT           +  ///
  ALLOW_WHOLE_MILK_OTHER_LT           +  ///
  ALLOW_OTHER_DAIRY_HOUSE_LT          +  ///
  ALLOW_OTHER_DAIRY_WAGES_LT


tabstat                              ///
  d_total_milk_production_lt            ///
  D_TOTAL_MILK_PRODUCTION_LT            ///
  WHLE_MILK_SOLD_TO_CREAMERY_LT         ///
  LqMilkSoldWSALE_LT                    ///
  LqMilkSoldRETAIL_LT                   ///
  LQDMLK_SOLD_WSALE_RETAIL_LT           ///
  [weight=UAA_WEIGHT]                   ///
  ,by(YE_AR)


* Nice distribution graphs of 1983 and 1984 to illustrate production response a little better

*tw (kdensity LQDMLK_SOLD_WSALE_RETAIL_LT if YE_AR == 1983 & LQDMLK_SOLD_WSALE_RETAIL_LT > 0 [weight=UAA_WEIGHT ]) (kdensity LQDMLK_SOLD_WSALE_RETAIL_LT if YE_AR == 1984 & LQDMLK_SOLD_WSALE_RETAIL_LT > 0 [weight=UAA_WEIGHT ]), legend(label(1 "1983") label(2 "1984")) ytitle("Density") title("The distribution of liquid milk production across farms") ylabel(none)
