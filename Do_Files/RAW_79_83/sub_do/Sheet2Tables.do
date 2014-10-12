args i YYYY outdata 

* _i
*    the Sheet number being prepared in each workbook (1 per year)
* _YYYY 
*    the 4 digit year extracted from the workbook's name
* _outdata 
*    the filepath to the folder where you'll save the data

macro list _outdata

*qui destring, replace force

capture rename farm FARM_CODE
label var FARM_CODE "Farm code"

capture gen int YE_AR = `YYYY' 
capture gen int Row   = _n


*====================================================================
* Apply renaming do file from appropriate mapping sheet of 
*   varnamemappings.xlsx here
*====================================================================
qui do sub_do/_renameSheet/renameSheetLennon`i'.do
*====================================================================






*--------------------------------------------------------------------
* A few necessary variable calculations and manipulations
*--------------------------------------------------------------------

* Junk variables are just those that I haven't found an analogue for 
*   in the IB variable names. I assume they won't be used in any 
*   further code. Make a list of these to remove from the vlist
*   defined below. 
capture ds   junk*
local junk_vlist "`r(varlist)'"
capture drop junk*


* HOME_GROWN_SEED_VALUE_EU isn't measured until 1981. Try to gen it
*   each year (will be ignored if variable already exists).
if `i' == 14  capture gen double HOME_GROWN_SEED_VALUE_EU = 0


* Variable erroneously coded as string
capture destring CLOSING_INVENTORY_50KGBAGS, replace force
capture destring var12, replace force


* If CropCode is in the data, then rename and keep it.
capture confirm variable CropCode
di _rc
if _rc==0 {
  rename CropCode CROP_CODE
  *local add_var "`add_var' CROP_CODE"
}


* ASSET_CLASS info is contained in sheet number. Create the variable
*  in each sheet, just using sheet number (`i') as string for now
*  Values will be assigned in main do file after svy_asset is complete
if `i' >= 63 & `i' <= 68  {

  gen str3 ASSET_CLASS = "`i'"

  * Add this to the list of additional vars to keep for the table
  local add_var "`add_var' ASSET_CLASS"
  
}


* Need to keep the 4 alloccropcodes and Quantity vars for 
*   svy_crop_fertilizer (converted to long format later in main)
if `i' == 12 local add_var "`add_var' alloccropcode? Quantity?" 

  
*--------------------------------------------------------------------






* The following would be an infinite loop if not for the break
*   condition being triggered by the absence of one of the matrices 
*   from memory. 

local j = 1
while `j' > 0 {
	
  * Determine if matrix S`i'_`j' exists in memory and if not, then
  *  break this (inner/j) loop and move on to the next sheet.
  capture confirm matrix S`i'_`j'
	

  * THE BREAK CONDITION - _rc = 0 unless matrix doesn't exist 
  if _rc != 0 {

    continue, break
			
  }



  * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  * REST OF J LOOP ONLY RUNS IF BREAK CONDITION ISN'T TRIGGERED
  * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  * Each matrix contains the variable list we want in its rownames and
  *   the name of the relevant svy_table in the colnames (there's only 
  *   1 column). Extract those to macros to work with them.
  local table: colnames S`i'_`j'
  local vlist: rownames S`i'_`j'
  local vlist: list vlist - junk_vlist
  local vlist "`vlist' `add_var'"
  local vlist: list uniq vlist
  macro list _i _j _table _vlist 

  
  * Occasional third sorting variable
  local OtherSortVar "" // initialise as blank
  if `i' >=  4 & `i' <=  5 local OtherSortVar "CROP_CODE"
  if `i' == 11             local OtherSortVar "CROP_CODE"
  if `i' == 14             local OtherSortVar "CROP_CODE"


  * 1:1 with table, use Row (in effect, just loading data)
  if `i' == 12             local OtherSortVar "Row"
  if `i' == 52             local OtherSortVar "Row"
  if `i' >= 57 & `i' <= 58 local OtherSortVar "Row WORKER_CODE"
  if `i' == 59             local OtherSortVar "Row"


  * svy_loans is fundamentally different. There are no accnt numbers
  *   and the sheets split up New vs Existing loans for several common
  *   variables. Best way to handle this is to "merge" by Row and 
  *   card (just gives the sheet number). This is really just 
  *   appending the two sheets (which I assume John's code is going
  *   to collapse again later anyway)
  if `i' >= 61 & `i' <= 62 local OtherSortVar "Row card"


  local WrongSortVars "CROP_CODE WORKER_CODE ASSET_CLASS Row" 
  local WrongSortVars: list WrongSortVars - OtherSortVar
  local WrongSortVars: list WrongSortVars - add_var
  macro list _WrongSortVars
 

  preserve 
  keep FARM_CODE YE_AR `OtherSortVar' `vlist'
  ds, varwidth(32)


  dupcheck `outdata' `OtherSortVar' 

  * If this far, then number of duplicates is small, so drop them
  duplicates drop FARM_CODE YE_AR `OtherSortVar', force


  capture merge 1:1 FARM_CODE YE_AR `OtherSortVar' using ///
    `outdata'/svy_tables_7983/`table', nogen

  if _rc != 0 {

    use `outdata'/svy_tables_7983/`table', clear
    save `outdata'/debug.dta, replace
    restore
    use `outdata'/debug.dta, clear
    ds, varwidth(32)
    di "There was a problem with the merge!"
    STOP!!!

  }

  capture drop `WrongSortVars'
  *save `outdata'/svy_tables_7983/`table', replace
  save `outdata'/svy_tables_7983/`table'`YYYY'_`i', replace


  restore

  local j = `j' + 1
  * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

}


* Save a csv version (can be turned on or off, useful for debugging)
capture mkdir `outdata'/csv
capture mkdir `outdata'/csv/raw`YYYY'
outsheet using ///
  `outdata'/csv/raw`YYYY'/Sheet`i'.csv, replace comma
*DONE:
* PROBLEM: svy_hay_silage only has silage (file overwriting itself)
* FIX: Save to same file within Jloop (build on each merge). When out
*      of J loop save file with unique name. Name must be particular
*      to year AND sheet! Make sure that "local files" pattern is 
*      updated in master file (around line 144). Reset initial dataset
*      as last step of this file.       
*use  `outdata'/svy_tables_7983/`table', clear 
*save `outdata'/svy_tables_7983/`table'`YYYY'_`i', replace

* Reset initial dataset (uses blank command defined in main do file)
blank

save `outdata'/svy_tables_7983/`table', replace


