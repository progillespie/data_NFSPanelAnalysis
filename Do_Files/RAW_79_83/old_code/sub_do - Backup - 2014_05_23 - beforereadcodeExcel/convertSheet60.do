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
*	  Sheet60.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet60") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*====================================================================
rename Paidcasuallabourallocatedto  CASUAL_LABOUR_ALLOC_DAIRY_EU
rename D                            CASUAL_LABOUR_ALLOC_CATTLE_EU
rename E                            CASUAL_LABOUR_ALLOC_SHEEP_EU
rename F                            CASUAL_LABOUR_ALLOC_PIGS_EU
rename G                            CASUAL_LABOUR_ALLOC_POULTRY_EU
rename H                            CASUAL_LABOUR_ALLOC_OTHER_EU
rename PaidcasuallabourNonAllocable CASUAL_LABOUR_NON_ALLOCABLE_EU
rename J                            CROP1_CODE
rename K                            ALLOCATED_TO_CROP1_EU
rename L                            CROP2_CODE
rename M                            ALLOCATED_TO_CROP2_EU
rename N                            CROP3_CODE
rename O                            ALLOCATED_TO_CROP3_EU
rename P                            CROP4_CODE
rename Q                            ALLOCATED_TO_CROP4_EU
rename R                            CROP5_CODE
rename S                            ALLOCATED_TO_CROP5_EU
rename T                            CROP6_CODE
rename U                            ALLOCATED_TO_CROP6_EU
rename PaidcasuallabourTotalAllocat CASUAL_LABOUR_TOTAL_ALLOC_EU
*====================================================================


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



*====================================================================
* Calculated variables
*====================================================================
*====================================================================

capture drop junk*
