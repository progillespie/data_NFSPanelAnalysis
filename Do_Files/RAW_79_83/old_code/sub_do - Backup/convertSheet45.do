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



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*===================================================================
rename HorsesClosingInventoryBreedin junk_45_26
rename D                             junk_45_27
rename E                             junk_45_28
rename F                             junk_45_29
rename HorsesClosingInventoryOtherS  junk_45_30
rename H                             junk_45_31
rename HorsesClosingInventoryNumber  junk_45_32
rename HorsesClosingInventoryValue   junk_45_33
rename K                             junk_45_34
rename L                             junk_45_35
rename M                             junk_45_36
rename N                             junk_45_37
rename O                             junk_45_38
rename P                             junk_45_39
rename HorsesClosingInventoryTotal   junk_45_40
rename ClosingInventoryNumber        junk_45_41
rename ClosingInventoryValuehd       junk_45_42
rename ClosingInventoryBreedingAnima junk_45_43
rename U                             junk_45_44
rename ClosingInventoryOthersNumber  junk_45_45
rename ClosingInventoryOthersValueh  junk_45_46
*====================================================================
capture drop junk*
