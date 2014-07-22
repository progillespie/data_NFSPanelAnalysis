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



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*===================================================================
rename StandardManDaysDairyCows     DAIRY_COWS
rename StandardManDaysSuckling      SUCKLING
rename StandardManDaysCattle1Year   CATTLE_LT1YR
rename StandardManDays12YearsOld    CATTLE_1_2YRS
rename StandardManDays23YearsOld    CATTLE_2_3YRS
rename StandardManDaysSheepEwes     SHEEP_EWES
rename StandardManDaysHoggets       SHEEP_HOGGETS
rename StandardManDaysPigsSows      PIGS_SOWS
rename StandardManDaysFatteners     PIGS_FATTENERS
rename StandardManDaysPoultryHensL  POULTRY_HENS_LAYERS
rename StandardManDaysTableFowl     POULTRY_TABLE_FOWL
rename StandardManDaysPullets       POULTRY_PULLETS
rename StandardManDaysOtherFowlT    POULTRY_OTHER_FOWL_TURKEYS
rename StandardManDaysHorsesDraug   HORSES_DRAUGHT
rename StandardManDaysLessthan2ye   HORSES_LT2YRS
rename StandardManDaysOver2yearso   HORSES_GT2YRS
rename StandardManDaysOtherPonies   HORSES_PONIES_MULES
rename StandardManDaysCereals       CEREALS
rename StandardManDaysSugarBeet     SUGAR_BEET
rename StandardManDaysPotatoesProc  POTATOES_PROCESSING
rename StandardManDaysPotatoesWare  POTATOES_WARE
rename StandardManDaysVegetableCrop VEGETABLE_CROPS
rename StandardManDaysSilageCode    SILAGE_CODE
rename forageacresHandFedacres      FORAGE_HAND_FED_HA
rename forageacresHandFeddays       FORAGE_HAND_FED_DAYS
rename forageacresgrazedacres       FORAGE_GRAZED_HA
rename forageacresgrazeddays        FORAGE_GRAZED_DAYS
*====================================================================
capture drop junk*
