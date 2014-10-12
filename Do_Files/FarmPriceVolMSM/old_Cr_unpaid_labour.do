*******************************************
* Create unpaid_labour
*******************************************

* = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
* Create individual level labour units
* = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 

* Ind. level labour units, before adj. for age
gen labour_units  = 0 
replace labour_units = HOURS_WORKED / 1800
replace labour_units = 1 if (HOURS_WORKED / 1800) > 1

* Clean YEAR_BORN var
gen number_workers = 1 
bysort FARM_CODE YE_AR: egen s_number_workers = sum(number_workers)
qui do fix_YEAR_BORN.do

* Age adjustment - >  18          - Mult. by 1 (i.e. no adj.) 
*                  >  16 & <= 18  - Mult. by 0.75
*                  >  14 & <= 16  - Mult. by 0.5
*                  <= 14          - Mult. by 0 (i.e. discard these)


* Creating a temporary age var makes code simpler
gen age  = YE_AR - YEAR_BORN

* Do the adjustment
* No need to replace at all for `age' > 18

replace labour_units = labour_units * 0.75 ///
  if age > 16 & age <= 18

replace labour_units = labour_units * 0.5  ///
  if age > 14 & age <= 16

replace labour_units = labour_units * 0    ///
  if age <= 14
* = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 



* CHANGE-7983: Created d_labour_units_unpaid & s_HOURS_WORKED
by  FARM_CODE YE_AR: egen d_labour_units_unpaid       = sum(labour_units)
by  FARM_CODE YE_AR: egen s_HOURS_WORKED            = sum(HOURS_WORKED)


by  FARM_CODE YE_AR: egen rnk = rank(YE_AR),unique

keep if rnk == 1

drop rnk

* CHANGE-7983: Included d_labour_units_unpaid & s_HOURS_WORKED
keep  FARM_CODE YE_AR d_labour_units_unpaid s_HOURS_WORKED s_number_workers 

sort FARM_CODE YE_AR

mvencode *, mv(0) override
