* Make 79 - 83 data compatible with John Lennon's ConvertIBDataSet
*  code. 

* Approach taken: 
* Read spreadsheets, then save them in same structure as 
*  svy_tables in ConvertIBDataSet directory

local startdir: pwd
local dodir  "D:/Data/data_NFSPanelAnalysis/Do_Files/RAW_79_83/sub_do"
local outdatadir "D:/Data/data_NFSPanelAnalysis/OutData/RAW_79_83"
local svydir "D:\Data\data_NFSPanelAnalysis\OrigData\FarmPriceVolMSM\"
*local svydir "D:/Data/data_NFSPanelAnalysis/OrigData/ConvertIBDataSet"

capture mkdir `outdatadir'/svy_tables_7983

use `outdatadir'/nfs_7983, clear
drop closingInv


qui ds
local vlist `r(varlist)'


capture gen YE_AR    = year
capture gen FARM_CODE= farmcode

foreach var of local vlist {
    local uppervar = upper("`var'")
    rename `var' `uppervar'
}



rename DAIRY_COWS_SH_BULLS_XFER_IN_NO    ///
       DAIRY_COWS_SH_BULLS_TRANSFER_IN_

rename DAIRY_COWS_SH_BULLS_XFER_IN_EU    ///
       DAIRY_COWS_SH_BULLS_TRANSFER_IN0

rename DAIRY_COWS_SH_BULLS_XFER_OUT_NO   ///
       DAIRY_COWS_SH_BULLS_TRANSFER_OUT

rename DAIRY_COWS_SH_BULLS_XFER_OUT_EU   ///
       DAIRY_COWS_SH_BULLS_TRANSFER_OU0

rename CATTLE_CALVES_6M_1YR_OP_INV_NO    ///
       CATTLE_CALVES_6MTHS_1YR_OP_INV_N

rename CATTLE_CALVES_6M_1YR_CLOS_INV_NO  ///
       CATTLE_CALVES_6MTHS_1YR_CLOS_INV

rename CATTLE_CALVES_6M_1YR_OP_INV_EU    ///
       CATTLE_CALVES_6MTHS_1YR_OP_INV_E

rename CATTLE_CALVES_6M_1YR_CLOS_INV_EU  ///
       CATTLE_CALVES_6MTHS_1YR_CLOS_IN0

rename CATTLE_CALVES_LT6M_CLOS_INV_NO    ///
       CATTLE_CALVES_LT6MTHS_CLOS_INV_N

rename CATTLE_CALVES_LT6M_CLOS_INV_EU    ///
       CATTLE_CALVES_LT6MTHS_CLOS_INV_E

rename CATTLE_BREED_REPLACE_PURCH_NO     ///
       CATTLE_BREED_REPLACEMENTS_PURCHA 

rename CATTLE_BREED_REPLACE_PURCH_EU     ///
       CATTLE_BREED_REPLACEMENTS_PURCH0

rename CATTLE_RCPT_BULL_SERVICES_EU      ///
       CATTLE_RECEIPTS_FOR_BULL_SERVIC0

rename CATTLE_BREED_HERD_CULLS_SALES_NO  ///
       CATTLE_BREEDING_HERD_CULLS_SALES

rename CATTLE_BREED_HERD_CULLS_SALES_EU  ///
       CATTLE_BREEDING_HERD_CULLS_SALE0

rename CAS_LAB_NON_ALLOCABLE_EU          ///
       CASUAL_LABOUR_NON_ALLOCABLE_EU

rename CAS_LAB_TOTAL_ALLOC_EU            ///
       CASUAL_LABOUR_TOTAL_ALLOCATED_EU

rename PERM_CROPS_ORIG_GROSS_COST_EU     ///
       PERMANENT_CROPS_ORIG_GROSS_COST_

rename PERM_CROPS_ORIG_GRANTS_EU         ///
       PERMANENT_CROPS_ORIG_GRANTS1_EU

rename PERM_CROPS_IMPROVE_GRANTS_EU      ///
       PERMANENT_CROPS_IMPR_GRANTS1_EU

rename PERM_CROPS_MAJOR_IMPROVEMENTS_EU  ///
       PERMANENT_CROPS_MAJOR_IMPROVEMEN

rename PERM_CROPS_GRANTRECPREVYEAR       ///
       PERMANENT_CROPS_IMPR_GRANTS2_EU


