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
*	  Sheet28.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet28") firstrow clear
}



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*====================================================================
rename DairycowsinmilkJanuary   junk_28_142
rename DairycowsinmilkFebruary  junk_28_143
rename DairycowsinmilkMarch     junk_28_144
rename DairycowsinmilkApril     junk_28_145
rename DairycowsinmilkMay       junk_28_146
rename DairycowsinmilkJune      junk_28_147
rename DairycowsinmilkJuly      junk_28_148
rename DairycowsinmilkAugust    junk_28_149
rename DairycowsinmilkSeptember junk_28_150
rename DairycowsinmilkOctober   junk_28_151
rename DairycowsinmilkNovember  junk_28_152
rename DairycowsinmilkDecember  junk_28_153
rename DairycowsinmilkTotal     junk_28_154
*====================================================================
capture drop junk*

