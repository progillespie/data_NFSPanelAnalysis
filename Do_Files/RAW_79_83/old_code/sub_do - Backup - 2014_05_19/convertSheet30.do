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
*	  Sheet30.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet30") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*====================================================================
rename OpeningInventoryNumberEwes   junk_30_2
rename OpeningInventoryHeadEwes     junk_30_3
rename OpeningInventoryNumberLambsb junk_30_4
rename OpeningInventoryLambsbeforeW junk_30_5
rename OpeningInventoryNumberOtherl junk_30_6
rename OpeningInventoryHeadOtherl   junk_30_7
rename OpeningInventoryNumberSheep1 junk_30_8
rename OpeningInventoryHeadSheep1   junk_30_9
rename OpeningInventoryNumberSheepo junk_30_10
rename OpeningInventoryHeadSheepo   junk_30_11
rename OpeningInventoryNumberRams   junk_30_12
rename OpeningInventoryHeadRams     junk_30_13
rename OpeningInventoryNumberTotal  junk_30_14
rename OpeningInventoryQuantityWool junk_30_15
rename OpeningInventoryWoolValue    junk_30_16
*====================================================================
capture drop junk*
