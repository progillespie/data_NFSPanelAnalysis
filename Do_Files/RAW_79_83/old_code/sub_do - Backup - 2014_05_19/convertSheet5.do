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
*	  Sheet5.dta 
*
*	for each of the subdirectories of 
*       
*	  RAW_79_83/raw_dta/
*
*       
* 
*       The SAS variables created relate to crop details
*	and arable aid 
* 
*
*
*	Algorithm: SINGLE CODE
*
*
********************************************************
* READ THE README.txt FILE BEFORE CHANGING ANYTHING!!!
********************************************************



if "`standalone'"=="standalone"{
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw79_head.xls", sheet("Sheet5") firstrow clear
}



rename farm farmcode
label var farmcode "Farm code"



* Run the file which defines the program cropcodekey for use below.
qui do sub_do/cropcodekey.do







*====================================================================
* Cut and paste rename commands from appropriate mapping sheet of 
*   raw2SASnamemappings.xlsx here
*====================================================================
rename Acres                           cuarq
rename TotalYield                      cuylq
rename SalesQuantitytonsAc             cuslq
rename SalesValue                      cuslv
rename FedQuantitytonsAc               cufdq
rename FedValue                        cufdv
rename SeedQuantitytonsAc              cusdq
rename SeedValue                       cusdv
rename AllowancesHousetonsAc           junk_05_25
rename AllowancesWagestonsAc           junk_05_26
rename WastetonsAc                     cuwtq
rename ClosingInventoryQuantityto      cuclq
rename ClosingInventoryValue           cuclv
*====================================================================
capture drop junk*



*Create varlist to loop over (should match above, less junk* vars)
qui ds farmcode card CropCode, not // all vars EXCEPT listed here
local vlist "`r(varlist)'"



* Create a list of crop codes present in the data (excl. 0)
tostring CropCode, replace
qui levelsof CropCode, local(cropcodelist)
local zero = 0
local dot "."
local cropcodelist: list cropcodelist - zero
local cropcodelist: list cropcodelist - dot	
local cropcodelist: list uniq cropcodelist // ensure codes are unique
local cropcodelist: list sort cropcodelist // sort the list of codes
macro list _cropcodelist // display the list for review



foreach code of local cropcodelist{

	di "Creating vars for crop `code'"

	
	foreach var of local vlist {

	   gen `var'`code' = 0
	   replace `var'`code' = `var' if CropCode == "`code'"
	   * Way of copying label from generic to crop specific `var' 
	   local lbl : variable label `var'
	   label variable `var'`code' "`lbl' for crop `code'"
	   


	   * -------------------------------------------------------
	   *  Calling Crop code key program
	   * -------------------------------------------------------
	   * Program defined in sub_do/cropcodekey.do
	   * Takes crop code and returns SAS abbreviations, as well 
	   * as first3digits and lastdigit of crop code as separate 
	   * macros
	   * -------------------------------------------------------
	   cropcodekey `code'
	   * Store program's results in local macros for use below
	   local first3digits "`r(first3digits)'" 
	   local lastdigit    "`r(lastdigit)'" 
	   local cropabbrev   "`r(cropabbrev)'" 
	   local descriptor   "`r(descriptor)'" 
	   * -------------------------------------------------------
	


	   * Use abbreviations and digits to rename vars. Some vars will
	   *  need lastdigit in order to be a unique varname. We'll 
	   *  attempt to strip this off where possible below.
	   if "`cropabbrev'" != "" & {
	      macro list _cropabbrev _var
	      rename                                   ///
                 `var'`code'                           ///
                 `descriptor'`cropabbrev'`var'`lastdigit'
           }
	   else {
	      di "No SAS abbreviation for `code'. Varname unchanged."
	   }

	   * If valid, remove the lastdigit from varname, but don't do
	   *  it if it causes an error.
	   capture rename  ///
	      `descriptor'`cropabbrev'`var'`lastdigit' ///
              `descriptor'`cropabbrev'`var'

	}	

}


* Remove raw variables
drop CropCode
drop card
foreach var of local vlist{

	capture drop `var'
	capture drop `var'????

}



* Collapsing will destroy labels, so save them to macros
foreach v of var * {
	
	local l`v' : variable label `v'
	if `"`l`v''"' == "" {
		local l`v' "`v'"
	}

}



* Collapse the data to one farm per row 
ds farmcode, not // Get list of all vars less the by-variable
collapse (sum) `r(varlist)', by(farmcode)  



* Restore labels to variables
foreach v of var * {

	label var `v' "`l`v''"

}
