************ 12_7_2011.do *****************

insheet using inputdata\csv\cod8409.csv, clear
sort cffrmcod year
save inputdata\dta\cod8409, replace

insheet using inputdata\csv\pgillespie4.csv, clear
sort cffrmcod year
save inputdata\dta\pgillespie4, replace

use inputdata\dta\cod8409, clear
joinby cffrmcod year using inputdata\dta\pgillespie4.dta, unmatched(both)
save inputdata\dta\8409v0, replace

*browse

do "Data creator (Stata Do)/DAIRY data creator1.do"

save 8409v0d, replace
