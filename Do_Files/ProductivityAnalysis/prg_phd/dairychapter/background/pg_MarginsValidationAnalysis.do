 *****************************************************
*****************************************************
* Margins Validation Analysis
*
* (c) Cathal O’Donoghue Teagasc.
*
* 2008
*
* - PRG copy
*****************************************************
*****************************************************
clear
set mem 1400m
set more off
set matsize 300

capture log close
capture cmdlog close

local dodir ~/Documents/projects/phd/dairychapter
local nfsdatadir ~/Data/data_NFSPanelAnalysis/OutData
local outdatadir ~/Data/phd
local Regional_outdatadir ~/Data/data_NFSPanelAnalysis/OutData/RegionalAnalysis

cd `dodir'


log using pg_MarginsValidationAnalysis.log, replace 
di  "Job  Started  at  $S_TIME  on $S_DATE"

*****************************************************
**Merge regional and NFS files
*****************************************************

**Create a subset of variables

use `nfsdatadir'/nfs_data.dta, clear


*****************************************************
**Test Livestock Margins
*****************************************************


*Dairy
gen fdairygm_c = fdairygo - fdairydc
gen fdairygm_diff = fdairygm_c - fdairygm
tabstat fdairygm_c fdairygm fdairygm_diff,by(year) stats(mean) format(%9.3f)
*Cattle
gen fcatlegm_c = fcatlego - fcatledc
gen fcatlegm_diff = fcatlegm_c - fcatlegm
tabstat fcatlegm_c fcatlegm fcatlegm_diff,by(year) stats(mean) format(%9.3f)
*Sheep
gen fsheepgm_c = fsheepgo - fsheepdc
gen fsheepgm_diff = fsheepgm_c - fsheepgm
tabstat fsheepgm_c fsheepgm fsheepgm_diff,by(year) stats(mean) format(%9.3f)
*Pigs
gen fpigsgm_c = fpigsgo - fpigsdc
gen fpigsgm_diff = fpigsgm_c - fpigsgm
tabstat fpigsgm_c fpigsgm fpigsgm_diff,by(year) stats(mean) format(%9.3f)
*Poultry
gen fpoultgm_c = fpoultgo - fpoultdc
gen fpoultgm_diff = fpoultgm_c - fpoultgm
tabstat fpoultgm_c fpoultgm fpoultgm_diff,by(year) stats(mean) format(%9.3f)
*Horses
gen fhorsegm_c = fhorsego - fhorsedc
gen fhorsegm_diff = fhorsegm_c - fhorsegm 
tabstat fhorsegm_c fhorsegm fhorsegm_diff,by(year) stats(mean) format(%9.3f)
*Other Livestock
gen fothergm_c = fothergo - fotherdc
gen fothergm_diff = fothergm_c - fothergm 
tabstat fothergm_c fothergm fothergm_diff,by(year) stats(mean) format(%9.3f)
