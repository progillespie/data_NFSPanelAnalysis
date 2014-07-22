*****************************************************
*****************************************************
* Stochastic Frontier Modelling for Thesis
* (this master do file is not active yet)
* (it's currently a copy of the master used for 
* (the dairy chapter. I do have a file called 
* (datamaker.do which accomplishes much of the setup).
* (THIS FILE MIGHT BE ABANDONED LATER!!!)
* Patrick R. Gillespie		
*
* 2012
*
*
*****************************************************
* Required input files -
* nfs_data.dta  <-- usual NFS panel file (old system)
* regional_weights.dta <-- on the Z drive
* doFarmDerivedVars.do <-- creates Derived vars (see COD)
* education.csv <-- Requested from Anne Kinsella. Will 
*                    put a copy on the Z drive.
*****************************************************

clear
set mem 700m
set more off
set matsize 500

capture log close
capture cmdlog close



*****************************************************
* 1* Declare local macros for directory paths
*****************************************************

* path to data_NFSPanelAnalysis (i.e. the main directory)
* all subsequent filepath macros depend on this one
local paneldir E:/Data/data_NFSPanelAnalysis

* Make directories for output if they don't exist
capture mkdir `paneldir'/code_R
capture mkdir `paneldir'/OutData/REDP_Book
capture mkdir `paneldir'/OutData/REDP_Book/DairyChapter
capture mkdir `paneldir'/OutData/REDP_Book/DairyChapter/tab_logs

* filepaths of subdirectories of `paneldir'
local nfsdatadir `paneldir'/OutData 
local origdatadir `paneldir'/OrigData 
local Regional_outdatadir `paneldir'/OutData/RegionalAnalysis 
local outdatadir `paneldir'/OutData/REDP_Book/DairyChapter
local dodir `paneldir'/Do_Files/REDP_Book

local intdata nfs_9508 //<- nfs w/ derived vars
local intdata2 "cm_9508" // <- creamery milk only
local intdata3 "cm_9508_ctgrps" //<- adds cost groupings

*****************************************************
* 2* Set working directory and start logs
*****************************************************
cd `dodir'
log using `outdatadir'/master.log, replace 
di  "Job  Started  at  $S_TIME  on $S_DATE"



*****************************************************
* 3* Merge in weights
*****************************************************

use `nfsdatadir'/nfs_data.dta, clear
sort farmcode year
merge farmcode year using `Regional_outdatadir'/regional_weights.dta
drop _merge
*drop if region == . //turned off until regional_weights.dta gets 95-96
tabstat wt region, by(year)



*****************************************************
* 4* Get derived variables
*****************************************************
* To run analysis starting from nfs_data.dta uncomment
* the following. In the interest of transparency and
* reproducibility, this should be done to obtain final 
* results. Leave it turned off when doing intermediate
* program runs to save time. Don't forget to save the 
* intermediate dataset again when debugging.

*do doFarmDerivedVars.do


*save `outdatadir'/`intdata', replace

* closes any logs the previous do-file may have left
* open restarts this file's log
capture log close
log using dychap.log, append

* Starts from the intermediate dataset as a shortcut
use `outdatadir'/`intdata', clear



*****************************************************
* 5* System selection
*****************************************************

gen syst = ffszsyst-int(ffszsyst/10)*10
keep if syst == 1 | syst == 2



*****************************************************
* 6* Code borrowed from 
*    data_NFSPanelAnalysis/Do_Files/FarmLevelModel/FarmLevel_dairy.do
*    ... originally thought it was Thia's, but she wasn't
*    familiar with it, although her name is on the file.
*    ************************************************
*    Subset
*    Keep only farms with dairy gross output
*****************************************************

* Farms with no milk sales
keep if fdairygo > 0 & fdairygo < .
keep if doslcmgl > 0 & doslcmgl < .

* Farms with 50% liquid milk sales
keep if dosllmgl < 0.5*dotomkgl

* No herds with less than 10 dairy cows
keep if dpopinvd > 10

* Save another intermediate dataset, but do so using
* a local macro as this one will be called several times
* in the code below. Using the local ensures that
* the code calls in the correct file if the name of the 
* dataset is ever changed. 



*****************************************************
* Log this section separately
log close
log using `outdatadir'/tab_logs/gl2lt.log, text replace
*****************************************************
* 7* Check for proper units
*****************************************************

* Variables which could be in gallons or litres
local gl2lt_vlist "lt_lu doslcmgl dosllmgl domkfdgl doslmkgl"
local gl2lt_plist "p_doslcm p_dosllm p_domkfd"

* this table makes it clear that the dataset has units in gallons for years < 2002
tabstat year `gl2lt_vlist', by(year)
tabstat year `gl2lt_plist', by(year)

* convert pre-2002 to litres
foreach var in `gl2lt_vlist'{
	replace `var' = `var'*4.54609 if year <= 2001
}

foreach var in `gl2lt_plist'{
	replace `var' = `var'/4.54609 if year <= 2001
}

