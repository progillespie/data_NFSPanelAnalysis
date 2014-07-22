args shortfilename origdata standalone YY validate
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
*        Data/data_NFSPanelAnalysis/OrigData/RAW_79_83 
*
*
*	This file will produce: 
*       
*	  Sheet12.dta 
*
*	for each of the subdirectories of 
*       
*	  RAW_79_83/raw_dta/
*       
* 	
*       The SAS variables created relate to fertiliser 
* 	application and cost for various crops, e.g.:
*
*	wwhcufnq swhcufpq sotcufrv etc.
*
********************************************************
* READ THE README.txt FILE BEFORE CHANGING ANYTHING!!!
********************************************************

local i = 12

if "`standalone'"=="standalone"{
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/raw`YY'_head.xls", sheet("Sheet12") firstrow clear
}



capture rename farm farmcode
label var farmcode "Farm code"



* Run the file which defines the program cropcodekey for use below.
qui do sub_do/cropcodekey.do



*====================================================================
* Apply renaming do file from appropriate mapping sheet of 
*   raw2IBnamemappings.xlsx here
*====================================================================
do sub_do/_renameSheet/renameSheet`i'.do
outsheet using ///
  `origdata'/csv/`shortfilename'/Sheet`i'.csv, replace comma
*====================================================================



* Get per kg fertiliser price for each row
*  (i.e. the specific fertilser on each farm)
gen fertprice = ORIGINAL_COST_EU/ORIGINAL_QUANTITY_50KGBAGS
replace fertprice = fertprice/50



* We need to loop over each of the alloccropcode columns to
*  guarantee that I get info on all crop codes (e.g. what if
*  code 1234 appears only in alloccropcode4 ? I'd miss it!)

* Get lists of crop codes in alloccropcodes 1 through 4
foreach num in 1 2 3 4{
	di "Extracting codes entered as values for alloccropcode`num'"
	qui levelsof alloccropcode`num', local(cropcodelist`num')
}



* Now get the union of those lists for a master list
local cropcodelist: list cropcodelist1 | cropcodelist2 
local cropcodelist: list cropcodelist  | cropcodelist3
local cropcodelist: list cropcodelist  | cropcodelist4
local zero = 0
local dot "."
local cropcodelist: list cropcodelist - zero
local cropcodelist: list cropcodelist - dot	
* Remove any duplicate codes, and sort the list
local cropcodelist: list uniq cropcodelist
local cropcodelist: list sort cropcodelist



* Loop to sum recurring codes across a single row, saves in variable
*  named fertXXXX where the XXXX is the crop code. There will now be
*  a new var for each crop code.
foreach code of local cropcodelist{

	* Calculate quantity of specific fertiliser applied to this crop
	capture drop QUANTITY_ALLOCATED_50KGBAGS`code'
	gen     QUANTITY_ALLOCATED_50KGBAGS`code' = 0

	replace QUANTITY_ALLOCATED_50KGBAGS`code' = Quantity1 if alloccropcode1==`code' 
	replace QUANTITY_ALLOCATED_50KGBAGS`code' = QUANTITY_ALLOCATED_50KGBAGS`code' + Quantity2 ///
	                           if alloccropcode2==`code' 
	replace QUANTITY_ALLOCATED_50KGBAGS`code' = QUANTITY_ALLOCATED_50KGBAGS`code' + Quantity3 ///
	                           if alloccropcode3==`code' 
	replace QUANTITY_ALLOCATED_50KGBAGS`code' = QUANTITY_ALLOCATED_50KGBAGS`code' + Quantity4 /// 
	                           if alloccropcode4==`code' 
	replace QUANTITY_ALLOCATED_50KGBAGS`code' = QUANTITY_ALLOCATED_50KGBAGS`code'*50    // convert 50kg bags to kgs 
	label var QUANTITY_ALLOCATED_50KGBAGS`code' "Fertiliser allocated to `code' (kgs)"


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
	


	* Vars N P and K are the ratio of those elements in the specific
	* fertiliser applied. This is part of the reason for multiple rows
	* per farm. We only care about totals of N,P,and K per crop (not
	* the ratios they were applied in), so we need to calculate how
	* much N,P,K goes to each crop as a result of each fertiliser mix 
	* BEFORE collapsing the data by farm (i.e. combining the rows).
	gen D_FERTILISER_N_NO`code' = (QUANTITY_ALLOCATED_50KGBAGS`code' * ANALYSIS_N)/100
	gen D_FERTILISER_P_NO`code' = (QUANTITY_ALLOCATED_50KGBAGS`code' * ANALYSIS_P)/100
	gen D_FERTILISER_K_NO`code' = (QUANTITY_ALLOCATED_50KGBAGS`code' * ANALYSIS_K)/100
	label var D_FERTILISER_N_NO`code' "Kgs of N applied to crop `code'"
	label var D_FERTILISER_P_NO`code' "Kgs of P applied to crop `code'"
	label var D_FERTILISER_K_NO`code' "Kgs of k applied to crop `code'"



	* Create cost associated with this quantity 
	* (fertprice is row specific, so it will be the correct price)
	*gen cufrv`code' =  QUANTITY_ALLOCATED_50KGBAGS`code' * fertprice
	*label var cufrv`code' "Expense for fertiliser applied to crop `code'"
	gen D_FERTILISER_COST`code' =  QUANTITY_ALLOCATED_50KGBAGS`code' * fertprice
	label var D_FERTILISER_COST`code' "Expense for fertiliser applied to crop `code'"
	

	/*
	* Use abbreviations and digits to rename vars. Some vars will
	*  need lastdigit in order to be a unique varname. We'll 
	*  attempt to strip this off where possible below.
	if "`cropabbrev'" != "" & {

	   rename cufnq`code'   `descriptor'`cropabbrev'cufnq`lastdigit'
	   rename cufpq`code'   `descriptor'`cropabbrev'cufpq`lastdigit'
	   rename cufkq`code'   `descriptor'`cropabbrev'cufkq`lastdigit'
	   rename cufrv`code'   `descriptor'`cropabbrev'cufrv`lastdigit'

	}



	   * If valid, remove the lastdigit from varname, but don't do
	   *  it if it causes an error.
	   capture rename  ///
	      `descriptor'`cropabbrev'`var'`lastdigit' ///
              `descriptor'`cropabbrev'`var'

	*/
}



* Remove vars that will be meaningless when the data is collapsed
drop alloccropcode?
drop Quantity? 
drop card
drop ANALYSIS_N
drop ANALYSIS_P
drop ANALYSIS_K 
drop fertprice
*drop fert???? 
*drop *cuf?v????
*drop *cuf?q????
*capture drop cuf?v????
*capture drop cuf?q????



* Collapsing will destroy labels, so save them to macros
foreach v of var * {
	
	local shortv = subinstr("`v'", "_", "", .)
	local l`shortv' : variable label `v'

	if `"`l`shortv''"' == "" {
		local l`shortv' "`v'"
	}

}



* Vars mistakenly cast as strings
destring CLOSING_INVENTORY_50KGBAGS, replace

* Collapse the data to one farm per row 
qui ds farmcode, not // Get list of all vars less the by-variable
collapse (sum) `r(varlist)', by(farmcode)  



* Restore labels to variables
foreach v of var * {

	label var `v' "`l`shortv''"

}
