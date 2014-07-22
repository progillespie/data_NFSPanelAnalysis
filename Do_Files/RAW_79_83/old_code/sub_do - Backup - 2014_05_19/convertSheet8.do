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
rename CommonageSheep1NoofAnimals  junk_08_14
rename CommonageSheep1NoofDays     junk_08_15
rename CommonageSheep1             junk_08_16
rename CommonageSheep1LUEquivalen  junk_08_17
rename CommonageSheep2NoofAnimals  junk_08_18
rename CommonageSheep2NoofDays     junk_08_19
rename CommonageSheep2             junk_08_20
rename CommonageSheep2LUEquivalen  junk_08_21
rename CommonageHorsesNoofAnimals  junk_08_22
rename CommonageHorsesNoofDays     junk_08_23
rename CommonageHorses             junk_08_24
rename CommonageHorsesLUEquivalent junk_08_25
*====================================================================
capture drop junk*