* but this suggests that monetary units are already converted to euro for the pre 1999 years
tabstat p_* *vl*, by(year)

save `outdatadir'/`intdata2'.dta, replace



*****************************************************
* Log this section separately
log close
log using `outdatadir'/tab_logs/sector_units.log, text replace
****************************************************
* 8* Subset and collapse data to relevant var's per year 
*****************************************************
* create local macros of vars to keep when dataset is collapsed
local fdairy = "fdairygo fdairygm fdairydc"
local farm = "farmgo farmgm farmdc farmffi"
local go_vlist = "daforare doslcmgl  domlkbon  domlkpen  dosllmgl  domkfdgl  domkalvl  docftfvl docftfno docfslvl docfslno  doschbvl  dotochbv dotochbn  dopchbvl dopchbno  dotichbv dotichbn  dovlcnod" 

local go_plist = "p_doslcm p_dosllm p_domkfd p_docftfvl p_docfslvl p_dotochbv p_dopchbvl p_dotichbv" 

local ct_vlist = "dpnolu ddconvalq ddpasturq ddwinforq d_othmiscdcq ivmalldyq iaisfdyq itedairyq imiscdryq flabccdyq"

local ct_plist = "PCattleFeed PTotalFert POtherInputs PVetExp PMotorFuels PLabour"



* Following Head of Department's directions, changed code to generate
* per unit measures after summing columns by each year (sector-wide unit measures)

* tabstat will make a table in the log file; collapse then outsheet
* gives you a csv file which will match that output
sort year
tabstat daforare dpnolu doslmkgl `fdairy'[weight=wt], by(year) stats(sum)
collapse (sum) doslmkgl `fdairy' `farm' `go_vlist' `go_plist' `ct_vlist' `ct_plist' dosl*vl [weight=wt], by(year)

*******
* Some unit measures were created by doFarmDerivedVars.do, but these were not selected by the collapse command above, so we can recreate them here without a problem (i.e. no drop command necessary).
*******
* Per hectare measures
foreach var of varlist `fdairy' `go_vlist' `ct_vlist'{
	gen `var'_ha = `var'/daforare
}

* Per hectare indices (base = 2000)
foreach var of varlist `fdairy'{
	gen `var'_ha_i = `var'_ha/`var'_ha[6]
}

* Per LU measures
foreach var of varlist `fdairy' `go_vlist' `ct_vlist'{
	gen `var'_lu = `var'/dpnolu
}

* Per LU indices (base = 2000)
foreach var of varlist `fdairy'{ 
	gen `var'_lu_i = `var'_lu/`var'_lu[6]
}

* Per litre measures
foreach var of varlist `fdairy' `go_vlist' `ct_vlist'{
	gen `var'_lt = `var'/doslmkgl
}

* Per litre indices (base = 2000)
foreach var of varlist `fdairy'{ 
	gen `var'_lt_i = `var'_lt/`var'_lt[6]
}

gen stkrate=dpnolu/daforare
gen stkrate_i=stkrate/stkrate[6]
gen yield = doslmkgl/dpnolu 
gen yield_i = yield/yield[6]

outsheet year *_ha *_lu *_lt *_i stkrate using `outdatadir'/sector_units.csv, comma replace




*****************************************************
* Log this section separately
log close
log using `outdatadir'/tab_logs/farm_measures.log, text replace
*****************************************************
* 9* Obtain means per farm
*****************************************************

* Data is currently collapsed to sector sums, so clear
* and reload intdata2 which is at the farm level, but
* has also been subsetted (per first 6 sections of this
* file).
use `outdatadir'/`intdata2', clear

