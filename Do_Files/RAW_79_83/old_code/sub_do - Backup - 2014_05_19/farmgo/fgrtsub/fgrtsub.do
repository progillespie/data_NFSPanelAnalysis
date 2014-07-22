/* IB style formula

sum(svy_subsidies_grants       @single_farm_payment_net_value_eu) +
sum(svy_misc_receipts_expenses @misc_grants_subsidies_eu        )

RAW DATA POSITIONS
single_farm_payment_net_value_eu  29_16
misc_grants_subsidies_eu          55_4

*/


* Stata translation (using SAS codes)
* SFP won't exist until much later
gen  sfp = 0 

gen fgrtsub        = ///
	sfp        + ///
	fgrtsubs

* NOTE: fgrtsub and fgrtsubs are different variables (fgrtsubs has sfp added, but this will always be 0 until SFP is introduced in 2000's), therefore the two will be the same until then. Make sure to use the appropriate variable.
