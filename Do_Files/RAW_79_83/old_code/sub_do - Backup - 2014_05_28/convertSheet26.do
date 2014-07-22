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

local i = 26

if "`standalone'"=="standalone"{
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet26") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Apply renaming do file from appropriate mapping sheet of 
*   raw2IBnamemappings.xlsx here
*====================================================================
do sub_do/renameSheet`i'.do
*====================================================================



*====================================================================
* Calculated variables
*====================================================================
gen D_HERD_SIZE_AVG_NO                 = MTH12_TOTAL_DAIRY_COWS_NO/12
gen D_DAIRY_LU_INCL_BULLS =     ///
     MTH12_TOTAL_DAIRY_COWS_NO        / 12 + ///
     MTH12_TOTAL_DAIRY_STOCK_BULLS_NO / 12
gen D_TOTAL_CATTLE_NO                  = MTH12_TOTAL_ALL_CATTLE_NO / 12
*====================================================================
capture drop junk*
* Had to shorten D_DAIRY_LU_INCL_BULLS 