* doFarmDerivedVars.do created some unit measures, but we'd like to recreate them here, so drop any previous versions in the dataset.
drop *_ha *_lu *_lt

* And now recreate them... 
* Per hectare measures
foreach var of varlist `fdairy' `go_vlist' `ct_vlist'{
	gen `var'_ha = `var'/daforare
}

* Per LU measures
foreach var of varlist `fdairy' `go_vlist' `ct_vlist'{
	gen `var'_lu = `var'/dpnolu
}

* Per litre measures
foreach var of varlist `fdairy' `go_vlist' `ct_vlist'{
	gen `var'_lt = `var'/doslmkgl
}

* Create a local macro containing the proper order of variables for the Excel worksheet. Cannot put year into this list because it will cause an error when we collapse. Specify year `excel' in the outsheet command to get the right order. 
sort year
local excel doslmkgl fdairygo fdairygm fdairydc farmgo farmgm farmdc farmffi daforare doslcmgl domlkbon domlkpen dosllmgl domkfdgl domkalvl docftfvl docftfno docfslvl docfslno doschbvl dotochbv dotochbn dopchbvl dopchbno dotichbv dotichbn dovlcnod p_doslcm p_dosllm p_domkfd p_docftfvl p_docfslvl p_dotochbv p_dopchbvl p_dotichbv dpnolu ddconvalq ddpasturq ddwinforq d_othmiscdcq ivmalldyq iaisfdyq itedairyq imiscdryq flabccdyq PCattleFeed PTotalFert POtherInputs PVetExp PMotorFuels PLabour 

collapse (mean) `excel'[weight=wt], by(year)
outsheet year `excel' using `outdatadir'/farm_measures.csv, comma replace



*****************************************************
* Log this section separately
log close
log using `outdatadir'/tab_logs/ct_cat.log, text replace
*****************************************************
*10* Obtain cost groupings for each year 
*****************************************************
* Some setup which will result 
* in creation of intdata3
******************************
use `outdatadir'/`intdata2', clear

* Fixed (overhead) costs are not broken out by enterprise.
* Creating allocation weight for the dairy enterprise to 
* apply to fixed costs. After 2005, the weight should remove
* the Single Farm Payment and Disadvantaged Area Payments from 
* the denominator. Then apply the allocation weight to generate 
* fixed costs and total costs for the dairy enterprise. Then 
* break into per hectare and per litre. 
gen d_alloc_wt = fdairygo/farmgo
replace d_alloc_wt = fdairygo/(farmgo - sfp - lfa) if year>=2005
gen fdairyoh = farmohct*d_alloc_wt
gen fdairytct = fdairydc + fdairyoh
* Upon further review, I've realised that this cost grouping is inconsistent with the per litre cost grouping and is misleading. More intensive 
* producers will have higher costs per hectare but lower costs per litre, and consequently higher margin per litre. The effect of using per ha
* cost could be to mix groups of farms that are too different to belong together. Furthermore, the cost grouping should be consistent no matter which
* measure of GM (per ha or per litre), so as to ensure that the graphs are in fact comparable. Code was changed to reflect these decisions on 12 Oct,2012. 
gen fdairytct_lt = fdairytct/doslmkgl

* Create cost groupings in this format: yyyy_g (i.e. 4 digit year then 
* group number). This format allows you to easily collapse the dataset 
* by year AND cost grouping (collapse usually allows only one grouping
* variable). 
* Create 3 groups of farms by total costs per hectare in each year
local i = 1995
gen str ct_lt_cat = "" //<- "" is not a typo. One indicates missing values for string variables with empty double inverted commas (double quotes)
* Create 3 groups of farms by total costs per litre in each year
local i = 1995
while `i' < 2009{
	* creates grouping for the year, but missing in other years.
	xtile ct_lt_cat_`i'=fdairytct_lt [weight=wt] if year==`i', nq(3)

	* Thia's convention is to number the categories from highest cost
	* to lowest cost, so reassign values to match that by subtracting
	* from 4. 
	replace ct_lt_cat_`i' = 4 - ct_lt_cat_`i' if year==`i'

	* adds the 4 digit year to front, still missing in other years
	egen tmp_cat = concat(year ct_lt_cat_`i'), punct("_")

	* One var that fills up as you go through the loop (no missings).
	replace ct_lt_cat = tmp_cat if year == `i'
	drop ct_lt_cat_`i' tmp_cat
	local i = `i'+1
}
save `outdatadir'/`intdata3', replace

