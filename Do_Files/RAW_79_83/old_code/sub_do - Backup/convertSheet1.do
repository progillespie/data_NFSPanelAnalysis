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
rename farm               farmcode
rename SoilCode           ffsolcod
/*
rename Province           junk_01_5
rename CountyCode         junk_01_6
rename DED                junk_01_7
rename ClosingDateday     junk_01_8
rename ClosingDatemonth   junk_01_9
rename ClosingDateyear    junk_01_10
rename RecorderCode       junk_01_11
rename booknumber         junk_01_12
rename forceoption        junk_01_13
rename AltitudeCode       junk_01_14
rename LessFavouredAreas  junk_01_15
*====================================================================
capture drop junk*
*/

label var farmcode "Farm code"
