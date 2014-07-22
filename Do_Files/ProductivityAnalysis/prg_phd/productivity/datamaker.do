*********************************************
* Working Copy
*********************************************											
*	Patrick R. Gillespie					
*	Research Officer					
*	Teagasc, REDP						
*	Athenry, Co Galway, Ireland				
*	patrick.gillespie@teagasc.ie			
*											
*********************************************
*	Work for PhD
*	Part of Framework Project										
*	
*	04/02/2012
*	
*	SFA models in LIMDEP would not run
*	when 07 to 09 were added. Identified										
*	missing variables. This file extracts
*	those vars from raw NFS data.
*	
*	Input files location
*	F:/pg/productivity/inputdata/nfsraw/
*	Subdirectories
*	2007	2008	2009
*
* 	NFS data is contained in multiple 
*	spreadsheets. These should be 
* 	converted to .csv and named using 
* 	the format x_year where x is the 
* 	index number as suggested by the 
* 	filename (e.g. "2009 VAR 1-226.xls" 
* 	became "1_2009.csv", "2009 VAR 227-409 
* 	ok demog.xls" became "2_2009.csv", etc. 
* 	because there is a clear order to 
* 	the files). 
* 
* 	Output files will be saved in the 
*	directory called "dta" which the file
* 	looks for one level up from the present
* 	working directory. The files will be 
*	named using the format YEARvars.dta, 
* 	one for each of the years 2007, 2008,
* 	and 2009. The do-file is extendable to 
* 	additional years by ensuring the 
* 	datafiles are available in their own
* 	subdirectories, stored in nfsraw,
* 	and with all the files converted to 
* 	.csv using the naming convention 
* 	described above, and with alterations
* 	to the loop definitions as necessary.
*********************************************
* extract missing vars from raw nfs years
*********************************************
clear
set mem 500m


* Navigate to directory with NFS raw data years
cd F:/pg/productivity/inputdata/nfsraw/

* Define outer loop for reading in files (over each year)
foreach yyyy in 2007 2008 2009{ 
	* Define inner loop for reading in files (within each year)
       foreach file in 1 2 3 4 5 6 7 8 9{ 
       clear
       di "Reading data from `file'_`yyyy'.csv"
       insheet using `yyyy'/`file'_`yyyy'.csv, comma names 
       sort ffarmcod
	 gen year = `yyyy'
	 save `yyyy'/`file'_`yyyy',replace
 	 }
}

* Define outer loop for reading in files (over each year)
foreach yyyy in 2007 2008 2009{ 
	 clear
	 * Load starting dataset and merge in each year
       di "Loading `yyyy'/1_`yyyy'"
	 use `yyyy'/1_`yyyy'
	 
	 * Inner loop for merging remaining files (within each year)
	 foreach file in 2 3{ 
       di "Merging data from `file'_`yyyy'"
       merge ffarmcod using `yyyy'/`file'_`yyyy', sort
       drop _merge
 	 }
	keep ffarmcod year iaisfdy dotomkvl fdairygo fcplivgo fainvmch fainvbld fdcaslab fvalflab fohirlab fomacopt foexlime fofuellu fbelclbl fainvfrm flabsmds farmgo
	save ../dta/`yyyy'vars, replace
}

* Each year's dataset of missing variables has now been created. 
* The farmcode has a different variable name in the NFS than COD's 84 - 09
* dataset (and many dataset which I may have created using this) so the following
* loop renames that to one COD's dataset uses.
foreach yyyy in 2007 2008 2009{
	use ../dta/`yyyy'vars,clear
	rename ffarmcod cffrmcod
	sort cffrmcod year
	save, replace
}

* Now load in the master dataset and merge each year 
use ../../data8409/9609v1,clear


foreach yyyy in 2007 2008 2009{
	sort cffrmcod year
	merge cffrmcod year using ../dta/`yyyy'vars, update
	drop _merge
}

* Save your new master dataset (give a new name if  you want to preserve the original)
save ../../data8409/9609v2, replace

* At this point let J. Carroll's creator and construction files take over.
* Had to make slight alterations to original to get them to run. Current version
* of data creator file is called 8409dycreator.do
do ../../data8409/8409dycreator.do 
do ../../data8409/DDF_9609v2d.do

save ../../inputdata/dta/9609v2d, replace
outsheet using ../../inputdata/csv/9609v2d.csv, comma replace



 

