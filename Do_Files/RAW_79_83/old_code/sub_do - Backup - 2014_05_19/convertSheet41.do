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
rename PoultryClosingInventoryLayers junk_41_18
rename D                             junk_41_19
rename PoultryClosingInventoryChicks junk_41_20
rename F                             junk_41_21
rename PoultryClosingInventoryTable  junk_41_22
rename H                             junk_41_23
rename ClosingInventoryTotalNumber   junk_41_24
rename ClosingInventoryTurkeysNumber junk_41_25
rename ClosingInventoryTurkeysValue  junk_41_26
rename ClosingInventoryGeeseNumber   junk_41_27
rename ClosingInventoryGeeseValueun  junk_41_28
rename ClosingInventoryDucksNumber   junk_41_29
rename ClosingInventoryDucksValueu   junk_41_30
rename ClosingInventoryOthersNumber  junk_41_31
rename ClosingInventoryOthersValueu  junk_41_32
rename ClosingInventoryotherfowlTot  junk_41_33
*====================================================================
capture drop junk*
