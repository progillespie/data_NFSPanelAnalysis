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
*	  Sheet27.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet27") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*====================================================================
rename CalfBirthsJanuary           BIRTHS_JAN_NO
rename CalfBirthsFebruary          BIRTHS_FEB_NO
rename CalfBirthsMarch             BIRTHS_MAR_NO
rename CalfBirthsApril             BIRTHS_APR_NO
rename CalfBirthsMay               BIRTHS_MAY_NO
rename CalfBirthsJune              BIRTHS_JUN_NO
rename CalfBirthsJuly              BIRTHS_JUL_NO
rename CalfBirthsAugust            BIRTHS_AUG_NO
rename CalfBirthsSeptember         BIRTHS_SEP_NO
rename CalfBirthsOctober           BIRTHS_OCT_NO
rename CalfBirthsNovember          BIRTHS_NOV_NO
rename CalfBirthsDecember          BIRTHS_DEC_NO
rename CalfBirthsTotal             BIRTHS_TOTAL_NO
rename CattleDeathslessthan6Months DEATHS_LT6MTHS_NO
rename CattleDeathsGreaterthan6Mon DEATHS_GT6MTHS_NO
rename CattleDeathsAllCows         DEATHS_CATTLE_HERD_COWS_NO
rename DeadCalfBirths              DEATHS_CALVES_AT_BIRTH_NO
*====================================================================
capture drop junk*
