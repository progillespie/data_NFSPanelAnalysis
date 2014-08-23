* This file uses SGM vars and SGM coefficients to calculate
*  category and whole farm SGMs for the NFS/FADN
*  farm typology. 

local origdatadir "D:\\Data/data_NFSPanelAnalysis/OrigData/FarmPriceVolMSM"


* Crops codes taken from standard output calculation 2013.xlsx.  Brian
*   Moran sent that spreadsheet to Cathal O'Donoghue, John Lennon and
*   Patrick Gillespie. It details the calculation of SGM and SO
*   according to the EU FADN typology (which is what the NFS uses).
local wheat_codes       1111 1116 1117

local barley_codes      1141 1146 1571 1147 1577

local oats_codes        1151 1156 1157

local peas_codes        1211 1271 1291

local potatoes_codes    1311 1317

local sugarbeet_codes   1321 1327

local vegopen_codes     2211 2221 2231 2251 2261 2271 2281 2291 ///
                        2311 2321 2341 2371 2381 2431 2441 2451 /// 
                        2461 2491 2511 2531 2601 2611 2631 2651 2991

local vegglass_codes    2215 2225 2235 2255 2265 2275 2285 2295 ///
                        2315 2325 2345 2375 2385 2435 2445 2455 ///
                        2465 2495 2515 2535 2605 2615 2635 2655 2995

local fruitperm_codes   3011 3021 3031 3041 3051 3061 3071 3091 ///
                        3181 3191 3201 3211 3991

local nurseries_codes   6011

local mushrooms_codes   1391

local greenmaize_codes  9021

local roots_codes       9041 9051 9061 9071 9081

local otherplants_codes 9031

local rape_codes        1431 1436

local crop_codes `wheat_codes'  `barley_codes' `oats_codes' ///
                 `peas_codes'   `roots_codes'  `rape_codes' ///
                 `otherplants_codes' `greenmaize_codes'     ///
                 `mushrooms_codes'   `nurseries_codes'      ///
                 `fruitperm_codes'   `vegglass_codes'       /// 
                 `vegopen_codes' `sugarbeet_codes' `potatoes_codes' 





* Get crops data. Should be the merged version.
use "D:\data\Data_NFSPanelANalysis\OutData\FarmPriceVolMSM\merged_crop_tables_3", clear



* * * * * * * 
* Reshape crop data
* * * * * * * 

keep FARM_CODE YE_AR CROP_CODE CY_HECTARES_HA
* But we have repeated obs for each crop code! 
duplicates report


* Sum these to make each row unique.
collapse (sum) CY_HECTARES_HA, by(FARM_CODE YE_AR CROP_CODE)


* Each row is unique now.
duplicates report


* We still want data in wide format (variable for each crop code). 
*   Creates CY_HECTARES_HA**** where **** is the crop code
reshape wide CY_HECTARES_HA, i(FARM_CODE YE_AR) j(CROP_CODE)


* Each new var will have a lot of missing values - change to 0. 
mvencode CY_HECTARES_HA*, mv(0) override


* Build a list of the CY_HECTARE_HA vars we actually need
foreach code of local crop_codes{

  local code_vlist "`code_vlist' CY_HECTARES_HA`code'"
  
}

* Can't just keep this list though, because that would drop all the
*   non-crop vars that we want too. Have to build a list to drop.


* Get the list of the CY_HECTARE_HA vars we have in memory
qui ds CY_HECTARES_HA*
local all_crops_vlist "`r(varlist)'"


* All the crop vars not on the code_vlist can be dropped. 
local drop_vlist: list all_crops_vlist - code_vlist
macro list // for reviewing the lists


drop `drop_vlist'
ds, varwidth(32) // here's what we have in memory

* * * * * * * 

local keep_vlist ""
local keep_vlist "`keep_vlist' MTH* var*"
merge 1:1 FARM_CODE YE_AR  using `origdatadir'/svy_cattle      ,keepusing(`keep_vlist') nogen



* Here's 4 variables that look like they're missing from the data. 
*   We need these particular vars for calculate SGMs.
local rename MTH12_TOTAL_CATTLE_MALE_1_2YRS_NO   ///
             MTH12_TOTAL_CATTLE_FEMALE_1_2YRS_NO ///
             MTH12_TOTAL_CATTLE_MALE_GT2YRS_NO   ///
	     MTH12_TOTAL_CATTLE_FEMALE_GT2YRS_NO
* We actually have them, but the varnames are too long...
* Search for the var matching label, rename with shortened version 
foreach var of local rename {

  * Shorten MALE and FEMALE to bring the vars under the character limit
  local new_name = subinstr("`var'"     , "_MALE_"  , "_M_", .)
  local new_name = subinstr("`new_name'", "_FEMALE_", "_F_", .)

  qui ds, has(varlabel "`var'") // get the varname that has this label
  local anonymous_var "`r(varlist)'"

  rename `anonymous_var' `new_name' 
}



local keep_vlist "`keep_vlist' MTH*"
merge 1:1 FARM_CODE YE_AR  using `origdatadir'/svy_sheep       ,keepusing(`keep_vlist') nogen
merge 1:1 FARM_CODE YE_AR  using `origdatadir'/svy_horses_other,keepusing(`keep_vlist') nogen
merge 1:1 FARM_CODE YE_AR  using `origdatadir'/svy_pigs        ,nogen
merge 1:1 FARM_CODE YE_AR  using `origdatadir'/svy_poultry     ,nogen


* Not using the keep_vlist for this merge at the moment.
local keep_vlist ""
local keep_vlist "`keep_vlist' FALLOW_SETASIDE_HA"
local keep_vlist "`keep_vlist' TOTAL_PASTURE_HA"
local keep_vlist "`keep_vlist' ROUGH_GRAZING_HA"
merge 1:1 FARM_CODE YE_AR  using `origdatadir'/svy_farm, nogen


*TODO: Find the COUNTY_CODE, DED, and D_COUNTY_CODE in the raw data
*       and use them instead. For now, can use from 
*       dataallyears_out1.dta
merge 1:1 FARM_CODE YE_AR using "D:\\Data/data_NFSPanelAnalysis/OrigData/nfs_all/dataallyears_out1", keepusing(COUNTY_CODE D_COUNTY_CODE DED D_SAMPLE_CELL)


* For some reason D_COUNTY_CODE looks correct where COUNTY_CODE
*   clearly is not (perhaps REGION_CODE mis-named?). However, 1992
*   doesn't seem to have come through. Just use the following year to
*   fill in the blanks.
tsset FARM_CODE YE_AR
replace D_COUNTY_CODE = f.D_COUNTY_CODE if YE_AR == 1992
* TODO: this is around the time of Ag Census resampling, so double
*  check which of these years is appropriate.)


capture gen year = YE_AR
capture gen farmcode = FARM_CODE
capture gen SGMregion = 1 if D_COUNTY_CODE <  15
replace     SGMregion = 2 if D_COUNTY_CODE >= 15
