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
*	  Sheet49.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet49") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*===================================================================
rename PurchasesCode   C49_PURCHASES_CODE
rename Purchases       C49_PURCHASES_EU
rename SalesCode       C49_SALES_CODE
rename Sales           C49_SALES_EU
rename UsedinHouseCode C49_USED_IN_HOUSE_CODE
rename UsedinHouse     C49_USED_IN_HOUSE_EU
rename WagesCode       C49_WAGES_CODE
rename Wages           C49_WAGES_EU
rename OtherCode       C49_OTHER_CODE
rename Other           C49_OTHER_EU
rename DirectCostsCode C49_DIRECT_COSTS_CODE
rename DirectCosts     C49_DIRECT_COSTS_EU
rename SubsidiesCode   C49_SUBSIDIES_CODE
rename Subsidies       C49_SUBSIDIES_EU
*====================================================================
capture drop junk*
