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
rename TotalTillageCropsfromCard5   TOTAL_TILLAGE_CROPS_HA
rename TotalPasture                 TOTAL_PASTURE_HA
rename ley                          TOTAL_PASTURE_LEY_HA
rename permanentpasture             TOTAL_PASTURE_PERMANENT_HA
rename RoughGrazing                 ROUGH_GRAZING_HA
rename FallowinclSetaside           FALLOW_SETASIDE_HA
rename HouseGarden                  HOUSE_GARDEN_HA
rename Woodland                     WOODLAND_HA
rename AreanotinAgriculture         D_REMAINDER_OF_FARM_HA
rename OtherAreas                   OTHER_LAND_USE_HA
rename AreaunderglassHeated         AREA_UNDER_GLASS_HEATED
rename AreaunderglassUnheated       AREA_UNDER_GLASS_UNHEATED
rename Totallandfarmedabove         junk_03_19
rename PastureEquivalentofRoughGraz PASTURE_EQUIV_ROUGH_HA
*====================================================================
capture drop junk*
