* This is a linking do file. It's only purpose is to direct Stata to the 
*  location of another do file. This avoids duplicate code.

local startdir: pwd // Save current working directory location



* Grab the full path to the parent directory of D_FARM_GROSS_OUTPUT
*  (case sensitive, but will also match d_farm_gross_output, 
*   Don't used mixed case, e.g. D_farm_Gross_outPUT wont'work)
local parent_of_root = regexr("`startdir'", "\\D_FARM_GROSS_OUTPUT.*$|d_farm_gross_output.*$", "")

di "`startdir'"
di "`parent_of_root'"



* Change to the appropriate directory and run the do file
cd `parent_of_root'\D_FARM_GROSS_OUTPUT\D_TOTAL_CROPS_GROSS_OUTPUT_EU\D_OUTPUT_INV_MISC_CASH_CROP_EU\D_WW_GROSS_OUTPUT_OP_INV_EU



do D_ALLOWANCES_OP_TONNES_HA/D_ALLOWANCES_OP_TONNES_HA.do



cd `startdir' // return Stata to previous directory
