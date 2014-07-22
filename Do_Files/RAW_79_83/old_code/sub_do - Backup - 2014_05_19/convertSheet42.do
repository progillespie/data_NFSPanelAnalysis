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
rename PurchasesOrdinaryFowlNumber junk_42_34
rename PurchasesOrdinaryFowlValue  junk_42_35
rename PurchasesOtherFowlNumber    junk_42_36
rename PurchasesOtherFowlValue     junk_42_37
rename SalesOrdinaryFowlNumber     junk_42_38
rename SalesOrdinaryFowlValue      junk_42_39
rename SalesOtherFowlNumber        junk_42_40
rename SalesOtherFowlValue         junk_42_41
rename SalesHenEggsDozenNumber     junk_42_42
rename SalesHenEggsDozenValue      junk_42_43
rename SalesOtherEggsDozenNumber   junk_42_44
rename SalesOtherEggsDozenValue    junk_42_45
rename Subsidies                   junk_42_46
*====================================================================
capture drop junk*
