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
*	  Sheet64.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet64") firstrow clear
}



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*===================================================================
rename OTHERMachineryTOTALOriginalG junk_64_12
rename D                            junk_64_13
rename OTHERMachinerybeginningofyea junk_64_14
rename OTHERMachineryTOTALPurchaseT junk_64_15
rename OTHERMachineryTOTALMajorRepa junk_64_16
rename OTHERMachineryGrantrecincur  junk_64_17
rename OTHERMachineryTOTALSalesTr   junk_64_18
rename OTHERMachineryTOTALValue     junk_64_19
rename OTHERMachineryDepreciation   junk_64_20
rename OTHERMachineryENDofyearnet   junk_64_21
*====================================================================
capture drop junk*
