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
*	  Sheet50.dta 
*
*	for each of the subdirectories of 
*       
*	  RAW_79_83/raw_dta/
**
*	Algorithm: RENAME
*
*
********************************************************
* READ THE README.txt FILE BEFORE CHANGING ANYTHING!!!
********************************************************



if "`standalone'"=="standalone"{
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet50") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*===================================================================
rename PurchasedConcentrateOpeningIn CONC_OP_INV_50KGBAGS_NO
rename D                             CONC_OP_INV_50KGBAGS_EU
rename PurchasedConcentratePurchased CONC_PURCHASED_50KGBAGS_NO
rename F                             CONC_PURCHASED_50KGBAGS_EU
rename PurchasedConcentrateAllocated CONC_ALLOCATED_50KGBAGS_NO
rename H                             CONC_ALLOCATED_50KGBAGS_EU
rename PurchasedConcentrateClosingIn CONC_CLOS_INV_50KGBAGS_NO
rename J                             CONC_CLOS_INV_50KGBAGS_EU
*====================================================================
capture drop junk*
