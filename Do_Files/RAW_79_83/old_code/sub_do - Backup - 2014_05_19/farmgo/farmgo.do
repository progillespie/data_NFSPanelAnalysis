/* IB style formula
svy_farm                   @ d_total_livestock_gross_output    +
svy_crop_derived           @ d_total_crops_gross_output_eu     +
!!! svy_misc_receipts_expenses @ hired_machinery_in_cash_eu    +
!!! svy_misc_receipts_expenses @ hired_machinery_in_kind_eu    +
svy_misc_receipts_expenses @ other_receipts_in_cash_eu         +
svy_misc_receipts_expenses @ other_receipts_in_kind_eu         +
svy_misc_receipts_expenses @ sale_of_turf_value_eu             +
svy_misc_receipts_expenses @ used_in_house_other_eu            +
svy_misc_receipts_expenses @ misc_grants_subsidies_eu          +
svy_subsidies_grants       @ protein_payments_total_eu         +
svy_subsidies_grants       @ sheep_welfare_scheme_total_eu     +
svy_subsidies_grants       @ other_subsidies_payments_total_eu +
svy_farm                   @ land_let_out_eu                   +
svy_dairy_produce          @ milk_quota_let_eu                 +

(
 if (                     @super_levy_refund_eu >
                          @super_levy_charge_eu)
 then svy_dairy_produce   @super_levy_refund_eu
 else 0
)                                                              +

svy_subsidies_grants      @ single_farm_payment_net_value_eu   -
svy_farm                  @ d_inter_enterpise_transfers_eu

*/




* Stata translation (using SAS codes)
gen farmgo         = ///
	flivstgo   + ///
	fcropsgo   + ///
	frhiremh   + /// !!! sum of cash and kind
	frevoth    + /// !!! sum of rec. cash & kind, turf, and superlevy
*svy_misc_receipts_expenses @ used_in_house_other_eu            +
	fgrtsubs   + ///
*svy_subsidies_grants       @ protein_payments_total_eu         +
*svy_subsidies_grants       @ sheep_welfare_scheme_total_eu     +
*svy_subsidies_grants       @ other_subsidies_payments_total_eu +
	fincldlt   + ///
	dqifqlet   + ///
*svy_subsidies_grants      @ single_farm_payment_net_value_eu   -
	finttran




/* DO NOT FORGET! frevoth SHOULD REFLECT THE FOLLOWING
(
 if (                     @super_levy_refund_eu >
                          @super_levy_charge_eu)
 then svy_dairy_produce   @super_levy_refund_eu
 else 0
)

*/                                                             +
