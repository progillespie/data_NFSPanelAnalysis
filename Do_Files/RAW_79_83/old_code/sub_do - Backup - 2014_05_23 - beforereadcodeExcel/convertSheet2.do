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
*	  Sheet2.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet2") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*====================================================================
rename LandOwnedAcres           LAND_OWNED_HA
rename LandRentedInAcres        LAND_RENTED_IN_HA
rename LandRentedIn             LAND_RENTED_IN_EU
rename LandLetOutAcresAcres     LAND_LET_OUT_HA
rename LandLetOut               LAND_LET_OUT_EU
rename LandFarmedAcres          LAND_FARMED_HA
rename ratevaluationoflandowned RATEABLE_VALUATION_EU
rename buildingvaluation        BUILDING_VALUATION_EU
rename totalvaluation           TOTAL_VALUATION_EU
rename ratesforyear             D_MACHINERY_RATES_EU
rename Annuities                ANNUITIES_EU
*====================================================================
capture drop junk*
