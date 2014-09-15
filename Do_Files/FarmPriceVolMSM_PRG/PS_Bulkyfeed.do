**********************************************************************
**********************************************************************
* Price Simulation - Bulkyfeed
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
	sort FARM_CODE BULKYFEED_CODE YE_AR
	by FARM_CODE BULKYFEED_CODE: gen `var'_test2 = `var'_EU[_n-1] * dp`var' if `var'_EU[_n-1] != .
	qui replace `var'_test2 = `var'_EU if `var'_test2[_n-1] == .
}

* Price x Volume (price and volume change)
if sc_sim_actprice == 1 & sc_volchange == 1 { 
	sort FARM_CODE BULKYFEED_CODE YE_AR
	by FARM_CODE BULKYFEED_CODE: gen `var'_test2 = `var'_EU[_n-1] * dp`var' * dv`var'  if `var'_EU[_n-1] != .
	qui replace `var'_test2 = `var'_EU if `var'_test2[_n-1] == .
}
* Original Data
if sc_orig_data == 1 { 
	gen `var'_test2 = `var'_EU  
}


*Update variable in model 
qui replace `var'_EU = `var'_test2


sort FARM_CODE BULKYFEED_CODE YE_AR

** Lag volume
by FARM_CODE BULKYFEED_CODE: gen `var'_QTY_p1 = `var'_QTY[_n-1] if YE_AR[_n-1] == YE_AR-1
** Lag value
by FARM_CODE BULKYFEED_CODE: gen `var'_EU_p1 = `var'_EU[_n-1] if YE_AR[_n-1] == YE_AR-1

* Have product in both years
gen `var'_QTY_b = `var'_QTY > 0 & `var'_QTY != . & `var'_QTY_p1 > 0 & `var'_QTY_p1 != .
* 1 have produce in first year but not in second and 2 where have produce in first year, but missing in second
gen `var'_QTY_12 = 1*(`var'_QTY > 0 & `var'_QTY != . & `var'_QTY_p1 == 0 & `var'_QTY_p1 != . & exit_nfs == 1) + 2*(`var'_QTY > 0 & `var'_QTY != . & exit_nfs == 0)

* 1 have produce in second year but not in first and 2 where have produce in second year, but missing in first
*	gen `var'_QTY_21a = 1*(`var'_QTY == 0 & `var'_QTY != . & `var'_QTY_p1 > 0 & `var'_QTY_p1 != .) 
*	by FARM_CODE: gen `var'_QTY_21b = 2*(`var'_QTY[_n-1] == . & `var'_QTY > 0 & `var'_QTY != .)



**********************************************************************
* Summary Statistics
**********************************************************************

* Update count
qui replace nonzero`iteration' = nonzero`iteration' + 1 if `var'_QTY_12 == 1

* Update count of those who have a positive value this year
gen isvar`var' = `var'_QTY > 0 & `var'_QTY != . 
qui replace hasvar`iteration' = max(hasvar`iteration', isvar`var')	
drop isvar`var'


di ""
di "`var'"
di ""
* Compare Simulated with actual next year if farm has product in both years
di "Compare Simulated with actual next year if farm has product in both years"

*	by YE_AR: tab BULKYFEED_CODE if `var'_QTY_b == 1, sum(`var'_test1) nost
sort YE_AR
by YE_AR: tab BULKYFEED_CODE if `var'_QTY_b == 1, sum(`var'_test2) nost
by YE_AR: tab BULKYFEED_CODE if `var'_QTY_b == 1, sum(`var'_EU_p1) nost


di ""
di "`var'"
di ""

* Statistics for those who are there this year but not next
di "Statistics for those who are there this year but not next"

