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



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*===================================================================
rename code1      junk_47_63
rename NoofUnits1 junk_47_64
rename ValUnit1   junk_47_65
rename code2      junk_47_66
rename NoofUnits2 junk_47_67
rename ValUnit2   junk_47_68
rename code3      junk_47_69
rename NoofUnits3 junk_47_70
rename ValUnit3   junk_47_71
rename code4      junk_47_72
rename NoofUnits4 junk_47_73
rename ValUnit4   junk_47_74
rename code5      junk_47_75
rename NoofUnits5 junk_47_76
rename ValUnit5   junk_47_77
rename ToTalUnits junk_47_78
*====================================================================
capture drop junk*
