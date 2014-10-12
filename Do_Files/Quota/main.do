clear 


* Set directory macros
local startdir: pwd // save current location

local dataroot  ///
   "D:\Data\data_NFSPanelAnalysis"

local dodir      ///
   "`dataroot'\Do_Files\Quota"

local outdatadir    ///
   "`dataroot'\OutData\Quota"


local origdata79   ///
   "`dataroot'\OutData\RAW_79_83\svy_tables_7983"
local outdata79   ///
   "`dataroot'\OutData\FarmPriceVolMSM_7983"


local origdata84   ///
   "`dataroot'\OrigData\FarmPriceVolMSM\"
local outdata84   ///
   "`dataroot'\OutData\FarmPriceVolMSM\"






* ============================================================== * 
* =============== Program for building data ==================== *

capture program drop build
program define build, rclass


* Build the data from the FarmPriceVolMSM (original and my version)
args pattern

* Get list of all datasets with the word farm (lowercase)
local files2get: dir "." files "`pattern'", respectcase



* If no data loaded, use the first dataset, and remove it from list
*  NOTE: doing this step outside of the loop is more efficient.
qui count
if `r(N)' == 0 {

  local firstdata: word 1 of `files2get'
  use `firstdata', clear

  macro list _files2get _firstdata
  local file2get: list files2get - firstdata

}


* Now loop over file list to merge all desired datasets
foreach file of local files2get {

  pwd
  macro list _file

  merge 1:1 FARM_CODE YE_AR using `file', nogen update

}

* Shouldn't have any duplicates.
duplicates report FARM_CODE YE_AR

end
* =============== Program for building data ==================== *
* ============================================================== * 






* ------------------------------------------------------------------
* Use newly defined build program to make the dataset.
* ------------------------------------------------------------------

*--- Early years (based on my version) --- *
cd "`outdata79'" // Main output directory
build "*dairy*.dta"
build "*labour.dta"
build "misc_overhead_costs.dta"
build "invest*.dta"
build "svy_cattle*.dta"
build "svy_shee*.dta"
build "svy_pig*.dta"
build "svy_poultr*.dta"
build "svy_horse*.dta"
*build "total_crops_gross_output*"
build "svy_hay_silage_?.dta"


cd "1"       // Parameter subdirectory
build "*farm*.dta"
build "DAIRY*.dta"
build "*DAIRY*.dta"
build "*DAIRY*.dta"


cd "`origdata79'"         // raw data directory 
build "svy_farm.dta"
build "svy_misc_receipts_expenses.dta"
build "svy_livestock_expenses.dta"
build "svy_std_man_days.dta"



*--- Later years (based on COD version) --- *
cd "`outdata84'\1\"       // Parameter subdirectory
build "*farm*.dta"
build "DAIRY*.dta"
build "*DAIRY*.dta"

cd ..                    // Main output directory
build "*dairy*.dta"
build "*labour.dta"
build "misc_overhead_costs.dta"
build "invest*.dta"
build "svy_cattle*.dta"
build "svy_shee*.dta"
build "svy_pig*.dta"
build "svy_poultr*.dta"
build "svy_horse*.dta"
*build "total_crops_gross_output*"
build "svy_hay_silage_?.dta"
build "svy_weights_84.dta"

cd "`origdata84'"         // raw data directory 
build "svy_farm.dta"
build "svy_misc_receipts_expenses.dta"
build "svy_livestock_expenses.dta"
build "svy_std_man_days.dta"
  



* Go back to the merged crop tables to create the HA vars you need
*   for SMDS calculation, save, and merge into main dataset. Necessary
*   because these tables are multi-card, and we also have to reshape
*   that data to match the main data's panel structure.

preserve  // put main data in background

use `outdata79'/merged_crop_tables_3, clear
append using `outdata84'/merged_crop_tables_3

cd `dodir'
do Cr_HA_for_smds
save `outdatadir'/HA_for_smds.dta, replace

restore  // back to main data now

merge 1:1 FARM_CODE YE_AR using `outdatadir'/HA_for_smds.dta, nogen




* TEMPORARY - use my original code to recalculate D_FORAGE_AREA_HA
*   and D_FEED_AREA_EQUIV_HA. TODO: do this the FarmPriceVolMSM way. 
preserve

use "D:\Data\data_NFSPanelAnalysis\OutData\nfs_7983", clear
cd "D:\Data\data_NFSPanelAnalysis\Do_Files\RAW_79_83\sub_do" 
qui do D_FORAGE_AREA_HA/D_FORAGE_AREA_HA
qui do D_FEED_AREA_EQUIV_HA/D_FEED_AREA_EQUIV_HA
rename farmcode FARM_CODE
rename year YE_AR
keep FARM_CODE YE_AR D_FEED_AREA_EQUIV_HA D_FORAGE_AREA_HA
save `outdatadir'/feed_forage_ha, replace
cd `dodir'
restore

merge 1:1 FARM_CODE YE_AR using `outdatadir'/feed_forage_ha.dta, nogen update

