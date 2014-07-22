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
*	  Sheet22.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet22") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*====================================================================
rename closingInventoryOtherCowsNum CATTLE_OTHER_COWS_CLOS_INV_NO
rename closingInventoryOtherCowsH   CATTLE_OTHER_COWS_CLOS_INV_EU
rename closingInventoryInCalfHeifer CATTLE_IN_CALF_HF_CLOS_INV_NO
rename F                            CATTLE_IN_CALF_HF_CLOS_INV_EU
rename DroppedCalvesNo              junk_22_62
rename DroppedCalves                junk_22_63
rename closingInventoryCalveslessth CATTLE_CALVES_LT6M_CLOS_INV_NO
rename J                            CATTLE_CALVES_LT6M_CLOS_INV_EU
rename closingInventoryCalves6month CATTLE_CALVES_6M_1YR_CLOS_INV_NO
rename L                            CATTLE_CALVES_6M_1YR_CLOS_INV_EU
rename closingInventoryMaleCattle1  CATTLE_MALE_1_2Y_CLOS_INV_NO
rename N                            CATTLE_MALE_1_2Y_CLOS_INV_EU
rename closingInventoryFemaleCattle CATTLE_FEMALE_1_2Y_CLOS_INV_NO
rename P                            CATTLE_FEMALE_1_2Y_CLOS_INV_EU
rename closingInventoryMaleCattle2  CATTLE_MALE_2_3Y_CLOS_INV_NO
rename R                            CATTLE_MALE_2_3Y_CLOS_INV_EU
rename closingInventoryfemaleCattle CATTLE_FEMALE_2_3Y_CLOS_INV_NO
rename T                            CATTLE_FEMALE_2_3Y_CLOS_INV_EU
rename closingInventoryStockBullsNu CATTLE_STOCK_BULLS_CLOS_INV_NO
rename closingInventoryStockBulls   CATTLE_STOCK_BULLS_CLOS_INV_EU
rename closingInventorTotalNumber   CATTLE_TOTAL_CLOS_INV_NO
*====================================================================
capture drop junk*
* Had to remove letters from CATTLE_IN_CALF_HF_CLOS_INV_NO
* Had to remove letters from CATTLE_IN_CALF_HF_CLOS_INV_EU
* Had to remove letters MTHS = M YRS=Y
