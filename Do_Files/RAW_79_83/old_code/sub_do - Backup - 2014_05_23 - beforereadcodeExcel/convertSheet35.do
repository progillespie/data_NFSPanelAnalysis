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
*	  Sheet35.dta 
*
*	for each of the subdirectories of 
*       
*	  RAW_79_83/raw_dta/
*
*       
*	Algorithm: SUM ALL
*	
*
********************************************************
* READ THE README.txt FILE BEFORE CHANGING ANYTHING!!!
********************************************************



if "`standalone'"=="standalone"{
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet35") firstrow clear
}



rename farm farmcode
label var farm "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*====================================================================
rename OpeningInventorySowsinPigNu   SOWS_IN_PIG_OP_INV_NO
rename OpeningInventorySowsinPigVa   SOWS_IN_PIG_OP_INV_PERHEAD_EU
rename OpeningInventoryGiltsinPigN   GILTS_IN_PIG_OP_INV_NO
rename OpeningInventoryGiltsinPigV   GILTS_IN_PIG_OP_INV_PERHEAD_EU
rename OpeningInventorySowsSuckling  SOWS_SUCKLING_OP_INV_NO
rename H                             SOWS_SUCKLING_OP_INV_EU
rename OpeningInventoryBonhamsNumber BONHAMS_OP_INV_NO
rename OpeningInventoryBonhamsValue  BONHAMS_OP_INV_PERHEAD_EU
rename OpeningInventoryWeanersNumber WEANERS_OP_INV_NO
rename OpeningInventoryWeanersValue  WEANERS_OP_INV_PERHEAD_EU
rename OpeningInventoryFattenersNumb FATTENERS1_OP_INV_NO
rename OpeningInventoryFattenersWeig FATTENERS1_OP_INV_PERHEAD_KGS
rename OpeningInventoryFattenersValu FATTENERS1_OP_INV_PERHEAD_EU
rename P                             FATTENERS2_OP_INV_NO
rename Q                             FATTENERS2_OP_INV_PERHEAD_KGS
rename R                             FATTENERS2_OP_INV_PERHEAD_EU
rename S                             FATTENERS3_OP_INV_NO
rename T                             FATTENERS3_OP_INV_PERHEAD_KGS
rename U                             FATTENERS3_OP_INV_PERHEAD_EU
rename OpeningInventoryFatteningSows FATTENING_SOWS_OP_INV_NO
rename W                             FATTENING_SOWS_OP_INV_EU
rename OpeningInventoryStockBoarsNu  STOCK_BOARS_OP_INV_NO
rename OpeningInventoryStockBoars    STOCK_BOARS_OP_INV_PERHEAD_EU
rename OpeningInventoryTotalNumber   TOTAL_OP_INV_NO
*====================================================================
capture drop junk*
* Removed PERHEAD_ from SUCKLING SOWS and FATTENING SOWS vars

* Remove raw variables
*drop code // make sure to drop whatever codes there are
drop card



* Collapsing will destroy labels, so save them to macros
foreach v of var * {
	
	local l`v' : variable label `v'
	if `"`l`v''"' == "" {
		local l`v' "`v'"
	}

}



* Collapse the data to one farm per row 
ds farmcode, not // Get list of all vars less the by-variable
collapse (sum) `r(varlist)', by(farmcode)  



* Restore labels to variables
foreach v of var * {

	label var `v' "`l`v''"

}

