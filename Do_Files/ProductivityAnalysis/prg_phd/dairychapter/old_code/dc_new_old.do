*****************************************************
*****************************************************
* Dairy Chapter
*
* Patrick R. Gillespie		
*
* 2012
*
*
*****************************************************
*****************************************************

clear
set mem 1400m
set more off
set matsize 300

capture log close
capture cmdlog close

local dodir ~/Documents/projects/phd/dairychapter
local nfsdatadir ~/Data/data_NFSPanelAnalysis/OutData
local outdatadir ~/Data/phd
local Regional_outdatadir ~/Data/data_NFSPanelAnalysis/OutData/RegionalAnalysis

cd `dodir'
log using dc_new.log, replace 
di  "Job  Started  at  $S_TIME  on $S_DATE"

use `nfsdatadir'/nfs_data


*****************************************************
* System selection
*****************************************************

gen syst = ffszsyst-int(ffszsyst/10)*10
keep if syst == 1 | system`t' == 2

*****************************************************
* Code borrowed from Thia's
* data_NFSPanelAnalysis/Do_Files/FarmLevelModel/FarmLevel_dairy.do
* Subset 
* Keep only farms with dairy gross output
*****************************************************

* Farms with no milk sales
keep if fdairygo > 0 & fdairygo < .
keep if doslcmgl > 0 & doslcmgl < .


* Farms with 50% liquid milk sales
keep if dosllmgl < 0.5*dotomkgl


* No herds with less than 10 dairy cows
keep if dpopinvd > 10





*****************************************************
* Price Adjustment
*  - from doFarmDerivedVars.do
*****************************************************


capture gen PLabour = 0
*Employment Regulations Order (Agricultural Workers Joint Labour Committee) 
scalar sc_agewage_1994 = 137.24*52*1.27
scalar sc_agewage_1995 = (137.24*52*1.27 + 9705)/2
scalar sc_agewage_1996 = 9705
scalar sc_agewage_1997 = 10047
scalar sc_agewage_1998 = 10278
scalar sc_agewage_1999 = 10642
scalar sc_agewage_2000 = 11437
scalar sc_agewage_2001 = 12481
scalar sc_agewage_2002 = 13208
scalar sc_agewage_2003 = 13802
scalar sc_agewage_2004 = 14196
scalar sc_agewage_2005 = 15513
scalar sc_agewage_2006 = 16062
scalar sc_agewage_2007 = 17339
scalar sc_agewage_2008 = 345.93*52
scalar sc_agewage_2009 = (354.90+363.87)/2*52
scalar sc_agewage_2010 = (9.33+9.1)/2*52*40
*from FAPRI
scalar sc_agewage_2020 = sc_agewage_2008*1.14

*todo get update

local i = 1994
while `i' <= 2009 {
        replace PLabour = sc_agewage_`i'/sc_agewage_2000*100 if year == `i'
        local i = `i' + 1
}





*****************************************************
* Dairy Efficiency Analysis
*  - from doFarmDerivedVars.do
*****************************************************

gen gm_ha  = fdairygm/daforare
gen gm_lu  = fdairygm/dpnolu
gen gm_lt  = fdairygm/dotomkgl

* Deflate to 2000 prices
gen gm_lt_df = gm_lt/PMilk*100

* Set into bands
gen gm_lt_df5 = max(0.05,min(.25,int(gm_lt_df/.05)*.05)) if gm_lt != .

tab year gm_lt_df5

*GM = (GO/lt  S(DC(i)/lt))*lt/lu*lu/ha*ha

gen GO_ha = fdairygo/daforare
gen GO_lu = fdairygo/dpnolu
gen GO_lt = fdairygo/dotomkgl

gen lt_lu = dotomkgl/dpnolu

gen lu_ha = dpnolu/daforare

gen dc_ha = fdairydc/daforare
gen dc_lt = fdairydc/dotomkgl
gen dc_lu = fdairydc/dpnolu

*Litres per unit of concentrate
gen lt_conc = dotomkgl/(ddconval/(PCattleFeed/100))

*capture gen d_othmiscdc = ddmiscdc - ivmalldy - iaisfdy - itedairy - imiscdry - flabccdy

gen ha = daforare



*****************************************************
* Gross Output decomposition 
* - from doFarmDerivedVars.do 
*****************************************************



** Milk


* Milk Sales
gen tdotomkvl = doslcmvl + domlkbon - domlkpen + dosllmvl + domkfdvl + domkalvl if year > 1995
replace tdotomkvl = doslmkvl + domkfdvl + domkalvl if year <= 1995 

*Price milk sold to creamery
gen p_doslcm = doslcmvl/doslcmgl

*Price liquid milk

* Missing liquid milk volume after 2000
* todo why is this the case
replace dosllmgl = doslmkgl - doslcmgl if dosllmvl > 0 & year >= 2001 & (dosllmgl == 0)
gen p_dosllm = dosllmvl/dosllmgl

*Price milk fed
gen p_domkfd = domkfdvl/domkfdgl

*average price
gen p_doslmkvl = doslmkvl/doslmkgl

*set missing to zero
mvencode p_do*, mv(0) override

gen tdotomkvl1 = doslcmvl + domlkbon - domlkpen + dosllmvl + domkfdvl + domkalvl if year > 1995
replace tdotomkvl1 = doslmkvl + domkfdvl + domkalvl if year <= 1995 


gen hasliquidmilk = dosllmgl > 0 & dosllmgl != .
gen hasdomkfdgl = domkfdgl > 0 & domkfdgl != .
gen hasdomlkbon = domlkbon > 0
gen hasdomlkpen = domlkpen > 0
gen hasdomkalvl = domkalvl > 0


gen tdotomkvl2 = p_doslcm*doslcmgl + domlkbon - domlkpen + p_dosllm*dosllmgl + p_domkfd*domkfdgl + domkalvl if year > 1995

replace tdotomkvl2 = p_doslmkvl*doslmkgl + p_domkfd*domkfdgl + domkalvl if year <= 1995 

* per lu

gen dpnolu_ha = dpnolu/daforare
gen daforare_sh = daforare/fsizeadj

local dairy_go_vlist = "doslcmgl domlkbon domlkpen dosllmgl domkfdgl domkalvl doslmkgl"
foreach var in `dairy_go_vlist' {
	gen `var'_lu = `var'/dpnolu
        gen `var'_ha = `var'/daforare
        *gen `var'_lu_df = `var'_lu/p_`var'
}

