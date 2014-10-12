*******************************************
* Create unpaid_labour
*******************************************

/*

Reminder of Worker Codes (from B. Moran)

1	Owner/Manager
2	Spouse of Owner
3	Owner not Manager
4	Manager not Owner
5	Son/Daughter of Owner
6	Brother/Sister of Owner
7	Other Household Member
8	Other Regular Unpaid Workers

*/ 



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


* Creating a temporary age var makes code simpler. Also make permanent
*   age variable for the owner/operator.
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



* CHANGE-7983: Created d_labour_units_unpaid, s_HOURS_WORKED, and farm_md_age
by  FARM_CODE YE_AR: gen md_age               = age if WORKER_CODE == 1 | WORKER_CODE == 4 | s_number_workers == 1
replace md_age = 0 if missing(md_age)
by  FARM_CODE YE_AR: egen farm_md_age               = max(md_age) 
by  FARM_CODE YE_AR: egen d_labour_units_unpaid     = sum(labour_units)
by  FARM_CODE YE_AR: egen s_HOURS_WORKED            = sum(HOURS_WORKED)


sort FARM_CODE YE_AR WORKER_CODE
by  FARM_CODE YE_AR: egen rnk = rank(YE_AR),unique

keep if rnk == 1
drop rnk


* CHANGE-7983: Included  d_labour_units_unpaid, s_HOURS_WORKED, and farm_md_age
keep  FARM_CODE YE_AR d_labour_units_unpaid s_HOURS_WORKED s_number_workers farm_md_age

sort FARM_CODE YE_AR

hist farm_md_age
mvencode *, mv(0) override
