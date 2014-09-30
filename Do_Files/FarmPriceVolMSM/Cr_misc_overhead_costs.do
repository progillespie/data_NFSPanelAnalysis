*******************************************
* Create misc_overhead_costs
*******************************************


mvencode *, mv(0) override

gen d_expenditure_on_lime_eu = (LIME_OP_INV_VALUE_EU + LIME_PURCH_VALUE_EU) - LIME_CLOSING_INV_VALUE_EU


sort FARM_CODE YE_AR

keep FARM_CODE YE_AR d_expenditure_on_lime_eu ACCOUNTANTS_CONSULTANTS_FEES_EU TEAGASC_ADVISORY_FEES_EU OTHER_FARM_INSURANCES_EU OTHER_MISC_EXPENSES_EU BUILDINGS_FIRE_INSURANCE_EU SLURRY_FYM_PURCH_VALUE_EU WATER_CHARGES_EU

mvencode *, mv(0) override

gen d_misc_overhead_costs_eu = d_expenditure_on_lime_eu + ACCOUNTANTS_CONSULTANTS_FEES_EU + TEAGASC_ADVISORY_FEES_EU + OTHER_FARM_INSURANCES_EU + OTHER_MISC_EXPENSES_EU + BUILDINGS_FIRE_INSURANCE_EU + SLURRY_FYM_PURCH_VALUE_EU + WATER_CHARGES_EU

