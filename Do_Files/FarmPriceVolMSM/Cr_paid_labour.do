*******************************************
* Create paid_labour
*******************************************

by  FARM_CODE YE_AR: egen s_WAGES_PAID_EU = sum(WAGES_PAID_EU)
by  FARM_CODE YE_AR: egen s_SOCIAL_SECURITY_PAID_EU = sum(SOCIAL_SECURITY_PAID_EU)

by  FARM_CODE YE_AR: egen rnk = rank(YE_AR),unique

keep if rnk == 1

drop rnk

keep  FARM_CODE YE_AR s_WAGES_PAID_EU s_SOCIAL_SECURITY_PAID_EU

sort FARM_CODE YE_AR

mvencode *, mv(0) override
