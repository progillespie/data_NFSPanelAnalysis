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
rename AllowancesWholeMilkhouselit ALLOW_WHOLE_MILK_HOUSE_LT
rename AllowancesWholeMilkhouse    ALLOW_WHOLE_MILK_HOUSE_EU
rename AllowancesWholeMilkwageslit ALLOW_WHOLE_MILK_WAGES_LT
rename AllowancesWholeMilkwages    ALLOW_WHOLE_MILK_WAGES_EU
rename AllowancesWholeMilkotherlit ALLOW_WHOLE_MILK_OTHER_LT
rename AllowancesWholeMilkother    ALLOW_WHOLE_MILK_OTHER_EU
rename AllowancesButterhousekgs    ALLOW_BUTTER_HOUSE_KG
rename AllowancesButterhouse       ALLOW_BUTTER_HOUSE_EU
rename AllowancesButterwageskgs    ALLOW_BUTTER_WAGES_KG
rename AllowancesButterwages       ALLOW_BUTTER_WAGES_EU
rename AllowancesButterotherkgs    ALLOW_BUTTER_OTHER_KG
rename AllowancesButterother       ALLOW_BUTTER_OTHER_EU
rename AllowancesCreamhouselit     ALLOW_OTHER_DAIRY_HOUSE_LT
rename AllowancesCreamhouse        ALLOW_OTHER_DAIRY_HOUSE_EU
rename AllowancesCreamwageslit     ALLOW_OTHER_DAIRY_WAGES_LT
rename AllowancesCreamwages        ALLOW_OTHER_DAIRY_WAGES_EU
*====================================================================
capture drop junk*

