* Code for creating an indicator variable for subset of farms which 
* are present in dataset for entire time period (balanced subset)
* Obtained from 
* http://www.stata.com/statalist/archive/2008-03/msg01108.html

tempvar q
bysort fc: gen `q' = _n
gen byte balanced = 0
replace balanced = 1 if `q'== 10

