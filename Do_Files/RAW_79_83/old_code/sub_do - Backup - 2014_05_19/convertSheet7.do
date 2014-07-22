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
*	  Sheet7.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet7") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*====================================================================
rename GroundCutOnceacres           fsizslg1
rename GroundCutOnceofproduction    junk_07_20
rename GroundCuttwiceacres          fsizslg2
rename GroundCuttwiceofproductio    junk_07_22
rename GroundCutthriceacres         fsizslg3
rename GroundCutthriceofproducti    junk_07_24
rename OpeningInventoryTotalValue   junk_07_25
rename OpeningInventoryQuantitytonn junk_07_26
rename TotalYieldtonnes             junk_07_27
rename TotalAvailablefordisposal    junk_07_28
rename AmountFedtonnes              junk_07_29
rename AmountSoldtonnes             junk_07_30
rename ValueSold                    junk_07_31
rename Allowancestonnes             junk_07_32
rename AllowancesTotalvalue         junk_07_33
rename Wastetonnes                  junk_07_34
rename ClosingInventorytonnes       junk_07_35
*====================================================================
capture drop junk*

