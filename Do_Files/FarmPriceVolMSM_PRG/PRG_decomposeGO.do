

use 1/farm_gross_output.dta, clear

merge 1:1 FARM_CODE YE_AR using d_total_livestock_gross_output.dta, nogen
merge 1:1 FARM_CODE YE_AR using d_dairy_gross_output.dta, nogen
merge 1:1 FARM_CODE YE_AR using d_gross_output_cattle.dta, nogen

/*


merge 1:1 FARM_CODE YE_AR using , nogen
merge 1:1 FARM_CODE YE_AR using , nogen
merge 1:1 FARM_CODE YE_AR using , nogen
*/

tab YE_AR

tabstat d_farm_gross_output      ///
d_total_livestock_gross_output   ///
d_total_crops_gross_output_eu    ///
HIRED_MACHINERY_IN_CASH_EU       ///
HIRED_MACHINERY_IN_KIND_EU       ///
OTHER_RECEIPTS_IN_CASH_EU        ///
OTHER_RECEIPTS_IN_KIND_EU        ///
SALE_OF_TURF_VALUE_EU            ///
USED_IN_HOUSE_OTHER_EU           ///
MISC_GRANTS_SUBSIDIES_EU         ///
PROTEIN_PAYMENTS_TOTAL_EU        ///
SHEEP_WELFARE_SCHEME_TOTAL_EU    ///
OTHER_SUBS_PAYMENTS_TOTAL_EU     ///
LAND_LET_OUT_EU                  ///
MILK_QUOTA_LET_EU                ///
SINGLE_FARM_PAYMENT_NET_VALUE_EU ///
d_inter_enterpise_transfers_eu   ///
super_levy_refund_cond           ///
, by(YE_AR)


tabstat d_total_livestock_gross_output ///
 d_dairy_gross_output_eu               ///
 d_gross_output_cattle_eu              ///
 d_gross_output_sheep_and_wool_eu      ///
 d_gross_output_pigs_eu                ///
 d_poultry_gross_output_eu             ///
 d_gross_output_horses_eu              ///
 d_other_gross_output_eu               ///
, by(YE_AR)


tabstat d_dairy_gross_output_eu        ///
  d_total_milk_production_eu           ///
	d_dy_val_dropd_clvs_sld_trans_eu     ///
	d_dairy_herd_replace_cost_eu         ///
	DAIRY_COWS_SH_BULLS_SUBSIDIES_EU     ///
	SLAUGHTER_PREMIUM_DAIRY_PAYMENT_     ///
	DAIRY_EFF_PROG_TOTAL_PAYMENT_EU      ///
	DAIRY_COMP_FUND_TOTAL_PAYMENT_EU     ///
, by(YE_AR)


tabstat d_gross_output_cattle_eu       ///
  d_sales_incl_hse_consumption_eu      ///
	CATTLE_TOTAL_PURCHASES_EU            ///
	DY_COWS_SH_BULS_TRNSFR_IN_EU         ///
	d_transfer_from_dairy_herd_eu        ///
	d_value_of_change_of_numbers_eur     ///
	SUCKLER_WELFARE_SCHEME_TOTAL_EU      ///
, by(YE_AR) 
