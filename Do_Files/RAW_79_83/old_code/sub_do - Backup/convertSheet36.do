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



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*===================================================================
rename ClosingInventorySowsinPigNu   junk_36_26
rename ClosingInventorySowsinPigVa   junk_36_27
rename ClosingInventoryGiltsinPigN   junk_36_28
rename ClosingInventoryGiltsinPigV   junk_36_29
rename ClosingInventorySowsSuckling  junk_36_30
rename H                             junk_36_31
rename ClosingInventoryBonhamsNumber junk_36_32
rename ClosingInventoryBonhamsValue  junk_36_33
rename ClosingInventoryWeanersNumber junk_36_34
rename ClosingInventoryWeanersValue  junk_36_35
rename ClosingInventoryFattenersNumb junk_36_36
rename ClosingInventoryFattenersWeig junk_36_37
rename ClosingInventoryFattenersValu junk_36_38
rename P                             junk_36_39
rename Q                             junk_36_40
rename R                             junk_36_41
rename S                             junk_36_42
rename T                             junk_36_43
rename U                             junk_36_44
rename ClosingInventoryFatteningSows junk_36_45
rename W                             junk_36_46
rename ClosingInventoryStockBoarsNu  junk_36_47
rename ClosingInventoryStockBoars    junk_36_48
rename ClosingInventoryTotalNumber   junk_36_49
*====================================================================
capture drop junk*
