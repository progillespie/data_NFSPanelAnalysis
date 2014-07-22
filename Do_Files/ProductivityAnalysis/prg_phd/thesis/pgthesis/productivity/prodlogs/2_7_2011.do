log off
dir
mkdir prodlogs
dir
dir
insheet using inputdata\csv\cod8409.csv
dir "Data creator (Stata Do)\"
doedit "Data creator (Stata Do)\DAIRY data creator_pg.do"
doedit "Data creator (Stata Do)\DAIRY data creator1.do"
browse farmsys
sort cffrmcod year
save inputdata\dta\cod8409
dir inputdata\csv\
insheet using inputdata\csv\pgillespie4.csv, clear
rename farm_code cffrmcod
rename  ye_ar year
sort cffrmcod year
save inputdata\dta\pgillespie4
use inputdata\dta\cod8409, clear
merge cffrmcod year using inputdata\dta\pgillespie4.dta, unique
save inputdata\dta\8409v0
do "Data creator (Stata Do)\DAIRY data creator1.do"
* Not sure why foinsure is still missing. I think I have all the data, but it might have had a different name in the file Brian Moran sent me.
use inputdata\dta\8409v0, clear
rename D_INSURANCE_EU foinsure
browse D_INSUR*
use inputdata\dta\pgillespie4, clear
help merge
joinby cffrmcod year using inputdata\dta\cod8409.dta, replace unmatched(both)
joinby cffrmcod year using inputdata\dta\cod8409.dta, update unmatched(both)
use inputdata\dta\cod8409, clear
joinby cffrmcod year using inputdata\dta\pgillespie4.dta, unmatched(both)
browse
doedit D:\pglocal\datastat\nfs\Do_Files\NFSPanelCreate.do
save inputdata\dta\8409v0, replace
log close
