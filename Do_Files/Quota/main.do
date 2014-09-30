clear 


* Set directory macros
local startdir: pwd // save current location

local dataroot  ///
   "D:\Data\data_NFSPanelAnalysis"

local dodir      ///
   "`dataroot'\Do_Files\Quota"

local outdatadir    ///
   "`dataroot'\OutData\Quota"

local data79   ///
   "`dataroot'\OutData\RAW_79_83\justGO"

local data84   ///
   "`dataroot'\OutData\FarmPriceVolMSM\"






* ============================================================== * 
* =============== Program for building data ==================== *

capture program drop build
program define build, rclass


* Build the data from the FarmPriceVolMSM (original and my version)
args pattern

* Get list of all datasets with the word farm (lowercase)
local files2get: dir "." files "`pattern'", respectcase



* If no data loaded, use the first dataset, and remove it from list
*  NOTE: doing this step outside of the loop is more efficient.
qui count
if `r(N)' == 0 {

  local firstdata: word 1 of `files2get'
  macro list _files2get _firstdata
  local file2get: list files2get - firstdata
  use `firstdata', clear

}


* Now loop over file list to merge all desired datasets
foreach file of local files2get {

  merge 1:1 FARM_CODE YE_AR using `file', nogen update

}

* Shouldn't have any duplicates.
duplicates report FARM_CODE YE_AR

end
* =============== Program for building data ==================== *
* ============================================================== * 




* Use newly defined build program to make the dataset.

*--- Early years (based on my version) --- *
cd "`data79'\1\"       // first directory
build "*farm*.dta"

cd ..                  // second directory
build "d_*dairy*.dta"

*--- Later years (based on COD version) --- *
cd "`data84'\1\"       // first directory
build "*farm*.dta"

cd ..                  // second directory
build "d_*dairy*.dta"

cd `dodir'

quietly {

  * Unwanted vars. Capture prevents error if var isn't in data.
  capture drop `var' s_b_* 
  capture drop `var' vs_*  
  capture drop `var' dvs_*
  capture drop `var' dps_*
  capture drop `var' s_*
  capture drop `var' ps_*
  capture drop `var' nonzero*
  capture drop `var' hasvar*
  capture drop `var' rnk 
  capture drop `var' card 
  capture drop `var' lagval 
  capture drop `var' origsubset 
  capture drop `var' bulkfeed_cond
  capture drop if FARM_CODE == 0
  capture drop if missing(FARM_CODE)

}


* Declare panel structure
sort FARM_CODE YE_AR
qui xtset FARM_CODE YE_AR


* Descriptives
describe
table YE_AR ///
  , c(mean d_farm_gross_output sd d_farm_gross_output) 
table YE_AR ///
  , c(mean d_dairy_gross_output sd d_dairy_gross_output ) 


* Panel descriptives
xtdescribe
xtsum d_farm_gross_output d_dairy_gross_output


