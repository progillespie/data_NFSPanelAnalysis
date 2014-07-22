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
rename TransportAllocatedtoPigs      TRANSPORT_ALLOC_PIGS_EU
rename MiscellaneousAllocatedtoPigs  MISCELLANEOUS_ALLOC_PIGS_EU
rename TransportAllocatedtoPoultry   TRANSPORT_ALLOC_POULTRY_EU
rename MiscellaneousAllocatedtoPoult MISCELLANEOUS_ALLOC_POULTRY_EU
rename TransportAllocatedtoDairyHer  TRANSPORT_ALLOC_DAIRY_HERD_EU
rename MiscellaneousAllocatedtoDairy MISC_ALLOC_DAIRY_HERD_EU
rename TransportAllocatedtoCattle    TRANSPORT_ALLOC_CATTLE_EU
rename MiscellaneousAllocatedtoCattl MISCELLANEOUS_ALLOC_CATTLE_EU
rename TransportAllocatedtoSheep     TRANSPORT_ALLOC_SHEEP_EU
rename MiscellaneousAllocatedtoSheep MISCELLANEOUS_ALLOC_SHEEP_EU
rename TransportAllocatedtoHorses    TRANSPORT_ALLOC_HORSES_EU
rename MiscellaneousAllocatedtoHorse MISCELLANEOUS_ALLOC_HORSES_EU
rename TransportAllocatedtoother     TRANSPORT_ALLOC_OTHER_GRAZING_EU
rename MiscellaneousAllocatedtoother MISC_ALLOC_OTHER_GRAZING_EU
rename TotalTransportMiscCostsAl     TRANS_MISC_EXP_TOTAL_ALLOC_EU
*====================================================================
capture drop junk*
* Shortened vars. MISCELLANEOUS = MISC and GRAZING LIVESTOCK = GRAZING
