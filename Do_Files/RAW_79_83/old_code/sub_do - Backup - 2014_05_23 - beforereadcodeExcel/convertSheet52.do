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
*	  Sheet52.dta 
*
*	for each of the subdirectories of 
*       
*	  RAW_79_83/raw_dta/
*
*       
* 	
*       The SAS variables created relate to Bulk Feeds
*
*	
*	Algorithm: SUM ALL
*	
*
********************************************************
* READ THE README.txt FILE BEFORE CHANGING ANYTHING!!!
********************************************************



if "`standalone'"=="standalone"{
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet52") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*====================================================================
rename PurchasedbulkyfeedOpeningInv OP_INV1_OR_PURCHASED2
rename PurchasedbulkyfeedCode       BULKYFEED_CODE
rename PurchasedbulkyfeedCodst      BULKYFEED_COST_EU
rename PurchasedbulkyfeedQuantity   BULKYFEED_QUANTITY
rename PurchasedbulkyfeedAllocatedt ALLOC_DAIRY_HERD_QTY
rename H                            ALLOC_CATTLE_QTY
rename I                            ALLOC_SHEEP_QTY
rename J                            ALLOC_HORSES_QTY
rename K                            ALLOC_PIGS_QTY
rename L                            ALLOC_POULTRY_QTY
rename OtherGrazingLivestock        OTHER_GRAZING_LIVESTOCK
rename N                            ALLOC_WASTE_QTY
rename O                            ALLOC_TOTAL_QTY
rename PurchasedbulkyfeedClosingInv CLOS_INV_QUANTITY
*====================================================================
capture drop junk*


* Remove raw variables
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