******************************
* Create a csv with 3 rows per year (one per group) with group totals 
* per unit measures.
******************************

*************
* Per hectare
*************

* gsort allows descending order, sort does not
gsort year -fdairytct_lt
collapse (sum) daforare fdairygo fdairydc fdairyoh fdairygm [weight=wt], by(ct_lt_cat)

* generate per ha measures using sums of each group in each year
* which is what you have from the collapse statement
foreach var in fdairygo fdairydc fdairyoh fdairygm {
	gen `var'_ha = `var'/daforare
}

* separate year and group info in ct_lt_cat
gen year = substr(ct_lt_cat, 1, 4)
replace ct_lt_cat = substr(ct_lt_cat, -1, 1)

* then store as numeric vars instead of strings and create the csv
destring year ct_lt_cat, replace
sort ct_lt_cat year
outsheet using `outdatadir'/ct_cat_gmha.csv, comma replace
use `outdatadir'/`intdata3', clear



*************
* Per litre
*************

* gsort allows descending order, sort does not
gsort year -fdairytct_lt
collapse (sum) doslmkgl fdairygo fdairydc fdairyoh fdairygm [weight=wt], by(ct_lt_cat)

* generate per ha measures using sums of each group in each year
* which is what you have from the collapse statement
foreach var in fdairygo fdairydc fdairyoh fdairygm {
	gen `var'_lt = `var'/doslmkgl
}

* separate year and group info in ct_lt_cat
gen year = substr(ct_lt_cat, 1, 4)
replace ct_lt_cat = substr(ct_lt_cat, -1, 1)

* then store as numeric vars instead of strings and create the csv
destring year ct_lt_cat, replace
sort ct_lt_cat year
outsheet using `outdatadir'/ct_cat_gmlt.csv, comma replace



*****************************************************
* Log this section separately
log close
log using `outdatadir'/tab_logs/sex.log, text replace
*****************************************************
*11* Creamery producer sex
*****************************************************
use `outdatadir'/`intdata2', clear

* Sex of holder - collapse dataset to yr-sex groups, summing the wts
* to arrive at numbers of farms (or farm holders) represented by the 
* sample for each group. 
egen yr_sex = concat(year ogsexhld), punct("_")
collapse (sum) wt, by(yr_sex)

* extract year and sex information from yr_sex and store as numeric
gen year = substr(yr_sex, 1, 4)
gen ogsexhld = substr(yr_sex, -1, 1)
destring year ogsexhld, replace

* calculate farms represented in each year and divide the group wts by
* this figure to arrive at percentage of farms in each group within each 
* year
bysort year: egen yr_wt_tot = sum(wt)
gen sex_pct = wt/yr_wt_tot
sort ogsexhld year

* the data is now ready for a table, display then save csv for Excel
tabstat year ogsexhld wt yr_wt_tot sex_pct, by(yr_sex)
outsheet year ogsexhld wt yr_wt_tot sex_pct using `outdatadir'/sex.csv, comma replace


*****************************************************
* Log this section separately
log close
log using `outdatadir'/tab_logs/age.log, text replace
*****************************************************
*12* Creamery producer age
*****************************************************
* Age of holder
use `outdatadir'/`intdata2', clear

* Age of holder - collapse dataset to yr-age groups, summing the wts
* to arrive at numbers of farms (or farm holders) represented by the 
* sample for each group. 

* NOTE: ogagehld10 is a variable capturing 10 year age ranges from 
* 20 to 70+ which is created by doFarmDerivedVars.do.

egen yr_age = concat(year ogagehld10), punct("_")
collapse (sum) wt, by(yr_age)

* extract year and age information from yr_age and store as numeric
gen year = substr(yr_age, 1, 4)
gen ogagehld10 = substr(yr_age, -2, 2)
destring year ogagehld10, replace

* calculate farms represented in each year and divide the group wts by
* this figure to arrive at percentage of farms in each group within 
* each year
bysort year: egen yr_wt_tot = sum(wt)
gen age_pct = wt/yr_wt_tot
sort ogagehld10 year

