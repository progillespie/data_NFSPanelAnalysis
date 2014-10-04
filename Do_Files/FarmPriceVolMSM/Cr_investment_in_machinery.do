*******************************************
* Create investment_in_machinery
*******************************************

* CHANGE-8412: Investment variable created (new Cr file)
*  Modelled off of analagous depreciation code.

* CHANGE-8412: REPLACE_NET_VALUE named appropriately no correction needed


by  FARM_CODE YE_AR: egen pma_REPLACE_NET_VALUE = sum(REPLACE_NET_VALUE) if ASSET_CLASS == "PMA"
by  FARM_CODE YE_AR: egen oma_REPLACE_NET_VALUE = sum(REPLACE_NET_VALUE) if ASSET_CLASS == "OMA"

by  FARM_CODE YE_AR: egen m_pma_REPLACE_NET_VALUE = max(pma_REPLACE_NET_VALUE) 
by  FARM_CODE YE_AR: egen m_oma_REPLACE_NET_VALUE = max(oma_REPLACE_NET_VALUE) 

by  FARM_CODE YE_AR: egen rnk = rank(YE_AR),unique

keep if rnk == 1

drop rnk

keep  FARM_CODE YE_AR m_pma_REPLACE_NET_VALUE m_oma_REPLACE_NET_VALUE

mvencode *, mv(0) override

gen d_investment_in_machinery_eu = 0
replace d_investment_in_machinery_eu = m_pma_REPLACE_NET_VALUE + m_oma_REPLACE_NET_VALUE

