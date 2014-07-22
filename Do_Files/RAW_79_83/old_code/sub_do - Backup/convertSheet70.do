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
*	  Sheet70.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet70") firstrow clear
}



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*===================================================================
rename StandardManDaysDairyCows     junk_70_2
rename StandardManDaysSuckling      junk_70_3
rename StandardManDaysCattle1Year   junk_70_4
rename StandardManDays12YearsOld    junk_70_5
rename StandardManDays23YearsOld    junk_70_6
rename StandardManDaysSheepEwes     junk_70_7
rename StandardManDaysHoggets       junk_70_8
rename StandardManDaysPigsSows      junk_70_9
rename StandardManDaysFatteners     junk_70_10
rename StandardManDaysPoultryHensL  junk_70_11
rename StandardManDaysTableFowl     junk_70_12
rename StandardManDaysPullets       junk_70_13
rename StandardManDaysOtherFowlT    junk_70_14
rename StandardManDaysHorsesDraug   junk_70_15
rename StandardManDaysLessthan2ye   junk_70_16
rename StandardManDaysOver2yearso   junk_70_17
rename StandardManDaysOtherPonies   junk_70_18
rename StandardManDaysCereals       junk_70_19
rename StandardManDaysSugarBeet     junk_70_20
rename StandardManDaysPotatoesProc  junk_70_21
rename StandardManDaysPotatoesWare  junk_70_22
rename StandardManDaysVegetableCrop junk_70_23
rename StandardManDaysSilageCode    junk_70_24
rename forageacresHandFedacres      junk_70_25
rename forageacresHandFeddays       junk_70_26
rename forageacresgrazedacres       junk_70_27
rename forageacresgrazeddays        junk_70_28
*====================================================================
capture drop junk*
