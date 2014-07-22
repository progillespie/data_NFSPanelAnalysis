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
*	  Sheet10.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet10") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"







*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*====================================================================
rename BoardinginDairyCattleNoo   junk_10_50
rename D                          junk_10_51
rename BoardinginDairyCattle      junk_10_52
rename BoardinginDairyCattleLU    junk_10_53
rename G                          junk_10_54
rename H                          junk_10_55
rename I                          junk_10_56
rename J                          junk_10_57
rename K                          junk_10_58
rename L                          junk_10_59
rename M                          junk_10_60
rename N                          junk_10_61
rename BoardinginSheep1NoofAnima  BOARDING_IN_SHEEP1_ANIMALS_NO
rename BoardinginSheep1NoofDays   BOARDING_IN_SHEEP1_DAYS_NO
rename BoardinginSheep1           BOARDING_IN_SHEEP1_EU
rename BoardinginSheep1LUEquival  BOARDING_IN_SHEEP1_LU_EQUIV
rename BoardinginSheep2NoofAnima  BOARDING_IN_SHEEP2_ANIMALS_NO
rename BoardinginSheep2NoofDays   BOARDING_IN_SHEEP2_DAYS_NO
rename BoardinginSheep2           BOARDING_IN_SHEEP2_EU
rename BoardinginSheep2LUEquival  BOARDING_IN_SHEEP2_LU_EQUIV
rename BoardinginHorsesNoofAnimal BOARDING_IN_HORSES_ANIMALS_NO
rename BoardinginHorsesNoofDays   BOARDING_IN_HORSES_DAYS_NO
rename BoardinginHorses           BOARDING_IN_HORSES_EU
rename BoardinginHorsesLUEquivale BOARDING_IN_HORSES_LU_EQUIV
*====================================================================
capture drop junk*

