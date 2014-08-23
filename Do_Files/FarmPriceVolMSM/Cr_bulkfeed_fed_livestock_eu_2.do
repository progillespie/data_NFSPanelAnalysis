*******************************************
* Create bulkyfeed_fedto_livestock_eu_2
*******************************************

sort FARM_CODE YE_AR
by  FARM_CODE YE_AR: egen s_bulkfeed_allocdairy_eu = sum(s_b_ALLOC_DAIRY_HERD_EU)
by  FARM_CODE YE_AR: egen s_bulkfeed_alloccattle_eu = sum(s_b_ALLOC_CATTLE_EU)
by  FARM_CODE YE_AR: egen s_bulkfeed_allocsheep_eu = sum(s_b_ALLOC_SHEEP_EU)
by  FARM_CODE YE_AR: egen s_bulkfeed_allochorses_eu = sum(s_b_ALLOC_HORSES_EU)
by  FARM_CODE YE_AR: egen s_bulkfeed_allocdeer_eu = sum(s_b_ALLOC_DEER_EU)
by  FARM_CODE YE_AR: egen s_bulkfeed_allocgoats_eu = sum(s_b_ALLOC_GOATS_EU)


by  FARM_CODE YE_AR: egen rnk = rank(YE_AR),unique

keep if temp==1
drop temp

