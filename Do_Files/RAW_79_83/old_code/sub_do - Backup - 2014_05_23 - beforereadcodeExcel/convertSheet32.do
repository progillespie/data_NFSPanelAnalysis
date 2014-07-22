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
* 	The required input files are in:       
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
*	Algorithm: SUM ALL
*	
*
********************************************************
* READ THE README.txt FILE BEFORE CHANGING ANYTHING!!!
********************************************************



if "`standalone'"=="standalone"{
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw83_head.xls", sheet("Sheet32") firstrow clear
}



rename farm farmcode
label var farm "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*====================================================================
rename PurchasesEwesRamsNumber       EWES_RAMS_PURCHASES_NO
rename PurchasesEwesRamsTotalvalu    EWES_RAMS_PURCHASES_EU
rename PurchasesBreedingHoggetsNumbe BREEDING_HOGGETS_PURCHASES_NO
rename PurchasesBreedingHoggetsTotal BREEDING_HOGGETS_PURCHASES_EU
rename PurchasesStoreLambsNumber     STORE_LAMBS_PURCHASES_NO
rename PurchasesStoreLambsTotalvalu  STORE_LAMBS_PURCHASES_EU
rename SalesFatLambsNumber           FAT_LAMBS_SALES_NO
rename SalesFatLambsTotalvalue       FAT_LAMBS_SALES_EU
rename SalesStoreLambsNumber         STORE_LAMBS_SALES_NO
rename SalesStoreLambsTotalvalue     STORE_LAMBS_SALES_EU
rename SalesFatHoggetsNumber         FAT_HOGGETS_SALES_NO
rename SalesFatHoggetsTotalvalue     FAT_HOGGETS_SALES_EU
rename SalesBreedingHoggetsNumber    BREEDING_HOGGETS_SALES_NO
rename SalesBreedingHoggetsTotalval  BREEDING_HOGGETS_SALES_EU
rename SalesCullEwesRamsNumber       CULL_EWES_RAMS_SALES_NO
rename SalesCullEwesRamsTotalval     CULL_EWES_RAMS_SALES_EU
rename SalesBreedingEwesNumber       BREEDING_EWES_SALES_NO
rename SalesBreedingEwesTotalvalue   BREEDING_EWES_SALES_EU
rename SheepUsedInHouseNumber        USED_IN_HOUSE_NO
rename SheepUsedInHouseTotalvalue    USED_IN_HOUSE_EU
rename SheepSubsidies                TOTAL_SUBSIDIES_EU
rename WoolSalesKgs                  WOOL_SALES_QTY_KGS
rename WoolSales                     WOOL_SALES_VALUE_EU
*====================================================================
capture drop junk*


* Remove raw variables
*drop code // make sure to drop whatever codes there are
drop card



* Collapsing will destroy labels, so save them to macros
foreach v of var * {
	
	local l`v' : variable label `v'
	if `"`l`v''"' == "" {
		local l`v' "`v'"
	}

}



* Collapse the data to one farm per row 
ds farmcode, not // Get list of all vars less the by-variable
collapse (sum) `r(varlist)', by(farmcode)  



* Restore labels to variables
foreach v of var * {

	label var `v' "`l`v''"

}

