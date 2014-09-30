*******************************************
* Create misc_overhead_costs
*******************************************

* CHANGE-7983: create 0 variables
capture gen double ACCOUNTANTS_CONSULTANTS_FEES_EU = 0
capture gen double TEAGASC_ADVISORY_FEES_EU        = 0
capture gen double OTHER_FARM_INSURANCES_EU        = 0
capture gen double BUILDINGS_FIRE_INSURANCE_EU     = 0
capture gen double SLURRY_FYM_PURCH_VALUE_EU       = 0
capture gen double WATER_CHARGES_EU                = 0

* CHANGE-7983: calculate OTHER_MISC_EXPENSES_EU
* var 69 and var70 should be OTHER_MISC_EXPENSES in cash and kind respectively
capture egen double OTHER_MISC_EXPENSES_EU         = rowtotal(var69 var70)



mvencode *, mv(0) override

gen d_expenditure_on_lime_eu = (LIME_OP_INV_VALUE_EU + LIME_PURCH_VALUE_EU) - LIME_CLOSING_INV_VALUE_EU


sort FARM_CODE YE_AR

keep FARM_CODE YE_AR d_expenditure_on_lime_eu ACCOUNTANTS_CONSULTANTS_FEES_EU TEAGASC_ADVISORY_FEES_EU OTHER_FARM_INSURANCES_EU OTHER_MISC_EXPENSES_EU BUILDINGS_FIRE_INSURANCE_EU SLURRY_FYM_PURCH_VALUE_EU WATER_CHARGES_EU

mvencode *, mv(0) override

gen d_misc_overhead_costs_eu = d_expenditure_on_lime_eu + ACCOUNTANTS_CONSULTANTS_FEES_EU + TEAGASC_ADVISORY_FEES_EU + OTHER_FARM_INSURANCES_EU + OTHER_MISC_EXPENSES_EU + BUILDINGS_FIRE_INSURANCE_EU + SLURRY_FYM_PURCH_VALUE_EU + WATER_CHARGES_EU

