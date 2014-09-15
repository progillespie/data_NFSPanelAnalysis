*******************************************
* Create bulkyfeed_fedto_livestock_eu_1
*******************************************

*replace BULKYFEED_COST_EU = BULKYFEED_COST_EU * sc_p_purblk

*bulky feed allocated to dairy eu

*gen bulkfeed_cond = 1 if BULKYFEED_QUANTITY > 0

*gen bulkfeed_allocdairy_eu = 0
*replace bulkfeed_allocdairy_eu = (ALLOC_DAIRY_HERD_QTY / BULKYFEED_QUANTITY) * BULKYFEED_COST_EU if bulkfeed_cond == 1

*gen bulkfeed_alloccattle_eu = 0
*replace bulkfeed_alloccattle_eu = (ALLOC_CATTLE_QTY / BULKYFEED_QUANTITY) * BULKYFEED_COST_EU if bulkfeed_cond == 1

*gen bulkfeed_allocsheep_eu = 0
*replace bulkfeed_allocsheep_eu = (ALLOC_SHEEP_QTY / BULKYFEED_QUANTITY) * BULKYFEED_COST_EU if bulkfeed_cond == 1

*gen bulkfeed_allochorses_eu = 0
*replace bulkfeed_allochorses_eu = (ALLOC_HORSES_QTY / BULKYFEED_QUANTITY) * BULKYFEED_COST_EU if bulkfeed_cond == 1

*gen bulkfeed_allocdeer_eu = 0
*replace bulkfeed_allocdeer_eu = (ALLOC_DEER_QTY / BULKYFEED_QUANTITY) * BULKYFEED_COST_EU if bulkfeed_cond == 1

*gen bulkfeed_allocgoats_eu = 0
*replace bulkfeed_allocgoats_eu = (ALLOC_GOATS_QTY / BULKYFEED_QUANTITY) * BULKYFEED_COST_EU if bulkfeed_cond == 1


*sort FARM_CODE YE_AR
*by  FARM_CODE YE_AR: egen s_bulkfeed_allocdairy_eu = sum(bulkfeed_allocdairy_eu)
*by  FARM_CODE YE_AR: egen s_bulkfeed_alloccattle_eu = sum(bulkfeed_alloccattle_eu)
*by  FARM_CODE YE_AR: egen s_bulkfeed_allocsheep_eu = sum(bulkfeed_allocsheep_eu)
*by  FARM_CODE YE_AR: egen s_bulkfeed_allochorses_eu = sum(bulkfeed_allochorses_eu)
*by  FARM_CODE YE_AR: egen s_bulkfeed_allocdeer_eu = sum(bulkfeed_allocdeer_eu)
*by  FARM_CODE YE_AR: egen s_bulkfeed_allocgoats_eu = sum(bulkfeed_allocgoats_eu)


*by  FARM_CODE YE_AR: egen rnk = rank(YE_AR),unique

*keep if rnk == 1

*drop rnk

*keep FARM_CODE YE_AR s_bulkfeed_allocdairy_eu s_bulkfeed_alloccattle_eu s_bulkfeed_allocsheep_eu s_bulkfeed_allochorses_eu s_bulkfeed_allocdeer_eu s_bulkfeed_allocgoats_eu


*******************************************
*DOING THIS BY BULKYFEED CODE 
*******************************************

sort FARM_CODE YE_AR


gen bulkfeed_cond = 1 if BULKYFEED_QUANTITY > 0

gen ALLOC_TOTAL_EU = 0
replace ALLOC_TOTAL_EU = ( ALLOC_TOTAL_QTY / BULKYFEED_QUANTITY )* BULKYFEED_COST_EU if bulkfeed_cond == 1

gen ALLOC_DAIRY_HERD_EU = 0
replace ALLOC_DAIRY_HERD_EU = (ALLOC_DAIRY_HERD_QTY / BULKYFEED_QUANTITY) * BULKYFEED_COST_EU if bulkfeed_cond == 1

gen ALLOC_CATTLE_EU = 0
replace ALLOC_CATTLE_EU = (ALLOC_CATTLE_QTY / BULKYFEED_QUANTITY) * BULKYFEED_COST_EU if bulkfeed_cond == 1

gen ALLOC_SHEEP_EU = 0
replace ALLOC_SHEEP_EU = (ALLOC_SHEEP_QTY / BULKYFEED_QUANTITY) * BULKYFEED_COST_EU if bulkfeed_cond == 1

gen ALLOC_HORSES_EU = 0
replace ALLOC_HORSES_EU = (ALLOC_HORSES_QTY / BULKYFEED_QUANTITY) * BULKYFEED_COST_EU if bulkfeed_cond == 1

gen ALLOC_DEER_EU = 0
* CHANGE-7983: leave ALLOC_DEER_EU = 0 (no replace)
*replace ALLOC_DEER_EU = (ALLOC_DEER_QTY / BULKYFEED_QUANTITY) * BULKYFEED_COST_EU if bulkfeed_cond == 1

gen ALLOC_GOATS_EU = 0
* CHANGE-7983: leave ALLOC_GOATS_EU = 0 (no replace)
*replace ALLOC_GOATS_EU = (ALLOC_GOATS_QTY / BULKYFEED_QUANTITY) * BULKYFEED_COST_EU if bulkfeed_cond == 1



****The following sums by bulkyfeed code 

sort  FARM_CODE YE_AR BULKYFEED_CODE
* CHANGE-7983: don't create s_b_`var' for DEER & GOATS
*   removed ALLOC_DEER_QTY ALLOC_DEER_EU ALLOC_GOATS_QTY 
foreach var in  BULKYFEED_COST_EU BULKYFEED_QUANTITY ALLOC_DAIRY_HERD_QTY ALLOC_DAIRY_HERD_EU ALLOC_CATTLE_QTY ALLOC_CATTLE_EU ALLOC_SHEEP_QTY ALLOC_SHEEP_EU ALLOC_HORSES_QTY ALLOC_HORSES_EU ALLOC_GOATS_EU ALLOC_TOTAL_QTY ALLOC_TOTAL_EU {
	by FARM_CODE YE_AR BULKYFEED_CODE: egen s_b_`var' = sum(`var')
}

by  FARM_CODE YE_AR BULKYFEED_CODE: egen rnk = rank( YE_AR),unique

keep if rnk == 1

* CHANGE-7983: no DEER & GOAT vars in drop
*   removed ALLOC_DEER_QTY ALLOC_DEER_EU ALLOC_GOATS_QTY D_BULKY_FEED_PURCHASED_YR_EU 
drop rnk BULKYFEED_COST_EU BULKYFEED_QUANTITY ALLOC_DAIRY_HERD_QTY ALLOC_DAIRY_HERD_EU ALLOC_CATTLE_QTY ALLOC_CATTLE_EU ALLOC_SHEEP_QTY ALLOC_SHEEP_EU ALLOC_HORSES_QTY ALLOC_HORSES_EU ALLOC_GOATS_EU ALLOC_TOTAL_QTY ALLOC_TOTAL_EU CLOS_INV_QUANTITY ALLOC_WASTE_QTY ALLOC_POULTRY_QTY ALLOC_PIGS_QTY OP_INV1_OR_PURCHASED2

gen temp=1
