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
*	  Sheet32.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet32") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*====================================================================
rename PurchasesEwesRamsNumber       junk_32_32
rename PurchasesEwesRamsTotalvalu    junk_32_33
rename PurchasesBreedingHoggetsNumbe junk_32_34
rename PurchasesBreedingHoggetsTotal junk_32_35
rename PurchasesStoreLambsNumber     junk_32_36
rename PurchasesStoreLambsTotalvalu  junk_32_37
rename SalesFatLambsNumber           junk_32_38
rename SalesFatLambsTotalvalue       junk_32_39
rename SalesStoreLambsNumber         junk_32_40
rename SalesStoreLambsTotalvalue     junk_32_41
rename SalesFatHoggetsNumber         junk_32_42
rename SalesFatHoggetsTotalvalue     junk_32_43
rename SalesBreedingHoggetsNumber    junk_32_44
rename SalesBreedingHoggetsTotalval  junk_32_45
rename SalesCullEwesRamsNumber       junk_32_46
rename SalesCullEwesRamsTotalval     junk_32_47
rename SalesBreedingEwesNumber       junk_32_48
rename SalesBreedingEwesTotalvalue   junk_32_49
rename SheepUsedInHouseNumber        junk_32_50
rename SheepUsedInHouseTotalvalue    junk_32_51
rename SheepSubsidies                junk_32_52
rename WoolSalesKgs                  junk_32_53
rename WoolSales                     junk_32_54
*====================================================================
capture drop junk*
