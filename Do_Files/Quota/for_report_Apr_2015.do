

local datasource  "D:\\Data/data_NFSPanelAnalysis"
local project     "Quota"

local dodir       "`datasource'/Do_Files/`project'"
local origdatadir "`datasource'/OutData/`project'"
local outdatadir  "`datasource'/OutData/`project'"


cd `dodir'
use "`origdatadir'/data_for_dairydofile", clear
*qui mvencode *, mv(0) override

tabstat D_FORAGE_AREA_HA D_HERD_SIZE_AVG_NO UAA_SIZE [weight = UAA_WEIGHT], by(YE_AR) stats(sum)
tabstat UAA_WEIGHT, by(YE_AR) stats(sum)
quietly {
 
* --------------------------------------------------------------------
* Create/Update variables before collapsing
* --------------------------------------------------------------------

* Vars that need the formula restated for pre-1984
replace D_LABOUR_UNITS_TOTAL =                ///
  D_LABOUR_UNITS_PAID + D_LABOUR_UNITS_UNPAID /// 
  if YE_AR < 1984


replace D_DAIRY_GROSS_MARGIN =             ///
  D_DAIRY_GROSS_OUTPUT_EU                   - ///
  D_DAIRY_TOTAL_DIRECT_COSTS_EU            ///
  if YE_AR < 1984

replace D_TOTAL_COSTS_EU =                  ///
  D_TOTAL_DIRECT_COSTS_EU                    + ///
  D_FARM_TOTAL_OVERHEAD_COSTS_EU            ///
  if YE_AR < 1984

  
  
* Allocation of OH for dairy
gen double ALLOC = 0
replace ALLOC = ///
  D_DAIRY_GROSS_OUTPUT_EU / D_FARM_GROSS_OUTPUT ///
  if D_DAIRY_GROSS_OUTPUT_EU > 0 &              ///
     D_FARM_GROSS_OUTPUT     > 0
replace ALLOC = 1 if ALLOC > 1

gen double D_DAIRY_OVERHEAD_COST     = 0
replace D_DAIRY_OVERHEAD_COST =           ///
  D_FARM_TOTAL_OVERHEAD_COSTS_EU * ALLOC  ///
  if D_FARM_TOTAL_OVERHEAD_COSTS_EU > 0    
	 
gen double D_DAIRY_TOTAL_COST = 0
replace D_DAIRY_TOTAL_COST =              ///
  D_DAIRY_OVERHEAD_COST                    + ///
  D_DAIRY_TOTAL_DIRECT_COSTS_EU

  
* Calc. net margin... not allowing neg. OH cost
*  Also initialising as equal to GM
gen double D_DAIRY_FAMILY_INCOME = D_DAIRY_GROSS_MARGIN
replace D_DAIRY_FAMILY_INCOME =                   ///
  D_DAIRY_GROSS_MARGIN - D_DAIRY_OVERHEAD_COST    ///
  if D_DAIRY_OVERHEAD_COST > 0 
  
* --------------------------------------------------------------------



* --------------------------------------------------------------------
* Create list macros and scaled vars
* --------------------------------------------------------------------
* Create list of margin vars... start with farm level      
local marginvars "`marginvars' D_FARM_GROSS_MARGIN"
local marginvars "`marginvars' D_FARM_GROSS_OUTPUT"
local marginvars "`marginvars' D_FARM_DIRECT_COSTS"
local marginvars "`marginvars' D_FARM_TOTAL_OVERHEAD_COSTS_EU"
local marginvars "`marginvars' D_FARM_FAMILY_INCOME"

* ... and now add enterprise level
local marginvars "`marginvars' D_DAIRY_GROSS_MARGIN"
local marginvars "`marginvars' D_DAIRY_GROSS_OUTPUT_EU"
local marginvars "`marginvars' D_DAIRY_TOTAL_DIRECT_COSTS_EU"
local marginvars "`marginvars' D_DAIRY_OVERHEAD_COST" 
local marginvars "`marginvars' D_DAIRY_TOTAL_COST " 
local marginvars "`marginvars' D_DAIRY_FAMILY_INCOME" 


* Different list for unit variables (divisors for scaled measures)
local unitvars   "`unitvars' D_FORAGE_AREA_HA"
local unitvars   "`unitvars' D_TOTAL_MILK_PRODUCTION_LT"
local unitvars   "`unitvars' D_DAIRY_LIVSTK_UNITS_INC_BULLS"



* For per hectare measures...
*D_FORAGE_AREA_HA                 daforare

* For per litre measures...
*D_TOTAL_MILK_PRODUCTION_LT       dotomkgl

* For per cow measures...
*D_HERD_SIZE_AVG_NO               dpavnohd OR
*D_DAIRY_LIVSTK_UNITS_INC_BULLS   dpnolu


* Create the scaled variables (i.e. per ha, lt, lu)
local scaledvars  "" // initialise a blank list
foreach var of local marginvars {

  * Copies all but last 3 letters of varname
  local shortname = ///
    substr("`var'", 1, length("`var'") - 3)
  
  * Use shortname for scaled variable's name (avoids names > 32 char)
  *   Also, initialise var at 0 and only replace if denominator is
  *   missing or is 0. Use the local macro "unit" since the 
  *   denominator is referenced 3 times in the replace command
  local unit "D_FORAGE_AREA_HA"
  gen `shortname'_ha = 0
  replace `shortname'_ha = `var'/`unit' ///
    if `unit' > 0 & !missing(`unit')
	
  local unit "D_TOTAL_MILK_PRODUCTION_LT" 
  gen `shortname'_lt = 0
  replace `shortname'_lt = `var'/`unit' ///
    if `unit' > 0 & !missing(`unit')
    *if D_TOTAL_MILK_PRODUCTION_LT > 0 & !missing(D_TOTAL_MILK_PRODUCTION_LT)
	
  local unit "D_DAIRY_LIVSTK_UNITS_INC_BULLS"
  gen `shortname'_lu = 0
  replace `shortname'_lu = `var'/`unit' ///
    if `unit' > 0 & !missing(`unit')
  
	
  * Build up a list of the vars as the loop iterates
  local scaledvars "`scaledvars' `shortname'_ha `shortname'_lt `shortname'_lu"
}

