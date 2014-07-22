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
*	  Sheet34.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet34") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*===================================================================
rename MonthTotalBreedingEwes    MTH12_TOTAL_EWES_BREEDING_NO
rename MonthTotalLambsbeforewean MTH12_TOTAL_LAMBS_PRE_WEANING_NO
rename MonthTotalOtherlambsless  MTH12_TOTAL_LAMBS_LT1YR_NO
rename MonthTotalSheep12years    MTH12_TOTAL_SHEEP_1_2YRS_NO
rename MonthTotalSheepover2year  MTH12_TOTAL_SHEEP_GT2YRS_NO
rename MonthTotalRams            MTH12_TOTAL_RAMS_NO
rename MonthTotalAllSheep        MTH12_TOTAL_ALL_SHEEP_NO
*====================================================================
capture drop junk*
