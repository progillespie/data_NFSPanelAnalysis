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
*	  Sheet45.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet45") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*===================================================================
rename HorsesClosingInventoryBreedin HORSES_BREED_STOCK1_CLOS_INV_NO
rename D                             HORSES_BREED_STOCK1_CLOS_INV_EU
rename E                             HORSES_BREED_STOCK2_CLOS_INV_NO
rename F                             HORSES_BREED_STOCK2_CLOS_INV_EU
rename HorsesClosingInventoryOtherS  HORSES_OTHER_STOCK1_CLOS_INV_NO
rename H                             HORSES_OTHER_STOCK1_CLOS_INV_EU
rename HorsesClosingInventoryNumber  HORSES1_CLOS_INV_NO
rename HorsesClosingInventoryValue   HORSES1_CLOS_INV_PERUNIT_EU
rename K                             HORSES2_CLOS_INV_NO
rename L                             HORSES2_CLOS_INV_PERUNIT_EU
rename M                             HORSES3_CLOS_INV_NO
rename N                             HORSES3_CLOS_INV_PERUNIT_EU
rename O                             HORSES4_CLOS_INV_NO
rename P                             HORSES4_CLOS_INV_PERUNIT_EU
rename HorsesClosingInventoryTotal   TOTAL_HORSES_CLOS_INV_NO
rename ClosingInventoryNumber        CLOS_INV_NO
rename ClosingInventoryValuehd       CLOS_INV_PERUNIT_EU
rename ClosingInventoryBreedingAnima BREEDING_ANIMALS_CLOS_INV_NO
rename U                             BREEDING_ANIMALS_CLOS_INV_EU
rename ClosingInventoryOthersNumber  OTHERS_CLOS_INV_NO
rename ClosingInventoryOthersValueh  OTHERS_CLOS_INV_PERUNIT_EU
*====================================================================
capture drop junk*
* Removed PERUNIT from same vars as OP vars. Also removing ing in breeding.