* the data is now ready for a table, display then save csv for Excel
tabstat year ogagehld10 wt yr_wt_tot age_pct, by(yr_age)
outsheet year ogagehld10 wt yr_wt_tot age_pct using `outdatadir'/age.csv, comma replace



*****************************************************
* Log this section separately
log close
log using `outdatadir'/tab_logs/marst.log, text replace
*****************************************************
*13* Creamery producer marital status
*****************************************************
use `outdatadir'/`intdata2', clear

* Marital status of holder - collapse dataset to yr-marst groups, 
* summing the wts to arrive at numbers of farms (or farm holders)
* represented by the sample for each group. 

egen yr_marst = concat(year ogmarsth), punct("_")
collapse (sum) wt, by(yr_marst)

* extract year and marital status information from yr_marst and 
* store as numeric
gen year = substr(yr_marst, 1, 4)
gen ogmarsth = substr(yr_marst, -1, 1)
destring year ogmarsth, replace

* calculate farms represented in each year and divide the group wts by
* this figure to arrive at percentage of farms in each group within 
* each year
bysort year: egen yr_wt_tot = sum(wt)
gen marst_pct = wt/yr_wt_tot
sort ogmarsth year

* the data is now ready for a table, display then save csv for Excel
tabstat year ogmarsth wt yr_wt_tot marst_pct, by(yr_marst)
outsheet year ogmarsth wt yr_wt_tot marst_pct using `outdatadir'/marst.csv, comma replace



*****************************************************
* Log this section separately
log close
log using `outdatadir'/tab_logs/npers.log, text replace
*****************************************************
*14* Creamery producer households - age distribution
*****************************************************
use `outdatadir'/`intdata2', clear

* npers variables count the number of people falling into age groups
* in each farm household. Create a total figure for calculating %
* of the farm household for each category
gen totnpers = npers04 + npers515 + npers1519 + npers2024 + npers2544 + npers4564 + npers65

* now calculate the perctages
foreach var of varlist nper*{
	gen `var'_pct = `var'/totnpers
}

* Display the weighted per farm averages, then collapse the data
* so that it matches the table and write a csv for Excel.
tabstat *nper* [weight=wt], by(year)
collapse (mean) *npers* [weight=wt], by(year)
outsheet using `outdatadir'/npers.csv, comma replace



*****************************************************
* Log this section separately
log close
log using `outdatadir'/tab_logs/educ.log, text replace
*****************************************************
*15* Creamery producer education
*****************************************************
insheet using `outdatadir'/education.csv, clear
* for worker code 1 = owner/manager, 3 = owner not manager
* these are the only ones I'm interested in, so drop the rest.
keep if [worker_code ==1]
drop if ye_ar<2008
* This data contains a number of duplicate observations. This 
* duplication goes beyond the fact that the data is multi-caret
* (speak to Anne Kinsella, Brian Moran, or John Lennon for more 
* info on this... essentially there is more that one ob per farm
* per year by design). Even when limiting the selection to only
* owner/managers, there's still more than one ob per farm per 
* year. There may well be more than one owner/manager on several 
* farms, but I'll need tolocal educ "formal_agricultural_training_yn highest_education_achieved_code highest_formal_agri_training_cod current_in_education_yn" condense this somehow.

* Should keep the obs (i.e. rows) with the fewest missing values
* Next 3 lines counts missings on each row, creates var which =
* minimum number of missings per group of duplicates, then drops
* rows which have more missings than the minimum. This step is
* necessary because duplicates tag or duplicates drop merely 
* keeps the first row in each group of duplicates, not necessarily
* the BEST row.
egen miss = rowmiss(_all)
bysort farm_code ye_ar: egen minmiss = min(miss)
drop if miss != minmiss


* The remaining rows will either be unique or will have the same
* number of missing values. Now drop  rows which are exact matches 
* for all values). 
duplicates tag _all, gen(tag)
drop if tag>0
drop tag

* Still have 40 rows for which farm_code and ye_ar do not uniquely
* identify a row. This loop finds the max value within each group of
* duplicates and drops those obs which are not equal to the max value.
* Your left with the rows with the highest values for each var in 
* `educ'. 
rename formal_agricultural_training_yn formag
rename highest_education_achieved_code hieduc
rename highest_formal_agri_training_cod hiform 
rename current_in_education_yn curr_ed
local educ "formag hieduc hiform curr_ed"

