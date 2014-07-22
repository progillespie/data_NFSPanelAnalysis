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
*	  Sheet22.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet22") firstrow clear
}



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*====================================================================
rename closingInventoryOtherCowsNum junk_22_58
rename closingInventoryOtherCowsH   junk_22_59
rename closingInventoryInCalfHeifer junk_22_60
rename F                            junk_22_61
rename DroppedCalvesNo              junk_22_62
rename DroppedCalves                junk_22_63
rename closingInventoryCalveslessth junk_22_64
rename J                            junk_22_65
rename closingInventoryCalves6month junk_22_66
rename L                            junk_22_67
rename closingInventoryMaleCattle1  junk_22_68
rename N                            junk_22_69
rename closingInventoryFemaleCattle junk_22_70
rename P                            junk_22_71
rename closingInventoryMaleCattle2  junk_22_72
rename R                            junk_22_73
rename closingInventoryfemaleCattle junk_22_74
rename T                            junk_22_75
rename closingInventoryStockBullsNu junk_22_76
rename closingInventoryStockBulls   junk_22_77
rename closingInventorTotalNumber   junk_22_78
*====================================================================
capture drop junk*

