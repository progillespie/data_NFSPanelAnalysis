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



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*===================================================================
rename FuelLubricantsOpeningInve    junk_56_2
rename FuelLubricantsPurchases      junk_56_3
rename FuelLubricantsClosingInve    junk_56_4
rename MachineryRepairsMinor        junk_56_5
rename MachineryTax                 junk_56_6
rename MachineryInsurance           junk_56_7
rename RepairsGeneralUpkeeptoFarm   junk_56_8
rename FireInsuranceforFarmBuilding junk_56_9
rename GeneralUpkeepofLand          junk_56_10
*====================================================================
capture drop junk*