* ------------------------------------------------------------------






* ------------------------------------------------------------------
* Minor data manipulation
* ------------------------------------------------------------------

* NFS only started using weights in 1984. Prior to this, each row
*  of the data counted equally. Implicitly, this is equivalent to 
*  each farm having the same weight (we'll use 1 as our constant). 
replace UAA_WEIGHT = 1 if YE_AR < 1984
tabstat UAA_WEIGHT, by(YE_AR)

* Use Dairy GO > 50% of farm GO as an approximation of FARM_SYSTEM 
*   for years before 1984
replace FARM_SYSTEM = 1 ///
   if d_dairy_gross_output > (0.5 * d_farm_gross_output) & ///
      YE_AR < 1984

* Define D_SOIL_GROUP for 79 - 83 data
replace D_SOIL_GROUP = 1 if ///
  YE_AR < 1984               & ///
  SOIL_CODE == 1             | ///
  SOIL_CODE == 2

replace D_SOIL_GROUP = 2 if ///
  YE_AR < 1984               & ///
  SOIL_CODE == 3             | ///
  SOIL_CODE == 4

replace D_SOIL_GROUP = 3 if ///
  YE_AR < 1984               & ///
  SOIL_CODE == 5             | ///
  SOIL_CODE == 6

qui mvencode _all, mv(0) override
cd `dodir'



*!!! Important !!!* 
* OH will be wrong throughout the 80's because the raw data is missing
*  the depreciation vars. Use the sys. generated OH for 84 - 05
foreach var of varlist d_dep* {

  local uppercase = upper("`var'")
  replace `var' = `uppercase' ///
    if YE_AR > 1983 & YE_AR < 2006

}



replace d_farm_total_overhead_costs_eu = ///
  LAND_RENTED_IN_EU                       + ///
  d_car_electricity_telephone_eu          + ///
  d_hired_labour_casual_excl_eu           + ///
  d_intrst_pay_incl_hp_interest_eu        + ///
  d_machine_operating_expenses_eu         + ///
  d_depreciation_of_machinery_eu          + ///
  d_depreciation_of_buildings_eu          + ///
  BUILDINGS_REPAIRS_UPKEEP_EU             + ///
  LAND_GENERAL_UPKEEP_EU                  + ///
  d_depreciation_of_land_imps_eu          + ///
  d_misc_overhead_costs_eu                + ///
  pm_TOTAL_COST_OF_LEASE_EU               + ///
  TOTAL_COST_OF_LEASE_EU                  + ///
  ANNUITIES_EU


* TODO: make Cr_uaa_size.do for FarmPriceVolMSM_7983
* Never defined UAA_SIZE for the 79 - 83 data.
replace UAA_SIZE =     ///
  LAND_FARMED_HA        - ///
  (WOODLAND_HA          + ///
  NON_AGRI_AREA_HA      + ///
  OTHER_LAND_USE_HA)      ///
  if YE_AR < 1984


* update age variable with sys. generated one > 84 (I made a guess at 
*   a formula for farm_md_age and added it to Cr_unpaid_labour for the 
*   FarmPriceVolMSM_7983 folder, but not the post 84 folder, where we 
*   have a collected variable). 
replace farm_md_age = FARM_MD_AGE if YE_AR > 1986

gen double d_fuel_lubs_eu = 0
replace d_fuel_lubs_eu =            ///
  MACHINERY_FUEL_LUBS_OP_INV_EU      + ///
  MACHINERY_FUEL_LUBS_PURCHASES_EU   - ///
  MACHINERY_FUEL_LUBS_CLOS_INV_EU   
  

gen double d_insurance_eu = 0
replace d_insurance_eu  =  ///
  BUILDINGS_FIRE_INSURANCE_EU + MACHINERY_INSURANCE_EU
* TEMPORARY FIX
* Formula doesn't seem to work well for > 84. Prob. difference in 
*   input table in two time periods. 
replace d_insurance_eu = D_INSURANCE_EU if YE_AR > 1983


gen double d_total_labour_units = 0
replace d_total_labour_units  =   ///
  d_labour_units_paid              + ///
  d_labour_units_unpaid              


gen double d_crop_livestock_gross_output_eu = 0
replace d_crop_livestock_gross_output_eu = ///
  d_total_livestock_gross_output            + ///
  d_total_crops_gross_output_eu
  


