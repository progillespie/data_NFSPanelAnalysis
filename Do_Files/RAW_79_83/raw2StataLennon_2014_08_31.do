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
*   knowledge of which vars come from which sheet or to which 
*   table they belong.
local svy_tables: rownames(SVY_CODES)
local svy_tables: list uniq svy_tables



*--------------------------------------------------------------------
* Program to start from blank file with a few varnames and 0 obs
*--------------------------------------------------------------------
capture program drop blank, rclass
program define blank

clear
set obs 1
gen int  FARM_CODE   = .
gen int  YE_AR       = .
gen int  Row         = .
gen int  card        = .
gen int  CROP_CODE   = .
gen int  WORKER_CODE = .
gen str3 ASSET_CLASS = ""
drop if _n > 0

end
*--------------------------------------------------------------------
qui blank


capture mkdir `outdata'/svy_tables_7983

* Erase any .dta in the destination directory (because this file will
*   recreate them. We check that delfiles was actually created first
*   (in case the directory is already empty)
local delfiles: dir "`outdata'/svy_tables_7983/" files "*.dta"
capture macro list _delfiles

if _rc == 0 {

  foreach file of local delfiles {

    erase `outdata'/svy_tables_7983/`file'

  }

}


* Now save our blank data tables.
foreach table of local svy_tables {

  qui save `outdata'/svy_tables_7983/`table', replace

}


* You now have blank datasets for each svy_table, with 0 obs and
* just the key variables for the merge (FARM_CODE and YE_AR also
* with 0 obs). They are located here...
macro list _outdata


* ... and here's all the contents of that directory (the files)
dir `outdata'/svy_tables_7983/



*--------------------------------------------------------------------
* Program to check that number of duplicates is small enough to drop
*--------------------------------------------------------------------
capture program drop dupcheck
program define dupcheck, rclass
args outdata OtherSortVar 


  qui duplicates report FARM_CODE YE_AR `OtherSortVar' 
  local rN = `r(N)'
  local rU = `r(unique_value)'
  local rDUPS = `rN' - `rU'
  local DUPratio = `rDUPS'/`rN'
  return scalar DUPS     = `rDUPS'
  return scalar DUPratio = `DUPratio'
  if `DUPratio' > 0.05 & `rDUPS' > 9 {
     note: Check duplicates -- FARM_CODE YE_AR `OtherSortVar'
     save `outdata'/debug.dta, replace
     di "You to many duplicate values (ratio or abs number). "
     STOP!!!

  }

end
*--------------------------------------------------------------------



*--------------------------------------------------------------------
* This section reads the raw data from an Excel spreadsheet or csv
*   and prepares Stata datasets. 
*--------------------------------------------------------------------


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
  


  * 1.1 Save each sheet in Stata format, prepare for
  *  merging
  *-----------------------------------------------------

  * Loop over worksheets in workbook to import data.
  local i = 1
  while `i' <= `N_worksheet'{


    di "Working with `spreadsheet', Sheet`i'"



    quietly {

      import excel using `spreadsheet'          ///
        , sheet("Sheet`i'") firstrow clear


      * Once-off issues for various sheets
      qui do `dodir'/sub_do/specialcasesLennon.do ///
            `shortfilename' `i'

      * If a sheet has no obs then it won't save
      *  and you'll get an error. Fix this.
      qui count
      if `r(N)'==0  set obs 1
    

      * Do-Files are in dodir, so move there
      cd `dodir'


      * Drop dups (in terms of all vars, i.e. EXACT copy of a row)
      *   There's more duplicate handling in Sheet2Tables.do
      duplicates drop _all, force 


      local YY   = substr("`shortfilename'", 4,2)
      local YYYY = 1900 + `YY' 

      do sub_do/Sheet2Tables.do `i' `YYYY' `outdata' 


      cd `origdata'

      local i = `i' + 1
    }
    
  } // done with all sheets for this year



  * Now merge multisheet tables together within the year
  cd `outdata'/svy_tables_7983/

  foreach table of local svy_tables {

    macro list _table
    
 

    local OtherSortVar "" // initialise as blank


    if "`table'" == "svy_crops"           | ///
       "`table'" == "svy_crop_disposal"   | ///
       "`table'" == "svy_crop_expenses"     ///
            local OtherSortVar "CROP_CODE"


    if "`table'" == "svy_crop_fertilizer"       | ///
       "`table'" == "svy_purchased_bulkyfeed"   | ///
       "`table'" == "svy_unpaid_labour"         | ///
       "`table'" == "svy_paid_casual_labour"    | ///
       "`table'" == "svy_paid_labour"           | ///
       "`table'" == "svy_loans"                   ///
            local OtherSortVar "Row"


    if "`table'" == "svy_asset"                     | ///
       "`table'" == "svy_power_machinery_totals"    | ///
       "`table'" == "svy_other_machinery_totals"    | ///
       "`table'" == "svy_buildings_totals"          | ///
       "`table'" == "svy_land_improvements_totals"    ///
            local OtherSortVar "ASSET_CLASS"



    * Start from blank version of table
    *use `table', clear
    qui blank

    

    * Merge all files for a given table, for a given year
    local merge_files: dir "." files "`table'`YYYY'_*.dta"
    foreach filename of local merge_files {
      
      macro list _filename
      *save X`filename', replace // can change filename for debugging

      merge 1:1 FARM_CODE YE_AR `OtherSortVar' using `filename', nogen
      dupcheck `outdata' `OtherSortVar' 

      * If this far, then number of duplicates is small, so drop them
      duplicates drop FARM_CODE YE_AR `OtherSortVar', force
 
      erase `filename' // has to be done for append_files to be right

    }
  
  

  * Save a single file per table-year
  save `table'`YYYY'.dta, replace

  }

}
*--------------------------------------------------------------------






