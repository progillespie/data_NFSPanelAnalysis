*******************************************
* Make YEAR_BORN a consistent 4 digit year var (e.g. clean it)
*******************************************
gen str4 YYYY_BORN = string(YEAR_BORN) // initialise a string copy of YEAR_BORN


* YEAR_BORN should not go back before 1800, or before 1900 if YE_AR is recent
*  Set value to last 2 digits only, as we assume these are correct. They will 
*  be treated with the rest of the two digit years a few lines down.
replace YYYY_BORN = substr(YYYY_BORN,-2,.) if  YEAR_BORN < 1800 & strlen(YYYY_BORN) == 4
replace YYYY_BORN = substr(YYYY_BORN,-2,.) if  YEAR_BORN < 1900 & YE_AR > = 2000 & strlen(YYYY_BORN) == 4
destring YYYY_BORN, replace  // convert back to use math functions on it


* Convert 2 digit years to 4 digits. Will include obvious typos from above rule.
replace YYYY_BORN = YYYY_BORN + 1900 if YYYY_BORN < 100   // most years should be in 1900's


* YYYY_BORN values which imply negative age (impossible).
* Neg. ages must be born in 1800's pre-2000
replace YYYY_BORN = YYYY_BORN - 100 if YYYY_BORN > YE_AR & YE_AR <= 2000
* Neg. ages likely  born in 2000's post-2000
replace YYYY_BORN = YYYY_BORN + 100 if YYYY_BORN > YE_AR & YE_AR > 2000
* Particular farm, where MD is < 30 yet has son/daughter working 100 hours
*   YEAR_BORN == 7010 in 1980, which I take to mean the child was 
*    age 10 in 1980 (hence born in 1970). 
replace YYYY_BORN = 1970 if FARM_CODE == 4077 & YE_AR == 1980 & YEAR_BORN == 7010


* Double 00 years (interpreted as 0 by Stata). Assumption is 7 is the 
*   youngest reported age working on the farm. If the sole worker on 
*   the farm, then must be an adult, so assume 1900 (which would make a 
*   very old farmer). 
replace YYYY_BORN = 1900 if YYYY_BORN == 0 
replace YYYY_BORN = 2000 if YYYY_BORN == 0 & YE_AR >= 2007 & s_number_workers > 1



replace YYYY_BORN = 1900 if (YE_AR - YYYY_BORN) < 14 &  WORKER_CODE != 5

* Obvious typos. Every other instance of WORKER_CODE = 5 on these farms show correct birth year
replace YYYY_BORN = 1964 if FARM_CODE == 1545 & YE_AR == 1981 & YYYY_BORN == 164
replace YYYY_BORN = 1926 if FARM_CODE == 3301 & YE_AR == 1979 & YYYY_BORN == 526



* Now rename so that subsequent code uses the cleaned variable.
rename YEAR_BORN  YEAR_BORN_inconsitent // retained for comparison
rename YYYY_BORN  YEAR_BORN
