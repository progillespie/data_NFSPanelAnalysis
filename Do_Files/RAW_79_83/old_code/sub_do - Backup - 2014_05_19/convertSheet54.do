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
*	  Sheet54.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet54") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*===================================================================
rename TransportAllocatedtoPigs      junk_54_2
rename MiscellaneousAllocatedtoPigs  junk_54_3
rename TransportAllocatedtoPoultry   junk_54_4
rename MiscellaneousAllocatedtoPoult junk_54_5
rename TransportAllocatedtoDairyHer  junk_54_6
rename MiscellaneousAllocatedtoDairy junk_54_7
rename TransportAllocatedtoCattle    junk_54_8
rename MiscellaneousAllocatedtoCattl junk_54_9
rename TransportAllocatedtoSheep     junk_54_10
rename MiscellaneousAllocatedtoSheep junk_54_11
rename TransportAllocatedtoHorses    junk_54_12
rename MiscellaneousAllocatedtoHorse junk_54_13
rename TransportAllocatedtoother     junk_54_14
rename MiscellaneousAllocatedtoother junk_54_15
rename TotalTransportMiscCostsAl     junk_54_16
*====================================================================
capture drop junk*
