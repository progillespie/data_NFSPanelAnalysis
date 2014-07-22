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
*	  Sheet51.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet51") firstrow clear
}



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*===================================================================
rename PurchasedConcentrateAllocated icalldyq
rename D                             icalldyv
rename E                             icallcqt
rename F                             icallcvl
rename G                             icallsqt
rename H                             icallsvl
rename I                             icallhqt
rename J                             icallhvl
rename K                             icallpgq
rename L                             icallpgv
rename M                             icallpyq
rename N                             icallpyv
rename O                             icallolq
rename P                             icallolv
rename Q                             icwasteq
rename R                             icwastev
rename PurchasedConcentrateTotalAllo junk_51_30
rename T                             junk_51_31
rename MilkSubstitutefedtoCalves50   icmksubq
rename MilkSubstitutefedtoCalvesCo   icmksubv
*====================================================================
capture drop junk*
