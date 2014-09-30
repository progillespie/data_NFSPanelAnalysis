*******************************************
* wint_forg_fed_unit_cost
*******************************************

by  FARM_CODE YE_AR: egen i_arable_silage_fed_unit_cost = sum(a_sil_fed_unit_cost)
by  FARM_CODE YE_AR: egen i_fodder_beet_fed_unit_cost = sum(fdrbt_fed_unit_cost)
by  FARM_CODE YE_AR: egen i_sugar_beet_fed_unit_cost = sum(sgrbt_fed_unit_cost)
by  FARM_CODE YE_AR: egen i_maize_silage_fed_unit_cost = sum(mz_sil_fed_unit_cost)
by  FARM_CODE YE_AR: egen i_oat_in_sheaf_fed_unit_cost = sum(ots_shf_fed_unit_cost)
by  FARM_CODE YE_AR: egen i_mangolds_fed_unit_cost = sum(mgolds_fed_unit_cost)
by  FARM_CODE YE_AR: egen i_rape_seed_fed_unit_cost = sum(rseed_fed_unit_cost)
by  FARM_CODE YE_AR: egen i_straw_fed_unit_cost = sum(stw_fed_unit_cost)
by  FARM_CODE YE_AR: egen i_sugar_fed_unit_cost = sum(sug_fed_unit_cost)
by  FARM_CODE YE_AR: egen i_kale_fed_unit_cost = sum(kale_fed_unit_cost) 



by  FARM_CODE YE_AR: egen rnk = rank(YE_AR),unique

keep if rnk == 1

drop rnk

keep FARM_CODE YE_AR i_arable_silage_fed_unit_cost i_fodder_beet_fed_unit_cost i_sugar_beet_fed_unit_cost i_maize_silage_fed_unit_cost i_oat_in_sheaf_fed_unit_cost i_mangolds_fed_unit_cost i_rape_seed_fed_unit_cost i_straw_fed_unit_cost i_sugar_fed_unit_cost i_kale_fed_unit_cost



