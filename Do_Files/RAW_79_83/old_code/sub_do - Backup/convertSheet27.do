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



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*====================================================================
rename CalfBirthsJanuary           dpcfbjan
rename CalfBirthsFebruary          dpcfbfeb
rename CalfBirthsMarch             dpcfbmar
rename CalfBirthsApril             dpcfbapr
rename CalfBirthsMay               dpcfbmay
rename CalfBirthsJune              dpcfbjun
rename CalfBirthsJuly              dpcfbjul
rename CalfBirthsAugust            dpcfbaug
rename CalfBirthsSeptember         dpcfbsep
rename CalfBirthsOctober           dpcfboct
rename CalfBirthsNovember          dpcfbnov
rename CalfBirthsDecember          dpcfbdec
rename CalfBirthsTotal             dpcfbtot
rename CattleDeathslessthan6Months cpdthclf
rename CattleDeathsGreaterthan6Mon junk_27_139
rename CattleDeathsAllCows         cpdthcow
rename DeadCalfBirths              cpdthbir
*====================================================================
capture drop junk*
