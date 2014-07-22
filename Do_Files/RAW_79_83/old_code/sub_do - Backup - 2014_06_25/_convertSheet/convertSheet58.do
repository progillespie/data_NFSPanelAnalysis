args standalone YY validate
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
*	  Sheet58.dta 
*
*	for each of the subdirectories of 
*       
*	  RAW_79_83/raw_dta/
*
*       
* 	
*       The SAS variables created relate to 
* 	
*
*	
*	Algorithm: SUM ALL
*	
*
********************************************************
* READ THE README.txt FILE BEFORE CHANGING ANYTHING!!!
********************************************************

local i = 58

if "`standalone'"=="standalone"{
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw`YY'_head.xls", sheet("Sheet58") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Apply renaming do file from appropriate mapping sheet of 
*   raw2IBnamemappings.xlsx here
*====================================================================
do sub_do/_renameSheet/renameSheet`i'.do
*====================================================================


* Remove raw variables
drop card



*====================================================================
* Calculated variables
*====================================================================
gen D_LABOUR_UNITS_PAID_EXCL_CAS = PAID_HOURS_WORKED/1800
replace D_LABOUR_UNITS_PAID_EXCL_CAS = 1 ///
     if D_LABOUR_UNITS_PAID_EXCL_CAS > 1
replace D_LABOUR_UNITS_PAID_EXCL_CAS = ///
     D_LABOUR_UNITS_PAID_EXCL_CAS * PAID_LABOUR_UNIT_EQUIVALENT
label var D_LABOUR_UNITS_PAID_EXCL_CAS "flabpaid term (1of 2) - Paid worker labour units ( X Labour Unit Equivalents)"
*====================================================================



* Collapsing will destroy labels, so save them to macros
foreach v of var * {
	
	local shortv = subinstr("`v'", "_", "", .)
	local l`shortv' : variable label `v'

	if `"`l`shortv''"' == "" {
		local l`shortv' "`v'"
	}

}



* Collapse the data to one farm per row 
qui ds farmcode, not // Get list of all vars less the by-variable
collapse (sum) `r(varlist)', by(farmcode)  



* Restore labels to variables
foreach v of var * {

	local shortv = subinstr("`v'", "_", "", .)
	label var `v' "`l`shortv''"

}

capture drop junk*