foreach var of  varlist `educ'{
	bysort farm_code ye_ar: egen max_`var' = max(`var')
	drop if `var' != max_`var'
}


* Data are now uniquely id'ed by farm_code and ye_ar. 
* Now merge the data into intdata2
rename farm_code farmcode
rename ye_ar year
keep farmcode year `educ'
sort farmcode year
save `outdatadir'/educ, replace
use `outdatadir'/`intdata2', clear
merge farmcode year using `outdatadir'/educ, unique nokeep
keep if _merge==3
drop _merge

* Now have data for 303 obs (all in 2008). Collapse and write csv's. 

* create crosstab vars to use as by var's in collapse
foreach var of varlist `educ'{
egen `var'_tg = concat(`var' teagasc), punct("_")
egen `var'_reg = concat(`var' region ), punct("_")
egen `var'_age = concat(`var' ogagehld10), punct("_")
}

save `outdatadir'/educ, replace

* creates freq table csv's for crosstabs of educ vars with teagasc,
* region, and age categories
use `outdatadir'/educ, clear
foreach var of varlist `educ'{
	* var is a varlist local type, so store current value of var 
	* as a string for recreating var after the collapse statement
	local varname = "`var'"

	* teagasc crosstabs
	use `outdatadir'/educ, clear
	collapse (sum) wt, by(`var'_tg)
	egen tot_wt = sum(wt)
	gen pct = wt/tot_wt
	gen `varname' = substr(`var'_tg, 1, 1)
	gen teagasc = substr(`var'_tg, -1,1) 
	outsheet using `outdatadir'/`var'_tg.csv, comma replace

	* region crosstabs
	use `outdatadir'/educ, clear
	collapse (sum) wt, by(`var'_reg)
	egen tot_wt = sum(wt)
	gen pct = wt/tot_wt
	gen `varname'= substr(`var'_reg,1,1)
	gen region= substr(`var'_reg, -1,1) 
	outsheet using `outdatadir'/`var'_reg.csv, comma replace

	* age crosstabs
	use `outdatadir'/educ, clear
	collapse (sum) wt, by(`var'_age)
	egen tot_wt = sum(wt)
	gen pct = wt/tot_wt
	gen `varname' = substr(`var'_age,1,1)
	gen ogagehld10 = substr(`var'_age, -2,2) 
	outsheet using `outdatadir'/`var'_age.csv, comma replace
}



*****************************************************
* Log this section separately
log close
log using `outdatadir'/tab_logs/ofjh.log, text replace
*****************************************************
*15* Creamery producer off-farm employment - holder
*****************************************************
use `outdatadir'/`intdata2', clear

* Status of off-farm employment of holder - collapse dataset to 
* yr-ofjh groups summing the wts to arrive at numbers of farms 
* (or farm holders) represented by the sample for each group. 

egen yr_ofjh = concat(year isofffarmy), punct("_")
collapse (sum) wt, by(yr_ofjh)

* extract year and employment status information from yr_ofjh and 
* store as numeric
gen year = substr(yr_ofjh, 1, 4)
gen isofffarmy = substr(yr_ofjh, -1, 1)
destring year isofffarmy, replace

* calculate farms represented in each year and divide the group wts by
* this figure to arrive at percentage of farms in each group within 
* each year
bysort year: egen yr_wt_tot = sum(wt)
gen ofjh_pct = wt/yr_wt_tot
sort isofffarmy year

* the data is now ready for a table, display then save csv for Excel
tabstat year isofffarmy wt yr_wt_tot ofjh_pct, by(yr_ofjh)
outsheet year isofffarmy wt yr_wt_tot ofjh_pct using `outdatadir'/ofjh.csv, comma replace



*****************************************************
* Log this section separately
log close
log using `outdatadir'/tab_logs/ofjs.log, text replace
*****************************************************
*16* Creamery producer off-farm employment - spouse
*****************************************************
use `outdatadir'/`intdata2', clear

* Status of off-farm employment of spouse - collapse dataset to 
* yr-ofjs groups summing the wts to arrive at numbers of farms 
* (or farm holders) represented by the sample for each group. 

egen yr_ofjs = concat(year isspofffarmy), punct("_")
collapse (sum) wt, by(yr_ofjs)

* extract year and employment status information from yr_ofjs and 
* store as numeric
gen year = substr(yr_ofjs, 1, 4)
gen isspofffarmy = substr(yr_ofjs, -1, 1)
destring year isspofffarmy, replace

* calculate farms represented in each year and divide the group wts by
* this figure to arrive at percentage of farms in each group within 
* each year
bysort year: egen yr_wt_tot = sum(wt)
gen ofjs_pct = wt/yr_wt_tot
sort isspofffarmy year

* the data is now ready for a table, display then save csv for Excel
tabstat year isspofffarmy wt yr_wt_tot ofjs_pct, by(yr_ofjs)
outsheet year isspofffarmy wt yr_wt_tot ofjs_pct using `outdatadir'/ofjs.csv, comma replace



*****************************************************
* Log this section separately
log close
log using `outdatadir'/tab_logs/ofjb.log, text replace
*****************************************************
*17* Creamery producer off-farm employment - both
*****************************************************
use `outdatadir'/`intdata2', clear

* Status of off-farm employment of both - collapse dataset to 
* yr-ofjb groups summing the wts to arrive at numbers of farms 
* (or farm holders) represented by the sample for each group. 

egen yr_ofjb = concat(year bothwork), punct("_")
collapse (sum) wt, by(yr_ofjb)

* extract year and employment status information from yr_ofjb and 
* store as numeric
gen year = substr(yr_ofjb, 1, 4)
gen bothwork = substr(yr_ofjb, -1, 1)
destring year bothwork, replace

* calculate farms represented in each year and divide the group wts by
* this figure to arrive at percentage of farms in each group within 
* each year
bysort year: egen yr_wt_tot = sum(wt)
gen ofjb_pct = wt/yr_wt_tot
sort bothwork year

* the data is now ready for a table, display then save csv for Excel
tabstat year bothwork wt yr_wt_tot ofjb_pct, by(yr_ofjb)
outsheet year bothwork wt yr_wt_tot ofjb_pct using `outdatadir'/ofjb.csv, comma replace



*****************************************************
* Log this section separately
log close
log using `outdatadir'/tab_logs/teagasc.log, text replace
*****************************************************
*16* Creamery producer extension services
*****************************************************
use `outdatadir'/`intdata2', clear

* Status of Teagasc advisory utilisation - collapse dataset to
* yr-teagasc groups summing the wts to arrive at numbers of farms 
* (or farm holders) represented by the sample for each group. 

egen yr_teagasc = concat(year teagasc), punct("_")
collapse (sum) wt, by(yr_teagasc)

* extract year and employment status information from yr_teagasc and 
* store as numeric
gen year = substr(yr_teagasc, 1, 4)
gen teagasc = substr(yr_teagasc, -1, 1)
destring year teagasc, replace

* calculate farms represented in each year and divide the group wts by
* this figure to arrive at percentage of farms in each group within 
* each year
bysort year: egen yr_wt_tot = sum(wt)
gen teagasc_pct = wt/yr_wt_tot
sort teagasc year

* the data is now ready for a table, display then save csv for Excel
tabstat year teagasc wt yr_wt_tot teagasc_pct, by(yr_teagasc)
outsheet year teagasc wt yr_wt_tot teagasc_pct using `outdatadir'/teagasc.csv, comma replace



*****************************************************
* Ending message
*****************************************************
capture log close
log using `outdatadir'/master.log, append 

* List of intermediate datasets created
di _n _n "*********************************************************" _n "Intermediate datasets created:" _n _n _col(2) "NFS with Derived Variables" _col(30) "-->" _col(35) "`intdata'.dta" _n _col(2) "Creamery milk suppliers" _col(30) "-->" _col(35)  "`intdata2'.dta" _n _col(2) "Adds cost group variables" _col(30) "-->" _col(35)  "`intdata3'.dta" _n "*********************************************************" _n "Please check the contents of..." _n _n _col(2) "`outdatadir'" _n _n "...for all other output files (including logs)." _n "*********************************************************" _n _n
capture log close
