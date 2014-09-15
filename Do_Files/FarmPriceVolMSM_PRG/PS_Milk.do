**********************************************************************
**********************************************************************
* Price Simulation - Milk
**********************************************************************
**********************************************************************

local var = "$var1"


**********************************************************************
* Prepare Data
**********************************************************************

scalar sc_iteration = sc_iteration + 1
local i = sc_iteration
scalar sc_it_`var' = sc_iteration
local iteration = sc_iteration

* Number of variables that go from non-zero to zero in two consecutive years
gen nonzero`iteration' = 0

* Has one of the variables this year
gen hasvar`iteration' = 0



**********************************************************************
* Apply Price
**********************************************************************

qui replace dv`var' = 1 if sc_volchange == 0
qui replace dp`var' = 1 if sc_pricechange == 0

**TEST**
* Price (price change only)
if sc_sim_actprice == 1 & sc_volchange == 0 { 
	sort FARM_CODE YE_AR
	by FARM_CODE: gen `var'_test2 = `var'_EU[_n-1] * dp`var' if `var'_EU[_n-1] != .
	qui replace `var'_test2 = `var'_EU if `var'_test2[_n-1] == .
}

* Price x Volume (price and volume change)
if sc_sim_actprice == 1 & sc_volchange == 1 { 
	sort FARM_CODE YE_AR
	by FARM_CODE: gen `var'_test2 = `var'_EU[_n-1] * dp`var' * dv`var' if `var'_EU[_n-1] != .
	qui replace `var'_test2 = `var'_EU if `var'_test2[_n-1] == .
}

* Original Data
if sc_orig_data == 1 { 
	gen `var'_test2 = `var'_EU  
}

*Update variable in model 
qui replace `var'_EU = `var'_test2

sort FARM_CODE YE_AR

* Farm enters NFS, if enter_nfs is 0 the this farm entered the nfs in the current year
capture drop enter_nfs
by FARM_CODE: gen enter_nfs = FARM_CODE[_n-1] != . & YE_AR[_n-1] == YE_AR-1

* Farm exits NFS, if exit_nfs is 0 the this farm left/exited the nfs after the current year
capture drop exit_nfs
by FARM_CODE: gen exit_nfs = FARM_CODE[_n-1] != . & YE_AR[_n-1] == YE_AR-1

sort FARM_CODE YE_AR
** Lag volume
by FARM_CODE: gen `var'_LT_p1 = `var'_LT[_n-1] if YE_AR[_n-1] == YE_AR-1
** Lag value
by FARM_CODE: gen `var'_EU_p1 = `var'_EU[_n-1] if YE_AR[_n-1] == YE_AR-1

* Have product in both years
gen `var'_LT_b = `var'_LT > 0 & `var'_LT != . & `var'_LT_p1 > 0 & `var'_LT_p1 != .
* 1 have produce in first year but not in second and 2 where have produce in first year, but missing in second
gen `var'_LT_12 = 1*(`var'_LT > 0 & `var'_LT != . & `var'_LT_p1 == 0 & `var'_LT_p1 != . & exit_nfs == 1) + 2*(`var'_LT > 0 & `var'_LT != . & exit_nfs == 0)

* 1 have produce in second year but not in first and 2 where have produce in second year, but missing in first
*	gen `var'_LT_21a = 1*(`var'_LT == 0 & `var'_LT != . & `var'_LT_p1 > 0 & `var'_LT_p1 != .) 
*	by FARM_CODE: gen `var'_LT_21b = 2*(`var'_LT[_n-1] == . & `var'_LT > 0 & `var'_LT != .)

**********************************************************************
* Summary Statistics
**********************************************************************

* Update count
qui replace nonzero`iteration' = nonzero`iteration' + 1 if `var'_LT_12 == 1

* Update count of those who have a positive value this year
gen isvar`var' = `var'_LT > 0 & `var'_LT != . 
qui replace hasvar`iteration' = max(hasvar`iteration', isvar`var')	
drop isvar`var'

