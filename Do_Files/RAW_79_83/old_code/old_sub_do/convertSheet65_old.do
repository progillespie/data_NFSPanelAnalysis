
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
*	  Sheet65.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet65") firstrow clear
}



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*===================================================================
rename FarmBuildingsTOTALOriginalGr junk_65_22
rename D                            junk_65_23
rename FarmBuildingsbeginningofyear junk_65_24
rename FarmBuildingsNewThisYear     junk_65_25
rename FarmBuildingsTOTALMajorRepai junk_65_26
rename FarmBuildingsGrantrecforinv  junk_65_27
rename FarmBuildingsDepreciation    junk_65_28
rename FarmBuildingsendValue        junk_65_29
rename K                            junk_65_30
*====================================================================
capture drop junk*