gen milk_lu = doslcmgl_lu + dosllmgl_lu + domkfdgl_lu

foreach var in `dairy_go_vlist' {
        gen `var'_lt = `var'/(daforare*dpnolu_ha*milk_lu)
}

gen tdotomkvl3 = fsizeadj*daforare_sh*dpnolu_ha*(p_doslcm*doslcmgl_lu + domlkbon_lu - domlkpen_lu + p_dosllm*dosllmgl_lu + p_domkfd*domkfdgl_lu + domkalvl_lu) if year > 1995

replace tdotomkvl3 = fsizeadj*daforare_sh*dpnolu_ha*(p_doslmkvl*doslmkgl_lu + p_domkfd*domkfdgl_lu + domkalvl_lu) if year <= 1995 

tabstat *dotomkvl* p_doslcm doslcmvl doslcmgl domlkbon domlkpen  p_dosllm dosllmvl dosllmgl domkfdv p_domkfd domkfdvl domkfdgl domkalvl if dotomkvl > 0 [weight = wt],by(year) stats(mean)


** Replacement Cost

*doschbvl - price - needs to be before others as we do not know the number of sales for missing values
gen p_doschbvl = doschbvl/doschbno

* Correct sales of dairy cattle variable
replace doschbvl = doschbvl + dosldhrd - docfslvl - doschbvl if (doschbvl == 0 | year == 2009) & dosldhrd - docfslvl > 0 & dosldhrd - docfslvl != .  
replace doschbno = doschbno + dosldhrd - docfslno if doschbvl == 0 & dosldhrd - docfslvl > 0 & dosldhrd - docfslvl != .

