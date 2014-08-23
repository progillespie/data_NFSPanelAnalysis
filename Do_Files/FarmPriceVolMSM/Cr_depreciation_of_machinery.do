*******************************************
* Create depreciation_of_machinery
*******************************************

by  FARM_CODE YE_AR: egen pma_REPLACE_DEP_VALUE = sum(REPLACE_DEP_VALUE) if ASSET_CLASS == "PMA"
by  FARM_CODE YE_AR: egen oma_REPLACE_DEP_VALUE = sum(REPLACE_DEP_VALUE) if ASSET_CLASS == "OMA"

by  FARM_CODE YE_AR: egen m_pma_REPLACE_DEP_VALUE = max(pma_REPLACE_DEP_VALUE) 
by  FARM_CODE YE_AR: egen m_oma_REPLACE_DEP_VALUE = max(oma_REPLACE_DEP_VALUE) 

by  FARM_CODE YE_AR: egen rnk = rank(YE_AR),unique

keep if rnk == 1

drop rnk

keep  FARM_CODE YE_AR m_pma_REPLACE_DEP_VALUE m_oma_REPLACE_DEP_VALUE

mvencode *, mv(0) override

gen d_depreciation_of_machinery_eu = 0
replace d_depreciation_of_machinery_eu = m_pma_REPLACE_DEP_VALUE + m_oma_REPLACE_DEP_VALUE

