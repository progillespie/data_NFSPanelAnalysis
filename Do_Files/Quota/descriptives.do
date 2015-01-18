* ------------------------------------------------------------------
* Descriptives
* ------------------------------------------------------------------
args outdatadir



describe


quietly {

  capture mkdir `outdatadir'/descriptives  

  * -------------------
  * Financial Summary 
  * -------------------
  local tabname "financials.csv" 
  qui capture tabout YE_AR                           ///
    if FARM_SYSTEM == 1 & D_SOIL_GROUP < 3      ///
    [aweight=UAA_WEIGHT]                        ///
    using `outdatadir'/descriptives/`tabname'   ///
    ,  sum oneway replace style(csv)            ///
       cell(                                    ///
            mean d_farm_gross_output            ///  
            mean d_farm_direct_costs            ///    
            mean d_farm_gross_margin            ///  
            mean d_farm_total_overhead_costs_eu ///
            mean d_farm_family_income           ///
           )
  if _rc == 0 local tablist "`tablist' `tabname'"
  if _rc != 0 local prob_tablist "`prob_tablist' `tabname'"
  
  
  
  * -------------------
  * GO decomposition
  * -------------------
  local tabname "GOdecomp.csv" 
  qui capture tabout YE_AR                         ///
    if FARM_SYSTEM == 1 & D_SOIL_GROUP < 3         ///
    [aweight=UAA_WEIGHT]                           ///
    using `outdatadir'/descriptives/`tabname'      ///
    ,  sum oneway replace style(csv)               ///
       cell(                                       ///
             mean d_farm_gross_output              /// 
             mean SINGLE_FARM_PAYMENT_NET_VALUE_EU /// 
             mean SUPER_LEVY_CHARGE_EU             /// 
             mean SHEEP_WELFARE_SCHEME_TOTAL_EU    /// 
             mean d_inter_enterpise_transfers_eu   /// 
             mean d_total_livestock_gross_output   /// 
             mean OTHER_RECEIPTS_IN_CASH_EU        /// 
             mean OTHER_SUBS_PAYMENTS_TOTAL_EU     /// 
             mean PROTEIN_PAYMENTS_TOTAL_EU        /// 
             mean OTHER_RECEIPTS_IN_KIND_EU        /// 
             mean LAND_LET_OUT_EU                  /// 
             mean d_total_crops_gross_output_eu    /// 
             mean SALE_OF_TURF_VALUE_EU            /// 
             mean MILK_QUOTA_LET_EU                /// 
             mean MISC_GRANTS_SUBSIDIES_EU         /// 
             mean USED_IN_HOUSE_OTHER_EU           /// 
             mean SUPER_LEVY_REFUND_EU             /// 
           ) 
  if _rc == 0 local tablist "`tablist' `tabname'"
  if _rc != 0 local prob_tablist "`prob_tablist' `tabname'"
  
  
  * -------------------
  * DC decomposition
  * -------------------
  local tabname "DCdecomp.csv" 
  qui capture tabout YE_AR                            ///
    if FARM_SYSTEM == 1 & D_SOIL_GROUP < 3       ///
    [aweight=UAA_WEIGHT]                         ///
    using `outdatadir'/descriptives/`tabname'    ///
    ,  sum oneway replace style(csv)             ///
       cell(                                     ///
            mean d_farm_direct_costs             /// 
            mean d_poultry_total_direct_costs_eu /// 
            mean dc_fodder_crops_sold_eu         /// 
            mean csh_crp_op_inv_fed_eu_1         /// 
            mean d_horses_direct_costs_eu        /// 
            mean d_dc_inv_misc_csh_crop          /// 
            mean csh_crp_cy_fed_eu_1             /// 
            mean d_dairy_total_direct_costs_eu   /// 
            mean d_other_direct_costs_eu         /// 
            mean d_dc_select_crops               /// 
            mean s_home_grown_seed_value_eu      /// 
            mean d_cattle_total_direct_costs_eu  /// 
            mean d_total_livestock_direct_costs  /// 
            mean oth_csh_crop_dc                 /// 
            mean d_milk_fed_to_livestock_eu      /// 
            mean d_sheep_total_direct_costs_eu   /// 
            mean waste_hay_dc                    /// 
            mean s_setaside_dc                   /// 
            mean d_inter_enterpise_transfers_eu  /// 
            mean d_pigs_total_direct_costs_eu    /// 
            mean waste_sil_dc                    /// 
            mean d_total_crops_direct_costs_eu   /// 
           ) 
  if _rc == 0 local tablist "`tablist' `tabname'"
  if _rc != 0 local prob_tablist "`prob_tablist' `tabname'"
  
  
  
  * -------------------
  * OH decomposition
  * -------------------
  local tabname "OHdecomp.csv" 
  qui capture tabout YE_AR                              ///
    if FARM_SYSTEM == 1 & D_SOIL_GROUP < 3         ///
    [aweight=UAA_WEIGHT]                           ///
    using `outdatadir'/descriptives/`tabname'      ///
    ,  sum oneway replace style(csv)               ///
       cell(                                       ///
            mean d_farm_total_overhead_costs_eu    ///
            mean d_depreciation_of_machinery_eu    ///
            mean BUILDINGS_REPAIRS_UPKEEP_EU       ///
            mean TOTAL_COST_OF_LEASE_EU            ///
            mean LAND_RENTED_IN_EU                 ///
            mean LAND_GENERAL_UPKEEP_EU            ///
            mean d_car_electricity_telephone_eu    ///
            mean ANNUITIES_EU                      ///
            mean d_machine_operating_expenses_eu   ///
            mean d_depreciation_of_buildings_eu    ///
            mean d_hired_labour_casual_excl_eu     ///
            mean d_misc_overhead_costs_eu          ///
            mean d_depreciation_of_land_imps_eu    ///
            mean d_intrst_pay_incl_hp_interest_eu  ///
            mean pm_TOTAL_COST_OF_LEASE_EU         ///
           ) 
  if _rc == 0 local tablist "`tablist' `tabname'"
  if _rc != 0 local prob_tablist "`prob_tablist' `tabname'"
  
  
  
  * -------------------
  * Farm structures
  * -------------------
  local tabname "structures1.csv" 
  qui capture tabout YE_AR                           ///
    if FARM_SYSTEM == 1 & D_SOIL_GROUP < 3      ///
    [aweight=UAA_WEIGHT]                        ///
    using `outdatadir'/descriptives/`tabname'   ///
    ,  sum oneway replace style(csv)            ///
       cell(                                    ///
            mean UAA_SIZE                       ///
            mean LAND_FARMED_HA                 ///
            mean WOODLAND_HA                    ///
            mean NON_AGRI_AREA_HA               ///
            mean OTHER_LAND_USE_HA              ///
            mean D_SOIL_GROUP                   ///
           ) 
  if _rc == 0 local tablist "`tablist' `tabname'"
  if _rc != 0 local prob_tablist "`prob_tablist' `tabname'"
  
  
  gen double sh_owned   = LAND_OWNED        / UAA_SIZE
  gen double sh_rented  = LAND_RENTED_IN_HA / UAA_SIZE
  gen double sh_let     = LAND_LET_OUT_HA   / UAA_SIZE
  gen double sh_pasture = TOTAL_PASTURE_HA  / UAA_SIZE
  
  
  local tabname "structures2.csv" 
  qui capture tabout YE_AR                              ///
    if FARM_SYSTEM == 1 & D_SOIL_GROUP < 3         ///
    [aweight=UAA_WEIGHT]                           ///
    using `outdatadir'/descriptives/`tabname'      ///
    ,  sum oneway replace style(csv)               ///
       cell(                                       ///
            mean sh_owned                          ///
            mean sh_rented                         ///
            mean sh_let                            ///
            mean sh_pasture                        ///
            mean COMMONAGE_DAIRY_LU_EQUIV          ///
            mean COMMONAGE_TOTAL_HA                ///
            mean DEROGATION_GT170KGN_YN            ///
           ) 
  if _rc == 0 local tablist "`tablist' `tabname'"
  if _rc != 0 local prob_tablist "`prob_tablist' `tabname'"
  
  
  local tabname "structures3.csv" 
  qui capture tabout YE_AR                                ///
    if FARM_SYSTEM == 1 & D_SOIL_GROUP < 3           ///
    [aweight=UAA_WEIGHT]                             ///
    using `outdatadir'/descriptives/`tabname'        ///
    ,  sum oneway replace style(csv)                 ///
       cell(                                         ///
            mean FARM_MD_MARITAL_STATUS              ///
            mean FARM_MD_OTHER_GAINFUL_ACT_EMP_TY    ///
            mean FARM_MD_OCCUPATION_CODE             ///
            mean FARM_MD_INCOME_RECEIVED_CODE        ///
            mean FARM_MD_GENDER                      ///
            mean FARM_MD_PRIVATE_PUBLIC_SECTOR       ///
            mean FARM_MD_OTHER_JOB_WEEKS_NO          ///
            mean FARM_MD_AGE                         ///
            mean FARM_MD_SECTOR_CODE                 ///
            mean FARM_MD_HOURS_TYPICAL_WEEK_NO       ///
           )
  if _rc == 0 local tablist "`tablist' `tabname'"
  if _rc != 0 local prob_tablist "`prob_tablist' `tabname'"
  
  
  local tabname "structures4.csv" 
  qui capture tabout YE_AR                              ///
    if FARM_SYSTEM == 1 & D_SOIL_GROUP < 3         ///
    [aweight=UAA_WEIGHT]                           ///
    using `outdatadir'/descriptives/`tabname'      ///
    ,  sum oneway replace style(csv)               ///
       cell(                                       ///
            mean FARM_PRIMARY_EDUCATION_NO         ///
            mean FARM_SECOND_LEVEL_EDUCATION_NO    ///
            mean FARM_THIRD_LEVEL_EDUCATION_NO     ///
           )
  if _rc == 0 local tablist "`tablist' `tabname'"
  if _rc != 0 local prob_tablist "`prob_tablist' `tabname'"
  
  
  local tabname "structures5.csv" 
  qui capture tabout YE_AR                              ///
    if FARM_SYSTEM == 1 & D_SOIL_GROUP < 3         ///
    [aweight=UAA_WEIGHT]                           ///
    using `outdatadir'/descriptives/`tabname'      ///
    ,  sum oneway replace style(csv)               ///
       cell(                                       ///
            mean MILK_QUOTA_TOT_LEASED_EU          ///
            mean MILK_QUOTA_TOT_LEASED_LT          ///
            mean MILK_QUOTA_INHERITED_LT           ///
            mean MILK_QUOTA_SOLD_LT                ///
            mean MILK_QUOTA_GIFT_GIVEN_EU          ///
            mean MILK_QUOTA_LET_EU                 ///
            mean MILK_QUOTA_TOT_PURCH_LT           ///
            mean MILK_QUOTA_INHERITED_EU           ///
            mean MILK_QUOTA_SOLD_EU                ///
            mean MILK_QUOTA_TOTAL_CY_LT            ///
            mean MILK_QUOTA_OWN_CY_LT              ///
            mean MILK_QUOTA_TOT_PURCH_EU           ///
            mean MILK_QUOTA_LET_LT                 ///
            mean MILK_QUOTA_GIFT_GIVEN_LT          ///
           ) 
  if _rc == 0 local tablist "`tablist' `tabname'"
  if _rc != 0 local prob_tablist "`prob_tablist' `tabname'"
  

  local tabname "structures6.csv" 
  qui capture tabout YE_AR                              ///
    if FARM_SYSTEM == 1 & D_SOIL_GROUP < 3         ///
    [aweight=UAA_WEIGHT]                           ///
    using `outdatadir'/descriptives/`tabname'      ///
    ,  sum oneway replace style(csv)               ///
       cell(                                       ///
            mean d_dairy_stocking_rate /// 
            mean d_milk_yield          ///
            mean d_milk_price          ///
            mean d_labour_intensity_ha ///
            mean d_labour_intensity_lu ///
           ) 
  if _rc == 0 local tablist "`tablist' `tabname'"
  if _rc != 0 local prob_tablist "`prob_tablist' `tabname'"


}

* Output file listing
di "The following files have been written to" _newline(2) "`outdatadir'/descriptives"
foreach tabentry of local tablist{

  di "`tabentry'"

}

* Error list if applicable
if "`prob_tablist'" != "" {
  di "The following files received an error"
  foreach tabentry of local prob_tablist{

    di "`tabentry'"

  }
}
