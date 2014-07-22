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
rename CattleHerdSalesCalvesNumber  CATTLE_CALVES_SALES_NO
rename CattleHerdSalesCalvesValue   CATTLE_CALVES_SALES_EU
rename CattleHerdSalesWeanlingsNumb CATTLE_WEANLINGS_SALES_NO
rename CattleHerdSalesWeanlingsValu CATTLE_WEANLINGS_SALES_EU
rename CattleHerdSalesStoresNumb    CATTLE_STORES_SALES_NO
rename CattleHerdSalesStoresValu    CATTLE_STORES_SALES_EU
rename CattleHerdSalesFinishedsNum  CATTLE_FINISHED_SALES_NO
rename CattleHerdSalesFinishedsVal  CATTLE_FINISHED_SALES_EU
rename CattleHerdSalesBreedHerdCul  CATTLE_BREED_CULL_SALE_NO
rename L                            CATTLE_BREED_CULL_SALE_EU
rename CattleHerdSalesOtherNumber   CATTLE_OTHER_SALES_NO
rename CattleHerdSalesOtherValue    CATTLE_OTHER_SALES_EU
rename CattleHerdSalesTotalNumber   CATTLE_TOTAL_SALES_NO
rename CattleHerdSalesTotalValue    CATTLE_TOTAL_SALES_EU
*====================================================================
capture drop junk*
* Removed letters from CATTLE_BREEDING_HERD_CULLS_SALES vars