* View the list of scaled vars you just created
ds `scaledvars', v(32)

* Tables of weighted means 
tabstat `marginvars' [weight=UAA_WEIGHT ], by(YE_AR )
tabstat `unitvars'   [weight=UAA_WEIGHT ], by(YE_AR )
tabstat `scaledvars' [weight=UAA_WEIGHT ], by(YE_AR )


* --------------------------------------------------------------------




* --------------------------------------------------------------------
* Sample selection & creation of yearly cost thirds marker variable
* --------------------------------------------------------------------

* Select specialist dairy farms only
keep if ALLOC > 0.5 & !missing(ALLOC) & D_DAIRY_LIVSTK_UNITS_INC_BULLS > 10
keep if FARM_SYSTEM == 1
keep if D_UAA_PUB_SIZE_CODE > 0 & D_UAA_PUB_SIZE_CODE < 7
describe, short

* Issue with applied weights
bysort D_UAA_PUB_SIZE_CODE YE_AR : egen fixwt = max(UAA_WEIGHT)
rename UAA_WEIGHT OLD_UAA_WEIGHT
rename fixwt UAA_WEIGHT
}

tabstat D_FORAGE_AREA_HA D_HERD_SIZE_AVG_NO UAA_SIZE [weight = UAA_WEIGHT], by(YE_AR) stats(sum)
tabstat UAA_WEIGHT, by(YE_AR) stats(sum)

table YE_AR D_UAA_PUB_SIZE_CODE, c(min OLD_UAA_WEIGHT max OLD_UAA_WEIGHT)
table YE_AR D_UAA_PUB_SIZE_CODE, c(min UAA_WEIGHT max UAA_WEIGHT)

tw sc OLD_UAA_WEIGHT UAA_WEIGHT
STOP!!

qui summ YE_AR // to get the minimum and maximum year in the data
local imin = `r(min)'  // first year of data
local imax = `r(max)'  // last  year of data
gen byte ct_lt_cat = . //<- "" purposefully set to empty string
 
