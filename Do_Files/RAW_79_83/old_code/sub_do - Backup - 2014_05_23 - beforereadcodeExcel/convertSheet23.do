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
rename CattleHerdPurchasesCalvesNum CATTLE_CALVES_PURCHASES_NO
rename CattleHerdPurchasesCalvesVal CATTLE_CALVES_PURCHASES_EU
rename CattleHerdPurchasesWeanlings CATTLE_WEANLINGS_PURCHASES_NO
rename F                            CATTLE_WEANLINGS_PURCHASES_EU
rename CattleHerdPurchasesStoresNum TOTAL_STORES_PURCHASED_NO
rename CattleHerdPurchasesStoresVa  TOTAL_STORES_PURCHASED_EU
rename CattleHerdPurchasesBreedHerd CATTLE_BREED_REPL_PURCHASES_NO
rename J                            CATTLE_BREED_REPL_PURCHASES_EU
rename CattleHerdPurchasesOtherNumb CATTLE_OTHER_PURCHASES_NO
rename CattleHerdPurchasesOtherValu CATTLE_OTHER_PURCHASES_EU
rename CattleHerdPurchasesTotalNumb CATTLE_TOTAL_PURCHASES_NO
rename CattleHerdPurchasesTotalValu CATTLE_TOTAL_PURCHASES_EU
rename CattleHerdUsedinHouseNumber  CATTLE_USED_IN_HOUSE_NO
rename CattleHerdUsedinHouseValue   CATTLE_USED_IN_HOUSE_EU
rename CattleHerdReceiptsforBullSe  CATTLE_RCPTS_BULL_SERVICES_EU
rename CattleHerdSubsidiesValue     CATTLE_SUBSIDIES_EU
*====================================================================
capture drop junk*
* Removed letters from replacement vars and bull services.

