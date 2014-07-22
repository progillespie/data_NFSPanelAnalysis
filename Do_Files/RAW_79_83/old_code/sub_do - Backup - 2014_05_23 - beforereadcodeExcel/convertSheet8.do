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
*	  Sheet8.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet8") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*====================================================================
rename CommonageDairyCattleNoof    junk_08_2
rename D                           junk_08_3
rename CommonageDairyCattle        junk_08_4
rename CommonageDairyCattleLUEq    junk_08_5
rename G                           junk_08_6
rename H                           junk_08_7
rename I                           junk_08_8
rename J                           junk_08_9
rename K                           junk_08_10
rename L                           junk_08_11
rename M                           junk_08_12
rename N                           junk_08_13
rename CommonageSheep1NoofAnimals  COMMONAGE_SHEEP1_ANIMALS_NO
rename CommonageSheep1NoofDays     COMMONAGE_SHEEP1_DAYS_NO
rename CommonageSheep1             COMMONAGE_SHEEP1_EU
rename CommonageSheep1LUEquivalen  COMMONAGE_SHEEP1_LU_EQUIV
rename CommonageSheep2NoofAnimals  COMMONAGE_SHEEP2_ANIMALS_NO
rename CommonageSheep2NoofDays     COMMONAGE_SHEEP2_DAYS_NO
rename CommonageSheep2             COMMONAGE_SHEEP2_EU
rename CommonageSheep2LUEquivalen  COMMONAGE_SHEEP2_LU_EQUIV
rename CommonageHorsesNoofAnimals  COMMONAGE_HORSES_ANIMALS_NO
rename CommonageHorsesNoofDays     COMMONAGE_HORSES_DAYS_NO
rename CommonageHorses             COMMONAGE_HORSES_EU
rename CommonageHorsesLUEquivalent COMMONAGE_HORSES_LU_EQUIV
*====================================================================
capture drop junk*