set more off

* Create 3 groups of farms by total costs per litre in each year
forvalues i = `imin'(1)`imax' {

	* creates grouping for the year, but missing in other years.
	xtile ct_lt_cat_`i' = D_DAIRY_TOTAL_C_lt [weight=UAA_WEIGHT] ///
	  if YE_AR == `i', nq(3)
	
	* One var that fills up as you go through the loop (no missings)
	replace ct_lt_cat = ct_lt_cat_`i' if YE_AR == `i'
	drop ct_lt_cat_`i'
	

}

/* Thia's convention is to number the categories from highest 
	    cost to lowest cost, so reassign values to match that by 
	    subtracting from 4. */ 
replace ct_lt_cat = 4 - ct_lt_cat
rename  ct_lt_cat category
label define category 1 "High" 2 "Med." 3 "Low"
label var category category

* adds the 4 digit year to front, still missing in other years
egen str year_cat = concat(YE_AR category), punct("_")
* --------------------------------------------------------------------



* --------------------------------------------------------------------
* Collapsing to means and outsheeting
* --------------------------------------------------------------------



* First for all farms per year
preserve
collapse `marginvars'                  ///
         `unitvars'                    ///
		 `scaledvars'                  ///
         D_MILK_PRICE                  ///
         D_MILK_YIELD                  ///
         D_LABOUR_INTENSITY_*          ///
		 D_LABOUR_UNITS_PAID           ///
		 D_LABOUR_UNITS_UNPAID         ///
		 D_LABOUR_UNITS_TOTAL          ///
		 D_UAA_PUB_SIZE_CODE           ///
         D_INVEST*                     ///
         [weight = UAA_WEIGHT]         /// 
		  , by(YE_AR)

macro list _outdatadir
outsheet  ///
         YE_AR                         ///
         `marginvars'                  ///
         `unitvars'                    ///
		 `scaledvars'                  ///
         D_MILK_PRICE                  ///
         D_MILK_YIELD                  ///
         D_LABOUR_INTENSITY_*          ///
		 D_LABOUR_UNITS_PAID           ///
		 D_LABOUR_UNITS_UNPAID         ///
		 D_LABOUR_UNITS_TOTAL          ///
		 D_UAA_PUB_SIZE_CODE           ///
         D_INVEST*                     ///
  using "`outdatadir'/for_dairy_report_all.csv", comma replace 

restore


* Then by cost thirds
preserve
collapse ///
         YE_AR                          ///
		 category                      ///
         `marginvars'                  ///
         `unitvars'                    ///
		 `scaledvars'                  ///
         D_MILK_PRICE                  ///
         D_MILK_YIELD                  ///
         D_LABOUR_INTENSITY_*          ///
		 D_LABOUR_UNITS_PAID           ///
		 D_LABOUR_UNITS_UNPAID         ///
		 D_LABOUR_UNITS_TOTAL          ///
		 D_UAA_PUB_SIZE_CODE           ///
         D_INVEST*                     ///
         [weight = UAA_WEIGHT]         /// 
		  , by(year_cat)

outsheet YE_AR                         ///
         category                      ///
         `marginvars'                  ///
         `unitvars'                    ///
		 `scaledvars'                  ///
         D_MILK_PRICE                  ///
         D_MILK_YIELD                  ///
         D_LABOUR_INTENSITY_*          ///
		 D_LABOUR_UNITS_PAID           ///
		 D_LABOUR_UNITS_UNPAID         ///
		 D_LABOUR_UNITS_TOTAL          ///
		 D_UAA_PUB_SIZE_CODE           ///
		 D_INVEST*                     ///
  using "`outdatadir'/for_dairy_report_thirds.csv", comma replace 
  
restore

* --------------------------------------------------------------------

gen intwt = int(UAA_WEIGHT)

log using "`outdatadir'/margins_for_report_APR_2015.txt", text replace
foreach var of local scaledvars {

  di _newline(2) "Table for `var' by year and cost third"
  table YE_AR category [weight = intwt], c(mean `var')

}
log close

view "`outdatadir'/margins_for_report_APR_2015.txt"
