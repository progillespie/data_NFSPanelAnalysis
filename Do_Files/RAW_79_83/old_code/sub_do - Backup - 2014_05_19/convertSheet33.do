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
rename BreedofEwe                 junk_33_55
rename BreedofRam                 junk_33_56
rename HillorLowland              junk_33_57
rename NoofSheepShorn             junk_33_58
rename NoofEweslettoRam           junk_33_59
rename NoofeweLambstakingtheRam   junk_33_60
rename NoofBarrenEwes             junk_33_61
rename NoofEwesMatedHormoneTreate junk_33_62
rename NoofFatLambssoldpreJune1   junk_33_63
rename NoofInLambewesPurchases    junk_33_64
rename NoofInLambewesSales        junk_33_65
rename NoofewesPurchasedwithlambs junk_33_66
rename NoofewesSoldwithlambsatfo  junk_33_67
rename NoofLambsPurchasedatfoot   junk_33_68
rename NoofLambsSoldatfoot        junk_33_69
rename BirthsLive                 junk_33_70
rename DeathsEwes                 junk_33_71
rename DeathsLambsbeforeWeaning   junk_33_72
rename DeathsOther                junk_33_73
*====================================================================
capture drop junk*
