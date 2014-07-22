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
*	  Sheet29.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet29") firstrow clear
}



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*====================================================================
rename	DairyheifierscalvingdownJanu	junk_29_155
rename	DairyheifierscalvingdownFebr	junk_29_156
rename	DairyheifierscalvingdownMarc	junk_29_157
rename	DairyheifierscalvingdownApri	junk_29_158
rename	DairyheifierscalvingdownMay	junk_29_159
rename	DairyheifierscalvingdownJune	junk_29_160
rename	DairyheifierscalvingdownJuly	junk_29_161
rename	DairyheifierscalvingdownAugu	junk_29_162
rename	DairyheifierscalvingdownSept	junk_29_163
rename	DairyheifierscalvingdownOcto	junk_29_164
rename	DairyheifierscalvingdownNove	junk_29_165
rename	DairyheifierscalvingdownDece	junk_29_166
rename	DairyheifierscalvingdownTota	junk_29_167
*====================================================================
capture drop junk*

