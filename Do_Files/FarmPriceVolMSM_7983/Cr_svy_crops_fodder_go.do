*******************************************
* Create svy_crops_fodder_go
*******************************************


sort FARM_CODE YE_AR

keep FARM_CODE YE_AR s_fodd_op_sls_val s_fodd_cy_sls_val 

by  FARM_CODE YE_AR: egen rnk = rank( YE_AR),unique
keep if rnk == 1
drop rnk


