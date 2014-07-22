args standalone YY validate
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
*	  Sheet23.dta 
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

local i = 23

if "`standalone'"=="standalone"{
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw`YY'_head.xls", sheet("Sheet23") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Apply renaming do file from appropriate mapping sheet of 
*   raw2IBnamemappings.xlsx here
*====================================================================
do sub_do/_renameSheet/renameSheet`i'.do
*====================================================================
capture drop junk*
* Removed letters from replacement vars and bull services.

