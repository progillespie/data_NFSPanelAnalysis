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
*	  Sheet21.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet21") firstrow clear
}



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*====================================================================
rename OpeningInventoryOtherCowsNum junk_21_37
rename OpeningInventoryOtherCowsH   junk_21_38
rename OpeningInventoryInCalfHeifer junk_21_39
rename F                            junk_21_40
rename DroppedCalvesNo              junk_21_41
rename DroppedCalves                junk_21_42
rename OpeningInventoryCalveslessth junk_21_43
rename J                            junk_21_44
rename OpeningInventoryCalves6month junk_21_45
rename L                            junk_21_46
rename OpeningInventoryMaleCattle1  junk_21_47
rename N                            junk_21_48
rename OpeningInventoryFemaleCattle junk_21_49
rename P                            junk_21_50
rename OpeningInventoryMaleCattle2  junk_21_51
rename R                            junk_21_52
rename OpeningInventoryfemaleCattle junk_21_53
rename T                            junk_21_54
rename OpeningInventoryStockBullsNu junk_21_55
rename OpeningInventoryStockBulls   junk_21_56
rename OpeningInventorTotalNumber   junk_21_57
*====================================================================
capture drop junk*

