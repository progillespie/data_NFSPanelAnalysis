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
*	Algorithm: SINGLE CODE
*	
*
********************************************************
* READ THE README.txt FILE BEFORE CHANGING ANYTHING!!!
********************************************************

local i = 52

if "`standalone'"=="standalone"{
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw`YY'_head.xls", sheet("Sheet52") firstrow clear
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



*Create varlist to loop over (should match above, less junk* vars)
qui ds farmcode card BULKYFEED_CODE, not // all vars EXCEPT listed here
local vlist "`r(varlist)'"



* Create a list of crop codes present in the data (excl. 0)
tostring BULKYFEED_CODE, replace
qui levelsof BULKYFEED_CODE, local(bulkcodelist)
local zero = 0
local dot "."
local bulkcodelist: list bulkcodelist - zero
local bulkcodelist: list bulkcodelist - dot	
local bulkcodelist: list uniq bulkcodelist // ensure codes are unique
local bulkcodelist: list sort bulkcodelist // sort the list of codes
macro list _bulkcodelist // display the list for review



foreach code of local bulkcodelist{

	di "Creating vars for crop `code'"

	
	foreach var of local vlist {

	   gen double `var'`code' = 0
	   replace `var'`code' = `var' if BULKYFEED_CODE == "`code'"
	   * Way of copying label from generic to crop specific `var' 
	   local lbl : variable label `var'
	   label variable `var'`code' "`lbl' for crop `code'"
	   

	}	
}


* Remove raw variables
drop card
drop BULKYFEED_CODE 
drop OP_INV1_OR_PURCHASED2


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
