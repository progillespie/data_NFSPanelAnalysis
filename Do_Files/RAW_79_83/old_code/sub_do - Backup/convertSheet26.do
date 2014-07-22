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
*	  Sheet26.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet26") firstrow clear
}



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*====================================================================
rename MonthTotalDairyCows       junk_26_115
rename MonthTotalDairyStockBulls junk_26_116
rename MonthTotalOtherCows       junk_26_117
rename MonthTotalHeiferInCalf    junk_26_118
rename MonthTotalCalveslessthan  junk_26_119
rename MonthTotalCalves612month  junk_26_120
rename MonthTotalCattle12Years   junk_26_121
rename MonthTotalCattleover2Yea  junk_26_122
rename MonthTotalBeefStockBulls  cpavnobl
rename MonthTotalallcattle       cptotcno
*====================================================================
capture drop junk*