*	by YE_AR: tab BULKYFEED_CODE if `var'_QTY_12 == 1 | `var'_QTY_12 == 2, sum(`var'_test1) nost
by YE_AR: tab BULKYFEED_CODE if `var'_QTY_12 == 1 | `var'_QTY_12 == 2, sum(`var'_test2) nost
by YE_AR: tab BULKYFEED_CODE if `var'_QTY_12 == 1 | `var'_QTY_12 == 2, sum(`var'_EU_p1) nost


di ""
di "`var'"
di ""

* Statistics for those who are there this year but not next, but are in the survey both years
di "Statistics for those who are there this year but not next, but are in the survey both years"

*	by YE_AR: tab BULKYFEED_CODE if `var'_QTY_12 == 1, sum(`var'_test1) nost
by YE_AR: tab BULKYFEED_CODE if `var'_QTY_12 == 1, sum(`var'_test2) nost
by YE_AR: tab BULKYFEED_CODE if `var'_QTY_12 == 1, sum(`var'_EU_p1) nost


di ""
di "`var'"
di ""

* Statistics for those who are there this year but not next, but are in the survey only the first year
di "Statistics for those who are there this year but not next, but are in the survey only the first year"

*	by YE_AR: tab BULKYFEED_CODE if `var'_QTY_12 == 2, sum(`var'_test1) nost
by YE_AR: tab BULKYFEED_CODE if `var'_QTY_12 == 2, sum(`var'_test2) nost
by YE_AR: tab BULKYFEED_CODE if `var'_QTY_12 == 2, sum(`var'_EU_p1) nost


di ""
di "`var'"
di ""

* New Entrants or new purchasers
di "New Entrants or new purchasers"

capture drop lagval
sort FARM_CODE BULKYFEED_CODE YE_AR
by FARM_CODE BULKYFEED_CODE: gen lagval = `var'_EU[_n-1]

sort YE_AR 
*	by YE_AR: tab BULKYFEED_CODE if ((enter_nfs == 0 & `var'_QTY > 0 & `var'_QTY != .) | (enter_nfs == 1 & `var'_QTY > 0 & `var'_QTY != . & lagval == 0)), sum(`var'_test1) nost
by YE_AR: tab BULKYFEED_CODE if ((enter_nfs == 0 & `var'_QTY > 0 & `var'_QTY != .) | (enter_nfs == 1 & `var'_QTY > 0 & `var'_QTY != . & lagval == 0)), sum(`var'_test2) nost
by YE_AR: tab BULKYFEED_CODE if ((enter_nfs == 0 & `var'_QTY > 0 & `var'_QTY != .) | (enter_nfs == 1 & `var'_QTY > 0 & `var'_QTY != . & lagval == 0)), sum(`var'_EU) nost


di ""
di "`var'"
di ""

* New Entrants
di "New Entrants"

*	by YE_AR: tab BULKYFEED_CODE if enter_nfs == 0 & `var'_QTY > 0 & `var'_QTY != ., sum(`var'_test1) nost
by YE_AR: tab BULKYFEED_CODE if enter_nfs == 0 & `var'_QTY > 0 & `var'_QTY != ., sum(`var'_test2) nost
by YE_AR: tab BULKYFEED_CODE if enter_nfs == 0 & `var'_QTY > 0 & `var'_QTY != ., sum(`var'_EU) nost


di ""
di "`var'"
di ""

* New Pruchasers
di "New Pruchasers"

*	by YE_AR: tab BULKYFEED_CODE if enter_nfs == 1 & lagval == 0 & `var'_QTY > 0 & `var'_QTY != ., sum(`var'_test1) nost
by YE_AR: tab BULKYFEED_CODE if enter_nfs == 1 & lagval == 0 & `var'_QTY > 0 & `var'_QTY != ., sum(`var'_test2) nost
by YE_AR: tab BULKYFEED_CODE if enter_nfs == 1 & lagval == 0 & `var'_QTY > 0 & `var'_QTY != ., sum(`var'_EU) nost

tab nonzero`iteration' if hasvar`iteration' == 1

sort  FARM_CODE YE_AR BULKYFEED_CODE

