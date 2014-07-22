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



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*===================================================================
rename VetMedAIOpeningInvento  junk_53_2
rename VetMedAIPurchasedDurin  junk_53_3
rename VetMedAIClosingInvento  junk_53_4
rename VetMedicinetoPigs       junk_53_5
rename AIServiceFeestoPigs     junk_53_6
rename VetMedicineEtctoPoultry junk_53_7
rename VetMedicinetoDairyHerd  junk_53_8
rename AIServiceFeestoDairyHer junk_53_9
rename VetMedicinetoCattle     junk_53_10
rename AIServiceFeestoCattle   junk_53_11
rename VetMedicinetoSheep      junk_53_12
rename AIServiceFeestoSheep    junk_53_13
rename VetMedicinetoHorses     junk_53_14
rename AIServiceFeestoHorses   junk_53_15
rename TotalAllocated          junk_53_16
*====================================================================
capture drop junk*
