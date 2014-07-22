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
*	  Sheet16.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet16") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"







*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*====================================================================
rename LiquidMilkSoldWholesalegals  LqMilkSoldWSALE_LT
rename LiquidMilkSoldWholesale      LqMilkSoldWSALE_EU
rename LiquidMilkSoldRetailgals     LqMilkSoldRETAIL_LT
rename LiquidMilkSoldRetail         LqMilkSoldRETAIL_EU
rename LiquidMilkPurchasedforResale LqMilkPurchRESALE_LT
rename H                            LqMilkPurchRESALE_EU
rename SkimMilksoldGals             SKIM_MILK_SOLD_LT
rename SkimMilksold                 SKIM_MILK_SOLD_EU
rename SkimMilkFedtoCalvesGals      SKIM_MILK_FED_CALVES_LT
rename SkimMilkFedtoCalves          SKIM_MILK_FED_CALVES_EU
rename SkimMilkFedtoPigsGals        SKIM_MILK_FED_PIGS_LT
rename SkimMilkFedtoPigs            SKIM_MILK_FED_PIGS_EU
rename SkimMilkFedtoPoultryGals     SKIM_MILK_FED_POULTRY_LT
rename SkimMilkFedtoPoultry         SKIM_MILK_FED_POULTRY_EU
*====================================================================
capture drop junk*

