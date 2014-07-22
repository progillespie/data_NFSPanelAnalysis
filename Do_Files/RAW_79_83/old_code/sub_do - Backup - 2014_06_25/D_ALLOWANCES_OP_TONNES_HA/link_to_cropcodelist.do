* This is a linking do file. It's only purpose is to direct Stata to the 
*  location of another do file. This avoids duplicate code.

local startdir: pwd // Save current working directory location



* Grab the full path to the parent directory of D_FARM_GROSS_OUTPUT
*  (case sensitive, but will also match d_farm_gross_output, 
*   Don't used mixed case, e.g. D_farm_Gross_outPUT wont'work)
local parent_of_root = regexr("`startdir'", "\\sub_do.*$", "")



* Change to the appropriate directory and run the do file
cd `parent_of_root'/sub_do



do cropcodelist.do



cd `startdir' // return Stata to previous directory