gen CATTLE_SUCKLER_COWS_OP_INV_NO   =  0 
gen CATTLE_SUCKLER_COWS_OP_INV_EU   =  0 
gen CATTLE_SUCKLER_COWS_CLOS_INV_NO =  0 
gen CATTLE_SUCKLER_COWS_CLOS_INV_EU =  0 


gen CATTLE_OTHER_OP_INV_NO           = 0
gen CATTLE_OTHER_OP_INV_EU           = 0
gen CATTLE_OTHER_CLOS_INV_NO         = 0
gen CATTLE_OTHER_CLOS_INV_EU         = 0


gen CATTLE_STORES_MALE_PURCHASES_NO  = 0
gen CATTLE_STORES_MALE_PURCHASES_EU  = 0
gen CATTLE_STORES_FEMALE_PURCHASES_N = 0
gen CATTLE_STORES_FEMALE_PURCHASES_E = 0
gen CATTLE_STORES_MALE_SALES_NO      = 0
gen CATTLE_STORES_MALE_SALES_EU      = 0
gen CATTLE_STORES_FEMALE_SALES_NO    = 0
gen CATTLE_STORES_FEMALE_SALES_EU    = 0

gen CATTLE_FINISHED_MALE_SALES_NO    = 0
gen CATTLE_FINISHED_MALE_SALES_EU    = 0
gen CATTLE_FINISHED_FEMALE_SALES_NO  = 0
gen CATTLE_FINISHED_FEMALE_SALES_EU  = 0

gen CATTLE_BREEDING_ANIMALS_SALES_NO = 0
gen CATTLE_BREEDING_ANIMALS_SALES_EU = 0

gen CATTLE_IN_CALF_HEIFERS_CLOS_INV_ = 0
gen CATTLE_IN_CALF_HEIFERS_CLOS_INV0 = 0

gen MTH12_TOTAL_SUCKLER_COWS_NO      = 0

gen DEATHS_DAIRY_HERD_COWS_NO        = 0

gen TOTAL_FINISHED_MALES_SALES_NO    = 0
gen TOTAL_FINISHED_FEMALES_SALES_NO  = 0

gen MILK_QUOTA_OWN_CY_LT             = 0
gen MILK_QUOTA_TOT_LEASED_LT         = 0
gen MILK_QUOTA_TOT_LEASED_EU         = 0
gen MILK_QUOTA_TOT_PURCH_LT          = 0
gen MILK_QUOTA_TOT_PURCH_EU          = 0
gen MILK_QUOTA_INHERITED_LT          = 0
gen MILK_QUOTA_INHERITED_EU          = 0
gen MILK_QUOTA_LET_LT                = 0
gen MILK_QUOTA_LET_EU                = 0
gen MILK_QUOTA_SOLD_LT               = 0
gen MILK_QUOTA_SOLD_EU               = 0
gen MILK_QUOTA_GIFT_GIVEN_LT         = 0
gen MILK_QUOTA_GIFT_GIVEN_EU         = 0
gen MILK_QUOTA_TOTAL_CY_LT           = 0
gen SUPER_LEVY_REFUND_EU             = 0
gen SUPER_LEVY_CHARGE_EU             = 0
gen LEASING1_LITRES                  = 0
gen LEASING1_ANNUAL_COST_EU          = 0
gen LEASING1_LEASE_LENGTH_YRS        = 0
gen LEASING2_LITRES                  = 0
gen LEASING2_ANNUAL_COST_EU          = 0
gen LEASING2_LEASE_LENGTH_YRS        = 0
gen LEASING3_LITRES                  = 0
gen LEASING3_ANNUAL_COST_EU          = 0
gen LEASING3_LEASE_LENGTH_YRS        = 0
gen LEASING_TEMPORARY_LITRES         = 0
gen LEASING_TEMPORARY_COST_EU        = 0
gen QTY_MILK_ENTERED_PAID_NOT_PAID_L = 0
gen VAL_MILK_ENTERED_PAID_NOT_PAID_E = 0
gen TOT_STATUTORY_DEDUCTIONS_EU      = 0
gen IFA_ICMSA_LEVY_EU                = 0
gen MILK_RECORDING_COSTS_EU          = 0
gen TOTAL_DEDUCTIONS_EU              = 0
gen CREAMERY_PENALTIES_EU            = 0
gen CREAMERY_TOT_BUTTER_FAT_LT       = 0
gen CREAMERY_TOT_MILK_PROTEIN_LT     = 0
gen FARMHOUSE_CHEESE_OP_INV_EU       = 0
gen FARMHOUSE_CHEESE_SALES_EU        = 0
gen FARMHOUSE_CHEESE_CLOSING_INV_EU  = 0
gen IRISH_DAIRY_BOARD_LEVY_EU        = 0
gen DAIRY_RESEARCH_LEVY_EU           = 0
gen DISEASE_ERRADICATION_LEVY_EU     = 0
gen INSPECTION_LEVY_EU               = 0
gen DETERGENT_EU                     = 0
gen BULK_TANK_RENTAL_EU              = 0
gen MILK_PRODUCT_PROMOTION_EU        = 0

