local outdatadir $outdatadir
local intdata2 $intdata2
*****************************************************
log close
log using `outdatadir'/tab_logs/farm_measures.log, text replace
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
foreach var of varlist $fdairy $go_vlist $ct_vlist{
	gen `var'_ha = `var'/daforare
}

* Per LU measures
foreach var of varlist $fdairy $go_vlist $ct_vlist{
	gen `var'_lu = `var'/dpnolu
}

* Per litre measures
foreach var of varlist $fdairy $go_vlist $ct_vlist{
	gen `var'_lt = `var'/doslmkgl
}

* Create a local macro containing the proper order of variables for the Excel worksheet. Cannot put year into this list because it will cause an error when we collapse. Specify year `excel' in the outsheet command to get the right order. 
sort year
local excel doslmkgl fdairygo fdairygm fdairydc farmgo farmgm farmdc farmffi daforare doslcmgl domlkbon domlkpen dosllmgl domkfdgl domkalvl docftfvl docftfno docfslvl docfslno doschbvl dotochbv dotochbn dopchbvl dopchbno dotichbv dotichbn dovlcnod p_doslcm p_dosllm p_domkfd p_docftfvl p_docfslvl p_dotochbv p_dopchbvl p_dotichbv dpnolu ddconvalq ddpasturq ddwinforq d_othmiscdcq ivmalldyq iaisfdyq itedairyq imiscdryq flabccdyq PCattleFeed PTotalFert POtherInputs PVetExp PMotorFuels PLabour fsizuaa

collapse (mean) `excel'[weight=wt], by(year)
