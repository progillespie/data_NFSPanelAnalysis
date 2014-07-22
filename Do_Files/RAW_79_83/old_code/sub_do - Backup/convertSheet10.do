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
rename BoardinginSheep1NoofAnima  junk_10_62
rename BoardinginSheep1NoofDays   junk_10_63
rename BoardinginSheep1           junk_10_64
rename BoardinginSheep1LUEquival  junk_10_65
rename BoardinginSheep2NoofAnima  junk_10_66
rename BoardinginSheep2NoofDays   junk_10_67
rename BoardinginSheep2           junk_10_68
rename BoardinginSheep2LUEquival  junk_10_69
rename BoardinginHorsesNoofAnimal junk_10_70
rename BoardinginHorsesNoofDays   junk_10_71
rename BoardinginHorses           junk_10_72
rename BoardinginHorsesLUEquivale junk_10_73
*====================================================================
capture drop junk*

