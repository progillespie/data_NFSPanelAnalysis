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
*	  Sheet15.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet15") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"







*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*====================================================================
rename Wholemilksoldtocreamerylitr doslcmgl
rename Wholemilksoldtocreamery     doslcmvl
rename Bonuses                     domlkbon
rename TotalQuantityButterFatkgs   dabotfat
rename AverageButterFat            junk_15_6
rename FedToCalves                 junk_15_9
rename FedToPigs                   junk_15_10
rename FedToPoultry                junk_15_11
rename ButterSoldHomemadekgs       junk_15_12
rename ButterSoldHomemade          junk_15_13
rename CreamSoldPints              junk_15_14
rename CreamSold                   junk_15_15
*====================================================================
capture drop junk*

