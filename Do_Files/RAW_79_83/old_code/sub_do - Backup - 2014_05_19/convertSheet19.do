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
*	  Sheet19.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet19") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*====================================================================
rename closingInventoryNumberDairyC junk_19_13
rename closingInventoryValueDairyCo junk_19_14
rename E                            junk_19_15
rename F                            junk_19_16
rename closingInventoryNumberDairyS junk_19_17
rename closingInventoryValueDairySt junk_19_18
rename closingInventoryNumberCalves junk_19_19
rename closingInventoryValueCalvesl junk_19_20
rename closingInventoryNumberOther  junk_19_21
rename closingInventoryValueOther   junk_19_22
rename closingInventoryTotalNumber  junk_19_23
*====================================================================
capture drop junk*

