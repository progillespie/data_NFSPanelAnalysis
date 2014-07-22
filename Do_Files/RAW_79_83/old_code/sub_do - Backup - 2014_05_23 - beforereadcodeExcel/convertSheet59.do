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
*	  Sheet59.dta 
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



if "`standalone'"=="standalone"{
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet59") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*====================================================================
rename PaidCasualLabourTimeWorked  CASUAL_DAYS_WORKED
rename D                           CASUAL_HOURS_WORKED
rename PaidCasualLabourCapitalWork CASUAL_CAPITAL_WORK_DAYS
rename PaidCasualLabourWagesPaid   CASUAL_WAGES_PAID_EU
rename PaidCasualLabourSocialSecur CASUAL_SOCIAL_SECURITY_PAID_EU
rename LabourUnitEquivalent        CASUAL_LABOUR_UNIT_EQUIVALENT
*====================================================================


* Remove raw variables
*drop code // make sure to drop whatever codes there are
drop card



*====================================================================
* Calculated variables
*====================================================================
gen D_LABOUR_UNITS_PAID_CAS = CASUAL_HOURS_WORKED/1800
replace D_LABOUR_UNITS_PAID_CAS = 1 ///
     if D_LABOUR_UNITS_PAID_CAS > 1
replace D_LABOUR_UNITS_PAID_CAS = ///
     D_LABOUR_UNITS_PAID_CAS * CASUAL_LABOUR_UNIT_EQUIVALENT
label var D_LABOUR_UNITS_PAID_CAS "flabpaid term (2 of 2) - Paid casual worker labour units ( X Labour Unit Equivalents)"
*====================================================================



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

capture drop junk*
