*******************************************
* Create sum_i_conc_fed_horses
*******************************************
by  FARM_CODE YE_AR: egen s_i_concentrates_fed_horses = sum(i_concentrates_fed_horses)

by  FARM_CODE YE_AR: egen rnk = rank(YE_AR),unique

keep if rnk == 1

drop rnk

keep FARM_CODE YE_AR s_i_concentrates_fed_horses

sort FARM_CODE YE_AR 

