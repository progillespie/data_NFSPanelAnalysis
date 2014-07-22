/* IB style formula
svy_dairy_produce    @ d_total_milk_production_eu                     + 
svy_cattle           @ d_dairy_value_dropped_calves_sold_trans_eu     + 
svy_cattle           @ d_dairy_herd_replace_cost_eu                   + 
svy_cattle           @ dairy_cows_sh_bulls_subsidies_eu               + 
svy_subsidies_grants @ slaughter_premium_dairy_payment_received_ty_eu

*/



* Stata translation (using SAS codes)
gen fdairygo       = ///
	dotomkvl   + ///
	dovalclf   + ///
	doreplct   + ///
*svy_cattle          @ dairy_cows_sh_bulls_subsidies_eu               +
*svy_subsidies_grants @ slaughter_premium_dairy_payment_received_ty_eu
