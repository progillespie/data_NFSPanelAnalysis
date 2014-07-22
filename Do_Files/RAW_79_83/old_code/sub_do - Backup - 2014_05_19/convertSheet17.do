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
*	  Sheet17.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet17") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*====================================================================
rename AllowancesWholeMilkhouselit junk_17_34
rename AllowancesWholeMilkhouse    junk_17_35
rename AllowancesWholeMilkwageslit junk_17_36
rename AllowancesWholeMilkwages    junk_17_37
rename AllowancesWholeMilkotherlit junk_17_38
rename AllowancesWholeMilkother    junk_17_39
rename AllowancesButterhousekgs    junk_17_40
rename AllowancesButterhouse       junk_17_41
rename AllowancesButterwageskgs    junk_17_42
rename AllowancesButterwages       junk_17_43
rename AllowancesButterotherkgs    junk_17_44
rename AllowancesButterother       junk_17_45
rename AllowancesCreamhouselit     junk_17_46
rename AllowancesCreamhouse        junk_17_47
rename AllowancesCreamwageslit     junk_17_48
rename AllowancesCreamwages        junk_17_49
*====================================================================
capture drop junk*

