*******************************************
* Total crop hectarages, yields, etc for each farm-year 
*******************************************

* CHANGE-7983: Hectarages and yields variables created (new Cr file)

keep FARM_CODE YE_AR CY_HECTARES_HA CROP_CODE

* Drop obs with duplicated CROP_CODE within same farm-year
duplicates drop FARM_CODE YE_AR CROP_CODE, force


* Create separate HA var for each value of CROP_CODE
reshape wide CY_HECTARES_HA, i(FARM_CODE YE_AR) j(CROP_CODE)


* Only keep vars with 4 digit CROP_CODE suffixes
keep FARM_CODE YE_AR CY_HECTARES_HA????


* Change missing values to 0's
mvencode _all, mv(0) override


* HA for each crop in their own var now. Now sum each crop HA within
*  each farm-year to match panel structure of main data. The numbers
*  below are the particular CROP_CODE's we need for SMDS calc. Will 
*  keep only these and the by() vars. 
collapse (sum) *1321 (sum) *1311 (sum) *11?? (sum) *157?, by(FARM_CODE YE_AR*)
