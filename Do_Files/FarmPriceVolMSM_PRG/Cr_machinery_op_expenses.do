*******************************************
* Create machinery_operating_expenses
*******************************************

* CHANGE-7983: removed var31 from keep
keep FARM_CODE YE_AR MACHINERY_FUEL_LUBS_OP_INV_EU MACHINERY_FUEL_LUBS_PURCHASES_EU MACHINERY_FUEL_LUBS_CLOS_INV_EU MACHINERY_MINOR_REPAIRS_EU MACHINERY_TAX_EU MACHINERY_INSURANCE_EU BUILDINGS_REPAIRS_UPKEEP_EU LAND_GENERAL_UPKEEP_EU

sort FARM_CODE YE_AR

mvencode *, mv(0) override

gen d_machine_operating_expenses_eu  = 0
replace d_machine_operating_expenses_eu  = (MACHINERY_FUEL_LUBS_OP_INV_EU + MACHINERY_FUEL_LUBS_PURCHASES_EU - MACHINERY_FUEL_LUBS_CLOS_INV_EU) + MACHINERY_MINOR_REPAIRS_EU + MACHINERY_TAX_EU + MACHINERY_INSURANCE_EU

