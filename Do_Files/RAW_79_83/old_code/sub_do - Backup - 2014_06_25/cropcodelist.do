capture program drop cropcodelist
program define cropcodelist, rclass



qui ds
local vlist "`r(varlist)'"


foreach var of local vlist {

	* This regular expression looks for 4 digits in a row in the varname 
	*  and evaluates to true if it finds that pattern
	if regexm("`var'", "([a-zA-Z]*_)*[a-zA-Z]*([0-9][0-9][0-9][0-9])") {
		local code = regexs(2)
		local crop_codes "`crop_codes' `code'"
	}
}

local crop_codes: list uniq crop_codes
local crop_codes: list sort crop_codes


return local code_list "`crop_codes'"

end
