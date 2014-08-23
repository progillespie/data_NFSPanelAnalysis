*******************************************
*******************************************
* Create Price from Milk
*******************************************
*******************************************

local var = "$var1"

* Initialise variables
gen p`var' = 0
gen v`var' = 0
gen dv`var' = 0
gen dp`var' = 0

sort  FARM_CODE YE_AR 

*Volume
qui replace v`var' = `var'_LT

*Price = Value divided by Quantity
qui replace p`var' = `var'_EU /v`var'

* Calculate Mean Price, to impute price for those without a price
sort YE_AR 
by YE_AR : egen tm`var' = mean(p`var') if p`var'  > 0 & p`var'  != .
replace tm`var' = 0 if tm`var' == .
by YE_AR : egen m`var' = max(tm`var')	
replace p`var' = m`var' if p`var' == .

* Next years price
sort FARM_CODE YE_AR
by FARM_CODE: gen p`var'_p1 = p`var'[_n-1]

* Change in price year on year
qui replace dp`var' = p`var'_p1/p`var'

* Mean change in price, to impute price for those without a price
sort YE_AR 
by YE_AR : egen tmdp`var' = mean(dp`var' ) if dp`var'  > 0 & dp`var'  != .
replace tmdp`var' = 0 if tmdp`var' == .
by YE_AR : egen mdp`var' = max(tmdp`var')
replace dp`var' = mdp`var' if dp`var' == .

* Mean Volume, to impute price for those without a volume
sort YE_AR 
by YE_AR : egen tmv`var' = mean(v`var') if v`var'  > 0 & v`var'  != .
replace tmv`var' = 0 if tmv`var' == .
by YE_AR : egen mv`var' = max(tmv`var')
replace v`var' = mv`var' if v`var' == . | v`var' == 0

* Next years volume
sort FARM_CODE YE_AR
by FARM_CODE: gen v`var'_p1 = v`var'[_n-1]

* Change in volume year on year
qui replace dv`var' = v`var'_p1/v`var'

* Mean Change in volume
sort YE_AR 
by YE_AR : egen tmvd`var' = mean(dv`var') if dv`var'  > 0 & dv`var' != .
replace tmvd`var' = 0 if tmvd`var' == .
by YE_AR : egen mvd`var' = max(tmvd`var')
replace dv`var' = mvd`var' if dv`var' == .

* Clean

qui drop tm`var'-mvd`var'
