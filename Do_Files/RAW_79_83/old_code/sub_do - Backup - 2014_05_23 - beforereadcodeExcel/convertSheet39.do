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
rename PigsPurchasesBreedingStockNu BREEDING_STOCK_PURCHASES_NO
rename PigsPurchasesBreedingStockTo BREEDING_STOCK_PURCHASES_EU
rename PigsPurchasesBonhamsStores   BONHAMS_STORES_PURCHASES_NO
rename F                            BONHAMS_STORES_PURCHASES_KGS
rename G                            BONHAMS_STORES_PURCHASES_EU
rename SalesBreedingStocknumbers    BREEDING_STOCK_SALES_NO
rename SalesBreedingStockTotalprice BREEDING_STOCK_SALES_EU
rename SalesBonhamsStoresnumbers    BONHAMS_STORES_SALES_NO
rename SalesBonhamsStoresTotalWei   BONHAMS_STORES_SALES_KGS
rename SalesBonhamsStoresTotalpri   BONHAMS_STORES_SALES_EU
rename SalesPorkersBaconPigsnumbe   PORKERS_BACON_SALES_NO
rename SalesPorkersBaconPigsTotal   PORKERS_BACON_SALES_KGS
rename O                            PORKERS_BACON_SALES_EU
*====================================================================
capture drop junk*
