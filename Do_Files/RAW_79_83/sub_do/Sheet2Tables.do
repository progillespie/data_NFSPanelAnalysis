args i YYYY outdata 



capture rename farm FARM_CODE
label var FARM_CODE "Farm code"

capture gen int YE_AR = `YYYY' 
capture gen int Row   = _n


*====================================================================
* Apply renaming do file from appropriate mapping sheet of 
*   varnamemappings.xlsx here
*====================================================================
qui do sub_do/_renameSheet/renameSheetLennon`i'.do
*outsheet using ///
  *`origdata'/csv/`shortfilename'/Sheet`i'.csv, replace comma
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


* If CropCode is in the data, then rename and keep it.
capture confirm variable CropCode
if _rc==0 {
  rename CropCode CROP_CODE
  local add_var "`add_var' CROP_CODE"
}

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
  macro list _table _vlist 

  preserve 
  keep FARM_CODE YE_AR Row `vlist'

  merge 1:1 FARM_CODE YE_AR Row using ///
    `outdata'/svy_tables_7983/`table', nogen

  save `outdata'/svy_tables_7983/`table', replace

  restore

  local j = `j' + 1
  * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

}

TODO: svy_hay_silage only has silage (so it's only sheet 7 that's
 coming through).
save `outdata'/svy_tables_7983/`table'`YYYY'`', replace

* Reset initial dataset
keep FARM_CODE YE_AR Row
drop if _n > 0 
save `outdata'/svy_tables_7983/`table', replace
