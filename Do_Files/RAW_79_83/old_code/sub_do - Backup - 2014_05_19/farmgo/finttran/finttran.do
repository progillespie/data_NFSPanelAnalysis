/* IB style formula

FINTTRAN
svy_dairy_produce     @ d_milk_fed_to_livestock_eu +
svy_crop_derived      @ d_cash_crops_fed_eu        +
sum(svy_crop_expenses @ home_grown_seed_value_eu)


*/


* Stata translation (using SAS codes)
gen = ///
	domkfdvl

