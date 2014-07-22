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
capture rename GroundCutOnceacres           HAY_1ST_GROUND_CUT_HA
capture rename GroundCutOnceyield           HAY_1ST_CUT_YIELD_TONNES
capture rename GroundCutOnceofproduction    HAY_1ST_CUT_PRODUCTION_PERCENT
capture rename GroundCuttwiceacres          HAY_2ND_GROUND_CUT_HA
capture rename GroundCutTwiceyield          HAY_2ND_CUT_YIELD_TONNES
capture rename GroundCuttwiceofproductio    HAY_2ND_CUT_PRODUCTION_PERCENT
capture rename GroundCutthriceacres         HAY_3RD_GROUND_CUT_HA
capture rename GroundCutThriceyield         HAY_3RD_CUT_YIELD_TONNES
capture rename GroundCutthriceofproducti    HAY_3RD_CUT_PRODUCTION_PERCENT
capture rename OpeningInventoryTotalValue   HAY_OP_INV_TOTAL_VALUE_EU
capture rename OpeningInventoryQuantitytonn HAY_OP_INV_QTY_TONNES
capture rename TotalYieldtonnes             HAY_TOTAL_YIELD_TONNES
capture rename TotalAvailablefordisposal    HAY_TOTAL_AVAILABLE_TONNES
capture rename AmountFedtonnes              HAY_FED_QUANTITY_TONNES
capture rename AmountSoldtonnes             HAY_SALES_QUANTITY_TONNES
capture rename ValueSold                    HAY_SALES_VALUE_EU
capture rename Allowancestonnes             HAY_ALLOW_QUANTITY_TONNES
capture rename AllowancesTotalvalue         HAY_ALLOW_VALUE_EU
capture rename Wastetonnes                  HAY_WASTE_QUANTITY_TONNES
capture rename ClosingInventorytonnes       HAY_CLOSING_INV_QUANTITY_TONNES
*====================================================================
capture drop junk*

