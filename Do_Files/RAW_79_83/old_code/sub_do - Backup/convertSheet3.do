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
*	  Sheet3.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet3") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*====================================================================
rename TotalTillageCropsfromCard5   junk_03_2
rename TotalPasture                 junk_03_4
rename ley                          junk_03_5
rename permanentpasture             junk_03_6
rename RoughGrazing                 fsizrgac
rename FallowinclSetaside           junk_03_8
rename HouseGarden                  junk_03_9
rename Woodland                     fsizfort
rename AreanotinAgriculture         fsizrema
rename OtherAreas                   junk_03_12
rename AreaunderglassHeated         junk_03_13
rename AreaunderglassUnheated       junk_03_14
rename Totallandfarmedabove         junk_03_19
rename PastureEquivalentofRoughGraz fsizrgeq
*====================================================================
capture drop junk*
