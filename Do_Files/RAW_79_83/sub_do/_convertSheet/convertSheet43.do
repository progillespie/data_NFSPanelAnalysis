args shortfilename origdata standalone YY validate
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
*	  Sheet43.dta 
*
*	for each of the subdirectories of 
*       
*	  RAW_79_83/raw_dta/
*
*
*	This file will produce: 
*       
*	  Sheet43.dta 
*       
* 	
*       The SAS variables created relate to Poultry
* 	
*
*	
*	Algorithm: SUM ALL
*	
*
********************************************************
* READ THE README.txt FILE BEFORE CHANGING ANYTHING!!!
********************************************************

local i = 43

if "`standalone'"=="standalone"{
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw`YY'_head.xls", sheet("Sheet43") firstrow clear
}



capture rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Apply renaming do file from appropriate mapping sheet of 
*   raw2IBnamemappings.xlsx here
*====================================================================
do sub_do/_renameSheet/renameSheet`i'.do
outsheet using ///
  `origdata'/csv/`shortfilename'/Sheet`i'.csv, replace comma
*====================================================================
capture drop junk*
* Shortened ORDINARY FOWL OTHER ALLOWANCES


* Remove raw variables
drop PoultrySystemCode
drop card



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
