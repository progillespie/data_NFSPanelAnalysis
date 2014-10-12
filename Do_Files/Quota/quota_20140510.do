matrix drop _all
mata: mata clear
version 9.0
clear
set more off
set matsize 4000

set mem 300m



local project "Quota"


local dodir "D:/Data\Data_NFSPanelAnalysis/Do_Files/`project'"
local outdatadir "../../OutData/`project'"
capture mkdir `outdatadir'

cd "`dodir'"


*use `outdatadir'/copy_dataallyears, clear
*use `outdatadir'/nfs_d210, clear
*use `outdatadir'/nfs_data, clear
use `outdatadir'/dataallyears_out1, clear
*use `outdatadir'/nfs_9510.dta, clear
notes

*----------------------------------
*TEMPORARY!!!
*----------------------------------
gen oh_alloc   = fdairygo/farmgo
gen fdairyoh   = farmohct*oh_alloc
*gen cntry      = 1
*gen fdairyec   = 0
*----------------------------------
*TEMPORARY!!!
*----------------------------------

*----------------------------------
* Do Comparative Analysis
*----------------------------------

* Stocking Rate
capture gen lu_ha        = dpnolu/daforare

* Labour units
capture gen labu_ha      = flabunpd/daforare

* Yield
capture gen lt_lu        = dotomkgl/dpnolu

* Milk Price
gen milk_price           = fdairygo/dotomkgl

*Gross Output
gen fdairygo_ha          = fdairygo/daforare
capture drop fdairygo_lu
gen fdairygo_lu          = fdairygo/dpnolu
gen fdairygo_labu        = fdairygo/flabunpd
capture drop fdairygo_lt
gen fdairygo_lt          = fdairygo/dotomkgl

* Costs
gen fdairydc_lt          = fdairydc/dotomkgl
gen fdairydc_lu          = fdairydc/dpnolu
gen fdairydc_ha          = fdairydc/daforare
gen fdairydc_labu        = fdairydc/flabunpd

gen fdairyoh_lt          = fdairyoh/dotomkgl
gen fdairyoh_lu          = fdairyoh/dpnolu
gen fdairyoh_ha          = fdairyoh/daforare
gen fdairyoh_labu        = fdairyoh/flabunpd

gen cost_lt              = fdairydc_lt+ fdairyoh_lt
gen cost_lu              = (fdairydc + fdairyoh)/dpnolu
gen cost_ha              = (fdairydc + fdairyoh)/daforare
gen cost_labu            = (fdairydc + fdairyoh)/flabunpd

gen rentrateha           = forntcon/fsizldrt
gen ownlandpct           = fsizldow/fsizuaa
gen ownlandha            = daforare*ownlandpct
gen ownlandval           = ownlandha*rentrateha

* Margin
gen fdairynm             = fdairygm - fdairyoh
gen fdairynm_lt          = fdairygm/dotomkgl - fdairyoh_lt
gen fdairynm_ha          = fdairygm/daforare - fdairyoh_ha

gen fdairygm_lt          = fdairygm/dotomkgl
gen fdairygm_labu        = fdairygm/flabunpd

gen nm_lt1               = fdairynm_lt
gen nm_lu1               = (fdairygm - fdairyoh)/dpnolu
gen nm_ha1               = (fdairygm - fdairyoh)/daforare
gen nm_labu1             = (fdairygm - fdairyoh)/flabunpd
gen nm_labu1_land        = (fdairygm - fdairyoh-ownlandval)/flabunpd

* Adjusted Net Margin
levelsof year, local(yr_list)
*local yr_list = "1995 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009"
STOP!!
local cntry_list = "1"


gen AllFarms = 1

local i = 1984
while `i' < 2012{

	qui do sub_do/kden_finance AllFarms 1 ==`i' 
	graph export `outdatadir'/kden_finance_`i'.pdf, replace
	local i = `i' + 1
}

*local var "fdairygo_ha"
*local var "daforare"
local var "cost_ha"
*local var "nm_ha1"
*local var "lu_ha"
*local var "fdairygo_lu"
*local var "cost_lu"
*local var "nm_lu1"
*local var "lt_lu"
*local var "fdairygo_lt"
*local var "nm_lt1"
*local var "labu_ha"
*local var "fdairygo_labu"
*local var "cost_labu"
*local var "nm_labu1"

*kdensity `var' if year == 2008 & nm_lt1  < 0.3  & nm_lt1  > -0.1 

