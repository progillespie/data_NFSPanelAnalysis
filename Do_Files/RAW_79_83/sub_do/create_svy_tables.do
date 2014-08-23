* Make 79 - 83 data compatible with John Lennon's ConvertIBDataSet
*  code. 

* Approach taken: 
* Read spreadsheets, then save them in same structure as 
*  svy_tables in ConvertIBDataSet directory

local startdir: pwd
local dodir  "D:/Data/data_NFSPanelAnalysis/Do_Files/RAW_79_83/sub_do"
local outdatadir "D:/Data/data_NFSPanelAnalysis/OutData/RAW_79_83"
local svydir "D:/Data/data_NFSPanelAnalysis/OrigData/ConvertIBDataSet"

capture mkdir `outdatadir'/svy_tables_7983

use `outdatadir'/nfs_7983, clear
drop closingInv


qui ds
local vlist `r(varlist)'


foreach var of local vlist {
    local lowervar = lower("`var'")
    rename `var' `lowervar'
}

rename farmcode farm_code
rename year     ye_ar
rename dairy_cows_sh_bulls_xfer_in_no dairy_cows_sh_bulls_transfer_in_
rename dairy_cows_sh_bulls_xfer_in_eu dairy_cows_sh_bulls_transfer_in0
rename dairy_cows_sh_bulls_xfer_out_no dairy_cows_sh_bulls_transfer_out
rename dairy_cows_sh_bulls_xfer_out_eu dairy_cows_sh_bulls_transfer_ou0
rename cattle_calves_6m_1yr_op_inv_no  cattle_calves_6mths_1yr_op_inv_n
rename cattle_calves_6m_1yr_clos_inv_no cattle_calves_6mths_1yr_clos_inv
rename cattle_calves_6m_1yr_op_inv_eu cattle_calves_6mths_1yr_op_inv_e
rename cattle_calves_6m_1yr_clos_inv_eu cattle_calves_6mths_1yr_clos_in0
rename cattle_calves_lt6m_clos_inv_no cattle_calves_lt6mths_clos_inv_n
rename cattle_calves_lt6m_clos_inv_eu cattle_calves_lt6mths_clos_inv_e
rename cattle_breed_replace_purch_no cattle_breed_replacements_purcha 
rename cattle_breed_replace_purch_eu cattle_breed_replacements_purch0
rename cattle_rcpt_bull_services_eu cattle_receipts_for_bull_servic0
rename cattle_breed_herd_culls_sales_no cattle_breeding_herd_culls_sales
rename cattle_breed_herd_culls_sales_eu cattle_breeding_herd_culls_sale0
rename cas_lab_non_allocable_eu casual_labour_non_allocable_eu
rename cas_lab_total_alloc_eu casual_labour_total_allocated_eu
rename perm_crops_orig_gross_cost_eu permanent_crops_orig_gross_cost_
rename perm_crops_orig_grants_eu permanent_crops_orig_grants1_eu
rename perm_crops_improve_grants_eu permanent_crops_impr_grants1_eu
rename perm_crops_major_improvements_eu permanent_crops_major_improvemen
rename perm_crops_grantrecprevyear permanent_crops_impr_grants2_eu


gen cattle_suckler_cows_op_inv_no = 0
gen cattle_suckler_cows_op_inv_eu = 0
gen cattle_suckler_cows_clos_inv_no= 0
gen cattle_suckler_cows_clos_inv_eu= 0


gen cattle_other_op_inv_no = 0
gen cattle_other_op_inv_eu = 0
gen cattle_other_clos_inv_no = 0
gen cattle_other_clos_inv_eu = 0


gen cattle_stores_male_purchases_no = 0
gen cattle_stores_male_purchases_eu = 0
gen cattle_stores_female_purchases_n = 0
gen cattle_stores_female_purchases_e = 0
gen cattle_stores_male_sales_no = 0
gen cattle_stores_male_sales_eu = 0
gen cattle_stores_female_sales_no = 0
gen cattle_stores_female_sales_eu = 0

gen cattle_finished_male_sales_no = 0
gen cattle_finished_male_sales_eu = 0
gen cattle_finished_female_sales_no = 0
gen cattle_finished_female_sales_eu = 0

