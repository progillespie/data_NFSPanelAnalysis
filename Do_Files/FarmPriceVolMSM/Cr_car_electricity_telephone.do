*******************************************
* Create car_electricity_telephone
*******************************************


sort FARM_CODE YE_AR

keep FARM_CODE YE_AR ELECTRICITY_FARM_SHARE_EU TELEPHONE_FARM_SHARE_EU TOTAL FARM_SHARE_PERCENTAGE

mvencode *, mv(0) override

gen d_car_electricity_telephone_eu = 0
replace d_car_electricity_telephone_eu = ELECTRICITY_FARM_SHARE_EU + TELEPHONE_FARM_SHARE_EU + ((TOTAL * FARM_SHARE_PERCENTAGE) / 100)
