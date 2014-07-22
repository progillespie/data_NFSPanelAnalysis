qui ds
local vlist "`r(varlist)'"


foreach var of local vlist {

	scalar sc_match = 0

	if regexm("`var'", "([a-zA-Z]*_)*[a-zA-Z]*([0-9][0-9][0-9][0-9])") {
	   scalar sc_match = 1 
	}
	
	if sc_match == 1 {
		local code = regexs(2)
		local crop_codes "`crop_codes' `code'"
	}
}

global crop_codes: list uniq crop_codes
global crop_codes: list sort global(crop_codes)



foreach code of global crop_codes {

	if regexm("`code'", "111[0-9]") | ///
	   regexm("`code'", "115[0-9]") | ///
	   regexm("`code'", "114[0-9]") | ///
	   regexm("`code'", "143[0-9]") | ///
	   regexm("`code'", "157[0-9]") | ///
	   regexm("`code'", "131[0-9]") | ///
	   regexm("`code'", "132[0-9]") | ///
	   regexm("`code'", "146[0-9]") | ///
	   regexm("`code'", "811[0-9]") | ///
	   regexm("`code'", "921[0-9]") | ///
	   regexm("`code'", "922[0-9]") | ///
	   regexm("`code'", "923[0-9]") | ///
	   regexm("`code'", "902[0-9]") | ///
	   regexm("`code'", "903[0-9]") | ///
	   regexm("`code'", "904[0-9]") | ///
	   regexm("`code'", "905[0-9]") | ///
	   regexm("`code'", "906[0-9]") | ///
	   regexm("`code'", "907[0-9]") | ///
	   regexm("`code'", "908[0-9]") | ///
	   regexm("`code'", "175[0-9]") {

	   * This code doesn't belong on the list
	   *  so do nothing.
	}


	else {

	   * This one does belong, so add it
	   local other_vlist "`other_vlist ' `code'"
	
	}

}


global other_vlist: list uniq other_vlist
global other_vlist: list sort global(other_vlist)

macro list crop_codes other_vlist
*/
