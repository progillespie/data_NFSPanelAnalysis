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
*	  Sheet40.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet40") firstrow clear
}



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*===================================================================
rename PoultryOpeningInventoryLayers junk_40_2
rename D                             junk_40_3
rename PoultryOpeningInventoryChicks junk_40_4
rename F                             junk_40_5
rename PoultryOpeningInventoryTable  junk_40_6
rename H                             junk_40_7
rename OpeningInventoryTotalNumber   junk_40_8
rename OpeningInventoryTurkeysNumber junk_40_9
rename OpeningInventoryTurkeysValue  junk_40_10
rename OpeningInventoryGeeseNumber   junk_40_11
rename OpeningInventoryGeeseValueun  junk_40_12
rename OpeningInventoryDucksNumber   junk_40_13
rename OpeningInventoryDucksValueu   junk_40_14
rename OpeningInventoryOthersNumber  junk_40_15
rename OpeningInventoryOthersValueu  junk_40_16
rename OpeningInventoryotherfowlTot  junk_40_17
*====================================================================
capture drop junk*
