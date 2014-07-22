********************************************************
********************************************************
*							
*	Patrick R. Gillespie
*	Research Officer		
*	Teagasc, REDP			
*	Athenry, Co Galway, Ireland
*	patrick.gillespie@teagasc.ie		
*											
********************************************************
*	RSF Project DAF RSF 07 505 (GO1390)	*											
*	A micro level analysis of the Irish 	
*	agri-food sector: lessons and 		
*	recommendations from Denmark and 	
*	the Netherlands				
*											
*	Task4	
*	To run - uncomment "do biofuels.do" 
*	in master.do and run that file
********************************************************
* Develops a model of biofuel adoption
********************************************************



********************************************************
* PRELIMINARIES
********************************************************
clear
capture log close
capture cmdlog close
do sub_do/osrprice.do
use "../CountrySTATAFiles/databuilds/$dataname.dta", clear
sort country region subregion farmcode year
********************************************************



********************************************************
* MODEL SETUP
********************************************************
do sub_do/model_setup.do
********************************************************



********************************************************
* MODEL SPECIFICATION
********************************************************
* Starting a log which records each run of the model
*  in a separate log file which will be named with the
*  time and date of that run and will be located in
*  logs/results
********************************************************
*
capture mkdir logs/results
local c_time = c(current_time)
local c_date = c(current_date)
local c_date_time = "`c_date'"+"_"+"`c_time'"
local time_string = subinstr("`c_date_time'", ":", "_", .)
local time_string = subinstr("`time_string'", " ", "_", .)
log using logs/results/`time_string'.log


* Full panel 
************
quietly xtreg oilseedrapeuaa policy sizeclass setasideuaa ln_labour ln_ffi solvency intensity specialise i.year year#mscode, fe vce(robust)
estimates store fulluaa

quietly xtreg osrape_prop policy sizeclass setasideuaa ln_labour ln_ffi solvency intensity specialise i.year year#mscode, fe vce(robust)
estimates store fullprop


* Panel restriction (adopters only)
***********************************
quietly xtreg oilseedrapeuaa policy sizeclass setasideuaa ln_labour ln_ffi solvency intensity specialise i.year year#mscode if adopt==1, fe vce(robust)
estimates store resuaa

quietly xtreg osrape_prop policy sizeclass setasideuaa ln_labour ln_ffi solvency intensity specialise i.year year#mscode if adopt==1, fe vce(robust)
estimates store resprop

outreg2 policy sizeclass setasideuaa ln_labour ln_ffi solvency intensity specialise[*] using "output/docs/model", word stat(coef se) replace 
********************************************************



********************************************************
* CHOW TESTS
********************************************************
*
* Break across time
*******************
quietly xtreg osrape_prop policy sizeclass setasideuaa ln_labour ln_ffi solvency intensity specialise i.year year#mscode pol_sizeclass pol_setasideuaa pol_ln_labour pol_ln_ffi pol_solvency pol_intensity pol_specialise, vce(robust)

test _b[pol_sizeclass]=0, notest
test _b[pol_setasideuaa]=0, notest
test _b[pol_ln_labour]=0, notest
test _b[pol_ln_ffi]=0, notest
test _b[pol_solvency]=0, notest
test _b[pol_intensity]=0, notest
test _b[pol_specialise]=0, notest
test _b[policy]=0, accum

outreg2 policy sizeclass pol_sizeclass setasideuaa pol_setasideuaa ln_labour pol_ln_labour ln_ffi pol_ln_ffi solvency pol_solvency intensity pol_intensity specialise pol_specialise using "output/docs/Chow_time", addstat(Chi-squared statistic, r(chi2), Prob > chi2, r(p)) word nocons replace


* Break across adoption status
******************************
quietly xtreg osrape_prop policy adopt sizeclass setasideuaa ln_labour ln_ffi solvency intensity specialise i.year year#mscode pol_adop, vce(robust)

test _b[pol_adop]=0, notest
test _b[adopt]=0, accum

outreg2 policy pol_adop adopt using "output/docs/Chow_adopt", addstat(Chi-squared statistic, r(chi2), Prob > chi2, r(p)) word nocons replace
********************************************************



********************************************************
* Postestimation tests
********************************************************
*do sub_do/postestimation.do
********************************************************



********************************************************
* CLEAN UP
********************************************************
*
tsset, clear
clear
clear matrix
capture log close
capture cmdlog close
********************************************************
