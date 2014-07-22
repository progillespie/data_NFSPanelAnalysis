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
rename CalvesSalesNumber         DAIRY_CALVES_SALES_NO
rename CalvesSalesValue          DAIRY_CALVES_SALES_EU
rename CalvesTransfersNumber     DAIRY_CALVES_TRANSFER_NO
rename CalvesTransfersValue      DAIRY_CALVES_TRANSFER_EU
rename CowsSpringingHeifersBulls junk_20_28
rename H                         junk_20_29
rename SalesDairyCowsNo          DAIRY_COWS_SALES_NO
rename SalesDairyCowsValue       DAIRY_COWS_SALES_VALUE_EU
rename K                         junk_20_32
rename L                         junk_20_33
rename M                         junk_20_34
rename N                         junk_20_35
rename DairySubsidiesValue       junk_20_36
*====================================================================
capture drop junk*

