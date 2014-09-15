*******************************************
* Create hired_labour_casual_excl
*******************************************

sort FARM_CODE YE_AR

mvencode *, mv(0) override

gen d_hired_labour_casual_excl_eu = 0
replace d_hired_labour_casual_excl_eu = s_WAGES_PAID_EU + s_SOCIAL_SECURITY_PAID_EU + CASUAL_LABOUR_NON_ALLOCABLE_EU
