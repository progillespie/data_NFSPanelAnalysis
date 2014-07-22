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
*	  Sheet55.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet55") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*===================================================================
rename GrantsSubsidiesMiscellaneous MISC_GRANTS_SUBSIDIES_EU
rename D                            MISC_GRANTS_SUBS_PREV_YEARS_EU
rename HiredMachineryInCash         HIRED_MACHINERY_IN_CASH_EU
rename HiredMachineryInKind         HIRED_MACHINERY_IN_KIND_EU
rename OtherReceiptsInCash          OTHER_RECEIPTS_IN_CASH_EU
rename OtherReceiptsInKind          OTHER_RECEIPTS_IN_KIND_EU
rename Total                        TOTAL_MISC_RECEIPTS_EU
rename OtherMiscellaneousExpensesin OTHER_MISC_EXPENSES_IN_CASH_EU
rename K                            OTHER_MISC_EXPENSES_IN_KIND_EU
rename Electricityfarmshare         ELECTRICITY_FARM_SHARE_EU
rename Telephonefarmshare           TELEPHONE_FARM_SHARE_EU
rename UsedinHouseOther             USED_IN_HOUSE_OTHER_EU
rename Carfarmshare                 FARM_SHARE_PERCENTAGE
rename P                            TOTAL_MISC_EXPENSES_EU
*====================================================================
* Shortened PREVIOUS YEARS var


*====================================================================
* Calculated variables
*====================================================================
*====================================================================
capture drop junk*
