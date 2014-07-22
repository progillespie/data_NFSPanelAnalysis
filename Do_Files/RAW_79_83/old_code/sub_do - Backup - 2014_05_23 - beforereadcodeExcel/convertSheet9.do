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
rename BoardingoutSheep1NoofAnim  BOARDING_OUT_SHEEP1_ANIMALS_NO
rename BoardingoutSheep1NoofDays  BOARDING_OUT_SHEEP1_DAYS_NO
rename BoardingoutSheep1          BOARDING_OUT_SHEEP1_EU
rename BoardingoutSheep1LUEquiva  BOARDING_OUT_SHEEP1_LU_EQUIV
rename BoardingoutSheep2NoofAnim  BOARDING_OUT_SHEEP2_ANIMALS_NO
rename BoardingoutSheep2NoofDays  BOARDING_OUT_SHEEP2_DAYS_NO
rename BoardingoutSheep2          BOARDING_OUT_SHEEP2_EU
rename BoardingoutSheep2LUEquiva  BOARDING_OUT_SHEEP2_LU_EQUIV
rename BoardingoutHorsesNoofAnima BOARDING_OUT_HORSES_ANIMALS_NO
rename BoardingoutHorsesNoofDays  BOARDING_OUT_HORSES_DAYS_NO
rename BoardingoutHorses          BOARDING_OUT_HORSES_EU
rename BoardingoutHorsesLUEquival BOARDING_OUT_HORSES_LU_EQUIV
*====================================================================
capture drop junk*
