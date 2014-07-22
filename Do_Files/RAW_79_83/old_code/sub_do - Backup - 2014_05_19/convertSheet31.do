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
*	  Sheet31.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet31") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*====================================================================
rename ClosingInventoryNumberEwes   junk_31_17
rename ClosingInventoryHeadEwes     junk_31_18
rename ClosingInventoryNumberLambsb junk_31_19
rename ClosingInventoryLambsbeforeW junk_31_20
rename ClosingInventoryNumberOtherl junk_31_21
rename ClosingInventoryHeadOtherl   junk_31_22
rename ClosingInventoryNumberSheep1 junk_31_23
rename ClosingInventoryHeadSheep1   junk_31_24
rename ClosingInventoryNumberSheepo junk_31_25
rename ClosingInventoryHeadSheepo   junk_31_26
rename ClosingInventoryNumberRams   junk_31_27
rename ClosingInventoryHeadRams     junk_31_28
rename ClosingInventoryNumberTotal  junk_31_29
rename ClosingInventoryQuantityWool junk_31_30
rename ClosingInventoryWoolValue    junk_31_31
*====================================================================
capture drop junk*
