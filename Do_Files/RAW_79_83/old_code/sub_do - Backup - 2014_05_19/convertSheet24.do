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
*	  Sheet24.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet24") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*====================================================================
rename CattleHerdSalesCalvesNumber  junk_24_95
rename CattleHerdSalesCalvesValue   junk_24_96
rename CattleHerdSalesWeanlingsNumb junk_24_97
rename CattleHerdSalesWeanlingsValu junk_24_98
rename CattleHerdSalesStoresNumb    junk_24_99
rename CattleHerdSalesStoresValu    junk_24_100
rename CattleHerdSalesFinishedsNum  junk_24_101
rename CattleHerdSalesFinishedsVal  junk_24_102
rename CattleHerdSalesBreedHerdCul  junk_24_103
rename L                            junk_24_104
rename CattleHerdSalesOtherNumber   junk_24_105
rename CattleHerdSalesOtherValue    junk_24_106
rename CattleHerdSalesTotalNumber   junk_24_107
rename CattleHerdSalesTotalValue    junk_24_108
*====================================================================
capture drop junk*

