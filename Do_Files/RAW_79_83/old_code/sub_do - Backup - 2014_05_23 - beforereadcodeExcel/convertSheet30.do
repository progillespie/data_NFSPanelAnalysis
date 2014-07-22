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
*	  Sheet30.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet30") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*====================================================================
rename OpeningInventoryNumberEwes   EWES_OP_INV_NO
rename OpeningInventoryHeadEwes     EWES_OP_INV_EU
rename OpeningInventoryNumberLambsb LAMBS_PRE_WEANING_OP_INV_NO
rename OpeningInventoryLambsbeforeW LAMBS_PRE_WEANING_OP_INV_EU
rename OpeningInventoryNumberOtherl LAMBS_LT1YR_OP_INV_NO
rename OpeningInventoryHeadOtherl   LAMBS_LT1YR_OP_INV_EU
rename OpeningInventoryNumberSheep1 SHEEP_1_2YRS_OP_INV_NO
rename OpeningInventoryHeadSheep1   SHEEP_1_2YRS_OP_INV_EU
rename OpeningInventoryNumberSheepo SHEEP_GT2YRS_OP_INV_NO
rename OpeningInventoryHeadSheepo   SHEEP_GT2YRS_OP_INV_EU
rename OpeningInventoryNumberRams   RAMS_OP_INV_NO
rename OpeningInventoryHeadRams     RAMS_OP_INV_EU
rename OpeningInventoryNumberTotal  TOTAL_OP_INV_NO
rename OpeningInventoryQuantityWool WOOL_OP_INV_QTY_KGS
rename OpeningInventoryWoolValue    WOOL_OP_INV_VALUE_EU
*====================================================================
capture drop junk*



