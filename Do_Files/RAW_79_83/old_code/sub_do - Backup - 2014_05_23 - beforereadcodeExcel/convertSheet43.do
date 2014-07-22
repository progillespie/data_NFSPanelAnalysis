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



if "`standalone'"=="standalone"{
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet43") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*====================================================================
rename EggsusedinHousedoz          EGGS_DOZ_USED_IN_HOUSE_NO
rename EggsusedinHouseValue        EGGS_DOZ_USED_IN_HOUSE_EU
rename EggsusedinWagesdoz          EGGS_DOZ_WAGES_NO
rename EggsusedinWagesValue        EGGS_DOZ_WAGES_EU
rename EggsusedinOtherdoz          EGGS_DOZ_OTHER_ALLOWANCES_NO
rename EggsusedinOtherValue        EGGS_DOZ_OTHER_ALLOWANCES_EU
rename OrdinaryFowlusedinHouseNumb ORDINARY_FOWL_USED_IN_HOUSE_NO
rename OrdinaryFowlusedinHouseValu ORDINARY_FOWL_USED_IN_HOUSE_EU
rename OrdinaryFowlusedinWagesNumb ORDINARY_FOWL_WAGES_NO
rename OrdinaryFowlusedinWagesValu ORDINARY_FOWL_WAGES_EU
rename OrdinaryFowlusedinOtherNumb ORD_FOWL_OTHER_ALLOWANCES_NO
rename OrdinaryFowlusedinOtherValu ORD_FOWL_OTHER_ALLOWANCES_EU
rename OtherFowlusedinHouseNumber  OTHER_FOWL_USED_IN_HOUSE_NO
rename OtherFowlusedinHouseValue   OTHER_FOWL_USED_IN_HOUSE_EU
rename OtherFowlusedinWagesNumber  OTHER_FOWL_WAGES_NO
rename OtherFowlusedinWagesValue   OTHER_FOWL_WAGES_EU
rename OtherFowlusedinOtherNumber  OTHER_FOWL_OTHER_ALLOWANCES_NO
rename OtherFowlusedinOtherValue   OTHER_FOWL_OTHER_ALLOWANCES_EU
rename Poultry12MonthTotalsLaying  MTH12_TOTAL_LAYING_BIRDS_NO
rename Poultry12MonthTotalsChicks  MTH12_TOTAL_CHICKS_PULLETS_NO
rename Poultry12MonthTotalsTable   MTH12_TOTAL_TABLE_FOWL_NO
rename Poultry12MonthTotalsOther   MTH12_TOTAL_OTHER_FOWL_NO
rename Poultry12MonthTotalsAllFo   MTH12_TOTAL_ALL_FOWL_NO
rename PoultrySystemCode           PoultrySystemCode
*====================================================================
capture drop junk*
* Shortened ORDINARY FOWL OTHER ALLOWANCES


* Remove raw variables
drop PoultrySystemCode
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
