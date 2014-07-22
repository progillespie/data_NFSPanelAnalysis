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
*	  Sheet40.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw83_head.xls", sheet("Sheet40") firstrow clear
}



rename farm farmcode
label var farm "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*====================================================================
rename PoultryOpeningInventoryLayers LAYERS_OP_INV_NO
rename D                             LAYERS_OP_INV_PERUNIT_EU
rename PoultryOpeningInventoryChicks CHICKS_PULLETS_OP_INV_NO
rename F                             CHICKS_PULLETS_OP_INV_EU
rename PoultryOpeningInventoryTable  TABLE_FOWL_OP_INV_NO
rename H                             TABLE_FOWL_OP_INV_PERUNIT_EU
rename OpeningInventoryTotalNumber   TOTAL_ORDINARY_FOWL_OP_INV_NO
rename OpeningInventoryTurkeysNumber TURKEYS_OP_INV_NO
rename OpeningInventoryTurkeysValue  TURKEYS_OP_INV_PERUNIT_EU
rename OpeningInventoryGeeseNumber   GEESE_OP_INV_NO
rename OpeningInventoryGeeseValueun  GEESE_OP_INV_PERUNIT_EU
rename OpeningInventoryDucksNumber   DUCKS_OP_INV_NO
rename OpeningInventoryDucksValueu   DUCKS_OP_INV_PERUNIT_EU
rename OpeningInventoryOthersNumber  OTHERS_OP_INV_NO
rename OpeningInventoryOthersValueu  OTHERS_OP_INV_PERUNIT_EU
rename OpeningInventoryotherfowlTot  TOTAL_OTHER_FOWL_OP_INV_NO
*====================================================================
capture drop junk*
* Removed PERUNIT_ from CHICKS PULLETS var

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

