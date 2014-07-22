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
*	  Sheet49.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet49") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*===================================================================
rename PurchasesCode   junk_49_90
rename Purchases       junk_49_91
rename SalesCode       junk_49_92
rename Sales           junk_49_93
rename UsedinHouseCode junk_49_94
rename UsedinHouse     junk_49_95
rename WagesCode       junk_49_96
rename Wages           junk_49_97
rename OtherCode       junk_49_98
rename Other           junk_49_99
rename DirectCostsCode junk_49_100
rename DirectCosts     junk_49_101
rename SubsidiesCode   junk_49_102
rename Subsidies       junk_49_103
*====================================================================
capture drop junk*
