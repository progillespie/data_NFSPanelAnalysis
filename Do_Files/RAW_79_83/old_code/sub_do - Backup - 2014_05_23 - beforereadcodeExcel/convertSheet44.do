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
*	  Sheet44.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet44") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*===================================================================
rename HorsesOpeningInventoryBreedin HORSES_BREED_STOCK1_OP_INV_NO
rename D                             HORSES_BREED_STOCK1_OP_INV_EU
rename E                             HORSES_BREED_STOCK2_OP_INV_NO
rename F                             HORSES_BREED_STOCK2_OP_INV_EU
rename HorsesOpeningInventoryOtherS  HORSES_OTHER_STOCK1_OP_INV_NO
rename H                             HORSES_OTHER_STOCK1_OP_INV_EU
rename HorsesOpeningInventoryNumber  HORSES1_OP_INV_NO
rename HorsesOpeningInventoryValue   HORSES1_OP_INV_PERUNIT_EU
rename K                             HORSES2_OP_INV_NO
rename L                             HORSES2_OP_INV_PERUNIT_EU
rename M                             HORSES3_OP_INV_NO
rename N                             HORSES3_OP_INV_PERUNIT_EU
rename O                             HORSES4_OP_INV_NO
rename P                             HORSES4_OP_INV_PERUNIT_EU
rename HorsesOpeningInventoryTotal   TOTAL_HORSES_OP_INV_NO
rename OpeningInventoryCode          OP_INV_CODE
rename OpeningInventoryNumber        OP_INV_NO
rename OpeningInventoryValuehd       OP_INV_PERUNIT_EU
rename OpeningInventoryBreedingAnima BREEDING_ANIMALS_OP_INV_CODE
rename V                             BREEDING_ANIMALS_OP_INV_NO
rename W                             BREEDING_ANIMALS_OP_INV_EU
rename OpeningInventoryOthersCode    OTHERS_OP_INV_CODE
rename OpeningInventoryOthersNumber  OTHERS_OP_INV_NO
rename OpeningInventoryOthersValueh  OTHERS_OP_INV_PERUNIT_EU
*====================================================================
capture drop junk*
* Removed PERUNIT_ from HORSE BREED STOCK, HORSES OTHER,  and BREEDING ANIMALS vars
