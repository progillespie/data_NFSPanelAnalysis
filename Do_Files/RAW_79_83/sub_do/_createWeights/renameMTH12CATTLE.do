* Here's 4 variables that look like they're missing from the data. 
*   We need these particular vars for calculate SGMs.
local rename MTH12_TOTAL_CATTLE_MALE_1_2YRS_NO   ///
             MTH12_TOTAL_CATTLE_FEMALE_1_2YRS_NO ///
             MTH12_TOTAL_CATTLE_MALE_GT2YRS_NO   ///
	     MTH12_TOTAL_CATTLE_FEMALE_GT2YRS_NO

macro list _rename

ds MTH12_*, varwidth(32)


* We actually have them, but the varnames are too long...
ds , has(varlabel "MTH12_TOTAL_CATTLE*")


* ... so they've been assigned anonymous variable names.
* It's lucky that we've labels to ID them with!


* Fix this by looping over rename, searching for the var with
* corresponding label, and renaming with a shortened version of the
* name.
foreach var of local rename {

  * Shorten MALE and FEMALE to bring the vars under the character limit
  local new_name = subinstr("`var'"     , "_MALE_"  , "_M_", .)
  local new_name = subinstr("`new_name'", "_FEMALE_", "_F_", .)

  qui ds, has(varlabel "`var'") // get the varname that has this label
  local anonymous_var "`r(varlist)'"

  rename `anonymous_var' `new_name' 
}


ds MTH12_TOTAL_CATTLE*, varwidth(32)
