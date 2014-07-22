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
*	  Sheet20.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet20") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*====================================================================
rename CalvesSalesNumber         junk_20_24
rename CalvesSalesValue          junk_20_25
rename CalvesTransfersNumber     junk_20_26
rename CalvesTransfersValue      junk_20_27
rename CowsSpringingHeifersBulls junk_20_28
rename H                         junk_20_29
rename SalesDairyCowsNo          junk_20_30
rename SalesDairyCowsValue       junk_20_31
rename K                         junk_20_32
rename L                         junk_20_33
rename M                         junk_20_34
rename N                         junk_20_35
rename DairySubsidiesValue       junk_20_36
*====================================================================
capture drop junk*

