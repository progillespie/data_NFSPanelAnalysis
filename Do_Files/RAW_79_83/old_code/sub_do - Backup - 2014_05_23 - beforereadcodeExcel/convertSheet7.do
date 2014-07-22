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
capture rename GroundCutOnceacres           SIL_1ST_GROUND_CUT_HA
capture rename GroundCutOnceyield           SIL_1ST_CUT_YIELD_TONNES
capture rename GroundCutOnceofproduction    SIL_1ST_CUT_PRODUCTION_PERCENT
capture rename GroundCuttwiceacres          SIL_2ND_GROUND_CUT_HA
capture rename GroundCutTwiceyield          SIL_2ND_CUT_YIELD_TONNES
capture rename GroundCuttwiceofproductio    SIL_2ND_CUT_PRODUCTION_PERCENT
capture rename GroundCutthriceacres         SIL_3RD_GROUND_CUT_HA
capture rename GroundCutThriceyield         SIL_3RD_CUT_YIELD_TONNES
capture rename GroundCutthriceofproducti    SIL_3RD_CUT_PRODUCTION_PERCENT
capture rename OpeningInventoryTotalValue   SIL_OP_INV_TOTAL_VALUE_EU
capture rename OpeningInventoryQuantitytonn SIL_OP_INV_QTY_TONNES
capture rename TotalYieldtonnes             SIL_TOTAL_YIELD_TONNES
capture rename TotalAvailablefordisposal    SIL_TOTAL_AVAILABLE_TONNES
capture rename AmountFedtonnes              SIL_FED_QUANTITY_TONNES
capture rename AmountSoldtonnes             SIL_SALES_QUANTITY_TONNES
capture rename ValueSold                    SIL_SALES_VALUE_EU
capture rename Allowancestonnes             SIL_ALLOW_QUANTITY_TONNES
capture rename AllowancesTotalvalue         SIL_ALLOW_VALUE_EU
capture rename Wastetonnes                  SIL_WASTE_QUANTITY_TONNES
capture rename ClosingInventorytonnes       SIL_CLOSING_INV_QUANTITY_TONNES
*====================================================================
capture drop junk*

