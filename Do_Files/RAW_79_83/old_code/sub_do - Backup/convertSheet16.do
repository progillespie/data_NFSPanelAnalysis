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
rename LiquidMilkSoldWholesalegals  junk_16_18
rename LiquidMilkSoldWholesale      junk_16_19
rename LiquidMilkSoldRetailgals     junk_16_20
rename LiquidMilkSoldRetail         junk_16_21
rename LiquidMilkPurchasedforResale dompfrgl
rename H                            dompfrvl
rename SkimMilksoldGals             junk_16_24
rename SkimMilksold                 junk_16_25
rename SkimMilkFedtoCalvesGals      junk_16_26
rename SkimMilkFedtoCalves          junk_16_27
rename SkimMilkFedtoPigsGals        junk_16_28
rename SkimMilkFedtoPigs            junk_16_29
rename SkimMilkFedtoPoultryGals     junk_16_30
rename SkimMilkFedtoPoultry         junk_16_31
*====================================================================
capture drop junk*

