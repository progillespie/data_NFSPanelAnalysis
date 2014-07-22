args standalone validate
********************************************************
********************************************************
*
*       Patrick R. Gillespie                            
*       Walsh Fellow                    
*       Teagasc, REDP                           
*       patrick.gillespie@teagasc.ie            
*
********************************************************
* 
*	Code to convert raw NFS data (prepared by Gerry
*       Quinlan - before he retired) to the "SAS"
*       varnames for further analysis. This will match
*	dataset conventions such as in nfs_data.dta
*       
* 	The required input files are in:       
*       
*        Data/data_NFSPanelAnalysis/OrigData/RAW_79_83 
*
*
*	This file will produce: 
*       
*	  Sheet13.dta 
*
*	for each of the subdirectories of 
*       
*	  RAW_79_83/raw_dta/
*
*
*	Algorithm: RENAME
*
*
********************************************************
* READ THE README.txt FILE BEFORE CHANGING ANYTHING!!!
********************************************************



if "`standalone'"=="standalone"{
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet13") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"







*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*====================================================================
rename OpeningInventoryQuantity50kg  FERT_OP_INV_QTY_BAGS
rename OpeningInventoryTotalValue    FERT_OP_INV_VALUE_EU
rename PurchasedduringYearQuantity5  FERT_PURCH_QTY_BAGS
rename PurchasedduringYearTotalValue FERT_PURCH_VALUE_EU
rename UsedduringYearQuantity50kg    FERT_USED_QTY_BAGS
rename UsedduringYearTotalValue      FERT_USED_VALUE_EU
rename WasteQuantity50kgBags         FERT_WASTE_QTY_BAGS
rename WasteTotalValue               FERT_WASTE_VALUE_EU
rename ClosingInventoryQuantity50kg  FERT_CLOSING_INV_QTY_BAGS
rename ClosingInventoryTotalValue    FERT_CLOSING_INV_VALUE_EU
rename LimeOpeningInventoryTonnes    LIME_OP_INV_QTY_TONNES
rename LimeOpeningInventory          LIME_OP_INV_VALUE_EU
rename LimePurchasedduringYearTonne  LIME_PURCH_QTY_TONNES
rename LimePurchasedduringYear       LIME_PURCH_VALUE_EU
rename LimeClosingInventoryTonnes    LIME_CLOSING_INV_QTY_TONNES
rename LimeClosingInventory          LIME_CLOSING_INV_VALUE_EU
rename SlurryandorFYMpurchases       SLURRY_FYM_PURCH_VALUE_EU
rename OtherCropExpensesOpeningInve  OTHER_CROP_EXP_OP_INV_VALUE_EU
*rename OtherCropExpensesClosingInve  OTHER_CROP_EXP_CLOSING_INV_VALUE_EU
*====================================================================
capture drop junk*
