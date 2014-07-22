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
*        Data/data_NFSPanelAnalysis/OrigData/RAW_79_83 
*
*
*	This file will produce: 
*       
*	  Sheet12.dta 

*	for each of the subdirectories of 
*       
*	  RAW_79_83/raw_dta/
*
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
*************************************************************************


if "`standalone'"=="standalone"{
	import excel using "D:/Data/data_NFSPanelAnalysis/OrigData/RAW_79_83/RAW_79_83/raw79_head.xls", sheet("Sheet12") firstrow clear
}
local project "quota"
local outdata "D:/Data/data_NFSPanelAnalysis/OutData/`project'"
local zero = 0


* Get per kg fertiliser price for each row 
*  (i.e. the specific fertilser on each farm)
gen fertprice = TotalCost/TotalQuantity50Kgbags
replace fertprice = fertprice/50


* We need to loop over each of the alloccropcode columns to 
*  guarantee that I get info on all crop codes (e.g. what if 
*  code 1234 appears only in alloccropcode4 ? I'd miss it!)

* Get lists of crop codes in alloccropcodes 1 through 4
foreach num in 1 2 3 4{
	di "Extracting codes entered as values for alloccropcode`num'"
	qui levelsof alloccropcode`num', local(cropcode`num')
}

* Now get the union of those lists for a master list
local cropcode: list cropcode1 | cropcode2 
local cropcode: list cropcode  | cropcode3
local cropcode: list cropcode  | cropcode4
local cropcode: list cropcode - zero	

* Remove any duplicate codes, and sort the list
local cropcode: list uniq cropcode
local cropcode: list sort cropcode


* Loop to sum recurring codes across a single row, saves in variable
*  named fertXXXX where the XXXX is the crop code. There will now be
*  a new var for each crop code.
foreach code of local cropcode{


	capture drop fert`code'

	* Calculate quantity of specific fertiliser mix applied to this
	*  crop.
	gen     fert`code' = 0
	replace fert`code' = Quantity1 if alloccropcode1==`code' 
	replace fert`code' = fert`code' + Quantity2 ///
	                           if alloccropcode2==`code' 
	replace fert`code' = fert`code' + Quantity3 ///
	                           if alloccropcode3==`code' 
	replace fert`code' = fert`code' + Quantity4 /// 
	                           if alloccropcode4==`code' 
	replace fert`code' = fert`code'*50 // convert 50kg bags to kgs 


	local first3digits = substr("`code'",1,3)
	local lastdigit    = substr("`code'",-1,1)

	* Conditional statements to replace codes with SAS abbreviations
	
	* Initialise the macro
	local cropabbrev ""
	
	* First three digits = crop 
	if "`first3digits'" =="111" {
		local cropabbrev "wh"
	}
	
	if "`first3digits'" =="114" {
		local cropabbrev "by"
	}
	
	if "`first3digits'" =="115" {
		local cropabbrev "ot"
	}
	
	if "`first3digits'" =="131" {
		local cropabbrev "pot"
	}
	
	if "`first3digits'" =="132" {
		local cropabbrev "sbe"
	}
	
	if "`first3digits'" =="143" {
		local cropabbrev "osr"
	}
	
	if "`first3digits'" =="156" {
		local cropabbrev "lsd"
	}
	
	if "`first3digits'" =="157" {
		local cropabbrev "mby"
	}
	
	if "`first3digits'" =="175" {
		local cropabbrev "for"
	}
	
	if "`first3digits'" =="811" {
		local cropabbrev "stw"
	}
	
	if "`first3digits'" =="902" {
		local cropabbrev "msl"
	}
	
	if "`first3digits'" =="903" {
		local cropabbrev "asl"
	}
	
	if "`first3digits'" =="904" {
		local cropabbrev "tms"
	}
	
	if "`first3digits'" =="906" {
		local cropabbrev "fbt"
	}
	
	if "`first3digits'" =="922" {
		local cropabbrev "hay"
	}
	
	if "`first3digits'" =="923" {
		local cropabbrev "sil"
	}

	
	*Last digit = description. There are SAS abbreviations for only 
	* the "spring" = 1 and "winter"=6 descriptors . Also, these are 
	* only ever applied to the crops wheat, barley, and oats. 
	local descriptor ""
	if "`lastdigit'"    =="1"  &        ///
	  ["`first3digits'" == "111"  ///
	  | "`first3digits'"== "114"  /// 
	  | "`first3digits'"== "115"  ]  {

		local descriptor "s"
		local lastdigit ""
		
	}

	if "`lastdigit'"    =="6"  &  ///
	  ["`first3digits'" == "111"  ///
	  | "`first3digits'"== "114"  /// 
	  | "`first3digits'"== "115"  ]  {

		local descriptor "w"
		local lastdigit ""
	}


	* Vars N P and K are the ratio of those elements in the specific
	* fertiliser applied. This is part of the reason for multiple rows
	* per farm. We only care about totals of N,P,and K per crop (not
	* the ratios they were applied in), so we need to calculate how
	* much N,P,K goes to each crop as a result of each fertiliser mix 
	* BEFORE collapsing the data by farm (i.e. combining the rows).
	if "`cropabbrev'" == "" {
		local cropabbrev "nul`code'"
	}
	gen `descriptor'`cropabbrev'cufnq`lastdigit' = ///
	  (fert`code' * N)/100
	gen `descriptor'`cropabbrev'cufpq`lastdigit' = ///
	  (fert`code' * P)/100
	gen `descriptor'`cropabbrev'cufkq`lastdigit' = ///
	  (fert`code' * K)/100
	

	* Create cost associated with this quantity 
	* (fertprice is row specific, so it will be the correct price)
	gen `descriptor'`cropabbrev'cufrv`lastdigit'= ///
	  fert`code' * fertprice


	* NOTE: Either `descriptor' or `lastdigit' will be an empty string	  *        by this point. The reason for building the variable name
	*        this way is that the descriptor is the first character of	  *        the SAS varname, but is only applied to certain crops.
	*        I'd like to retain this info in the varname for the other        *        crops , but Stata doesn't allow varnames to begin with a 	    * 	     digit, hence I just add the last digit back to the end of        *        the varname. I also need to do something like this to 
	* 	 ensure that I have unique varnames (e.g. for sugarbeet
	*        descriptor will be empty (as it should be) but there 

}


if "`validate'"!= "validate"{
	* Remove vars that will be meaningless when the data is collapsed
	drop fert???? 
	drop Totalqtyused
	drop Quantityclosinginventory
	drop alloccropcode?
	drop Quantity? 
	drop card
	drop N
	drop P
	drop K 
	drop TotalCost
	drop TotalQuantity
	drop fertprice
	
	* Remove vars for which there is no SAS varname
	drop nul*

}


