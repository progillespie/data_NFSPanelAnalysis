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
*	  Sheet6.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet6") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*====================================================================
rename GroundCutOnceacres           fsiz1hay
rename GroundCutOnceofproduction    junk_06_3
rename GroundCuttwiceacres          fsiz2hay
rename GroundCuttwiceofproductio    junk_06_5
rename GroundCutthriceacres         fsiz3hay
rename GroundCutthriceofproducti    junk_06_7
rename OpeningInventoryTotalValue   junk_06_8
rename OpeningInventoryQuantitytonn junk_06_9
rename TotalYieldtonnes             junk_06_10
rename TotalAvailablefordisposal    junk_06_11
rename AmountFedtonnes              junk_06_12
rename AmountSoldtonnes             junk_06_13
rename ValueSold                    junk_06_14
rename Allowancestonnes             junk_06_15
rename AllowancesTotalvalue         junk_06_16
rename Wastetonnes                  junk_06_17
rename ClosingInventorytonnes       junk_06_18
*====================================================================
capture drop junk*

