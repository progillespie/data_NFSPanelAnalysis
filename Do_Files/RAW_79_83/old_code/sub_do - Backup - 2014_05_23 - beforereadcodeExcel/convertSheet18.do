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
*	  Sheet18.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet18") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*====================================================================
rename OpeningInventoryNumberDairyC DAIRY_COWS1_OP_INV_NO
rename OpeningInventoryValueDairyCo DAIRY_COWS1_OP_INV_EU
rename E                            DAIRY_COWS2_OP_INV_NO
rename F                            DAIRY_COWS2_OP_INV_EU
rename OpeningInventoryNumberDairyS DAIRY_STOCK_BULLS_OP_INV_NO
rename OpeningInventoryValueDairySt DAIRY_STOCK_BULLS_OP_INV_EU
rename OpeningInventoryNumberCalves DAIRY_CALVES_LT1WEEK_OP_INV_NO
rename OpeningInventoryValueCalvesl DAIRY_CALVES_LT1WEEK_OP_INV_EU
rename OpeningInventoryNumberOther  CATTLE_OTHER_OP_INV_NO
rename OpeningInventoryValueOther   CATTLE_OTHER_OP_INV_EU
rename OpeningInventoryTotalNumber  CATTLE_TOTAL_OP_INV_NO
*====================================================================
capture drop junk*

