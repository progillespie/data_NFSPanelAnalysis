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
rename HorsesOpeningInventoryBreedin junk_44_2
rename D                             junk_44_3
rename E                             junk_44_4
rename F                             junk_44_5
rename HorsesOpeningInventoryOtherS  junk_44_6
rename H                             junk_44_7
rename HorsesOpeningInventoryNumber  junk_44_8
rename HorsesOpeningInventoryValue   junk_44_9
rename K                             junk_44_10
rename L                             junk_44_11
rename M                             junk_44_12
rename N                             junk_44_13
rename O                             junk_44_14
rename P                             junk_44_15
rename HorsesOpeningInventoryTotal   junk_44_16
rename OpeningInventoryCode          junk_44_17
rename OpeningInventoryNumber        junk_44_18
rename OpeningInventoryValuehd       junk_44_19
rename OpeningInventoryBreedingAnima junk_44_20
rename V                             junk_44_21
rename W                             junk_44_22
rename OpeningInventoryOthersCode    junk_44_23
rename OpeningInventoryOthersNumber  junk_44_24
rename OpeningInventoryOthersValueh  junk_44_25
*====================================================================
capture drop junk*
