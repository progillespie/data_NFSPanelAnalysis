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
*	  Sheet1.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet1") firstrow clear
}



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*====================================================================
rename farm              farmcode
rename card              junk_01_3
rename SoilCode          SOIL_CODE
rename Province          PROVINCE
rename CountyCode        COUNTY_CODE
rename DED               DED
rename ClosingDateday    CLOSING_DAY
rename ClosingDatemonth  CLOSING_MONTH
rename ClosingDateyear   CLOSING_YEAR
rename RecorderCode      RECORDER_CODE
rename booknumber        BOOK_NUMBER
rename forceoption       FORCE_OPTION
rename AltitudeCode      ALTITUDE_CODE
rename LessFavouredAreas LESS_FAVOURED_AREAS
*====================================================================
capture drop junk*
*/

label var farmcode "Farm code"
