* This is a linking do file. It's only purpose is to direct Stata to the 
*  location of another do file. This avoids duplicate code.

local startdir: pwd // Save current working directory location



* Grab the full path to the parent directory of D_FARM_GROSS_OUTPUT
local parent_of_root = regexr("`startdir'", "\\D_FARM_GROSS_OUTPUT.*$", "")



* Change to the appropriate directory and run the do file
cd `parent_of_root'\<<INSERT REST OF FILEPATH TO PARENT DIR OF DO FILE>>



qui do <<DIR NAME (SAME AS DO FILE)>>/<<DO FILE NAME>>.do



cd `startdir' // return Stata to previous directory
