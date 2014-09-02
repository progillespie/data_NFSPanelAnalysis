clear all
set maxvar 10000
  


local startdir: pwd // Save current working directory location
local dodir    "D:\Data/data_NFSPanelAnalysis/Do_Files/RAW_79_83"
local origdata "D:\Data/data_NFSPanelAnalysis/OrigData/RAW_79_83"
local outdata  "D:\Data/data_NFSPanelAnalysis/OutData/RAW_79_83"
capture mkdir `outdata'


cd `origdata'
local files: dir "." files "*.xls*"

* Create renaming do files dynamically using raw2IBnamemappings.xlsx
* (will fail if the spreadsheet is open... close and run again)
*  (can be made static by turning off if do files already exist)
cd `dodir'
  

qui do sub_do/create_renameSheet_lennon_code.do

* Previous do file left in memory a matrix storing the 
*   svy_tables we need. Initialise these as blank datasets to 
*   which we merge variables from the various sheets without prior
*   knowledge of which vars come from which sheet or which to 
*   table they belong.
local svy_tables: rownames(SVY_CODES)
local svy_tables: list uniq svy_tables


capture mkdir `outdata'/svy_tables_7983
qui foreach table of local svy_tables {

  clear
  set obs 1
  gen int FARM_CODE = .
  gen int YE_AR     = . 
  gen int Row       = . 
  drop if _n > 0
  save `outdata'/svy_tables_7983/`table', replace

}


* You now have blank dataset for each svy_table, with 0 obs and
* just the key variables for the merge (FARM_CODE and YE_AR also
* with 0 obs). They are located here...
macro list _outdata


* ... and here's all the contents of that directory (the files)
dir `outdata'/svy_tables_7983/






* This section reads the raw data from an Excel spreadsheet or csv
*   and prepares Stata datasets. 
*-------------------------------------------------------------
* 1 Create one dataset per year (i.e. each workbook/.xls file)
*-------------------------------------------------------------
foreach spreadsheet of local files {
  
  * Data is in origdata. Ensure that's the current dir
  cd `origdata'


  local shortfilename = substr("`spreadsheet'",1,5)
  capture mkdir raw_dta/`shortfilename'
  capture mkdir csv/`shortfilename'

  * Get info about this workbook (year, no. sheets)
  qui import excel using `spreadsheet', describe
  macro list _shortfilename
  
  * Number of sheets. Store in `N_worksheet'
  local N_worksheet = `r(N_worksheet)' 
  
  

  *-----------------------------------------------------
  * 1.1 Save each sheet in Stata format, prepare for
  *  merging
  *-----------------------------------------------------

  * Loop over worksheets in workbook to import data.
  *local i = 1
  local i = 6
  while `i' <= 7 {
  *while `i' <= `N_worksheet'{

    di "Working with `spreadsheet', Sheet`i'"


    quietly{

      import excel using `spreadsheet'          ///
        , sheet("Sheet`i'") firstrow clear


      * If a sheet has no obs then it won't save
      *  and you'll get an error. Fix this.
      qui count
      if `r(N)'==0  set obs 1
    

      *++++++++++++++++++++++++++++++++++++++++++++
      * Do-Files are in dodir, so move there
      *++++++++++++++++++++++++++++++++++++++++++++

      cd `dodir'

      * Drop dups (in terms of all vars)
      duplicates drop _all, force


      local YY   = substr("`shortfilename'", 4,2)
      local YYYY = 1900 + `YY' 
      do sub_do/Sheet2Tables.do `i' `YYYY' `outdata'


      cd `origdata'

      local i = `i' + 1
    }


  }

}
*-------------------------------------------------------------



exit


*-------------------------------------------------------------
* Convert fertilizer table to long format
*-------------------------------------------------------------
cd `outdata'/svy_tables_7983/

foreach table of local svy_tables {

  local files: dir "." files "`table'????.dta"
  foreach filename of local files {

    macro list _filename
    if "`filename'" == "`table'1979.dta"  use `filename', clear
    else append using `filename' 


    *erase `filename'

  }
  
  capture drop Row
  sort FARM_CODE YE_AR
  save `table'.dta, replace

}



use svy_crop_fertilizer, clear
do `dodir'\sub_do\wide2long.do

* John's 8 - 9 thousand range
tab YE_AR


*DONE: 
*  PROBLEM: Table looks like two datasets sat next to each other
*  FIX: Was accidentally appending svy_crop_fertilizer_lime 
*       (due to using "`table'*" as my pattern when defining the 
*        local `files' around line 144). Changed pattern to 
*        `table'??.dta to get correct file list. Also excludes 
*        files that are just `table'.dta, which were blank and had
*        to be ignored anyway, so the first condition doing was
*        removed.

save svy_crop_fertilizer, replace
*-------------------------------------------------------------



*-------------------------------------------------------------
* Create enter_exit_nfs.dta
*-------------------------------------------------------------

use svy_farm, clear

* The dataset enter_exit_nfs.dta is need to get the FarmPriceVolMSM
*   file to finish creating the derived data. It contains two vars
*   (not counting FARM_CODE and YE_AR). 
* enter_nfs = 0 in the first year farm reports, else 1
* exit_ nfs = 0 in the last year farm reports, else 1

tempvar min_yr // Vars created with tempvar will be deleted 
tempvar max_yr //   automatically at the end of the file

bysort FARM_CODE: egen `min_yr' = min(YE_AR)
bysort FARM_CODE: egen `max_yr' = max(YE_AR)

gen enter_nfs = YE_AR != `min_yr'
gen exit_nfs  = YE_AR != `max_yr'

keep FARM_CODE YE_AR enter_nfs exit_nfs


save enter_exit_nfs.dta, replace


*-------------------------------------------------------------


cd `startdir' // return Stata to previous directory
