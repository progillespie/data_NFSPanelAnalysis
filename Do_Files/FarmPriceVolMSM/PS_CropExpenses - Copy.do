**********************************************************************
**********************************************************************
* Price Simulation - Crops Expenses
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

sort FARM_CODE CROP_CODE YE_AR

** Lag volume
**by FARM_CODE CROP_CODE: gen `var'_QTY_TONNES_HA_p1 = `var'_QTY_TONNES_HA[_n+1] if YE_AR[_n+1] == YE_AR+1
** Lag value
by FARM_CODE CROP_CODE: gen `var'_EU_p1 = `var'_EU[_n+1] if YE_AR[_n+1] == YE_AR+1

* Have product in both years
gen `var'_EU_b = `var'_EU > 0 & `var'_EU != . & `var'_EU_p1 > 0 & `var'_EU_p1 != .
* 1 have produce in first year but not in second and 2 where have produce in first year, but missing in second
gen `var'_EU_12 = 1*(`var'_EU > 0 & `var'_EU != . & `var'_EU_p1 == 0 & `var'_EU_p1 != . & exit_nfs == 1) + 2*(`var'_EU > 0 & `var'_EU != . & exit_nfs == 0)

* 1 have produce in second year but not in first and 2 where have produce in second year, but missing in first
*	gen `var'_QTY_TONNES_HA_21a = 1*(`var'_QTY_TONNES_HA == 0 & `var'_QTY_TONNES_HA != . & `var'_QTY_TONNES_HA_p1 > 0 & `var'_QTY_TONNES_HA_p1 != .) 
*	by FARM_CODE: gen `var'_QTY_TONNES_HA_21b = 2*(`var'_QTY_TONNES_HA[_n-1] == . & `var'_QTY_TONNES_HA > 0 & `var'_QTY_TONNES_HA != .)


**********************************************************************
* Summary Statistics
**********************************************************************

* Update count
qui replace nonzero`iteration' = nonzero`iteration' + 1 if `var'_EU_12 == 1

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

*	by YE_AR: tab CROP_CODE if `var'_EU_b == 1, sum(`var'_test1) nost
	by YE_AR: tab CROP_CODE if `var'_EU_b == 1, sum(`var'_test2) nost
	by YE_AR: tab CROP_CODE if `var'_EU_b == 1, sum(`var'_EU_p1) nost


	di ""
	di "`var'"
	di ""

	* Statistics for those who are there this year but not next
	di "Statistics for those who are there this year but not next"

*	by YE_AR: tab CROP_CODE if `var'_EU_12 == 1 | `var'_EU_12 == 2, sum(`var'_test1) nost
	by YE_AR: tab CROP_CODE if `var'_EU_12 == 1 | `var'_EU_12 == 2, sum(`var'_test2) nost
	by YE_AR: tab CROP_CODE if `var'_EU_12 == 1 | `var'_EU_12 == 2, sum(`var'_EU_p1) nost


	di ""
	di "`var'"
	di ""

	* Statistics for those who are there this year but not next, but are in the survey both years
	di "Statistics for those who are there this year but not next, but are in the survey both years"

*	by YE_AR: tab CROP_CODE if `var'_EU_12 == 1, sum(`var'_test1) nost
	by YE_AR: tab CROP_CODE if `var'_EU_12 == 1, sum(`var'_test2) nost
	by YE_AR: tab CROP_CODE if `var'_EU_12 == 1, sum(`var'_EU_p1) nost


	di ""
	di "`var'"
	di ""

	* Statistics for those who are there this year but not next, but are in the survey only the first year
	di "Statistics for those who are there this year but not next, but are in the survey only the first year"

*	by YE_AR: tab CROP_CODE if `var'_EU_12 == 2, sum(`var'_test1) nost
	by YE_AR: tab CROP_CODE if `var'_EU_12 == 2, sum(`var'_test2) nost
	by YE_AR: tab CROP_CODE if `var'_EU_12 == 2, sum(`var'_EU_p1) nost


	di ""
	di "`var'"
	di ""

	* New Entrants or new purchasers
	di "New Entrants or new purchasers"

	capture drop lagval
	sort FARM_CODE CROP_CODE YE_AR
	by FARM_CODE CROP_CODE: gen lagval = `var'_EU[_n-1]

	sort YE_AR 
*	by YE_AR: tab CROP_CODE if ((enter_nfs == 0 & `var'_EU > 0 & `var'_EU != .) | (enter_nfs == 1 & `var'_EU > 0 & `var'_EU != . & lagval == 0)), sum(`var'_test1) nost
	by YE_AR: tab CROP_CODE if ((enter_nfs == 0 & `var'_EU > 0 & `var'_EU != .) | (enter_nfs == 1 & `var'_EU > 0 & `var'_EU != . & lagval == 0)), sum(`var'_test2) nost
	by YE_AR: tab CROP_CODE if ((enter_nfs == 0 & `var'_EU > 0 & `var'_EU != .) | (enter_nfs == 1 & `var'_EU > 0 & `var'_EU != . & lagval == 0)), sum(`var'_EU) nost

	di ""
	di "`var'"
	di ""

	* New Entrants
	di "New Entrants"

*	by YE_AR: tab CROP_CODE if enter_nfs == 0 & `var'_EU > 0 & `var'_EU != ., sum(`var'_test1) nost
	by YE_AR: tab CROP_CODE if enter_nfs == 0 & `var'_EU > 0 & `var'_EU != ., sum(`var'_test2) nost
	by YE_AR: tab CROP_CODE if enter_nfs == 0 & `var'_EU > 0 & `var'_EU != ., sum(`var'_EU) nost


	di ""
	di "`var'"
	di ""

	* New Pruchasers
	di "New Pruchasers"

*	by YE_AR: tab CROP_CODE if enter_nfs == 1 & lagval == 0 & `var'_EU > 0 & `var'_EU != ., sum(`var'_test1) nost
	by YE_AR: tab CROP_CODE if enter_nfs == 1 & lagval == 0 & `var'_EU > 0 & `var'_EU != ., sum(`var'_test2) nost
	by YE_AR: tab CROP_CODE if enter_nfs == 1 & lagval == 0 & `var'_EU > 0 & `var'_EU != ., sum(`var'_EU) nost

	tab nonzero`iteration' if hasvar`iteration' == 1




sort  FARM_CODE YE_AR CROP_CODE