/*
*******************************************************
* K-S tests*  Per Labour Unit (no price adjustment)
*******************************************************

*---------------------------------
* Using nm_labu1 
*---------------------------------

local var "nm_labu1"
matrix KS_`var' = (0, 0)
matrix TT_`var' = (0, 0)
local i = 0
foreach yr of local yr_list{
	
	local j = 1 
	while `j' < 3{
	   matrix KSROW = (0,0)
	   matrix TTROW = (0,0)
	   * NM K-S and T tests IE- NI
	   qui ksmirnov `var' if year == `yr' & nm_lt1  < 0.3  & nm_lt1  > -0.1 , by(cntry) 
	   matrix KSROW[1,1] = round(`r(p_cor)',.001)
	   qui ttest `var' if year == `yr' & nm_lt1  < 0.3  & nm_lt1  > -0.1 , by(cntry) unequal
	   matrix TTROW[1,1] = round(`r(p)',.001)
	
	   * NM K-S and T tests BMW- NI
	   qui ksmirnov `var' if se == 0 & year == `yr' & nm_lt1  < 0.3  & nm_lt1  > -0.1 , by(cntry) 
	   matrix KSROW[1,2] = round(`r(p_cor)',.001)
	   qui ttest `var' if se == 0 & year == `yr' & nm_lt1  < 0.3  & nm_lt1  > -0.1 , by(cntry) unequal
	   matrix TTROW[1,2] = round(`r(p)',.001)

	   local j = `j' + 1
	}
	
	matrix KS_`var' = (KS_`var' \ KSROW)
	matrix TT_`var' = (TT_`var' \ TTROW)
	local i = `i' + 1
}
local i = `i' + 1
matrix KS_`var' = KS_`var'[2..`i', 1..2]
matrix TT_`var' = TT_`var'[2..`i', 1..2]
matrix rownames KS_`var' = `yr_list'
matrix colnames KS_`var' = "IE - NI" "BMW - NI"
matrix rownames TT_`var' = `yr_list'
matrix colnames TT_`var' = "IE - NI" "BMW - NI"



*******************************************************
* K-S tests*  Per Labour Unit (Adjusted Price)
*******************************************************


*---------------------------------
* Using nm_labu1_land
*---------------------------------
local var "nm_labu1_land"
matrix KS_`var' = (0, 0)
matrix TT_`var' = (0, 0)
local i = 0
foreach yr of local yr_list{
	
	local j = 1 
	while `j' < 3{
	   matrix KSROW = (0,0)
	   matrix TTROW = (0,0)
	   * NM K-S and T tests IE- NI
	   qui ksmirnov `var' if year == `yr' & nm_lt1  < 0.3  & nm_lt1  > -0.1 , by(cntry) 
	   matrix KSROW[1,1] = round(`r(p_cor)',.001)
	   qui ttest `var' if year == `yr' & nm_lt1  < 0.3  & nm_lt1  > -0.1 , by(cntry) unequal
	   matrix TTROW[1,1] = round(`r(p)',.001)
	
	   * NM K-S and T tests BMW- NI
	   qui ksmirnov `var' if se == 0 & year == `yr' & nm_lt1  < 0.3  & nm_lt1  > -0.1 , by(cntry) 
	   matrix KSROW[1,2] = round(`r(p_cor)',.001)
	   qui ttest `var' if se == 0 & year == `yr' & nm_lt1  < 0.3  & nm_lt1  > -0.1 , by(cntry) unequal
	   matrix TTROW[1,2] = round(`r(p)',.001)

	   local j = `j' + 1
	}
	
	matrix KS_`var' = (KS_`var' \ KSROW)
	matrix TT_`var' = (TT_`var' \ TTROW)
	local i = `i' + 1
}
local i = `i' + 1
matrix KS_`var' = KS_`var'[2..`i', 1..2]
matrix TT_`var' = TT_`var'[2..`i', 1..2]
matrix rownames KS_`var' = `yr_list'
matrix colnames KS_`var' = "IE - NI" "BMW - NI"
matrix rownames TT_`var' = `yr_list'
matrix colnames TT_`var' = "IE - NI" "BMW - NI"





*Removed from loop until can implement the ownlandval again
*nm_labu_adj_land
*nm_labu1_land  
foreach var of varlist nm_labu1  nm_labu_adj  {
	matrix list KS_`var'
	matrix list TT_`var'

}

*/


*---------------------------------
* Using nem_labu_adj
*---------------------------------
* NM Kernel Density IE- NI
*ksmirnov nem_labu_adj if year == 2008 & nm_lt1  < 0.3  & nm_lt1  > -0.1 

* NM Kernel Density BMW- NI
*ksmirnov nem_labu_adj if se == 0 & year == 2008 & nm_lt1  < 0.3  & nm_lt1  > -0.1 


*label var nm_labu_adj  "Adjusted net margin per hour (€)"
*label var nem_labu_adj "Adjusted net economic margin per hour (€)"

*qui do sub_do/kden_regions  nem_labu_adj 2009


notes
