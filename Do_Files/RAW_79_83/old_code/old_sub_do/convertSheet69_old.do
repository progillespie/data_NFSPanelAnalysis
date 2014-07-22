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
*	  Sheet69.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet69") firstrow clear
}



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*===================================================================
rename exceptionlaprofitinformerper junk_69_7
rename exceptionlalossinformerperio junk_69_8
rename exceptionlaprofitonclearance junk_69_9
rename exceptionlalossonclearancesa junk_69_10
rename exceptionlaprofitonamountsdu junk_69_11
rename exceptionlalossonamountsdue  junk_69_12
rename exceptionlaprofitonprofitl   junk_69_13
rename exceptionlalossonprofitlos   junk_69_14
rename familysettlement             junk_69_15
rename ptherdebts                   junk_69_16
rename creditors                    junk_69_17
rename other                        junk_69_18
rename cashonhand                   junk_69_19
rename investments                  junk_69_20
rename debtors                      junk_69_21
rename R                            junk_69_22
*====================================================================
capture drop junk*
