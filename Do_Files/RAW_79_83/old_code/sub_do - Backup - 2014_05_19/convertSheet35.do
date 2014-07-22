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
*rename OpeningInventorySowsinPigNu   junk_35_2
rename OpeningInventorySowsinPigVa   junk_35_3
rename OpeningInventoryGiltsinPigN   junk_35_4
rename OpeningInventoryGiltsinPigV   junk_35_5
rename OpeningInventorySowsSuckling  junk_35_6
rename H                             junk_35_7
rename OpeningInventoryBonhamsNumber junk_35_8
rename OpeningInventoryBonhamsValue  junk_35_9
rename OpeningInventoryWeanersNumber junk_35_10
rename OpeningInventoryWeanersValue  junk_35_11
rename OpeningInventoryFattenersNumb junk_35_12
rename OpeningInventoryFattenersWeig junk_35_13
rename OpeningInventoryFattenersValu junk_35_14
rename P                             junk_35_15
rename Q                             junk_35_16
rename R                             junk_35_17
rename S                             junk_35_18
rename T                             junk_35_19
rename U                             junk_35_20
rename OpeningInventoryFatteningSows junk_35_21
rename W                             junk_35_22
rename OpeningInventoryStockBoarsNu  junk_35_23
rename OpeningInventoryStockBoars    junk_35_24
rename OpeningInventoryTotalNumber   junk_35_25
*====================================================================
capture drop junk*


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

