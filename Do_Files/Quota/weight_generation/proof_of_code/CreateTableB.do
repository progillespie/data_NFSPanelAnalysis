capture drop TableBColumn
capture drop TableBCell
capture drop system

qui tostring ffszsyst, gen(str_sys)
gen system = substr(str_sys, -1,.)
qui destring system, replace
drop str_sys
capture label drop system
label define system 1 "Dairying"	2 "Dairying/Other"	4 "Cattle Rearing" ///
                    5 "Cattle Other"	6 "Mainly Sheep"	7 "Tillage Systems"
label value system system
label var system "Farm Type"



* Create filter for farm size to replicate Appendix B Table B of NFS 
*   report (pg 46 in 2009)

gen TableBColumn = 1 if system==1 & fsizuaa < 10
replace TableBColumn = 2 if fsizuaa >= 10 & fsizuaa < 20
replace TableBColumn = 3 if fsizuaa >= 20 & fsizuaa < 30
replace TableBColumn = 4 if fsizuaa >= 30 & fsizuaa < 50
replace TableBColumn = 5 if fsizuaa >= 50 & fsizuaa <= 100
replace TableBColumn = 6 if fsizuaa > 100

capture label drop TableBColumn
label define TableBColumn 1 "<10"	2 "10-20"	3 "20-30" ///
                          4 "30-50"	5 "50-100"	6 ">100"
label value TableBColumn TableBColumn
label var TableBColumn "Size(Ha)"



quiet{


/* Alternative approach numbering each cell, 
    inactive, but kept for reference, and placed inside quiet{} to suppress output

		gen TableBCell = .
levelsof system, local(systemcodes)
local i = 1


foreach syscode of local systemcodes{


	replace TableBCell = `i' if system==`syscode' & fsizuaa < 10
	local i = `i' + 1

	replace TableBCell = `i' if system==`syscode' & fsizuaa >= 10 & fsizuaa < 20
	local i = `i' + 1

	replace TableBCell = `i' if system==`syscode' & fsizuaa >= 20 & fsizuaa < 30
	local i = `i' + 1

	replace TableBCell = `i' if system==`syscode' & fsizuaa >= 30 & fsizuaa < 50
	local i = `i' + 1

	replace TableBCell = `i' if system==`syscode' & fsizuaa >= 50 & fsizuaa <= 100
	local i = `i' + 1

	replace TableBCell = `i' if system==`syscode' & fsizuaa > 100
	local i = `i' + 1


}

tab TableBCell if system ==1 & year==2009
*/
}

local datadir: pwd //directory path for sourcing the tables
local outdatadir ///
 "D:\\Data\\data_NFSPanelAnalysis\\OutData\\Quota\\weight_generation\\proof_of_code"
 
 
log using `outdatadir'/CreateTableB.txt, text replace
* Recreate "Table B: Sample Numbers for 2009 Results (and Representation)"
*  for each year of the panel
levelsof year, local(all_years) // gets a list of all years to loop over
foreach yr of local all_years{
	
	di _newline(5)"Table B: Sample Numbers for `yr' Results (and Representation)"
	table system TableBColumn if year==`yr', contents(freq mean wt)
	di "Source dataset: `datadir'\\$S_FN"
}
*  Top number    = Cell frequency     
*  Bottom number = Cell weight (i.e. representation)
log close

view `outdatadir'/CreateTableB.txt



