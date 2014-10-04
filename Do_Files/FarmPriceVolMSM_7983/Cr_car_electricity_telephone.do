*******************************************
* Create car_electricity_telephone
*******************************************


sort FARM_CODE YE_AR
* CHANGE-7983: keep - Removed TOTAL_MISC_EXPENSES_EU (FARM_SHARE_PERCENTAGE really car expenses in euro for 79-83 data)
keep FARM_CODE YE_AR ELECTRICITY_FARM_SHARE_EU TELEPHONE_FARM_SHARE_EU FARM_SHARE_PERCENTAGE

mvencode *, mv(0) override

gen d_car_electricity_telephone_eu = 0

* CHANGE-7983: FARM_SHARE_PERCENTAGE is really euro expense, not a share for this data
*replace d_car_electricity_telephone_eu = ELECTRICITY_FARM_SHARE_EU + TELEPHONE_FARM_SHARE_EU + ((TOTAL * FARM_SHARE_PERCENTAGE) / 100)
replace d_car_electricity_telephone_eu = ELECTRICITY_FARM_SHARE_EU + TELEPHONE_FARM_SHARE_EU + FARM_SHARE_PERCENTAGE