gen CATTLE_SUBSIDIES_NO              = 1
gen CATTLE_RECEIPTS_FOR_BULL_SERVICE = 1

gen DEATHS_CATTLE_ALL_COWS_NO = DEATHS_CATTLE_HERD_COWS_NO

gen LIQUIDMILK_SOLD_WHOLESALE_RETAIL = LQMILKSOLDWSALE_LT + LQMILKSOLDRETAIL_LT
gen LIQUIDMILK_SOLD_WHOLESALE_RETAI0 = LQMILKSOLDWSALE_EU + LQMILKSOLDRETAIL_EU

egen CLOSING_DATE = concat(CLOSING_DAY CLOSING_MONTH  CLOSING_YEAR), punct("_")


gen TOTAL_LAND_FARMED_HA = LAND_FARMED_HA 

gen LAND_VALUE_EST_BEG_OF_YEAR_HA =     ///
      LAND_VALUE_EST_BEG_OF_YEAR_EU      / ///
     (LAND_VALUE_PURCHASES_EU / LAND_VALUE_PURCHASES_HA)

gen LAND_VALUE_EST_END_OF_YEAR_HA =LAND_VALUE_EST_BEG_OF_YEAR_HA + LAND_VALUE_PURCHASES_HA - LAND_VALUE_SALES_HA

gen LAND_VALUE_EST_END_OF_YEAR_EU =LAND_VALUE_EST_END_OF_YEAR_HA * (LAND_VALUE_SALES_EU/LAND_VALUE_SALES_HA)

gen FARM_FORESTRY_HA = WOODLAND_HA
gen WOODLAND_OLD_HA = WOODLAND_HA

preserve


* Get lists of vars in each table dataset
cd `svydir'

* There's a lot of intermediate data in the FarmPriceVolMSM directory
*  quickest way to see what we actually need is to get the
*  intersection set of .dta file in this directory with files from the
*  related directory ConvertIBDataSet 
local svy_tables_1: dir                                     ///
  "D:\Data\data_NFSPanelAnalysis\OrigData\FarmPriceVolMSM\" ///
  files "*.dta"

local svy_tables_2: dir                                      ///
  "D:\Data\data_NFSPanelAnalysis\OrigData\ConvertIBDataSet\" ///
  files "*.dta"


local svy_tables: list svy_tables_1 & svy_tables_2

local skip_tables "`skip_tables' svy_asset.dta"
local skip_tables "`skip_tables' svy_buildings.dta"
local skip_tables "`skip_tables' svy_buildings_totals.dta"
local skip_tables "`skip_tables' svy_car_expenses.dta"
local skip_tables "`skip_tables' svy_crops.dta"
local skip_tables "`skip_tables' svy_crops_casual_labour.dta"
local skip_tables "`skip_tables' svy_crop_disposal.dta"
local skip_tables "`skip_tables' svy_crop_expenses.dta"
local skip_tables "`skip_tables' svy_crop_fertilizer.dta"
local skip_tables "`skip_tables' svy_deer.dta"
local skip_tables "`skip_tables' svy_weights.dta"
local skip_tables "`skip_tables' svy_unpaid_labour.dta"
local skip_tables "`skip_tables' svy_paid_labour.dta"
local skip_tables "`skip_tables' svy_paid_casual_labour.dta"
local skip_tables "`skip_tables' svy_subsidies_grants.dta"
local skip_tables "`skip_tables' svy_std_man_days.dta"
local skip_tables "`skip_tables' svy_sheep.dta"
local skip_tables "`skip_tables' svy_purchased_bulkyfeed.dta"
local skip_tables "`skip_tables' svy_power_machinery_totals.dta"
local skip_tables "`skip_tables' svy_other_machinery_totals.dta"
local skip_tables "`skip_tables' svy_pigs.dta"
local skip_tables "`skip_tables' svy_poultry.dta"
local skip_tables "`skip_tables' svy_misc_receipts_expenses.dta"
local skip_tables "`skip_tables' svy_milk_rw.dta"
local skip_tables "`skip_tables' svy_loans.dta"
local svy_tables: list svy_tables - skip_tables
macro list _svy_tables



