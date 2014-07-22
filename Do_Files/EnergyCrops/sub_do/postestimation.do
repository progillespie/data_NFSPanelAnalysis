********************************************************
********************************************************
*							
*	Patrick R. Gillespie
*	Recording Code written by: 
*
*       Daragh Clancy
* 
*       Research Officer		
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
*		
********************************************************
* Statistical test of FADN dataset
********************************************************


********************************************************
* Panel must be tsset before running! Can be called at * the bottom of sub_do/biofuels.do 
********************************************************
*
*Ramsey RESET Test*
*******************
*
generate trend = _n
regress osrape_prop policy sizeclass setasideuaa ln_labour ln_ffi solvency intensity specialise
estat ovtest


*Multicollinearity*
*******************
*
quietly regress osrape_prop policy sizeclass setasideuaa ln_labour ln_ffi solvency intensity specialise
estat vif


*Heteroskedasticity: Breusch-Pagan Test*
****************************************
*
quietly regress osrape_prop policy sizeclass setasideuaa ln_labour ln_ffi solvency intensity specialise
estat hettest


*Heteroskedasticity: White's Test*
**********************************
*
quietly regress osrape_prop policy sizeclass setasideuaa ln_labour ln_ffi solvency intensity specialise
imtest, white


*Fixed Effects
**************
*
xtreg osrape_prop policy sizeclass setasideuaa ln_labour ln_ffi solvency intensity specialise
estimates, fe
store fixed
*
xtreg osrape_prop policy sizeclass setasideuaa ln_labour ln_ffi solvency intensity specialise
estimates 
store random
*
hausman fixed random, constant


*Serial Correlation: Prais-Winsten Procedure*
*********************************************
prais 
*


*FE/RE Models with AR(1) Disturbances*
**************************************
*
xtregar osrape_prop policy sizeclass setasideuaa ln_labour ln_ffi solvency intensity specialise
estimates, fe
store fixed
*
xtregar osrape_prop policy sizeclass setasideuaa ln_labour ln_ffi solvency intensity specialise
estimates
store random
*
hausman fixed random, constant

********************************************************
