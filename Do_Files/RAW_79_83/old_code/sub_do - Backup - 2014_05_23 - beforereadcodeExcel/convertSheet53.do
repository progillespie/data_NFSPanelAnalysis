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
*	  Sheet53.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet53") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*===================================================================
rename VetMedAIOpeningInvento  VET_MED_AI_OP_INV_EU
rename VetMedAIPurchasedDurin  VET_MED_AI_PURCHASED_EU
rename VetMedAIClosingInvento  VET_MED_AI_CLOS_INV_EU
rename VetMedicinetoPigs       VET_MED_ALLOC_PIGS_EU
rename AIServiceFeestoPigs     AI_SERVICE_FEES_ALLOC_PIGS_EU
rename VetMedicineEtctoPoultry VET_MED_ETC_ALLOC_POULTRY_EU
rename VetMedicinetoDairyHerd  VET_MED_ALLOC_DAIRY_HERD_EU
rename AIServiceFeestoDairyHer AI_SERVICE_FEES_ALLOC_DAIRY_EU
rename VetMedicinetoCattle     VET_MED_ALLOC_CATTLE_EU
rename AIServiceFeestoCattle   AI_SERVICE_FEES_ALLOC_CATTLE_EU
rename VetMedicinetoSheep      VET_MED_ALLOC_SHEEP_EU
rename AIServiceFeestoSheep    AI_SERVICE_FEES_ALLOC_SHEEP_EU
rename VetMedicinetoHorses     VET_MED_ALLOC_HORSES_EU
rename AIServiceFeestoHorses   AI_SERVICE_FEES_ALLOC_HORSES_EU
rename TotalAllocated          VET_MED_AI_FEES_TOTAL_ALLOC_EU
*====================================================================
capture drop junk*
* Removed HERD_ and SERVICE_ from varnames
