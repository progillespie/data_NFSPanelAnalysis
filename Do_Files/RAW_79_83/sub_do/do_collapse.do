* Routine for collapsing one of the temp datasets. Saves a bit of 
* code repeating in the convertSheet code (and also one or two 
* D_ or I_ variable definitions.


* Collapsing will destroy labels, so save them to macros
foreach v of var * {
	
	local l`v' : variable label `v'
	if `"`l`v''"' == "" {
		local l`v' "`v'"
	}

}



* Collapse the data to one farm per row 
ds farmcode, not // Get list of all vars less the by-variable
collapse (sum) `r(varlist)', by(farmcode)  



* Restore labels to variables
foreach v of var * {

	label var `v' "`l`v''"

}
