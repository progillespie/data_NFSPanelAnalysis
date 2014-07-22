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
*	  Sheet51.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet51") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*===================================================================
rename PurchasedConcentrateAllocated CONC_ALLOC_DAIRY_50KGBAGS_NO
rename D                             CONC_ALLOC_DAIRY_50KGBAGS_EU
rename E                             CONC_ALLOC_CATTLE_50KGBAGS_NO
rename F                             CONC_ALLOC_CATTLE_50KGBAGS_EU
rename G                             CONC_ALLOC_SHEEP_50KGBAGS_NO
rename H                             CONC_ALLOC_SHEEP_50KGBAGS_EU
rename I                             CONC_ALLOC_HORSES_50KGBAGS_NO
rename J                             CONC_ALLOC_HORSES_50KGBAGS_EU
rename K                             CONC_ALLOC_PIGS_50KGBAGS_NO
rename L                             CONC_ALLOC_PIGS_50KGBAGS_EU
rename M                             CONC_ALLOC_POULTRY_50KGBAGS_NO
rename N                             CONC_ALLOC_POULTRY_50KGBAGS_EU
rename O                             CONC_ALLOC_OTHER_50KGBAGS_NO
rename P                             CONC_ALLOC_OTHER_50KGBAGS_EU
rename Q                             CONC_ALLOC_WASTE_50KGBAGS_NO
rename R                             CONC_ALLOC_WASTE_50KGBAGS_EU
rename PurchasedConcentrateTotalAllo CONC_ALLOC_TOTAL_50KGBAGS_NO
rename T                             CONC_ALLOC_TOTAL_50KGBAGS_EU
rename MilkSubstitutefedtoCalves50   CONC_MILK_SUBS_CALVES_50KG_NO
rename MilkSubstitutefedtoCalvesCo   CONC_MILK_SUBS_CALVES_50KG_EU
*====================================================================
capture drop junk*
* Shortened 50KG BAGS vars
