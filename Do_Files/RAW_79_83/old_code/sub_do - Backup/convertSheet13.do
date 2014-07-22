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
* 	The required input files are in:       
*       
*        Data/data_NFSPanelAnalysis/OrigData/RAW_79_83 
*
*
*	This file will produce: 
*       
*	  Sheet13.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet13") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*====================================================================
rename OpeningInventoryQuantity50kg  junk_13_17
rename OpeningInventoryTotalValue    junk_13_18
rename PurchasedduringYearQuantity5  junk_13_19
rename PurchasedduringYearTotalValue junk_13_20
rename UsedduringYearQuantity50kg    junk_13_21
rename UsedduringYearTotalValue      junk_13_22
rename WasteQuantity50kgBags         junk_13_23
rename WasteTotalValue               junk_13_24
rename ClosingInventoryQuantity50kg  junk_13_25
rename ClosingInventoryTotalValue    junk_13_26
rename LimeOpeningInventoryTonnes    junk_13_27
rename LimeOpeningInventory          junk_13_28
rename LimePurchasedduringYearTonne  junk_13_29
rename LimePurchasedduringYear       foexlime
rename LimeClosingInventoryTonnes    junk_13_31
rename LimeClosingInventory          junk_13_32
rename SlurryandorFYMpurchases       junk_13_33
rename OtherCropExpensesOpeningInve  junk_13_34
rename OtherCropExpensesClosingInve  junk_13_35
*====================================================================
capture drop junk*
