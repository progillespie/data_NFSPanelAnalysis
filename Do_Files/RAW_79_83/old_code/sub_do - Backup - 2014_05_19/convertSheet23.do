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
*	  Sheet23.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet23") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*====================================================================
rename CattleHerdPurchasesCalvesNum junk_23_79
rename CattleHerdPurchasesCalvesVal junk_23_80
rename CattleHerdPurchasesWeanlings junk_23_81
rename F                            junk_23_82
rename CattleHerdPurchasesStoresNum junk_23_83
rename CattleHerdPurchasesStoresVa  junk_23_84
rename CattleHerdPurchasesBreedHerd junk_23_85
rename J                            junk_23_86
rename CattleHerdPurchasesOtherNumb junk_23_87
rename CattleHerdPurchasesOtherValu junk_23_88
rename CattleHerdPurchasesTotalNumb junk_23_89
rename CattleHerdPurchasesTotalValu junk_23_90
rename CattleHerdUsedinHouseNumber  junk_23_91
rename CattleHerdUsedinHouseValue   junk_23_92
rename CattleHerdReceiptsforBullSe  junk_23_93
rename CattleHerdSubsidiesValue     junk_23_94
*====================================================================
capture drop junk*

