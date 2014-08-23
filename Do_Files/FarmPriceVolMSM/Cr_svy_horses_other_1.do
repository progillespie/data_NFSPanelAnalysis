*******************************************
* Create svy_horses_other_1
*******************************************


rename var4 HORSES_BREEDING_STOCK1_OP_INV_PE
rename var6 HORSES_BREEDING_STOCK2_OP_INV_PE
rename var8 HORSES_OTHER_STOCK1_OP_INV_PERUN
rename var27 HORSES_BREEDING_STOCK1_CLOS_INV_
rename var28 HRSE_BRD_STK1_CLS_INV_PERUNIT_EU
rename var29 HORSES_BREEDING_STOCK2_CLOS_INV_
rename var30 HRSE_BRD_STK2_CLS_INV_PERUNIT_EU
rename var32 HORSES_OTHER_STOCK1_CLOS_INV_PER
rename var50 HORSES_EQUINES_STUD_FEES_RECEIPT 
rename var51 HORSES_EQUINES_SUBSIDIES_RECEIPT

gen d_horses_lu_boarding_out = BOARDING_OUT_HORSES_ANIMALS_NO * (BOARDING_OUT_HORSES_DAYS_NO / 365) * BOARDING_OUT_HORSES_LU_EQUIV
replace d_horses_lu_boarding_out = 0 if d_horses_lu_boarding_out == .

gen d_horses_lu_boarding_in = BOARDING_IN_HORSES_ANIMALS_NO * (BOARDING_IN_HORSES_DAYS_NO / 365) * BOARDING_IN_HORSES_LU_EQUIV
replace d_horses_lu_boarding_in = 0 if d_horses_lu_boarding_in == .

gen i_horses_lu_home_grazing = d_horses_livestock_units - (COMMONAGE_HORSES_ANIMALS_NO * (COMMONAGE_HORSES_DAYS_NO / 365) * COMMONAGE_HORSES_LU_EQUIV) - d_horses_lu_boarding_out + d_horses_lu_boarding_in


*D_HORSES_OPENING_INVENTORY_TRADING_STOCK_EU (D_HORSES_OPENING_INVENTORY_TRADI)
gen d_horses_opening_inventory_tradi = 0
replace d_horses_opening_inventory_tradi = (HORSES_OTHER_STOCK1_OP_INV_NO *  HORSES_OTHER_STOCK1_OP_INV_PERUN) + (HORSES1_OP_INV_NO * HORSES1_OP_INV_PERUNIT_EU) + (HORSES2_OP_INV_NO * HORSES2_OP_INV_PERUNIT_EU) + (HORSES3_OP_INV_NO * HORSES3_OP_INV_PERUNIT_EU) + (HORSES4_OP_INV_NO * HORSES4_OP_INV_PERUNIT_EU)

*D_HORSES_OPENING_INVENTORY_BREEDING_STOCK_EU (D_HORSES_OPENING_INVENTORY_BREED)
gen d_horses_opening_inventory_breed = 0
replace d_horses_opening_inventory_breed = (HORSES_BREEDING_STOCK1_OP_INV_NO * HORSES_BREEDING_STOCK1_OP_INV_PE) + (HORSES_BREEDING_STOCK2_OP_INV_NO * HORSES_BREEDING_STOCK2_OP_INV_PE)

*D_OPENING_INVENTORY_HORSES_EU
gen d_opening_inventory_horses_eu = 0
replace d_opening_inventory_horses_eu = d_horses_opening_inventory_breed + d_horses_opening_inventory_tradi 

*D_HORSES_CLOSING_INVENTORY_TRADING_STOCK_EU (D_HORSES_CLOSING_INVENTORY_TRADI)
gen d_horses_closing_inventory_tradi = 0
replace d_horses_closing_inventory_tradi = (HORSES_OTHER_STOCK1_CLOS_INV_NO *  HORSES_OTHER_STOCK1_CLOS_INV_PER) + (HORSES1_CLOS_INV_NO * HORSES1_CLOS_INV_PERUNIT_EU) + (HORSES2_CLOS_INV_NO * HORSES2_CLOS_INV_PERUNIT_EU) + (HORSES3_CLOS_INV_NO * HORSES3_CLOS_INV_PERUNIT_EU) + (HORSES4_CLOS_INV_NO * HORSES4_CLOS_INV_PERUNIT_EU)

*D_HORSES_CLOSING_INVENTORY_BREEDING_STOCK_EU (D_HORSES_CLOSING_INVENTORY_BREED)
gen d_horses_closing_inventory_breed = 0
replace d_horses_closing_inventory_breed = (HORSES_BREEDING_STOCK1_CLOS_INV_ * HRSE_BRD_STK1_CLS_INV_PERUNIT_EU) + (HORSES_BREEDING_STOCK2_CLOS_INV_ * HRSE_BRD_STK2_CLS_INV_PERUNIT_EU)

*D_CLOSING_INVENTORY_HORSES_EU
gen d_closing_inventory_horses_eu = 0
replace d_closing_inventory_horses_eu = d_horses_closing_inventory_breed + d_horses_closing_inventory_tradi 

*D_HORSE_SALES_EU
gen d_horse_sales_eu = 0
replace d_horse_sales_eu = HORSES_EQUINES_SALES_EU + HORSES_EQUINES_STUD_FEES_RECEIPT + HORSES_EQUINES_SUBSIDIES_RECEIPT

