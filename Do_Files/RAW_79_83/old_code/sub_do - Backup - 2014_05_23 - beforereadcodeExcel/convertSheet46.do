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



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*===================================================================
rename HorsesOtherEquinesPurchases   HORSES_EQUINES_PURCHASES_EU
rename HorsesOtherEquinesSales       HORSES_EQUINES_SALES_EU
rename HorsesOtherEquinesOtherRec    HORSES_EQUINES_STUD_FEES_RCPT_EU
rename HorsesOtherEquinesSubsidi     HORSES_EQUINES_SUBSIDIES_RCPT_EU
rename OtherLivestockPurchases       OTHER_LIVESTOCK_PURCHASES_EU
rename OtherLivestockSales           OTHER_LIVESTOCK_SALES_EU
rename OtherLivestockAllowancesiuse  OTHER_LVSTCK_ALLOW_INCL_HOUSE_EU
rename OtherLivestockAllowanceswages junk_46_54
rename OtherLivestockAllowancesother junk_46_55
rename MonthTotalNoHorsesDraug       MTH12_TOTAL_HORSES_DRAUGHT_NO
rename MonthTotalNoHorsesUnder       MTH12_TOTAL_HORSES_LT2YR_NO
rename MonthTotalNooverOver2         MTH12_TOTAL_HORSES_GT2YR_NO
rename MonthTotalNoPonies            MTH12_TOTAL_PONIES_NO
rename MonthTotalNoMulesJenne        MTH12_TOTAL_MULES_JENNETS_NO
rename Asses                         MTH12_TOTAL_ASSES_NO
rename MonthTotalNoT                 MTH12_TOTAL_HORSES_EQUINES_NO
*====================================================================
capture drop junk*
* Shortened STUD FEES RECEIPTS vars and OTHER LIVESTOCK ALLOWANCES var
