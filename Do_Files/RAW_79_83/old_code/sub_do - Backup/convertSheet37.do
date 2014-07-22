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



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*===================================================================
rename PigsSystemCode              junk_37_50
rename PigsNoofFarrowings          junk_37_51
rename PigsLiveBirths              junk_37_52
rename PigsDeathsbeforeweaning     junk_37_53
rename PigsDeathsFatteners         junk_37_54
rename PigsDeathsOthers            junk_37_55
rename Pigs12MonthTotalSows        junk_37_56
rename Pigs12MonthTotalGiltsinPig  junk_37_57
rename Pigs12MonthTotalBonhamsbefo junk_37_58
rename Pigs12MonthTotalWeaners     junk_37_59
rename Pigs12MonthTotalFatteners   junk_37_60
rename Pigs12MonthTotalFatteningSo junk_37_61
rename Pigs12MonthTotalStockBoars  junk_37_62
rename Pigs12MonthTotal            junk_37_63
*====================================================================
capture drop junk*
