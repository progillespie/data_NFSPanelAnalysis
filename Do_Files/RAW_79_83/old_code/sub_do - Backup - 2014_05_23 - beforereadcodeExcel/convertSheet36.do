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
*	The required input files are in:       
*       
*        Data/data_NFSPanelAnalysis/OrigData/RAW_79_83 
*
*
*	This file will produce: 
*       
*	  Sheet36.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet36") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*===================================================================
rename ClosingInventorySowsinPigNu   SOWS_IN_PIG_CLOS_INV_NO
rename ClosingInventorySowsinPigVa   SOWS_IN_PIG_CLOS_INV_PERHEAD_EU
rename ClosingInventoryGiltsinPigN   GILTS_IN_PIG_CLOS_INV_NO
rename ClosingInventoryGiltsinPigV   GILTS_IN_PIG_CLOS_INV_PERHEAD_EU
rename ClosingInventorySowsSuckling  SOWS_SUCKLING_CLOS_INV_NO
rename H                             SOWS_SUCKLING_CLOS_INV_EU
rename ClosingInventoryBonhamsNumber BONHAMS_CLOS_INV_NO
rename ClosingInventoryBonhamsValue  BONHAMS_CLOS_INV_PERHEAD_EU
rename ClosingInventoryWeanersNumber WEANERS_CLOS_INV_NO
rename ClosingInventoryWeanersValue  WEANERS_CLOS_INV_PERHEAD_EU
rename ClosingInventoryFattenersNumb FATTENERS1_CLOS_INV_NO
rename ClosingInventoryFattenersWeig FATTENERS1_CLOS_INV_PERHEAD_KGS
rename ClosingInventoryFattenersValu FATTENERS1_CLOS_INV_PERHEAD_EU
rename P                             FATTENERS2_CLOS_INV_NO
rename Q                             FATTENERS2_CLOS_INV_PERHEAD_KGS
rename R                             FATTENERS2_CLOS_INV_PERHEAD_EU
rename S                             FATTENERS3_CLOS_INV_NO
rename T                             FATTENERS3_CLOS_INV_PERHEAD_KGS
rename U                             FATTENERS3_CLOS_INV_PERHEAD_EU
rename ClosingInventoryFatteningSows FATTENING_SOWS_CLOS_INV_NO
rename W                             FATTENING_SOWS_CLOS_INV_EU
rename ClosingInventoryStockBoarsNu  STOCK_BOARS_CLOS_INV_NO
rename ClosingInventoryStockBoars    STOCK_BOARS_CLOS_INV_PERHEAD_EU
rename ClosingInventoryTotalNumber   TOTAL_CLOS_INV_NO
*====================================================================
capture drop junk*
*Removed PERHEAD_ from SUCKLING SOWS and FATTENING SOWS vars
