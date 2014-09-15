*******************************************
* Create depreciation_of_land_imps
*******************************************

* CHANGE-7983: rename HIST_DEP_VALUE REPLACE_DEP_VALUE
*   Had named the depreciation value in the raw data as HIST because
*   I supposed that this was more appropriate (there were changes to 
*   treatment of depreciation). Doing the renaming here to call
*   call attention to it for later (maybe we'll want to recalc?). 
rename HIST_DEP_VALUE REPLACE_DEP_VALUE


by  FARM_CODE YE_AR: egen lan_REPLACE_DEP_VALUE = sum(REPLACE_DEP_VALUE) if ASSET_CLASS == "LAN"

by  FARM_CODE YE_AR: egen m_lan_REPLACE_DEP_VALUE = max(lan_REPLACE_DEP_VALUE) 

by  FARM_CODE YE_AR: egen rnk = rank(YE_AR),unique

keep if rnk == 1

drop rnk

keep  FARM_CODE YE_AR m_lan_REPLACE_DEP_VALUE

mvencode *, mv(0) override

gen d_depreciation_of_land_imps_eu = m_lan_REPLACE_DEP_VALUE
