*******************************************
* Create investment_in_livestock
*******************************************

* TODO: Define this variable!!

/*
* CHANGE-8412: Investment variable created (new Cr file)

by  FARM_CODE YE_AR: egen bld_REPLACE_NET_VALUE = sum(REPLACE_NET_VALUE) if ASSET_CLASS == "BLD"

by  FARM_CODE YE_AR: egen m_bld_REPLACE_NET_VALUE = max(bld_REPLACE_NET_VALUE) 

by  FARM_CODE YE_AR: egen rnk = rank(YE_AR),unique

keep if rnk == 1

drop rnk

keep  FARM_CODE YE_AR m_bld_REPLACE_NET_VALUE

mvencode *, mv(0) override
*/

gen d_investment_in_livestock = m_bld_REPLACE_NET_VALUE