quietly{
  foreach table of local svy_tables {
  
      noisily macro list _table
      use `table', clear
      capture drop d_*
      capture drop i_*
      capture drop var* 
      /*
      if "`table'" == "svy_cattle.dta"{
  
        drop dairy_cows_sh_bulls_sales_breedi
        drop dairy_cows_sh_bulls_sales_breed0
        drop dairy_cows_sh_bulls_sales_cull_n
        drop dairy_cows_sh_bulls_sales_cull_e
        drop dairy_cows_sh_bulls_subsidies_*
        drop dairy_support_litres
        drop dairy_disease_compensation_code
        drop dairy_disease_compensation_value
        drop cattle_disease_compensation_code
        drop cattle_disease_compensation_value
        drop jan_finished_males_sales_no
        drop feb_finished_males_sales_no
        drop mar_finished_males_sales_no
        drop apr_finished_males_sales_no
        drop may_finished_males_sales_no
        drop jun_finished_males_sales_no
        drop jul_finished_males_sales_no
        drop aug_finished_males_sales_no
        drop sep_finished_males_sales_no
        drop oct_finished_males_sales_no
        drop nov_finished_males_sales_no
        drop dec_finished_males_sales_no
        drop jan_finished_females_sales_no
        drop feb_finished_females_sales_no
        drop mar_finished_females_sales_no
        drop apr_finished_females_sales_no
        drop may_finished_females_sales_no
        drop jun_finished_females_sales_no
        drop jul_finished_females_sales_no
        drop aug_finished_females_sales_no
        drop sep_finished_females_sales_no
        drop oct_finished_females_sales_no
        drop nov_finished_females_sales_no
        drop dec_finished_females_sales_no
        drop mth12_total_cattle_male_1_2yrs_n
        drop mth12_total_cattle_female_1_2yrs_n
        drop mth12_total_cattle_male_gt2yrs_n
        drop mth12_total_cattle_female_gt2yrs
  
      }
  
  
      
      if "`table'" == "svy_farm.dta"{
  
        drop esu_size
        drop uaa_size
        drop farm_system
        drop typology_code
        drop total_sgms
        drop comparative_analysis_required
        drop unusual_circumstances
        drop ppf_participation
        drop e_profit_monitoring
        drop organic_registered
        drop organic_register_body
        drop land_use_share_percent
        drop *_md_*
        drop *_md
        drop *_spouse_*
        drop farm_household*
        drop farm_type*
        drop farm_pre_school_no
        drop *education*
        drop farm_full*  
        drop farm_part*
        drop farm_pension*
        drop farm_dole*
        drop farm_aged*
        drop long_typology_code
        drop energy_crop*
        drop category_of_owner
        drop registered_for_vat
        drop advisory_contact
        drop advisory_contact_type
        drop land_rented_pasture_ha
        drop land_rented_pasture_eu
        drop land_rented_cereals_ha
        drop land_rented_cereals_eu
        drop land_rented_pot_sugar_ha
        drop land_rented_pot_sugar_eu
        drop land_rented_other_ha
        drop land_rented_other_eu
        drop commonage_total_ha
        drop claimed_area_aid
        drop area_stocked_used
        drop permanent_crops_orig_grants2_eu
        drop permanent_crops_impr_grants3_eu
        drop permanent_crops_impr_grants4_eu
        drop land_value_installation_grants_e
        drop land_value_inheritance_acquisiti
        drop land_value_rented_from_family_ha
        drop land_value_rent_paid_to_family_e
        drop land_value_rented_from_nonfamily
        drop land_value_rent_paid_to_nonfamil
        drop land_value_acquired_by_other_mea
        drop land_value_disposed_by_other_mea
  
        *drop 
        */ 
  
      }
      
      
      qui ds
      *qui capture ds `not_vlist', not
      local vlist "`r(varlist)'"
      macro list _vlist
  
      restore
      preserve
      

      keep `vlist'
      save `outdatadir'/svy_tables_7983/`table', replace
  }
}
cd `startdir'
