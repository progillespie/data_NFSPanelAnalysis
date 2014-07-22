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
*	  Sheet31.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet31") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*====================================================================
rename ClosingInventoryNumberEwes   EWES_CLOS_INV_NO
rename ClosingInventoryHeadEwes     EWES_CLOS_INV_EU
rename ClosingInventoryNumberLambsb LAMBS_PRE_WEANING_CLOS_INV_NO
rename ClosingInventoryLambsbeforeW LAMBS_PRE_WEANING_CLOS_INV_EU
rename ClosingInventoryNumberOtherl LAMBS_LT1YR_CLOS_INV_NO
rename ClosingInventoryHeadOtherl   LAMBS_LT1YR_CLOS_INV_EU
rename ClosingInventoryNumberSheep1 SHEEP_1_2YRS_CLOS_INV_NO
rename ClosingInventoryHeadSheep1   SHEEP_1_2YRS_CLOS_INV_EU
rename ClosingInventoryNumberSheepo SHEEP_GT2YRS_CLOS_INV_NO
rename ClosingInventoryHeadSheepo   SHEEP_GT2YRS_CLOS_INV_EU
rename ClosingInventoryNumberRams   RAMS_CLOS_INV_NO
rename ClosingInventoryHeadRams     RAMS_CLOS_INV_EU
rename ClosingInventoryNumberTotal  TOTAL_CLOS_INV_NO
rename ClosingInventoryQuantityWool WOOL_CLOS_INV_QTY_KGS
rename ClosingInventoryWoolValue    WOOL_CLOS_INV_VALUE_EU
*====================================================================
capture drop junk*