sort YE_AR 


di ""
di "`var'"
di ""

* Compare Simulated with actual next year if farm has product in both years
di "Compare Simulated with actual next year if farm has product in both years"

* CHANGE-7983: added capture to following two tabstats
capture tabstat `var'_test2 `var'_EU_p1 if `var'_LT_b == 1, by(YE_AR) stats(mean)
capture tabstat `var'_test2 `var'_EU_p1 if `var'_LT_b == 1, by(YE_AR) stats(count)

di ""
di "`var'"
di ""

* Statistics for those who are there this year but not next
di "Statistics for those who are there this year but not next"
* CHANGE-7983: added capture to following two tabstats
capture tabstat `var'_test2 `var'_EU_p1 if `var'_LT_12 == 1 | `var'_LT_12 == 2, by(YE_AR) stats(mean)
capture tabstat `var'_test2 `var'_EU_p1 if `var'_LT_12 == 1 | `var'_LT_12 == 2, by(YE_AR) stats(count)

di ""
di "`var'"
di ""

* Statistics for those who are there this year but not next, but are in the survey both years
di "Statistics for those who are there this year but not next, but are in the survey both years"
* CHANGE-7983: added capture to following two tabstats
capture tabstat `var'_test2 `var'_EU_p1 if `var'_LT_12 == 1, by(YE_AR) stats(mean)
capture tabstat `var'_test2 `var'_EU_p1 if `var'_LT_12 == 1, by(YE_AR) stats(count)

di ""
di "`var'"
di ""
* Statistics for those who are there this year but not next, but are in the survey only the first year
di "Statistics for those who are there this year but not next, but are in the survey only the first year"
* CHANGE-7983: added capture to following two tabstats
capture tabstat `var'_test2 `var'_EU_p1 if `var'_LT_12 == 2, by(YE_AR) stats(mean)
capture tabstat `var'_test2 `var'_EU_p1 if `var'_LT_12 == 2, by(YE_AR) stats(count)



di ""
di "`var'"
di ""

* New Entrants or new purchasers
di "New Entrants or new purchasers"

capture drop lagval
sort FARM_CODE YE_AR
by FARM_CODE: gen lagval = `var'_EU[_n-1] 

* CHANGE-7983: added capture to following two tabstats
capture tabstat `var'_test2 `var'_EU if ((enter_nfs == 0 & `var'_LT > 0 & `var'_LT != .) | (enter_nfs == 1 & `var'_LT > 0 & `var'_LT != . & lagval == 0)), by(YE_AR) stats(mean)
capture tabstat `var'_test2 `var'_EU if ((enter_nfs == 0 & `var'_LT > 0 & `var'_LT != .) | (enter_nfs == 1 & `var'_LT > 0 & `var'_LT != . & lagval == 0)), by(YE_AR) stats(count)


di ""
di "`var'"
di ""

* New Entrants
di "New Entrants"
* CHANGE-7983: added capture to following two tabstats
capture tabstat `var'_test2 `var'_EU if enter_nfs == 0 & `var'_LT > 0 & `var'_LT != ., by(YE_AR) stats(mean)
capture tabstat `var'_test2 `var'_EU if enter_nfs == 0 & `var'_LT > 0 & `var'_LT != ., by(YE_AR) stats(count)


di ""
di "`var'"
di ""

* New Pruchasers
di "New Pruchasers"
* CHANGE-7983: added capture to following two tabstats
capture tabstat `var'_test2 `var'_EU if enter_nfs == 1 & lagval == 0 & `var'_LT > 0 & `var'_LT != ., by(YE_AR) stats(mean)
capture tabstat `var'_test2 `var'_EU if enter_nfs == 1 & lagval == 0 & `var'_LT > 0 & `var'_LT != ., by(YE_AR) stats(count)

tab nonzero`iteration' if hasvar`iteration' == 1


sort  FARM_CODE YE_AR

