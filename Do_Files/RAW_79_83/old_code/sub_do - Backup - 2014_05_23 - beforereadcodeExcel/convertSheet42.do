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
*	The required input files are in:       
*       
*        Data/data_NFSPanelAnalysis/OrigData/RAW_79_83 
*
*
*	This file will produce: 
*       
*	  Sheet42.dta 
*
*	for each of the subdirectories of 
*       
*	  RAW_79_83/raw_dta/
*
*
*	Algorithm: RENAME
*
*
********************************************************
* READ THE README.txt FILE BEFORE CHANGING ANYTHING!!!
********************************************************



if "`standalone'"=="standalone"{
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet42") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*===================================================================
rename PurchasesOrdinaryFowlNumber ORDINARY_FOWL_PURCHASES_NO
rename PurchasesOrdinaryFowlValue  ORDINARY_FOWL_PURCHASES_EU
rename PurchasesOtherFowlNumber    OTHER_FOWL_PURCHASES_NO
rename PurchasesOtherFowlValue     OTHER_FOWL_PURCHASES_EU
rename SalesOrdinaryFowlNumber     ORDINARY_FOWL_SALES_NO
rename SalesOrdinaryFowlValue      ORDINARY_FOWL_SALES_EU
rename SalesOtherFowlNumber        OTHER_FOWL_SALES_NO
rename SalesOtherFowlValue         OTHER_FOWL_SALES_EU
rename SalesHenEggsDozenNumber     HEN_EGG_DOZEN_SALES_NO
rename SalesHenEggsDozenValue      HEN_EGG_DOZEN_SALES_EU
rename SalesOtherEggsDozenNumber   OTHER_EGG_DOZEN_SALES_NO
rename SalesOtherEggsDozenValue    OTHER_EGG_DOZEN_SALES_EU
rename Subsidies                   SUBSIDIES_VALUE_EU
*====================================================================
capture drop junk*
