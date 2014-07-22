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
*	  Sheet60.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet60") firstrow clear
}



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*===================================================================
rename Paidcasuallabourallocatedto  junk_60_23
rename D                            junk_60_24
rename E                            junk_60_25
rename F                            junk_60_26
rename G                            junk_60_27
rename H                            junk_60_28
rename PaidcasuallabourNonAllocable junk_60_29
rename J                            junk_60_30
rename K                            junk_60_31
rename L                            junk_60_32
rename M                            junk_60_33
rename N                            junk_60_34
rename O                            junk_60_35
rename P                            junk_60_36
rename Q                            junk_60_37
rename R                            junk_60_38
rename S                            junk_60_39
rename T                            junk_60_40
rename U                            junk_60_41
rename PaidcasuallabourTotalAllocat junk_60_42
*====================================================================
capture drop junk*