do smds

quietly {

  * Unwanted vars. Capture prevents error if var isn't in data.
  capture drop `var' s_b_* 
  capture drop `var' vs_*  
  capture drop `var' dvs_*
  capture drop `var' dps_*
  capture drop `var' ps_*
  capture drop `var' nonzero*
  capture drop `var' hasvar*
  capture drop `var' rnk 
  capture drop `var' card 
  capture drop `var' lagval 
  capture drop `var' origsubset 
  capture drop `var' bulkfeed_cond
  capture drop if FARM_CODE == 0
  capture drop if missing(FARM_CODE)

}



* Rough sample selection. Farms based on percentile of OH (approx.
*   mainly dairy farm definition).
foreach YYYY in 1979 1980 1981 1982 1983 { 

  qui summ d_farm_total_overhead_costs_eu if YE_AR == `YYYY', detail
  scalar define sc_OH`YYYY' = `r(p90)'
  scalar list sc_OH`YYYY'

  drop if                                       ///
    d_farm_total_overhead_costs_eu > sc_OH`YYYY' & ///
    YE_AR == `YYYY'                              & ///
    FARM_SYSTEM == 1

}

* ------------------------------------------------------------------






* ------------------------------------------------------------------
* Descriptives
* ------------------------------------------------------------------
describe

* -------------------
* Financial Summary 
* -------------------
rename d_farm_gross_output            FarmGO
rename d_farm_direct_costs            FarmDC
rename d_farm_gross_margin            FarmGM
rename d_farm_total_overhead_costs_eu FarmOH
rename d_farm_family_income           FarmFFI
tabstat                 ///
    FarmGO                 ///
    FarmDC                 ///
    FarmGM                 ///
    FarmOH                 ///
    FarmFFI                ///
  if FARM_SYSTEM == 1 & ///
  D_SOIL_GROUP < 3      ///
  [weight=UAA_WEIGHT]   ///
  , by(YE_AR)
rename FarmGO  d_farm_gross_output
rename FarmDC  d_farm_direct_costs
rename FarmGM  d_farm_gross_margin
rename FarmOH  d_farm_total_overhead_costs_eu
rename FarmFFI d_farm_family_income



* -------------------
* GO decomposition
* -------------------
tabstat                           /// 
    d_farm_gross_output              /// 
    SINGLE_FARM_PAYMENT_NET_VALUE_EU /// 
    SUPER_LEVY_CHARGE_EU             /// 
    SHEEP_WELFARE_SCHEME_TOTAL_EU    /// 
    d_inter_enterpise_transfers_eu   /// 
    d_total_livestock_gross_output   /// 
    OTHER_RECEIPTS_IN_CASH_EU        /// 
    OTHER_SUBS_PAYMENTS_TOTAL_EU     /// 
    PROTEIN_PAYMENTS_TOTAL_EU        /// 
    OTHER_RECEIPTS_IN_KIND_EU        /// 
    LAND_LET_OUT_EU                  /// 
    d_total_crops_gross_output_eu    /// 
    SALE_OF_TURF_VALUE_EU            /// 
    MILK_QUOTA_LET_EU                /// 
    MISC_GRANTS_SUBSIDIES_EU         /// 
    USED_IN_HOUSE_OTHER_EU           /// 
    SUPER_LEVY_REFUND_EU             /// 
  if FARM_SYSTEM ==1              /// 
  [weight=UAA_WEIGHT]             /// 
  , by(YE_AR)



* -------------------
* DC decomposition
* -------------------
tabstat                          /// 
    d_farm_direct_costs             /// 
    d_poultry_total_direct_costs_eu /// 
    dc_fodder_crops_sold_eu         /// 
    csh_crp_op_inv_fed_eu_1         /// 
    d_horses_direct_costs_eu        /// 
    d_dc_inv_misc_csh_crop          /// 
    csh_crp_cy_fed_eu_1             /// 
    d_dairy_total_direct_costs_eu   /// 
    d_other_direct_costs_eu         /// 
    d_dc_select_crops               /// 
    s_home_grown_seed_value_eu      /// 
    d_cattle_total_direct_costs_eu  /// 
    d_total_livestock_direct_costs  /// 
    oth_csh_crop_dc                 /// 
    d_milk_fed_to_livestock_eu      /// 
    d_sheep_total_direct_costs_eu   /// 
    waste_hay_dc                    /// 
    s_setaside_dc                   /// 
    d_inter_enterpise_transfers_eu  /// 
    d_pigs_total_direct_costs_eu    /// 
    waste_sil_dc                    /// 
    d_total_crops_direct_costs_eu   /// 
  if FARM_SYSTEM == 1 &          /// 
  D_SOIL_GROUP < 3               /// 
  [weight=UAA_WEIGHT]            /// 
  , by(YE_AR)



* -------------------
* OH decomposition
* -------------------
tabstat                           /// 
    d_farm_total_overhead_costs_eu   /// 
    d_depreciation_of_machinery_eu   /// 
    BUILDINGS_REPAIRS_UPKEEP_EU      /// 
    TOTAL_COST_OF_LEASE_EU           /// 
    LAND_RENTED_IN_EU                /// 
    LAND_GENERAL_UPKEEP_EU           /// 
    d_car_electricity_telephone_eu   /// 
    ANNUITIES_EU                     /// 
    d_machine_operating_expenses_eu  /// 
    d_depreciation_of_buildings_eu   /// 
    d_hired_labour_casual_excl_eu    /// 
    d_misc_overhead_costs_eu         /// 
    d_depreciation_of_land_imps_eu   /// 
    d_intrst_pay_incl_hp_interest_eu /// 
    pm_TOTAL_COST_OF_LEASE_EU        /// 
  if FARM_SYSTEM == 1 &           /// 
  D_SOIL_GROUP < 3                /// 
  [weight=UAA_WEIGHT]             /// 
  , by(YE_AR)



* -------------------
* Farm structures
* -------------------
tabstat                  ///
    UAA_SIZE                ///
    LAND_FARMED_HA          ///
    WOODLAND_HA             ///
    NON_AGRI_AREA_HA        ///
    OTHER_LAND_USE_HA       ///
  if FARM_SYSTEM == 1 &  /// 
  D_SOIL_GROUP < 3       /// 
  [weight=UAA_WEIGHT]    /// 
  , by(YE_AR)


gen double sh_owned   = LAND_OWNED        / UAA_SIZE
gen double sh_rented  = LAND_RENTED_IN_HA / UAA_SIZE
gen double sh_let     = LAND_LET_OUT_HA   / UAA_SIZE
gen double sh_pasture = TOTAL_PASTURE_HA  / UAA_SIZE

tabstat                        ///
    sh_*                          ///
    COMMONAGE*                    ///
    MILK_QUOTA*                   ///
    FARM_MD*                   ///
    FARM*EDUC*                 ///
    DEROGATION*                ///
  if FARM_SYSTEM == 1 &        /// 
  D_SOIL_GROUP < 3             /// 
  [weight=UAA_WEIGHT]          /// 
  , by(YE_AR)


tabstat                        ///
    D_SOIL_GROUP                  ///
  if FARM_SYSTEM == 1          /// 
  [weight=UAA_WEIGHT]          /// 
  , by(YE_AR)



* D_INVESTMENT_IN_LAND_IMPROVEMENTS too long, given "var145". Fix that.
rename var145  D_INVESTMENT_IN_LAND_IMPROVEMENT 

* Update the calculated vars with values from IB where we have them
foreach var of varlist *invest* {

  local uppercase = upper("`var'")
  replace `var' = `uppercase' if YE_AR > 1983

}


