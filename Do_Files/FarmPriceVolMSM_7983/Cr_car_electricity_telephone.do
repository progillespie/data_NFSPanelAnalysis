*******************************************
* Create car_electricity_telephone
*******************************************


sort FARM_CODE YE_AR
* CHANGE-7983: keep - Swapped TOTAL with TOTAL_MISC_EXPENSES_EU 
*   TOTAL is really svy_car_expenses/total (see comment below)
keep FARM_CODE YE_AR ELECTRICITY_FARM_SHARE_EU TELEPHONE_FARM_SHARE_EU TOTAL_MISC_EXPENSES_EU FARM_SHARE_PERCENTAGE

mvencode *, mv(0) override

gen d_car_electricity_telephone_eu = 0

* CHANGE-7983: replace - Swapped TOTAL with TOTAL_MISC_EXPENSES_EU 
*   TOTAL doesn't exist in 79-83 data, presumed TOTAL_MISC_EXPENSES is correct var (on same sheet).
*   Also, svy_car_expenses is set as just a copy of vars_svy_misc_receipts_expenses, because that 
*   is where FARM_SHARE_PERCENTAGE was stored historically. Other vars from this table don't 
*   exist.
*replace d_car_electricity_telephone_eu = ELECTRICITY_FARM_SHARE_EU + TELEPHONE_FARM_SHARE_EU + ((TOTAL * FARM_SHARE_PERCENTAGE) / 100)
replace d_car_electricity_telephone_eu = ELECTRICITY_FARM_SHARE_EU + TELEPHONE_FARM_SHARE_EU + ((TOTAL_MISC_EXPENSES_EU * FARM_SHARE_PERCENTAGE) / 100)
