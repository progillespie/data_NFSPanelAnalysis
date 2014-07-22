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
*	  Sheet47.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet47") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*===================================================================
rename code1      C47_CODE_1
rename NoofUnits1 C47_UNITS_NO_1
rename ValUnit1   C47_VAL_PER_UNIT_1
rename code2      C47_CODE_2
rename NoofUnits2 C47_UNITS_NO_2
rename ValUnit2   C47_VAL_PER_UNIT_2
rename code3      C47_CODE_3
rename NoofUnits3 C47_UNITS_NO_3
rename ValUnit3   C47_VAL_PER_UNIT_3
rename code4      C47_CODE_4
rename NoofUnits4 C47_UNITS_NO_4
rename ValUnit4   C47_VAL_PER_UNIT_4
rename code5      C47_CODE_5
rename NoofUnits5 C47_UNITS_NO_5
rename ValUnit5   C47_VAL_PER_UNIT_5
rename ToTalUnits C47_TOTAL_UNITS
*====================================================================
capture drop junk*