* prices
*dotochbv
gen p_dotochbv = dotochbv/dotochbn
*dopchbvl
gen p_dopchbvl = dopchbvl/dopchbno
*dotichbv
gen p_dotichbv = dotichbv/dotichbn

*set missing to zero
mvencode p_doschbvl p_dotochbv p_dopchbvl p_dotichbv, mv(0) override

*dovlcnod
*todo find this out

* Other sales and purchases not in data
gen do_othersales = dosldhrd - doschbvl - docfslvl
gen do_otherpurchase = doprdhrd - dopchbvl

gen tdoreplct1 = doschbvl + dotochbv - (dopchbvl + dotichbv) + dovlcnod
gen tdoreplct2 = doschbvl + p_dotochbv*dotochbn - (p_dopchbvl*dopchbno + p_dotichbv*dotichbn) + dovlcnod

tabstat p_doschbvl doschbvl dotochbv do_otherpurchase dopchbvl dotichbv dovlcnod tdoreplct* doreplct p_dotochbv dotochbn p_dopchbvl dopchbno p_dotichbv dotichbn if dotomkvl > 0 [weight = wt],by(year) stats(mean)

** Value of dropped calves (sold+trans


* Price
gen p_docftfvl = docftfvl/docftfno
gen p_docfslvl = docfslvl/docfslno
*set missing to zero
mvencode p_do*, mv(0) override

gen tdovalclf1 = docftfvl + docfslvl
gen tdovalclf2 = p_docftfvl*docftfno + p_docfslvl*docfslno

tabstat *dovalclf* p_docftfvl p_docfslvl docftfno docfslno docftfvl docfslvl if dotomkvl > 0 [weight = wt],by(year) stats(mean)


*check 
tabstat p_doslcm doslcmvl doslcmgl p_dosllm dosllmvl dosllmgl p_doslcm domkfdvl domkfdgl if dotomkvl > 0 [weight = wt],by(year)

* todo
* Per hectare (check)
gen tfdairygo1 = daforare*(p_doslcm*doslcmgl_ha + domlkbon_ha - domlkpen_ha + p_dosllm*dosllmgl_ha + p_domkfd*domkfdgl_ha + domkalvl_ha) + p_docftfvl*docftfno + p_docfslvl*docfslno + doschbvl + p_dotochbv*dotochbn - (p_dopchbvl*dopchbno + p_dotichbv*dotichbn) + dovlcnod if year > 1995


* Per LU (check)
*gen dpnolu_ha = dpnolu/daforare

gen tfdairygo2 = daforare*dpnolu_ha*(p_doslcm*doslcmgl_lu + domlkbon_lu - domlkpen_lu + p_dosllm*dosllmgl_lu + p_domkfd*domkfdgl_lu + domkalvl_lu) + p_docftfvl*docftfno + p_docfslvl*docfslno + doschbvl + p_dotochbv*dotochbn - (p_dopchbvl*dopchbno + p_dotichbv*dotichbn) + dovlcnod if year > 1995


* Per litre (check)
gen tfdairygo3 = daforare*dpnolu_ha*lt_lu*(p_doslcm*doslcmgl_lt + domlkbon_lt - domlkpen_lt + p_dosllm*dosllmgl_lt + p_domkfd*domkfdgl_lt + domkalvl_lt) + p_docftfvl*docftfno + p_docfslvl*docfslno + doschbvl + p_dotochbv*dotochbn - (p_dopchbvl*dopchbno + p_dotichbv*dotichbn) + dovlcnod if year > 1995

* Per hectare (measure)
gen tfdairygo4 = (daforare*(p_doslcm*doslcmgl_ha + domlkbon_ha - domlkpen_ha + p_dosllm*dosllmgl_ha + p_domkfd*domkfdgl_ha + domkalvl_ha) + p_docftfvl*docftfno + p_docfslvl*docfslno + doschbvl + p_dotochbv*dotochbn - (p_dopchbvl*dopchbno + p_dotichbv*dotichbn) + dovlcnod)/daforare if year > 1995

* Per LU (measure)
gen tfdairygo5 = (daforare*dpnolu_ha*(p_doslcm*doslcmgl_lu + domlkbon_lu - domlkpen_lu + p_dosllm*dosllmgl_lu + p_domkfd*domkfdgl_lu + domkalvl_lu) + p_docftfvl*docftfno + p_docfslvl*docfslno + doschbvl + p_dotochbv*dotochbn - (p_dopchbvl*dopchbno + p_dotichbv*dotichbn) + dovlcnod)/(daforare*dpnolu_ha) if year > 1995

* Per litre (measure)
gen tfdairygo6 = (daforare*dpnolu_ha*lt_lu*(p_doslcm*doslcmgl_lt + domlkbon_lt - domlkpen_lt + p_dosllm*dosllmgl_lt + p_domkfd*domkfdgl_lt + domkalvl_lt) + p_docftfvl*docftfno + p_docfslvl*docfslno + doschbvl + p_dotochbv*dotochbn - (p_dopchbvl*dopchbno + p_dotichbv*dotichbn) + dovlcnod)/(daforare*dpnolu_ha*lt_lu) if year > 1995




*****************************************************
* Direct Costs Decomposition 
* - from doFarmDerivedVars.do 
*****************************************************

gen d_othmiscdc = ddmiscdc - ivmalldy - iaisfdy - itedairy - imiscdry - flabccdy

local d_inp_vlist = "ddconval ddpastur ddwinfor d_othmiscdc ivmalldy iaisfdy itedairy imiscdry flabccdy fdairydc iballdry ibhaydvl ibstrdvl ibsildvl"

local dairydc_vlist = "ddconval ddpastur ddwinfor d_othmiscdc ivmalldy iaisfdy itedairy imiscdry flabccdy"

* moved the gen statement down to where the other tfdairy vars are defined below
*gen tfdairydc1 = ddconval + ddpastur + ddwinfor + d_othmiscdc + ivmalldy + iaisfdy + itedairy + imiscdry + flabccdy

* doslmkgl_lu dosllmgl_lu domkfdgl_lu domlkbon_lu domlkpen_lu domkalvl_lu
* Quantity

local var = "ddconval"
gen p_`var' = PCattleFeed/100
gen `var'q = `var'/(p_`var')

local var = "ddpastur"
gen p_`var' = PTotalFert/100
gen `var'q = `var'/(p_`var')

local var = "ddwinfor"
gen p_`var' = PTotalFert/100
gen `var'q = `var'/(p_`var')

local var = "ivmalldy"
gen p_`var' = PVetExp/100
gen `var'q = `var'/(p_`var')

local var = "iaisfdy"
gen p_`var' = PVetExp/100
gen `var'q = `var'/(p_`var')

local var = "itedairy"
gen p_`var' = PMotorFuels/100
gen `var'q = `var'/(p_`var')

local var = "imiscdry"
gen p_`var' = POtherInputs/100
gen `var'q = `var'/(p_`var')

* PLabour not found in nfs_data.do!!
local var = "flabccdy"
gen p_`var' = PLabour/100
gen `var'q = `var'/(p_`var')

local var = "d_othmiscdc"
gen p_`var' = POtherInputs/100
gen `var'q = `var'/(p_`var')

foreach var in `dairydc_vlist' {
        gen `var'q_ha = `var'q/daforare
        gen `var'q_lu = `var'q/dpnolu
        gen `var'q_lt = `var'q/(daforare*dpnolu_ha*milk_lu)
        gen `var'q_lu_df = `var'q_lu/p_`var'
        *regress `var'q_lu_df p_`var' region2-region8 soil2 soil3 teagasc if daforare > 0

}


* Per farm
gen tfdairydc0 = ddconval + ddpastur + ddwinfor + d_othmiscdc + ivmalldy + iaisfdy + itedairy + imiscdry + flabccdy


* Per hectare 
gen tfdairydc1 = daforare*(ddconvalq_ha*(PCattleFeed/100)  + ddpasturq_ha*(PTotalFert/100)  + ddwinforq_ha*(PTotalFert/100)  + d_othmiscdcq_ha*(POtherInputs/100) + ivmalldyq_ha*(PVetExp/100) + iaisfdyq_ha*(PVetExp/100) + itedairyq_ha*(PMotorFuels/100) + imiscdryq_ha*(POtherInputs/100) + flabccdyq_ha*(PLabour/100))


* Per LU 
gen tfdairydc2 = dpnolu*(ddconvalq_lu*(PCattleFeed/100)  + ddpasturq_lu*(PTotalFert/100)  + ddwinforq_lu*(PTotalFert/100)  + d_othmiscdcq_lu*(POtherInputs/100) + ivmalldyq_lu*(PVetExp/100) + iaisfdyq_lu*(PVetExp/100) + itedairyq_lu*(PMotorFuels/100) + imiscdryq_lu*(POtherInputs/100) + flabccdyq_lu*(PLabour/100))


* Per litre 
gen tfdairydc3 = daforare*dpnolu_ha*lt_lu*(ddconvalq_lt*(PCattleFeed/100)  + ddpasturq_lt*(PTotalFert/100)  + ddwinforq_lt*(PTotalFert/100)  + d_othmiscdcq_lt*(POtherInputs/100) + ivmalldyq_lt*(PVetExp/100) + iaisfdyq_lt*(PVetExp/100) + itedairyq_lt*(PMotorFuels/100) + imiscdryq_lt*(POtherInputs/100) + flabccdyq_lt*(PLabour/100))

save `outdatadir'/dc_new, replace

tabstat fdairydc tfdairy* [weight=wt], by(year)
collapse fdairydc tfdairy* [weight=wt], by(year)

use `outdatadir'/dc_new, clear 
tabstat *dotomkvl* p_doslcm doslcmvl doslcmgl domlkbon domlkpen  p_dosllm dosllmvl dosllmgl domkfdv p_domkfd domkfdvl domkfdgl domkalvl if dotomkvl > 0 [weight = wt],by(year) stats(mean)

tabstat p_doschbvl doschbvl dotochbv do_otherpurchase dopchbvl dotichbv dovlcnod tdoreplct* doreplct p_dotochbv dotochbn p_dopchbvl dopchbno p_dotichbv dotichbn if dotomkvl > 0 [weight = wt],by(year) stats(mean)

tabstat *dovalclf* p_docftfvl p_docfslvl docftfno docfslno docftfvl docfslvl if dotomkvl > 0 [weight = wt],by(year) stats(mean)

tabstat p_doslcm doslcmvl doslcmgl p_dosllm dosllmvl dosllmgl p_doslcm domkfdvl domkfdgl if dotomkvl > 0 [weight = wt],by(year)
*fdairydc fdairygo 
*collapse tfdairy* `dairy_go_vlist' `d_inp_vlist' `dairydc_vlist' [weight=wt], by(year)
collapse daforare fsizuaa dpnolu lt_lu GO* gm* tfdairy* fdairygo `dairy_go_vlist'* `d_inp_vlist'* p_* [weight=wt], by(year)

* Convert punts to euro
*/.787564
*replace GO_ha = GO_ha/.787564 if year <1999
*replace GO_lu = GO_lu/.787564 if year <1999
*replace GO_lt = GO_lt/.787564 if year <1999
*replace gm_ha = gm_ha/.787564 if year <1999
*replace gm_lu = gm_lu/.787564 if year <1999
*replace gm_lt = gm_lt/.787564 if year <1999

*foreach var in `dairydc_vlist'{
*	replace `var'= `var'/.787564 if year <1999
*}

outsheet using `outdatadir'/dc_new_tab.csv, comma replace 
log close