gen cattle_breeding_animals_sales_no = 0
gen cattle_breeding_animals_sales_eu = 0

gen cattle_in_calf_heifers_clos_inv_= 0
gen cattle_in_calf_heifers_clos_inv0= 0

gen mth12_total_suckler_cows_no = 0

gen deaths_dairy_herd_cows_no = 0

gen total_finished_males_sales_no = 0
gen total_finished_females_sales_no = 0

gen milk_quota_own_cy_lt = 0
gen milk_quota_tot_leased_lt = 0
gen milk_quota_tot_leased_eu = 0
gen milk_quota_tot_purch_lt = 0
gen milk_quota_tot_purch_eu = 0
gen milk_quota_inherited_lt = 0
gen milk_quota_inherited_eu = 0
gen milk_quota_let_lt = 0
gen milk_quota_let_eu = 0
gen milk_quota_sold_lt = 0
gen milk_quota_sold_eu = 0
gen milk_quota_gift_given_lt = 0
gen milk_quota_gift_given_eu = 0
gen milk_quota_total_cy_lt = 0
gen super_levy_refund_eu = 0
gen super_levy_charge_eu = 0
gen leasing1_litres = 0
gen leasing1_annual_cost_eu = 0
gen leasing1_lease_length_yrs = 0
gen leasing2_litres = 0
gen leasing2_annual_cost_eu = 0
gen leasing2_lease_length_yrs = 0
gen leasing3_litres = 0
gen leasing3_annual_cost_eu = 0
gen leasing3_lease_length_yrs = 0
gen leasing_temporary_litres = 0
gen leasing_temporary_cost_eu = 0
gen qty_milk_entered_paid_not_paid_l = 0
gen val_milk_entered_paid_not_paid_e = 0
gen tot_statutory_deductions_eu = 0
gen ifa_icmsa_levy_eu = 0
gen milk_recording_costs_eu = 0
gen total_deductions_eu = 0
gen creamery_penalties_eu = 0
gen creamery_tot_butter_fat_lt = 0
gen creamery_tot_milk_protein_lt = 0
gen farmhouse_cheese_op_inv_eu = 0
gen farmhouse_cheese_sales_eu = 0
gen farmhouse_cheese_closing_inv_eu = 0
gen irish_dairy_board_levy_eu = 0
gen dairy_research_levy_eu = 0
gen disease_erradication_levy_eu = 0
gen inspection_levy_eu = 0
gen detergent_eu = 0
gen bulk_tank_rental_eu = 0
gen milk_product_promotion_eu = 0

gen cattle_subsidies_no = 1
gen cattle_receipts_for_bull_service = 1

gen deaths_cattle_all_cows_no = deaths_cattle_herd_cows_no

gen liquidmilk_sold_wholesale_retail = lqmilksoldwsale_lt + lqmilksoldretail_lt
gen liquidmilk_sold_wholesale_retai0 = lqmilksoldwsale_eu + lqmilksoldretail_eu

egen closing_date = concat(closing_day closing_month  closing_year), punct("_")


gen total_land_farmed_ha = land_farmed_ha 

gen land_value_est_beg_of_year_ha =land_value_est_beg_of_year_eu/(land_value_purchases_eu/land_value_purchases_ha)

gen land_value_est_end_of_year_ha =land_value_est_beg_of_year_ha + land_value_purchases_ha - land_value_sales_ha

gen land_value_est_end_of_year_eu =land_value_est_end_of_year_ha * (land_value_sales_eu/land_value_sales_ha)

gen farm_forestry_ha = woodland_ha
gen woodland_old_ha = woodland_ha

preserve


* Get lists of vars in each table dataset
cd `svydir'

local svy_tables: dir "." files "*.dta"
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
local svy_tables: list svy_tables - skip_tables
macro list _svy_tables

foreach table of local svy_tables {

    use `table', clear
    capture drop d_*
    capture drop i_*

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


    }
    
    qui ds
    local vlist "`r(varlist)'"
    macro list _vlist

    restore
    preserve
    
    macro list _table
    keep `vlist'
    save `outdatadir'/svy_tables_7983/`table', replace
}

cd `startdir'
