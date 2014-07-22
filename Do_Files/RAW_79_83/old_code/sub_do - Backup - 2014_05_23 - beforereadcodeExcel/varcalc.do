
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
* 	The required input files are in:       
*       
*        Data/data_NFSPanelAnalysis/OutData/quota
*
*
*	This file will produce: 
*       
*	  Data in memory - to be saved by master file
*
*
*	Some calculated vars require data from mult. 
*	 sheets. Vars required have been prefixed       
*        calc_*. We complete caclulations here.
*
* 	
*       The SAS variables created relate to 
* 	  VARIOUS	
*
*	
*	Simple calculations only (not meant to replace
*	 DoFarmDerivedVars.do .)
*
********************************************************
* READ THE README.txt FILE BEFORE CHANGING ANYTHING!!!
********************************************************



if "`standalone'"=="standalone"{
	use ../../../OutData/quota/raw_79_83.dta, clear
}

clear

if "`standalone'" == "test" {

	do sub_do/convertSheet57.do standalone
	save temp57, replace

	do sub_do/convertSheet58.do standalone
	save temp58, replace

	do sub_do/convertSheet59.do standalone



	merge 1:1 farmcode using temp57, nogen
	erase temp57.dta

	merge 1:1 farmcode using temp58, nogen
	erase temp58.dta

}


* flabpaid
gen flabpaid = calc_flabpaid_59_17 + calc_flabpaid_58_11 
label var flabpaid "Labour units paid"


* flabtotl
*gen 

drop calc_*
