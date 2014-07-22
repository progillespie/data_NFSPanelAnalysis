*****************************************************
*****************************************************
* Dairy Chapter
*
* Patrick R. Gillespie		
*
* 2012
*
*
*****************************************************
*****************************************************

clear
set mem 1400m
set more off
set matsize 500

capture log close
capture cmdlog close

local dodir ~/Documents/projects/phd/dairychapter
local nfsdatadir ~/Data/data_NFSPanelAnalysis/OutData
local outdatadir ~/Data/phd
local Regional_outdatadir ~/Data/data_NFSPanelAnalysis/OutData/RegionalAnalysis

cd `dodir'
log using dc_new2.log, replace 
di  "Job  Started  at  $S_TIME  on $S_DATE"

*use ~/Data/nfs_209der
*append using ~/Data/data2010_out1
*save `nfsdatadir'/nfs_d210, replace
use `nfsdatadir'/nfs_d210

*****************************************************
* System selection
*****************************************************

gen syst = ffszsyst-int(ffszsyst/10)*10
keep if syst == 1 | syst == 2

*****************************************************
* Code borrowed from Thia's
* data_NFSPanelAnalysis/Do_Files/FarmLevelModel/FarmLevel_dairy.do
* Subset 
* Keep only farms with dairy gross output
*****************************************************

* Farms with no milk sales
keep if fdairygo > 0 & fdairygo < .
keep if doslcmgl > 0 & doslcmgl < .


* Farms with 50% liquid milk sales
keep if dosllmgl < 0.5*dotomkgl


* No herds with less than 10 dairy cows
keep if dpopinvd > 10

*****************************************************
* Subset and collapse data to relevant var's per year 
*****************************************************

* create vlists of vars to keep when dataset is collapsed
local fdairy = "fdairygo fdairygm fdairydc"
local farm = "farmgo farmgm farmdc farmffi"
local go_vlist = "daforare doslcmgl  domlkbon  domlkpen  dosllmgl  domkfdgl  domkalvl  docftfvl docftfno docfslvl docfslno  doschbvl  dotochbv dotochbn  dopchbvl dopchbno  dotichbv dotichbn  dovlcnod" 

local go_plist = "p_doslcm p_dosllm p_domkfd p_docftfvl p_docfslvl p_dotochbv p_dopchbvl p_dotichbv" 

local ct_vlist = "dpnolu ddconvalq ddpasturq ddwinforq d_othmiscdcq ivmalldyq iaisfdyq itedairyq imiscdryq flabccdyq"

local ct_plist = "PCattleFeed PTotalFert POtherInputs PVetExp PMotorFuels PLabour"


* Check for proper units

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

drop *_ha *_lu *_lt

* recreate per ha measures
foreach var in `farm'{
	gen `var'_ha = `var'/daforare
}
foreach var in `fdairy'{
	gen `var'_ha = `var'/daforare
}
foreach var in `go_vlist'{
	gen `var'_ha = `var'/daforare
}
foreach var in `ct_vlist'{
	gen `var'_ha = `var'/daforare
}

* recreate per lu measures
foreach var in `farm'{
	gen `var'_lu = `var'/dpnolu
}
foreach var in `fdairy'{
	gen `var'_lu = `var'/dpnolu
}
foreach var in `go_vlist'{
	gen `var'_lu = `var'/dpnolu
}
foreach var in `ct_vlist'{
	gen `var'_lu = `var'/dpnolu
}

* recreate per lt measures
foreach var in `farm'{
	gen `var'_lt = `var'/doslcmgl
}
foreach var in `fdairy'{
	gen `var'_lt = `var'/doslcmgl
}
foreach var in `go_vlist'{
	gen `var'_lt = `var'/doslcmgl
}
foreach var in `ct_vlist'{
	gen `var'_lt = `var'/doslcmgl
}

collapse lt_lu doslmkgl `fdairy' `farm' `go_vlist' `go_plist' `ct_vlist' `ct_plist' *_ha *_lu *_lt [weight=wt], by(year)
outsheet using ~/Data/nfs_yr2010.csv, comma replace
outsheet fdairy* using ~/Data/fdairy.csv, comma replace
log close
