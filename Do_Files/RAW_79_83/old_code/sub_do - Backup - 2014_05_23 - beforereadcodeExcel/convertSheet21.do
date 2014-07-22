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
*	  Sheet21.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet21") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"


*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*====================================================================
rename OpeningInventoryOtherCowsNum CATTLE_OTHER_COWS_OP_INV_NO
rename OpeningInventoryOtherCowsH   CATTLE_OTHER_COWS_OP_INV_EU
rename OpeningInventoryInCalfHeifer CATTLE_IN_CALF_HEIFERS_OP_INV_NO
rename F                            CATTLE_IN_CALF_HEIFERS_OP_INV_EU
rename DroppedCalvesNo              junk_21_41
rename DroppedCalves                junk_21_42
rename OpeningInventoryCalveslessth CATTLE_CALVES_LT6MTHS_OP_INV_NO
rename J                            CATTLE_CALVES_LT6MTHS_OP_INV_EU
rename OpeningInventoryCalves6month CATTLE_CALVES_6M_1_OP_INV_NO
rename L                            CATTLE_CALVES_6M_1_OP_INV_EU
rename OpeningInventoryMaleCattle1  CATTLE_MALE_1_2YRS_OP_INV_NO
rename N                            CATTLE_MALE_1_2YRS_OP_INV_EU
rename OpeningInventoryFemaleCattle CATTLE_FEMALE_1_2YRS_OP_INV_NO
rename P                            CATTLE_FEMALE_1_2YRS_OP_INV_EU
rename OpeningInventoryMaleCattle2  CATTLE_MALE_2_3YRS_OP_INV_NO
rename R                            CATTLE_MALE_2_3YRS_OP_INV_EU
rename OpeningInventoryfemaleCattle CATTLE_FEMALE_2_3YRS_OP_INV_NO
rename T                            CATTLE_FEMALE_2_3YRS_OP_INV_EU
rename OpeningInventoryStockBullsNu CATTLE_STOCK_BULLS_OP_INV_NO
rename OpeningInventoryStockBulls   CATTLE_STOCK_BULLS_OP_INV_EU
rename OpeningInventorTotalNumber   CATTLE_TOTAL_OP_INV_NO
*====================================================================
capture drop junk*
* Had to remove a few letters from CATTLE_CALVES_6MTHS_1YR_OP_INV_NO
* Had to remove a few letters from CATTLE_CALVES_6MTHS_1YR_OP_INV_EU
