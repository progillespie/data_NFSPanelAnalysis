* takes NUTS3 level weather data, collapses to NUTS2 
*  level for Ireland (finest disaggregation available)
*  then creates region and subregion codes from nuts_id
*  to prepare for merging with FADN data



* locals only apply to the file in which they were set, 
*  so either way they need to be set here
local fadnpaneldir $datadir/data_FADNPanelAnalysis
local fadnoutdatadir `fadnpaneldir'/OutData/$project
local nfspaneldir $datadir/data_NFSPanelAnalysis
local origdatadir `fadnpaneldir'/OrigData 
local fadn9907dir  `fadnpaneldir'/OrigData/eupanel9907
local fadn2dir  `fadnpaneldir'/OrigData/FADN_2/TEAGSC


* save before we load the weather data 
*  this file takes virtually no time to run, so just save a 
*  temporary .dta in the current directory and delete it at
*  the bottom of this file.
save temp$project, replace

insheet using `origdatadir'/NUTS3Climate.csv, clear

* subregion needs to start as a string var, but will be 
*  changed to numeric at end of file
gen str1 subregion = ""

* store all values of nuts_id to a macro
levelsof nuts_id, local(nuts3)

* loop over values of nuts_id (i.e. nuts3 macro)
foreach code of local nuts3{
	
	* get first two letters of the NUTS code
	*  Should be IE or UK.
	local prefix: di substr("`code'", 1, 2)
	
	
	* if Irish, then paste `prefix' next to the second to 
	*  last digit (either a 1 or a 2) as this ob's
	*  value of subregion
	if "`prefix'" == "IE"{
	local subregcode: di substr("`code'", -2, 1)
	replace subregion = "`prefix'`subregcode'" if nuts_id == "`code'"
	}
	
	* otherwise, do the same as above, but use last digit instead. 
	*  Should be in range 1 to 5.
	else{
	local subregcode: di substr("`code'", -1,1)
	replace subregion = "`prefix'`subregcode'" if nuts_id == "`code'"
	}

* clean up the local macros we don't need any longer
macro drop _prefix _subregcode
}


* have to get rid of this one OUTSIDE of the loop above
macro drop _nuts3


* now collapse the data so we have averages for 2 Irish subregions 
*  and 5 Northern subregions
collapse  area mean_precipmm std_percipmm mean_ann_min_temp std_ann_min_temp mean_ann_max_temp std_ann_max_temp mean_accumalated_ann_rad std_accumalted_ann_rad, by(subregion)


* we're going to need a region variable for the merge. Set to 
*  Irish FADN region code and we'll reset the appropriate values
*  for Northern Ireland in the loop below. 
gen region = 380


* we're also going to need to recode subregion to match FADN data
*  Same idea as in loops above. This time get values of subregion
*  which will be of form ALPHA ALPHA NUMBER (i.e. IE1, UK4, etc)
levelsof subregion, local(nuts2)


* loop over each subregion value, get the digit, update region
*  to the Northern Ireland code if the subregion starts with UK
*  and remove the prefix from subregion for all

foreach code of local nuts2{
	local subregcode: di substr("`code'", 3, .)
	replace region = 441 if subregion == "UK`subregcode'"
	replace subregion = "`subregcode'" if subregion == "`code'"
}


* make subregion numeric instead of a string
destring subregion, replace


* sort before merging
sort region subregion

* take a quick look at the data if it's not very large
list


* save before we load the FADN data as the master dataset.
*  this file takes virtually no time to run, so just save a 
*  temporary .dta for the merge in the current directory 
*  and delete it at the bottom of the file.
save tempweathervars, replace


use temp$project, clear


* sort before merging
sort region subregion


* then merge these values with the FADN data. This is a many to 1
*  merge, i.e. values of each of the variables here will repeat 
*  for every farm in a subregion.
merge m:1 region subregion using tempweathervars.dta


* Now you have weather data in, but there will be unmatched obs 
*  if you're merging to a data set that has only one of the two 
*  countries (weather data has both countries), so drop those 
*  unmatched obs (should be 2 or 5 of them with _merge code == 2)
drop if _merge == 2
tab _merge

erase tempweathervars.dta

