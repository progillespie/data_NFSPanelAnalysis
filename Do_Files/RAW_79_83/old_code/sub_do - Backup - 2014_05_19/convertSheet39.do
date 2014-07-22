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
*	  Sheet39.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet39") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*===================================================================
rename PigsPurchasesBreedingStockNu junk_39_72
rename PigsPurchasesBreedingStockTo junk_39_73
rename PigsPurchasesBonhamsStores   junk_39_74
rename F                            junk_39_75
rename G                            junk_39_76
rename SalesBreedingStocknumbers    junk_39_77
rename SalesBreedingStockTotalprice junk_39_78
rename SalesBonhamsStoresnumbers    junk_39_79
rename SalesBonhamsStoresTotalWei   junk_39_80
rename SalesBonhamsStoresTotalpri   junk_39_81
rename SalesPorkersBaconPigsnumbe   junk_39_82
rename SalesPorkersBaconPigsTotal   junk_39_83
rename O                            junk_39_84
*====================================================================
capture drop junk*
