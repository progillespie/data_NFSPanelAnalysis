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
*	  Sheet18.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet18") firstrow clear
}



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*====================================================================
rename OpeningInventoryNumberDairyC junk_18_2
rename OpeningInventoryValueDairyCo junk_18_3
rename E                            junk_18_4
rename F                            junk_18_5
rename OpeningInventoryNumberDairyS junk_18_6
rename OpeningInventoryValueDairySt junk_18_7
rename OpeningInventoryNumberCalves junk_18_8
rename OpeningInventoryValueCalvesl junk_18_9
rename OpeningInventoryNumberOther  junk_18_10
rename OpeningInventoryValueOther   junk_18_11
rename OpeningInventoryTotalNumber  junk_18_12
*====================================================================
capture drop junk*

