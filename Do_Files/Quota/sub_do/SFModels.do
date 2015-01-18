rename year YEAR
rename DC D


* gen LAND
gen	A  = LANDFAGE


keep Y?  H  D  C  L3  A  YEAR FC T T? T?? W

* Summary stats
summ	 Y2  H  D  C  L3  A  YEAR


* Sample selection
*drop if Y1 <= 0
drop  if Y2 <= 0
drop  if H  <= 0
drop  if D  <= 0
drop  if C  <= 0
drop  if L3 <= 0
drop  if A  <= 0
drop  if W  <  1

* Check that Min and Max years are correct


/* More summary for comparison with full sample

gen	GRPSIZE=_GROUPTI
CALC	LISTG=MAX(GRPSIZE)
*/


* CALCULATE MEANS		
egen MEANY1 = mean ( Y1 )
egen MEANY2 = mean ( Y2 )
egen MEANH  = mean ( H  )
egen MEAND  = mean ( D  )
egen MEANC  = mean ( C  )
egen MEANL  = mean ( L3 )
egen MEANA  = mean ( A  )



* MEAN ADJUSTMENT -- Eases interpretation of parameter estimates
*                      Makes it so B's are elasticities as in 
*                      Cobb-Douglas, even for the Translog functional
*                      form. 
gen MY1 = Y1 / MEANY1
gen MY2 = Y2 / MEANY2
gen MH  = H  / MEANH
gen MC  = C  / MEANC
gen MD  = D  / MEAND
gen ML  = L3 / MEANL
gen MA  = A  / MEANA



* CONVERT TO LOGS -- Both CD and TL functions are non-linear, 
*                      but this transforms them s.t. they are now 
*                      linear in parameters, hence they no longer 
*                      violate assumptions of OLS (which are the same
*                      that we must adhere to for these SFA models).

*LNY1=LOG(MY1) (neg values to fix... not using for now)
gen LNY2 = ln( MY2 )
gen LNH  = ln( MH  )
gen LND  = ln( MD  )
gen LNC  = ln( MC  )
gen LNL  = ln( ML  )
gen LNA  = ln( MA  )


* gen INTERACTION VARIABLES FOR TRANSLOG
gen TT   = T   * T
gen LNHH = LNH * LNH
gen LNHD = LNH * LND
gen LNHC = LNH * LNC
gen LNHL = LNH * LNL
gen LNHA = LNH * LNA

gen LNDD = LND * LND
gen LNDC = LND * LNC
gen LNDL = LND * LNL
gen LNDA = LND * LNA

gen LNCC = LNC * LNC
gen LNCL = LNC * LNL
gen LNCA = LNC * LNA

gen LNLL = LNL * LNL
gen LNLA = LNL * LNA

gen LNAA = LNA * LNA

gen LNHT = LNH * T
gen LNDT = LND * T
gen LNCT = LNC * T
gen LNLT = LNL * T
gen LNAT = LNA * T
gen TTT  = TT  * T


* Varlists
* Cobb-Douglas terms
local CD "LNH LND LNC LNL LNA"
summ `CD'

* Terms to add to CD (interactions) to create Translog form
local TL "" // initialise as blank
local TL "`TL' LNHH LNHD LNHC LNHL LNHA" 
local TL "`TL' LNDD LNDC LNDL LNDA"
local TL "`TL' LNCC LNCL LNCA"
local TL "`TL' LNLL LNLA" 
local TL "`TL' LNAA"
summ `TL'

local TCD "T TT"  // Time terms for CD 
local TTL "T TT LNHT LNDT LNCT LNLT LNAT" // Time terms for TL
summ `TCD' 
summ `TTL'


* Generic way to create list of time dummies 
*  Works no matter how many there are, and always drops T1 from list
*  to avoid perfect collinearity of dummies.
levelsof T, local(Tvalues)
foreach value of local Tvalues{

  local TDV "`TDV' T`value'"
}
local T1 "T1"
local TDV: list TDV - T1
macro list _TDV
summ	 `TDV'

summ `CD' `TL' `TDV'


xtset FC YEAR

capture log close
log using last_run.txt, replace text

/*
*/

bysort FC: egen WI = mean(W)

* PIT AND LEE, 1981
qui xtreg LNY2 `CD'  `TL' `TDV'  [pweight=WI], fe
matrix B = e(b)
sfpanel LNY2 `CD'  `TL' `TDV'  [pweight=WI], model(pl81) svfrontier(B) 
predict	UPL, u

bacon `CD', gen(outliers)

set more on
qui reg LNY2 `CD'  `TL' `TDV' [pweight=WI]
predict xb, xb
predict res, res
tw sc res xb , ml(outliers)
summ res, detail
count if outliers > 0
drop  if outliers > 0


* Battese and Coelli, 1992 
qui reg LNY2 `CD'  `TL' `TDV' [pweight=WI]
matrix B = e(b)
sfpanel LNY2 `CD'  `TL'  `TDV' [pweight=WI], model(bc92) tech(bhhh) svfrontier(B) 
predict	UBC, bc
exit

* 'True' Random Effects
qui xtreg LNY2 `CD'  `TL' `TDV' [pweight=WI] , fe
matrix B = e(b)
sfpanel LNY2 `CD'  `TL' `TDV' [pweight=WI]  , model(tre) svfrontier(B) nsim(10) simtype(halton)
predict	UTRE, u


* 'True' Fixed Effects
qui xtreg LNY2 `CD'  `TL' `TDV'  [pweight=WI], fe
matrix B = e(b)
sfpanel LNY2 `CD'  `TL' `TDV' [pweight=WI], model(tre) svfrontier(B) nsim(10) simtype(halton)
predict	UTFE, u

log close


view last_run.txt


