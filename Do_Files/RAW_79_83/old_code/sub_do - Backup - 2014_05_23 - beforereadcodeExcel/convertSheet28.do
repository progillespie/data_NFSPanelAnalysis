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
*	  Sheet28.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet28") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*====================================================================
rename DairycowsinmilkJanuary   LIQUID_LITRES_SOLD_JAN_LT
rename DairycowsinmilkFebruary  LIQUID_LITRES_SOLD_FEB_LT
rename DairycowsinmilkMarch     LIQUID_LITRES_SOLD_MAR_LT
rename DairycowsinmilkApril     LIQUID_LITRES_SOLD_APR_LT
rename DairycowsinmilkMay       LIQUID_LITRES_SOLD_MAY_LT
rename DairycowsinmilkJune      LIQUID_LITRES_SOLD_JUN_LT
rename DairycowsinmilkJuly      LIQUID_LITRES_SOLD_JUL_LT
rename DairycowsinmilkAugust    LIQUID_LITRES_SOLD_AUG_LT
rename DairycowsinmilkSeptember LIQUID_LITRES_SOLD_SEP_LT
rename DairycowsinmilkOctober   LIQUID_LITRES_SOLD_OCT_LT
rename DairycowsinmilkNovember  LIQUID_LITRES_SOLD_NOV_LT
rename DairycowsinmilkDecember  LIQUID_LITRES_SOLD_DEC_LT
rename DairycowsinmilkTotal     LIQUID_LITRES_SOLD_LT_SUBCARD
*====================================================================
capture drop junk*

