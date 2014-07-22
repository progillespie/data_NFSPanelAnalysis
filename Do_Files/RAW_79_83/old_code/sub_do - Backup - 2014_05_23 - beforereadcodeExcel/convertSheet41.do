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
*	  Sheet41.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet41") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*===================================================================
rename PoultryClosingInventoryLayers LAYERS_CLOS_INV_NO
rename D                             LAYERS_CLOS_INV_PERUNIT_EU
rename PoultryClosingInventoryChicks CHICKS_PULLETS_CLOS_INV_NO
rename F                             CHICKS_PULLETS_CLOS_INV_EU
rename PoultryClosingInventoryTable  TABLE_FOWL_CLOS_INV_NO
rename H                             TABLE_FOWL_CLOS_INV_PERUNIT_EU
rename ClosingInventoryTotalNumber   TOTAL_ORDINARY_FOWL_CLOS_INV_NO
rename ClosingInventoryTurkeysNumber TURKEYS_CLOS_INV_NO
rename ClosingInventoryTurkeysValue  TURKEYS_CLOS_INV_PERUNIT_EU
rename ClosingInventoryGeeseNumber   GEESE_CLOS_INV_NO
rename ClosingInventoryGeeseValueun  GEESE_CLOS_INV_PERUNIT_EU
rename ClosingInventoryDucksNumber   DUCKS_CLOS_INV_NO
rename ClosingInventoryDucksValueu   DUCKS_CLOS_INV_PERUNIT_EU
rename ClosingInventoryOthersNumber  OTHERS_CLOS_INV_NO
rename ClosingInventoryOthersValueu  OTHERS_CLOS_INV_PERUNIT_EU
rename ClosingInventoryotherfowlTot  TOTAL_OTHER_FOWL_CLOS_INV_NO
*====================================================================
capture drop junk*
* Removed PERUNIT_ from CHICKS PULLETS var
