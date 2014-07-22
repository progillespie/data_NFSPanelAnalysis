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



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*====================================================================
rename MonthTotalDairyCows       MTH12_TOTAL_DAIRY_COWS_NO
rename MonthTotalDairyStockBulls MTH12_TOTAL_DAIRY_STOCK_BULLS_NO
rename MonthTotalOtherCows       MTH12_TOTAL_OTHER_COWS_NO
rename MonthTotalHeiferInCalf    MTH12_TOTAL_IN_CALF_HEIFERS_NO
rename MonthTotalCalveslessthan  MTH12_TOTAL_CALVES_LT6MTHS_NO
rename MonthTotalCalves612month  MTH12_TOTAL_CALVES_6_12MTHS_NO
rename MonthTotalCattle12Years   MTH12_TOTAL_CATTLE_1_2YRS_NO
rename MonthTotalCattleover2Yea  MTH12_TOTAL_CATTLE_GT2YRS_NO
rename MonthTotalBeefStockBulls  MTH12_TOTAL_BEEF_STOCK_BULLS_NO
rename MonthTotalallcattle       MTH12_TOTAL_ALL_CATTLE_NO
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
