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
*	  Sheet19.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet19") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*====================================================================
rename closingInventoryNumberDairyC DAIRY_COWS1_CLOS_INV_NO
rename closingInventoryValueDairyCo DAIRY_COWS1_CLOS_INV_EU
rename E                            DAIRY_COWS2_CLOS_INV_NO
rename F                            DAIRY_COWS2_CLOS_INV_EU
rename closingInventoryNumberDairyS DAIRY_STOCK_BULLS_CLOS_INV_NO
rename closingInventoryValueDairySt DAIRY_STOCK_BULLS_CLOS_INV_EU
rename closingInventoryNumberCalves DAIRY_CALVES_LT1WEEK_CLOS_INV_NO
rename closingInventoryValueCalvesl DAIRY_CALVES_LT1WEEK_CLOS_INV_EU
rename closingInventoryNumberOther  CATTLE_OTHER_CLOS_INV_NO
rename closingInventoryValueOther   CATTLE_OTHER_CLOS_INV_EU
rename closingInventoryTotalNumber  CATTLE_TOTAL_CLOS_INV_NO
*====================================================================
capture drop junk*

