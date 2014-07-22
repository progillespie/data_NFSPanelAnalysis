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
*	  Sheet46.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet46") firstrow clear
}



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*===================================================================
rename HorsesOtherEquinesPurchases   junk_46_47
rename HorsesOtherEquinesSales       junk_46_48
rename HorsesOtherEquinesOtherRec    junk_46_49
rename HorsesOtherEquinesSubsidi     junk_46_50
rename OtherLivestockPurchases       junk_46_51
rename OtherLivestockSales           junk_46_52
rename OtherLivestockAllowancesiuse  junk_46_53
rename OtherLivestockAllowanceswages junk_46_54
rename OtherLivestockAllowancesother junk_46_55
rename MonthTotalNoHorsesDraug       junk_46_56
rename MonthTotalNoHorsesUnder       junk_46_57
rename MonthTotalNooverOver2         junk_46_58
rename MonthTotalNoPonies            junk_46_59
rename MonthTotalNoMulesJenne        junk_46_60
rename Asses                         junk_46_61
rename MonthTotalNoT                 junk_46_62
*====================================================================
capture drop junk*
