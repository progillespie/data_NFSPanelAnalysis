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
*	  Sheet56.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet56") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*===================================================================
rename FuelLubricantsOpeningInve    MACHINERY_FUEL_LUBS_OP_INV_EU
rename FuelLubricantsPurchases      MACHINERY_FUEL_LUBS_PURCHASES_EU
rename FuelLubricantsClosingInve    MACHINERY_FUEL_LUBS_CLOS_INV_EU
rename MachineryRepairsMinor        MACHINERY_MINOR_REPAIRS_EU
rename MachineryTax                 MACHINERY_TAX_EU
rename MachineryInsurance           MACHINERY_INSURANCE_EU
rename RepairsGeneralUpkeeptoFarm   BUILDINGS_REPAIRS_UPKEEP_EU
rename FireInsuranceforFarmBuilding BUILDINGS_FIRE_INSURANCE_EU
rename GeneralUpkeepofLand          LAND_GENERAL_UPKEEP_EU
*====================================================================
capture drop junk*
