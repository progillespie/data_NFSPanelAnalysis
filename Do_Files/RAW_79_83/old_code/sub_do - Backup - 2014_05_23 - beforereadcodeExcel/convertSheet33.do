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
*	  Sheet33.dta 
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
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet33") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"



*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*===================================================================
rename BreedofEwe                 EWE_BREED_CODE
rename BreedofRam                 RAM_BREED_CODE
rename HillorLowland              HILL_LOWLAND_CODE
rename NoofSheepShorn             SHEEP_SHORN_NO
rename NoofEweslettoRam           EWES_LET_TO_RAM_NO
rename NoofeweLambstakingtheRam   EWE_LAMBS_TAKING_RAM_NO
rename NoofBarrenEwes             BARREN_EWES_NO
rename NoofEwesMatedHormoneTreate EWES_MATED_HORMONE_TREATED_NO
rename NoofFatLambssoldpreJune1   FAT_LAMBS_SOLD_PRE_JUNE1_NO
rename NoofInLambewesPurchases    EWES_IN_LAMB_PURCHASES_NO
rename NoofInLambewesSales        EWES_IN_LAMB_SALES_NO
rename NoofewesPurchasedwithlambs EWES_AT_FOOT_LAMBS_PURCHASES_NO
rename NoofewesSoldwithlambsatfo  EWES_AT_FOOT_LAMBS_SALES_NO
rename NoofLambsPurchasedatfoot   LAMBS_AT_FOOT_PURCHASES_NO
rename NoofLambsSoldatfoot        LAMBS_AT_FOOT_SALES_NO
rename BirthsLive                 BIRTHS_LIVE_NO
rename DeathsEwes                 DEATHS_EWES_NO
rename DeathsLambsbeforeWeaning   DEATHS_LAMBS_PRE_WEANING_NO
rename DeathsOther                DEATHS_OTHER_NO
*====================================================================
capture drop junk*
