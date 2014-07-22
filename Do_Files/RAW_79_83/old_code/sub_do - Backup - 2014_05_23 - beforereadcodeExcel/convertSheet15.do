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
*	  Sheet15.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet15") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"







*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*====================================================================
rename Wholemilksoldtocreamerylitr WHOLE_MILK_SOLD_TO_CREAMERY_LT
rename Wholemilksoldtocreamery     WHOLE_MILK_SOLD_TO_CREAMERY_EU
rename Bonuses                     CREAMERY_BONUSES_EU
rename TotalQuantityButterFatkgs   CREAMERY_TOT_BUTTER_FAT_LT
rename AverageButterFat            AVERAGE_BUTTERFAT_PERCENT
rename FedToCalves                 CREAMERY_FED_CALVES_LT
rename FedToPigs                   CREAMERY_FED_PIGS_LT
rename FedToPoultry                CREAMERY_FED_POULTRY_LT
rename ButterSoldHomemadekgs       CREAMERY_BUTTER_SOLD_LBS
rename ButterSoldHomemade          CREAMERY_BUTTER_SOLD_EU
*rename CreamSoldPints              WHOLE_MILK_SOLD_TO_CREAMERY_LT
*rename CreamSold                   WHOLE_MILK_SOLD_TO_CREAMERY_EU
*====================================================================
capture drop junk*

