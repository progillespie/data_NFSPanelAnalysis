*******************************************
* Create svy_pigs_1
*******************************************

*D_PIG_SALES_EU
gen d_pig_sales_eu = 0
* CHANGE-7983: + CULL_SOWS_BOARS_SALES_EU removed from formula
replace d_pig_sales_eu = BREEDING_STOCK_SALES_EU + BONHAMS_STORES_SALES_EU + PORKERS_BACON_SALES_EU 

*D_PIG_PURCHASES
gen d_pig_purchases_eu = 0
replace d_pig_purchases_eu = BREEDING_STOCK_PURCHASES_EU + BONHAMS_STORES_PURCHASES_EU

*D_VALUE_OF_CHANGE_IN_NUMBERS_EU  ***** THIS FORMULA IS WRONG(IT IS FOR SHEEP) - BRIAN TO WRITE NEW FORMULA FOR PIGS - FOR NOW JUST USE THE VARIABLE WITHOUT DERIVATION EVEN THOUGH IT IS WRONG
*ALSO RENAME THE ABOVE "D_VALUE_OF_CHANGE_IN_NUMBERS_EU" TO "D_VALUE_OF_CHANGE_IN_NUM_PIGS_EU" AS IT IS THE SAME VARS USED FOR SHEEP.

* CHANGE-7983: Corrected formula for Pigs (received from B. Moran)
gen D_VALUE_OF_CHANGE_IN_NUMBERS_EU = ///
(                                                                                                 ///
 ((SOWS_IN_PIG_CLOS_INV_NO    - SOWS_IN_PIG_OP_INV_NO)    * SOWS_IN_PIG_CLOS_INV_PERHEAD_EU)    + ///
 ((GILTS_IN_PIG_CLOS_INV_NO   - GILTS_IN_PIG_OP_INV_NO)   * GILTS_IN_PIG_CLOS_INV_PERHEAD_EU)   + ///
 ((SOWS_SUCKLING_CLOS_INV_NO  - SOWS_SUCKLING_OP_INV_NO)  * SOWS_SUCKLING_CLOS_INV_EU)          + ///
 ((BONHAMS_CLOS_INV_NO        - BONHAMS_OP_INV_NO)        * BONHAMS_CLOS_INV_PERHEAD_EU)        + ///
 ((WEANERS_CLOS_INV_NO        - WEANERS_OP_INV_NO)        * WEANERS_CLOS_INV_PERHEAD_EU)        + ///
 ((FATTENERS1_CLOS_INV_NO     - FATTENERS1_OP_INV_NO)     * FATTENERS1_CLOS_INV_PERHEAD_EU)     + ///
 ((FATTENERS2_CLOS_INV_NO     - FATTENERS2_OP_INV_NO)     * FATTENERS2_CLOS_INV_PERHEAD_EU)     + ///
 ((FATTENERS3_CLOS_INV_NO     - FATTENERS3_OP_INV_NO)     * FATTENERS3_CLOS_INV_PERHEAD_EU)     + ///
 ((FATTENING_SOWS_CLOS_INV_NO - FATTENING_SOWS_OP_INV_NO) * FATTENING_SOWS_CLOS_INV_EU)         + ///
 ((STOCK_BOARS_CLOS_INV_NO    - STOCK_BOARS_OP_INV_NO)    * STOCK_BOARS_CLOS_INV_PERHEAD_EU)      ///
)




rename D_VALUE_OF_CHANGE_IN_NUMBERS_EU D_VALUE_OF_CHANGE_IN_NUM_PIGS_EU