*******************************************
* Create hay_silage_ha
*******************************************

gen d_adjusted_hectarage_of_hay_ha = ((HAY_1ST_GROUND_CUT_HA * HAY_1ST_CUT_PRODUCTION_PERCENT) + (HAY_2ND_GROUND_CUT_HA * HAY_2ND_CUT_PRODUCTION_PERCENT) + (HAY_3RD_GROUND_CUT_HA * HAY_3RD_CUT_PRODUCTION_PERCENT)) / 100

gen d_adj_hectarage_of_silage_ha = ((SIL_1ST_GROUND_CUT_HA * SIL_1ST_CUT_PRODUCTION_PERCENT) + (SIL_2ND_GROUND_CUT_HA * SIL_2ND_CUT_PRODUCTION_PERCENT) + (SIL_3RD_GROUND_CUT_HA * SIL_3RD_CUT_PRODUCTION_PERCENT)) / 100

keep FARM_CODE YE_AR d_adjusted_hectarage_of_hay_ha d_adj_hectarage_of_silage_ha

