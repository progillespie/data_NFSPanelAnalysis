*******************************************
* Total crop hectarages, yields, etc for each farm-year 
*******************************************

* CHANGE-7983: Hectarages and yields variables created (new Cr file)

local varstokeep ""
local varstokeep "`varstokeep' CY_HECTARES_HA"
local varstokeep "`varstokeep' CY_SALES_QTY_TONNES_HA"
local varstokeep "`varstokeep' CY_TOTAL_YIELD"
local varstokeep "`varstokeep' FED_DAIRY_TONNES_HA"


* Drop obs with duplicated CROP_CODE within same farm-year
duplicates drop FARM_CODE YE_AR CROP_CODE, force


local sumlist "`sumlist'"
* Loop over the vars specified above
foreach var of local varstokeep {

  * Build list of vars to sum in the collapse command at the end  
  local sumlist "`sumlist ' (sum) `var'????"

}

* Only keep vars with 4 digit CROP_CODE suffixes
keep FARM_CODE YE_AR CROP_CODE `varstokeep'

* Create separate HA var for each value of CROP_CODE
reshape wide `varstokeep' ,i(FARM_CODE YE_AR) j(CROP_CODE)



* Change missing values to 0's
mvencode _all, mv(0) override


* HA for each crop in their own var now. Now sum each crop HA within
*  each farm-year to match panel structure of main data. The numbers
*  below are the particular CROP_CODE's we need for SMDS calc. Will 
*  keep only these and the by() vars. 
collapse `sumlist', by(FARM_CODE YE_AR)
