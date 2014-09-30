**********************************************************************
**********************************************************************
* Price Simulation - Price only
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
	gen `var'_test2 = `var'_EU * dp`var'
}

* Price x Volume (price and volume change)
if sc_sim_actprice == 1 & sc_volchange == 1 { 
	gen `var'_test2 = `var'_EU * dp`var' * dv`var' 
}

* Original Data
if sc_orig_data == 1 { 
	gen `var'_test2 = `var'_EU  
}

*Update variable in model 
qui replace `var'_EU = `var'_test2
sort FARM_CODE YE_AR

** Lag value
by FARM_CODE: gen `var'_EU_p1 = `var'_EU[_n+1] if YE_AR[_n+1] == YE_AR+1

* Have product in both years
gen `var'_EU_b = `var'_EU > 0 & `var'_EU != . & `var'_EU_p1 > 0 & `var'_EU_p1 != .
* 1 have produce in first year but not in second and 2 where have produce in first year, but missing in second
gen `var'_EU_12 = 1*(`var'_EU > 0 & `var'_EU != . & `var'_EU_p1 == 0 & `var'_EU_p1 != . & exit_nfs == 1) + 2*(`var'_EU > 0 & `var'_EU != . & exit_nfs == 0)



**********************************************************************
* Summary Statistics
**********************************************************************

* Update count
qui replace nonzero`iteration' = nonzero`iteration' + 1 if `var'_EU > 0

* Update count of those who have a positive value this year
gen isvar`var' = `var'_EU > 0 & `var'_EU != . 
qui replace hasvar`iteration' = max(hasvar`iteration', isvar`var')	
drop isvar`var'

sort YE_AR 


di ""
di "`var'"
di ""
* Compare Simulated with actual next year if farm has product in both years
di "Compare Simulated with actual next year if farm has product in both years"

if "`var'" != "TRANSPORT_ALLOC_POULTRY" {
        * CHANGE-7983: added capture to following two tabstats
	capture tabstat `var'_test2 `var'_EU_p1 if `var'_EU_b == 1, by(YE_AR) stats(mean)
	capture tabstat `var'_test2 `var'_EU_p1 if `var'_EU_b == 1, by(YE_AR) stats(count)
}
di ""
di "`var'"
di ""

* Statistics for those who are there this year but not next
di "Statistics for those who are there this year but not next"

tabstat `var'_test2 `var'_EU_p1 if `var'_EU_12 == 1 | `var'_EU_12 == 2, by(YE_AR) stats(mean)
tabstat `var'_test2 `var'_EU_p1 if `var'_EU_12 == 1 | `var'_EU_12 == 2, by(YE_AR) stats(count)

di ""
di "`var'"
di ""

* Statistics for those who are there this year but not next, but are in the survey both years
di "Statistics for those who are there this year but not next, but are in the survey both years"

tabstat `var'_test2 `var'_EU_p1 if `var'_EU_12 == 1, by(YE_AR) stats(mean)
tabstat `var'_test2 `var'_EU_p1 if `var'_EU_12 == 1, by(YE_AR) stats(count)

di ""
di "`var'"
di ""

* Statistics for those who are there this year but not next, but are in the survey only the first year
di "Statistics for those who are there this year but not next, but are in the survey only the first year"

if "`var'" != "TRANSPORT_ALLOC_POULTRY" {
	tabstat `var'_test2 `var'_EU_p1 if `var'_EU_12 == 2, by(YE_AR) stats(mean)
	tabstat `var'_test2 `var'_EU_p1 if `var'_EU_12 == 2, by(YE_AR) stats(count)
}

di ""
di "`var'"
di ""

* New Entrants or new purchasers
di "New Entrants or new purchasers"

capture drop lagval
sort FARM_CODE YE_AR
by FARM_CODE: gen lagval = `var'_EU[_n-1] 	
tabstat `var'_test2 `var'_EU if ((enter_nfs == 0 & `var'_EU > 0 & `var'_EU != .) | (enter_nfs == 1 & `var'_EU > 0 & `var'_EU != . & lagval == 0)), by(YE_AR) stats(mean)
tabstat `var'_test2 `var'_EU if ((enter_nfs == 0 & `var'_EU > 0 & `var'_EU != .) | (enter_nfs == 1 & `var'_EU > 0 & `var'_EU != . & lagval == 0)), by(YE_AR) stats(count)


di ""
di "`var'"
di ""

* New Entrants
di "New Entrants"
tabstat `var'_test2 `var'_EU if enter_nfs == 0 & `var'_EU > 0 & `var'_EU != ., by(YE_AR) stats(mean)
tabstat `var'_test2 `var'_EU if enter_nfs == 0 & `var'_EU > 0 & `var'_EU != ., by(YE_AR) stats(count)


di ""
di "`var'"
di ""
* New Pruchasers Entrants
di "New Pruchasers Entrants"
tabstat `var'_test2 `var'_EU if enter_nfs == 1 & lagval == 0 & `var'_EU > 0 & `var'_EU != ., by(YE_AR) stats(mean)
tabstat `var'_test2 `var'_EU if enter_nfs == 1 & lagval == 0 & `var'_EU > 0 & `var'_EU != ., by(YE_AR) stats(count)

tab nonzero`iteration' if hasvar`iteration' == 1


sort  FARM_CODE YE_AR

