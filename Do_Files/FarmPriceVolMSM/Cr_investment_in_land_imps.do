*******************************************
* Create investment_in_land_improvement
*******************************************

* CHANGE-8412: Investment variable created (new Cr file)
*  Modelled off of analagous depreciation code.

* CHANGE-8412: REPLACE_NET_VALUE named appropriately no correction needed


by  FARM_CODE YE_AR: egen lan_REPLACE_NET_VALUE = sum(REPLACE_NET_VALUE) if ASSET_CLASS == "LAN"

by  FARM_CODE YE_AR: egen m_lan_REPLACE_NET_VALUE = max(lan_REPLACE_NET_VALUE) 

by  FARM_CODE YE_AR: egen rnk = rank(YE_AR),unique

keep if rnk == 1

drop rnk

keep  FARM_CODE YE_AR m_lan_REPLACE_NET_VALUE

mvencode *, mv(0) override


* IB name is actually D_INVESTMENT_IN_LAND_IMPROVEMENTS (note the S)
*   but this is one character too long for Stata.
gen d_investment_in_land_improvement = m_lan_REPLACE_NET_VALUE

