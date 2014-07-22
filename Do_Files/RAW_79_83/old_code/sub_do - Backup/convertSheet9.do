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
*	  Sheet9.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet9") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*====================================================================
rename BoardingoutDairyCattleNo   junk_09_26
rename D                          junk_09_27
rename BoardingoutDairyCattle     junk_09_28
rename BoardingoutDairyCattleLU   junk_09_29
rename G                          junk_09_30
rename H                          junk_09_31
rename I                          junk_09_32
rename J                          junk_09_33
rename K                          junk_09_34
rename L                          junk_09_35
rename M                          junk_09_36
rename N                          junk_09_37
rename BoardingoutSheep1NoofAnim  junk_09_38
rename BoardingoutSheep1NoofDays  junk_09_39
rename BoardingoutSheep1          junk_09_40
rename BoardingoutSheep1LUEquiva  junk_09_41
rename BoardingoutSheep2NoofAnim  junk_09_42
rename BoardingoutSheep2NoofDays  junk_09_43
rename BoardingoutSheep2          junk_09_44
rename BoardingoutSheep2LUEquiva  junk_09_45
rename BoardingoutHorsesNoofAnima junk_09_46
rename BoardingoutHorsesNoofDays  junk_09_47
rename BoardingoutHorses          junk_09_48
rename BoardingoutHorsesLUEquival junk_09_49
*====================================================================
capture drop junk*
