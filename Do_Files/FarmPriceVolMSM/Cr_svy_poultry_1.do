*******************************************
* Create svy_poultry_1
*******************************************

rename var9 D_SALES_LIVESTOCK_PROD_EGGS_EU
rename var22 CHICKS_PULLETS_CLOS_INV_PERUNIT_

*D_SALES_LIVESTOCK_PRODUCTS_EGGS_EU (renamed to D_SALES_LIVESTOCK_PROD_EGGS_EU)
gen d_sales_livestock_prod_eggs_eu = 0
replace d_sales_livestock_prod_eggs_eu = HEN_EGG_DOZEN_SALES_EU + OTHER_EGG_DOZEN_SALES_EU

*D_CLOSING_INVENTORY_POULTRY_EU
gen d_closing_inventory_poultry_eu = 0
replace d_closing_inventory_poultry_eu = ((LAYERS_CLOS_INV_NO * LAYERS_CLOS_INV_PERUNIT_EU) + (CHICKS_PULLETS_CLOS_INV_NO * CHICKS_PULLETS_CLOS_INV_PERUNIT_) + (TABLE_FOWL_CLOS_INV_NO * TABLE_FOWL_CLOS_INV_PERUNIT_EU) + (TURKEYS_CLOS_INV_NO * TURKEYS_CLOS_INV_PERUNIT_EU) + (GEESE_CLOS_INV_NO * GEESE_CLOS_INV_PERUNIT_EU) + (DUCKS_CLOS_INV_NO * DUCKS_CLOS_INV_PERUNIT_EU) + (OTHERS_CLOS_INV_NO * OTHERS_CLOS_INV_PERUNIT_EU))

*D_OPENING_INVENTORY_POULTRY_EU
gen d_opening_inventory_poultry_eu = 0
replace d_opening_inventory_poultry_eu = ((LAYERS_OP_INV_NO * LAYERS_OP_INV_PERUNIT_EU) + (CHICKS_PULLETS_OP_INV_NO * CHICKS_PULLETS_OP_INV_PERUNIT_EU) + (TABLE_FOWL_OP_INV_NO * TABLE_FOWL_OP_INV_PERUNIT_EU) + (TURKEYS_OP_INV_NO * TURKEYS_OP_INV_PERUNIT_EU) + (GEESE_OP_INV_NO * GEESE_OP_INV_PERUNIT_EU) + (DUCKS_OP_INV_NO * DUCKS_OP_INV_PERUNIT_EU) + (OTHERS_OP_INV_NO * OTHERS_OP_INV_PERUNIT_EU))
