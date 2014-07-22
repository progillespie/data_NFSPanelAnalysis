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
*	  Sheet55.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet55") firstrow clear
}



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*===================================================================
rename GrantsSubsidiesMiscellaneous junk_55_2
rename D                            junk_55_3
rename HiredMachineryInCash         junk_55_4
rename HiredMachineryInKind         junk_55_5
rename OtherReceiptsInCash          junk_55_6
rename OtherReceiptsInKind          junk_55_7
rename Total                        junk_55_8
rename OtherMiscellaneousExpensesin junk_55_9
rename K                            junk_55_10
rename Electricityfarmshare         junk_55_11
rename Telephonefarmshare           junk_55_12
rename UsedinHouseOther             junk_55_13
rename Carfarmshare                 junk_55_14
rename P                            junk_55_15
*====================================================================
capture drop junk*
