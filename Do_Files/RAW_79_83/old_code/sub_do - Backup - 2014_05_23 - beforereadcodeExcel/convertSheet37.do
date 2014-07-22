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
*	  Sheet37.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet37") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*===================================================================
rename PigsSystemCode              PigsSystemCode
rename PigsNoofFarrowings          FARROWINGS_NO
rename PigsLiveBirths              BIRTHS_LIVE_NO
rename PigsDeathsbeforeweaning     DEATHS_PRE_WEANING_NO
rename PigsDeathsFatteners         DEATHS_FATTENERS_NO
rename PigsDeathsOthers            DEATHS_OTHERS_NO
rename Pigs12MonthTotalSows        MTH12_TOTAL_SOWS_NO
rename Pigs12MonthTotalGiltsinPig  MTH12_TOTAL_GILTS_IN_PIG_NO
rename Pigs12MonthTotalBonhamsbefo MTH12_TOTAL_BONHAMS_PRE_W_NO
rename Pigs12MonthTotalWeaners     MTH12_TOTAL_WEANERS_NO
rename Pigs12MonthTotalFatteners   MTH12_TOTAL_FATTENERS_NO
rename Pigs12MonthTotalFatteningSo MTH12_TOTAL_FATTENING_SOWS_NO
rename Pigs12MonthTotalStockBoars  MTH12_TOTAL_STOCK_BOARS_NO
rename Pigs12MonthTotal            MTH12_TOTAL_ALL_PIGS_NO
*====================================================================
capture drop junk*
* Shortened BONHAMS var