*--------------------------------------------------------------------
* Append years together for each svy_table
*--------------------------------------------------------------------
cd `outdata'/svy_tables_7983/

foreach table of local svy_tables {

  * Get a list of files in this folder which begin with the name
  *   of the table and have the year and sheet number on the end
  local files: dir "." files "`table'????.dta"
  
  foreach filename of local files {

    macro list _filename
    if "`filename'" == "`table'1979.dta"  use `filename', clear
    else append using `filename' 


    erase `filename'

  }
  
  capture drop Row
  sort FARM_CODE YE_AR
  save `table'.dta, replace

}
*--------------------------------------------------------------------






*--------------------------------------------------------------------
* Convert fertilizer table to long format
*--------------------------------------------------------------------
use svy_crop_fertilizer, clear
qui do `dodir'\sub_do\wide2long.do

* John's 8 - 9 thousand range
tab YE_AR


*DONE: 
*  PROBLEM: Table looks like two datasets sat next to each other
*  FIX: Was accidentally appending svy_crop_fertilizer_lime 
*       (due to using "`table'*" as my pattern when defining the 
*        local `files' around line 144). Changed pattern to 
*        `table'??.dta to get correct file list. Also excludes 
*        files that are just `table'.dta, which were blank and had
*        to be ignored anyway, so the first condition doing this was
*        removed.
*  UPDATE: Changed YY to YYYY for 4 digit year, and added _`i' to
*          because intermediate datasets need to be year AND sheet
*          specific.

save svy_crop_fertilizer, replace
*--------------------------------------------------------------------






*--------------------------------------------------------------------
* Create enter_exit_nfs.dta
*--------------------------------------------------------------------

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
*--------------------------------------------------------------------






*--------------------------------------------------------------------
* Create svy_car_expenses.dta
*--------------------------------------------------------------------

* There was no separate table for svy_car_expenses in 79 - 83. 
*   There was one variable (the share of car expenses in farm misc. 
*   expenses) from that table, but that appears in the table
*   svy_misc_receipts_expenses.dta. The best we can do here is use
*   a copy of this as car expenses as well. 

use svy_misc_receipts_expenses, clear

save svy_car_expenses, replace 
*--------------------------------------------------------------------








*--------------------------------------------------------------------
* Correct values of ASSET_CLASS in svy_asset
*--------------------------------------------------------------------

* Created ASSET_CLASS using sheet numbers when constructing svy_asset
*   Replace these with the appropriate codes now.

use svy_asset, clear

replace ASSET_CLASS = "PMA" if ASSET_CLASS == "63"
replace ASSET_CLASS = "OMA" if ASSET_CLASS == "64"
replace ASSET_CLASS = "BLD" if ASSET_CLASS == "65"
replace ASSET_CLASS = "LAN" if ASSET_CLASS == "66"

save svy_asset, replace 
tab ASSET_CLASS YE_AR
*--------------------------------------------------------------------



cd `startdir' // return Stata to previous directory