* -------------------
* Panel descriptives
* -------------------

* Declare panel structure
sort FARM_CODE YE_AR
qui xtset FARM_CODE YE_AR

xtdescribe
xtsum                            ///
  d_farm_gross_output               ///
  d_dairy_gross_output              ///
  d_farm_direct_costs               ///
  d_dairy_total_direct_costs_eu     ///
  d_farm_total_overhead_costs_eu

* ------------------------------------------------------------------


* Graph of investment variables
preserve
collapse *invest* if FARM_SYSTEM == 1 & D_SOIL_GROUP < 3 [weight = UAA_WEIGHT ], by(YE_AR )
tw (line d_investment_in_buildings YE_AR)  ///
   (line d_investment_in_machinery YE_AR ) ///
   (line d_investment_in_land_improvement YE_AR ) ///
   , legend(label(1 "Buildings") ///
            label(2 "Machinery") ///
            label(3 "Land Imp."))
restore



* ------------------------------------------------------------------
* Switching to SAS varnames
* ------------------------------------------------------------------


* Make all varnames upper case only
qui ds 
local vlist "`r(varlist)'"
foreach var of local vlist {

  local uppercase = upper("`var'")
  
  capture rename `var' `uppercase' 

  if _rc != 0 {

    drop `uppercase'
    rename `var' `uppercase' 

  }

}

save `outdatadir'/data_for_dairydofile, replace

do dairydofile.do


* Change to SAS varnames
*qui do renameIB2SAS.do

* ------------------------------------------------------------------
