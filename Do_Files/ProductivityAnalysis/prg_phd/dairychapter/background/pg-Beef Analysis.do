*****************************************************
*****************************************************
*
* Beef Analysis
*
* (c) Cathal O'Donoghue NUIG
*
* date 22/5/2004
*
*
*****************************************************
*Initialise

clear
set maxvar 20000
******set mem 720m
******set more off
******set matsize 300
******version 9.0
******capture log close
******//cd "Z:\Agriculture Research\Rural Economy\Cathal ODonoghue"


local dodir data\data_NFSPanelAnalysis\Do_Files\InequalityAnalysis
local nfsdatadir data\data_NFSPanelAnalysis\OutData
local Regional_outdatadir data\data_NFSPanelAnalysis\OutData\RegionalAnalysis

* Data Year POSSIBLY LOOP THIS???????????????????????????????????????????????????????????????
local data_yr = 2002
scalar data_yr1 = `data_yr'

* Output Data
local outdatadir \data\data_NFSPanelAnalysis\OutData\dychap


log using `outdatadir'\dychap.log, replace 
di  "Job  Started  at  $S_TIME  on $S_DATE"

******cd d:
cd `dodir'

*****************************************************
*****************************************************
**Import NFS Data
*****************************************************
*****************************************************


use `nfsdatadir'\8409v0.dta, clear
sort farmcode year
merge farmcode year using `Regional_outdatadir'\regional_weights.dta
drop _merge

drop if year == .

gen age_holder = ogagehld
gen familyfarmincome = farmffi 
capture drop standardmandays
gen standardmandays = flabsmds
gen sizeoffarm = fsizuaa
*gen wave = year - 1982
gen noofhouseholds = oanohshm
gen npers04 = oanolt5y
gen npers515 = oano515y
gen npers1519 = oano1619
gen npers2024 = oano2024
gen npers2544 = oano2544
gen npers4564 = oano4564
gen npers65 = oanoge65
capture drop grossoutput
gen grossoutput = farmgo
capture drop directcosts
gen directcosts = farmdc
*append using \data\data_NFSPanelAnalysis\OutData\InequalityAnalysis\NFS1995small.dta

* next 5 lines extracts the last digit in the sizesystem variable. This gives the farm system
gen sizesystem = ffszsyst
gen s = sizesystem/10
gen intsys = int(s)
gen t = (s - intsys)*10
gen sys = round(t)
drop s intsys t
gen system_old = system
replace system = 0 
replace system = 0 if sys == 1
replace system = 1 if sys == 2
replace system = 2 if sys == 4
replace system = 3 if sys == 5
replace system = 4 if sys == 6
replace system = 5 if sys == 7

* system definitions
* 0 - dairying
* 1 - dairying + other
* 2 - cattle rearing
* 3 - cattle other
* 4 - mainly sheep
* 5 - tillage

gen ageoperator = 0
replace ageoperator = 1 if  age_holder <= 25
replace ageoperator = 2 if  (age_holder > 25 &  age_holder <= 35)
replace ageoperator = 3 if  (age_holder > 35 &  age_holder <= 45)
replace ageoperator = 4 if  (age_holder > 45 &  age_holder <= 55)
replace ageoperator = 5 if  (age_holder > 55 &  age_holder <= 65)
replace ageoperator = 6 if age_holder >= 66
* generates age bands: <25, 25-35, 35-45, 45-55, 55-65, >66
 
* Dayly Earnings = familyfarmincome/(Number of Months Worked * Weeks per Month * Hours per Week)
gen dearns = 0
replace dearns = familyfarmincome/ standardmandays/8
gen farmsize = 0
replace farmsize = 1 if sizeoffarm < 10
replace farmsize = 2 if sizeoffarm >= 10 & sizeoffarm < 20
replace farmsize = 3 if sizeoffarm > 20 & sizeoffarm < 30
replace farmsize = 4 if sizeoffarm > 30 & sizeoffarm < 50
replace farmsize = 5 if sizeoffarm > 50 & sizeoffarm < 100
replace farmsize = 6 if sizeoffarm >= 100

gen ffiperhectare = familyfarmincome/sizeoffarm

* log of income variables
gen lndearns = ln(dearns)
gen lnffi = ln(familyfarmincome)

gen total_labour_hours = standardmandays*8
gen  fulltime = 1 if total_labour_hours > 1350
replace  fulltime = 0 if total_labour_hours < 1350
* 1350 is 0.75 labour units whereas 1800 hours worked on the farm is considered to be 1 standard labour unit.
*In the NFS full time farms are defined as farms which require at least 0.75 standard labour units to operate.

*this generates real earnings year on year. Base year is  Nov 1996
* 94-95.1
*95-97.6
*96-99.3
*97-100.7
*98-103.1
*99-104.8
*2000-110.7
*2001-116.1

sort year
by year: egen av_ffi = mean(familyfarmincome)
gen tav_ffi2005 = av_ffi if year  == 2005
replace tav_ffi2005 = 0 if tav_ffi2005 ==. 
egen av_ffi2005 = max(tav_ffi2005)

gen index = av_ffi2005/av_ffi2005*familyfarmincome

gen rfarmy = index 

**Number of Persons in Household
capture drop npers
rename noofhouseholds npers

**Equivalence Scale - npers^x
gen es5 = npers^0.5
gen es7 = npers^0.7
gen es9 = npers^0.9
gen es10 = npers

**Equivalised Income 
gen rfarmyes0 = rfarmy
gen rfarmyes5 = rfarmy/es5
gen rfarmyes7 = rfarmy/es7
gen rfarmyes9 = rfarmy/es9
gen rfarmyes10 = rfarmy/es10

**Off Farm Income
gen isoff_farmy = 0
*replace isoff_farmy = 1 if 


**Age Squared
gen age2 = ageoperator^2


**costs
gen cost_per_output = 0
replace cost_per_output = directcosts/grossoutput

gen farmsize2 = farmsize*farmsize
gen cost_per_out2 =  cost_per_output^2
gen labour2 =  total_labour_hours^2
*xi: regress  familyfarmincome i.system i.fulltime  farmsize  ageoperator  age2 i.year  total_labour_hours  landowned landrented landlet totalforagearea feedacres  totalcropsandpasture hayadjustedacreage  silageadjustedacreage roughgrazing remainderoffarm acresrented_family_retirementsch acresrented_non_family_retiremen grazing_areatreated nongrazing pongrazing kongrazing grassland_areatreated nongrassland pongrassland kongrassland labourunitsunpaid_family_ labourunitspaid totallabourunits standardmandays directcosts i.soilcode

*gen dirpayts = fsubhors + fsubtbco + fsubforh + fsubesag + fsubyfig + fsubreps + fsub10tp + fsub22tp + fsubastp + fsubcatp + fsubchtp + fsubeptp + fsubextp + fsubgpcm + fsublitp + fsubmztp + fsubpbtp + fsubrptp + fsubsctp + fsubshtp + fsubsptp + fsubtups + fsubvstp

gen lfa = fsubchen
* Create Residual from Grants and subsidies
gen fgrntsub_resid = max(0,fgrntsub - (fsubesag + fsubreps))
* Single farm payment
gen sfp = 0
replace sfp = fsubchpp if year >= 2005
replace fgrntsub_resid = fgrntsub_resid - sfp if year >= 2005
replace fgrntsub_resid = 0 if fgrntsub_resid == .
* Single farm payment

replace fgrntsub_resid = max(0,fgrntsub_resid - fsubchen)

* Total Subsidies
gen dirpayts = 0

*Cattle Subsidy
replace dirpayts = dirpayts + cssuckcw + cs10mtbf + cs22mtbf + csslaugh + csextens + csheadag + csmctopu
*Suckler Welfare
gen suckler_welfare = 0
replace suckler_welfare = cosubsid if year >= 2008
replace dirpayts = dirpayts + suckler_welfare
*Sheep and Poultry Subsidy
replace dirpayts = dirpayts + sosubsid + posubsid
* Other grants and subsidies 
replace dirpayts = dirpayts + fgrntsub_resid + (fsubesag + fsubyfig + fsubreps)
*Cattle Head current year entitlemen(?)
replace dirpayts = dirpayts + fsubchen 
*SFP
replace dirpayts = dirpayts + sfp 

*Other subsidies
replace dirpayts = dirpayts  + fsubhors + fsubtbco + fsubforh 
*Tillage and Dairy Subsidy
replace dirpayts = dirpayts + dogpcomp + fsubastp + fsubcatp + fsubrptp + fsubpbtp + fsublitp + fsubmztp+ fsubvstp

replace dirpayts = dirpayts + dqcomlrd if year >= 2005 
replace dirpayts = dirpayts + dosubsvl if year >= 2002 & year < 2005
replace dirpayts = dirpayts + dosubsvl if year < 2001
* Cow Protein Payment
replace dirpayts = dirpayts + fsubsctp if year >= 2008


*2008 change to include suckler cow & protein payments
gen     rdirpaym = cosubsid + sosubsid + posubsid + fgrntsub + fsubhors + fsubtbco + fsubforh + dogpcomp + fsubastp + fsubcatp + fsubrptp + fsubpbtp + fsublitp +fsubmztp + fsubvstp + dqcomlrd + fsubsctp if year >= 2008

*2005 change to include slaughter prem but exclude dairy support payments as already included in sfp
replace rdirpaym = cosubsid + sosubsid + posubsid + fgrntsub + fsubhors + fsubtbco + fsubforh + dogpcomp + fsubastp + fsubcatp + fsubrptp + fsubpbtp + fsublitp +fsubmztp + fsubvstp + dqcomlrd if year >= 2005 & year < 2008

* dosubsvl - as per below - this includes dairy slaughter prem + dairy support payment
*  2002- 2004
replace rdirpaym = cosubsid + sosubsid + posubsid + fgrntsub + fsubhors + fsubtbco + fsubforh + dogpcomp + fsubastp + fsubcatp + fsubrptp + fsubpbtp + fsublitp +fsubmztp + fsubvstp + dosubsvl if year >= 2002 & year < 2005

*2001
replace rdirpaym = cosubsid + sosubsid + posubsid + fgrntsub + fsubhors + fsubtbco + fsubforh + dogpcomp + fsubastp + fsubcatp + fsubrptp + fsubpbtp + fsublitp +fsubmztp + fsubvstp if year == 2001

*<2001
replace rdirpaym = cosubsid + sosubsid + posubsid + fgrntsub + fsubhors + fsubtbco + fsubforh + dogpcomp + fsubastp + fsubcatp + fsubrptp + fsubpbtp + fsublitp +fsubmztp + fsubvstp + dosubsvl if year < 2001


quietly gen marketgo = grossoutput - dirpayts
quietly gen marketffi = farmffi - dirpayts



tab system, gen(system)
tab region, gen(region)
tab year, gen(year)

capture generate soil1=0
replace soil1=1 if ffsolcod<300

capture generate soil2=0
replace soil2=1 if ffsolcod<500
replace soil2=0 if ffsolcod<300

capture generate soil3=0
replace soil3=1 if ffsolcod<700
replace soil3=0 if ffsolcod<500


capture gen isofffarmy = oojobhld==1 | oojobhld==2
capture gen isspofffarmy = oojobsps == 1 | oojobsps == 2
capture gen bothwork = isspofffarmy == 1 & isofffarmy == 1
capture gen teagasc = foadvfee > 0

capture gen age_holder10 = int(max(20,min(70,age_holder))/10)*10
tab age_holder10, gen(age_holder10_)
tab farmsize, gen(farmsize_)


*****************************************************
* Share of Margins
*****************************************************

gen dairypgo = fdairygo/fcplivgo
gen dairypgm = fdairygm/fcplivgm

gen catlepgo = fcatlego/fcplivgo
gen catlepgm = fcatlegm/fcplivgm

gen sheeppgm = fsheepgm/fcplivgm

gen othergm = fpigsgm + fpoultgm + fhorsegm + fothergm

gen cropspgm = fcropsgm/fcplivgm
gen otherpgm = othergm/fcplivgm

gen ncattle = cpavnocw + cpavnohc + cpavno06 + cpavno61 + cpavno12 + cpavno2p + cpavnobl

* exclude those that have left the survey by 1996

gen in1994 = year == 1994
gen in1995 = year == 1995
gen in1996 = year == 1996
sort farmcode year
by farmcode: egen isin1994 = max(in1994)
by farmcode: egen isin1995 = max(in1995)
by farmcode: egen isin1996 = max(in1996)

gen droporig = (isin1994 == 1 | isin1995 == 1) & isin1996 == 0
tabstat dairypgm catlepgm sheeppgm otherpgm cropspgm ncattle cpavnocw cpavnohc cpavno06 -cpavno2p if fsizesu >= 2 & droporig == 0 & year == 2008 & fcplivgm > 0 [weight = wt], by(system) stats(mean)





tabstat farmcode year cptotcno cpavnocw cpavnohc cpavno06 cpavno61 cpavno12 cpavno2p cpavn12m cpavn12f cpavn2pm cpavn2pf cpavnobl cpdthcow cpdthclf cpdthbir cpdthc6m cpopinvc cpclinvc cpopinvb cpclinvb cpopinvt cpclinvt cosalesv copurval cotftdvl cotffdvl cotftdno cotffdno copurcno cosalcno coprcfno coslcfno coprwnno coslwnno coprstno coslstno coprmsno coprfsno coslmsno coslfsno coslfcno coslmfno coslffno coslffno coprbhno coslbhno coprocno coslocno coocidno [weight=wt] if ncattle > 0 & fsizesu >= 2 & droporig == 0, by (year) stats(mean)

local cattle_vlist = "cptotcno cpavnocw cpavnohc cpavno06 cpavno61 cpavno12 cpavno2p cpavn12m cpavn12f cpavn2pm cpavn2pf cpavnobl cpdthcow cpdthclf cpdthbir cpdthc6m cpopinvc cpclinvc cpopinvb cpclinvb cpopinvt cpclinvt cosalesv copurval cotftdvl cotffdvl cotftdno "
local cattle1_vlist = "cotffdno copurcno cosalcno coprcfno coslcfno coprwnno coslwnno coprstno coslstno coprmsno coprfsno coslmsno coslfsno coslfcno coslmfno coslffno coprbhno coslbhno coprocno coslocno coocidno"


sort year farmcode
foreach var in `cattle_vlist' {

	gen `var'_wt = wt*`var'
	by year: egen `var'_t = sum(`var'_wt)	
	drop `var'_wt
}
foreach var in `cattle1_vlist' {

	gen `var'_wt = wt*`var'
	by year: egen `var'_t = sum(`var'_wt)	
	drop `var'_wt
}

tabstat farmcode year *_t if ncattle > 0 & fsizesu >= 2 & droporig == 0, by (year) stats(mean)





*****************************************************
*****************************************************
* Thesis Tables
*****************************************************
*****************************************************

*****************************************************
* Production related fixed costs
*****************************************************

gen new_fc = fdnotalt + forntcon + focarelp + fohirlab + fointpay + fomacdpr + fomacopt + foblddpr + fobldmnt + fodprlim + foupkpld + foannuit + fortfmer + fomiscel
gen prod_fc = forntcon + focarelp + fohirlab
gen oth_fc = fdnotalt + fointpay + fomacdpr + fomacopt + foblddpr + fobldmnt + fodprlim + foupkpld + foannuit + fortfmer + fomiscel


tabstat farmcode year cptotcno cpavnocw cpavnohc cpavno06 cpavno61 cpavno12 cpavno2p cpavn12m cpavn12f cpavn2pm cpavn2pf cpavnobl cpdthcow cpdthclf cpdthbir cpdthc6m cpopinvc cpclinvc cpopinvb cpclinvb cpopinvt cpclinvt cosalesv copurval cotftdvl cotffdvl cotftdno cotffdno copurcno cosalcno coprcfno coslcfno coprwnno coslwnno coprstno coslstno coprmsno coprfsno coslmsno coslfsno coslfcno coslmfno coslffno coslffno coprbhno coslbhno coprocno coslocno coocidno [weight=wt] if ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3), by (year) stats(mean)



*****************************************************
* System Selection
*****************************************************

tabstat coprcfno coslcfno coprwnno coslwnno coprstno coslstno coslfcno coprbhno coslbhno coprocno coslocno  cotftdno cotffdno cpavno06 -cpavno2p if ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & year == 2008  [weight = wt], by(cpagecat) stats(mean)
tab cpagecat cpseaprd if fsizesu >= 2 & droporig == 0 & year == 2008 
tab cpagecat cptyrear if fsizesu >= 2 & droporig == 0 & year == 2008 
tab cpagecat region if fsizesu >= 2 & droporig == 0 & year == 2008 [iweight = wt]
tab cpagecat if fsizesu >= 2 & droporig == 0 & year == 2008 [weight = wt],sum( fsizuaa)

tab cptyrear, gen(cptyrear)
tab cpseaprd, gen(cpseaprd)
gen gmperha = fcatlegm/cpforacs
gen is65 = age_holder >= 65

tabstat region1-region8 cptyrear2-cptyrear5 cpseaprd2-cpseaprd4 gmperha fsizuaa fulltime isofffarmy isspofffarmy teagasc age_holder is65 dpcfb* if year == 2008 & ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0 [weight = wt], by(cpagecat) stats(mean)


*****************************************************
* Basic Income and Subsidies
*****************************************************


local subsidy_vlist = " lfa cssuckcw cs10mtbf cs22mtbf csslaugh csextens csheadag csmctopu fsubchen sfp suckler_welfare fgrntsub_resid fsubesag fsubyfig fsubreps dirpayts"
local subsidy1_vlist = " sfp dirpayts"

ineqdeco   familyfarmincome [weight = wt], by (year)
ineqdeco   familyfarmincome [weight = wt] if fulltime == 1, by (year)

gen wt_ha = wt*fsizuaa
gen wt_lu = wt*cpnolu

sort year
by year: egen twt_nfarms1 = sum(wt) if ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0
by year: egen twt_nfarms2 = sum(wt) if fsizesu >= 2 & droporig == 0 
gen pers = (oanolt5y + oano515y + oano1619 + oano2024 + oano2544 + oano4564 + oanoge65)
gen wt_pers = wt*(oanolt5y + oano515y + oano1619 + oano2024 + oano2544 + oano4564 + oanoge65)
gen adult = (oano2024 + oano2544 + oano4564 + oanoge65)
gen wt_adult = wt*(oano2024 + oano2544 + oano4564 + oanoge65)
by year: egen twt_pers1 = sum(wt_pers) if ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0
by year: egen twt_pers2 = sum(wt_pers) if fsizesu >= 2 & droporig == 0 
by year: egen twt_adult1 = sum(wt_adult) if ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0 
by year: egen twt_adult2 = sum(wt_adult) if fsizesu >= 2 & droporig == 0 
by year: egen twt_ha1 = sum(wt_ha) if ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0
by year: egen twt_ha2 = sum(wt_ha) if fsizesu >= 2 & droporig == 0 

by year: egen twt_lu1 = sum(wt_lu) if ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0
by year: egen twt_lu2 = sum(wt_lu) if fsizesu >= 2 & droporig == 0 

sort year region
by year region: egen rtwt_ha1 = sum(wt_ha) if ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0
by year region: egen rtwt_ha2 = sum(wt_ha) if fsizesu >= 2 & droporig == 0 


capture log close
log using `outdatadir'\Results.log, replace 
gen familyfarmincome_pc = familyfarmincome/pers

foreach var in `subsidy1_vlist' {

	gen ffi_`var' = familyfarmincome - `var'
	gen wtffi_`var' = (familyfarmincome - `var')*wt
	gen wt_`var' = (`var')*wt
	sort year
	by year: egen twt_`var'1 = sum(wt_`var') if ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0
	by year: egen twt_`var'2 = sum(wt_`var') if fsizesu >= 2 & droporig == 0 

	sort year region
	by year region: egen rtwt_`var'1 = sum(wt_`var') if ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0
	by year region: egen rtwt_`var'2 = sum(wt_`var') if fsizesu >= 2 & droporig == 0 

	* BI per Farm
	gen pf1_`var' = twt_`var'1/twt_nfarms1
	gen bi_pf1_`var' = twt_`var'1/twt_nfarms1
	gen bi_pf2_`var' = twt_`var'2/twt_nfarms2

	* BI per Person
	gen pp1_`var' = `var'/pers
	gen bi_pp1_`var' = twt_`var'1*pers/twt_pers1
	gen bi_pp2_`var' = twt_`var'2*pers/twt_pers2

	* BI per Adult
	gen pa1_`var' = `var'/adult
	gen bi_pa1_`var' = twt_`var'1*adult/twt_adult1
	gen bi_pa2_`var' = twt_`var'2*adult/twt_adult2

	*BI per Hectare
	gen pha1_`var' = `var'/fsizuaa
	gen bi_pha1_`var' = twt_`var'1*fsizuaa/twt_ha1
	gen bi_pha2_`var' = twt_`var'2*fsizuaa/twt_ha2

	*BI per Hectare (Region)
	gen bi_prha1_`var' = rtwt_`var'1*fsizuaa/rtwt_ha1
	gen bi_prha2_`var' = rtwt_`var'2*fsizuaa/rtwt_ha2

	*BI per LU
	gen plu1_`var' = `var'/cpnolu
	gen bi_plu1_`var' = twt_`var'1*cpnolu/twt_lu1
	gen bi_plu2_`var' = twt_`var'2*cpnolu/twt_lu2

	tabstat  `var' pf1_`var' - bi_plu2_`var' if year == 2008 & ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0 [weight = wt], by(cpagecat) stats(mean)
	tabstat  `var' pf1_`var' - bi_plu2_`var' if year == 2008 & ncattle > 0 & fsizesu >= 2 & droporig == 0 [weight = wt], by(system) stats(mean)


	* Distributional Impact of Payment
	* BI per Farm	
	gen bbi_pf1_`var' = familyfarmincome - `var' + bi_pf1_`var' 
	gen bbi_pf2_`var' = familyfarmincome - `var' + bi_pf2_`var' 

	* BI per Person
	gen bbi_pp1_`var' = familyfarmincome - `var' + bi_pp1_`var' 
	gen bbi_pp2_`var' = familyfarmincome - `var' + bi_pp2_`var' 

	* BI per Adult
	gen bbi_pa1_`var' = familyfarmincome - `var' + bi_pa1_`var' 
	gen bbi_pa2_`var' = familyfarmincome - `var' + bi_pa2_`var' 

	*BI per Hectare
	gen bbi_ha1_`var' = familyfarmincome - `var' + bi_pha1_`var' 
	gen bbi_ha2_`var' = familyfarmincome - `var' + bi_pha2_`var' 

	*BI per Hectare (Region)
	gen bbi_rha1_`var' = familyfarmincome - `var' + bi_prha1_`var' 
	gen bbi_rha2_`var' = familyfarmincome - `var' + bi_prha2_`var' 

	*BI per LU
	gen bbi_lu1_`var' = familyfarmincome - `var' + bi_plu1_`var' 
	gen bbi_lu2_`var' = familyfarmincome - `var' + bi_plu2_`var' 

}



*****************************************************
* Incentives
*****************************************************

* Farms can increase their stock through increasing births, or purchasing
* try a 10% increase in each
* can we identify the average duration of each component? 

* Relate GO to change in stock, sales and purchases

gen newcgo = cosalesv - copurval + covalcno + cosubsid - cotffdvl + cotftdvl

** Now decompose purchases and sales

* sales
gen newcosalesv = coslcfvl + coslwnvl +  coslstvl + coslfcvl + coslbhvl + coslocvl + coserrec
gen homecons = cosalesv - newcosalesv

* purchases

gen newcopurval = coprcfvl + coprwnvl + coprstvl  + coprbhvl + coprocvl

* to test incentives, do it on a per system basis
* Assume the cow is on the farm for the full length of the system
* Generate the costs and subsidy 


* Generate Purchase and Sales Prices

local price_vlist =  "coslcf coslwn coslst coslfc coslbh cosloc coprcf coprwn coprst  coprbh coproc"

foreach var in `price_vlist' {

	gen `var'_p = `var'vl/`var'no
}



* Compare enterprise direct costs with total direct costs

tabstat prod_fc oth_fc farmdc fdpurcon fdpurblk fdferfil fdcrppro fdpursed fdmachir fdtrans fdaifees fdvetmed fdcaslab fdmqleas fdmiscel fcatledc cdconcen cdpastur cdwinfor cdmilsub cdtotfed cdmiscdc cdtotldc if ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0 [weight = wt], by(year) stats(mean)

gen new_cdc = cdconcen + cdpastur + cdwinfor + cdmilsub + cdmiscdc 


* DC Fixed and Variable-Fixed Costs
gen nonc_dc = farmdc - cdtotldc
gen tot_cost = prod_fc + oth_fc + nonc_dc + cdtotldc

* Gross Output

tabstat prod_fc oth_fc farmdc nonc_dc cdtotldc cosalesv copurval covalcno  cotffdvl cotftdvl cosubsid if ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0 	, by(year) stats(mean)


*****************************************************************************
* Incentives
*****************************************************************************

* trends in Cattle Numbers
tab year if ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0 [weight = wt], sum(cptotcno)
*Quintiles of Margins (Gross Enterprise and Gross Farm)

gen mkt_ecgm_ha = (fcatlegm - cosubsid)/fsizuaa
gen mkt_fcgm_ha = (farmgm  - dirpayts)/fsizuaa
gen mkt_fcgm1_ha = (farmgm  - dirpayts - prod_fc)/fsizuaa
gen marketffi_ha = marketffi/fsizuaa

gen marketgo_ha = marketgo/fsizuaa
gen dirpayts_ha = dirpayts/fsizuaa
gen prod_fc_ha  = prod_fc/fsizuaa
gen oth_fc_ha  = oth_fc/fsizuaa
gen farmdc_ha = farmdc/fsizuaa


gen mkt_ecgm_lu = (fcatlegm - cosubsid)/fnocatlu
gen mkt_fcgm_lu = (farmgm  - dirpayts)/fnocatlu
gen mkt_fcgm1_lu = (farmgm  - dirpayts - prod_fc)/fnocatlu
gen marketffi_lu = marketffi/fnocatlu

gen marketgo_lu = marketgo/fnocatlu
gen dirpayts_lu = dirpayts/fnocatlu
gen prod_fc_lu  = prod_fc/fnocatlu
gen oth_fc_lu  = oth_fc/fnocatlu
gen farmdc_lu = farmdc/fnocatlu

gen mkt_fcgm1_q = .
local i = 1994

while `i' <= 2009 {

	xtile mkt_ecgm_q`i' = mkt_ecgm_ha if year == `i' & ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0, nq(5)
	xtile mkt_fcgm_q`i' = mkt_fcgm_ha if year == `i' & ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0, nq(5)
	xtile mkt_fcgm1_q`i' = mkt_fcgm1_ha if year == `i' & ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0, nq(5)
	xtile marketffi_q`i'= marketffi_ha if year == `i' & ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0, nq(5)
	xtile marketffi_lu_q`i'= marketffi_lu if year == `i' & ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0, nq(5)

	xtile mkt_tillage_fcgm1_q`i' = mkt_fcgm1_ha if year == `i' & fsizesu >= 2 & droporig == 0 & (system == 5), nq(5)
	replace mkt_fcgm1_q = mkt_fcgm1_q`i' if year == `i' & ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0
	local i = `i' + 1
}

tabstat  mkt_ecgm_ha mkt_fcgm_ha mkt_fcgm1_ha marketffi_ha dirpayts_ha marketgo_ha farmdc_ha prod_fc_ha oth_fc_ha is65 isofffarmy if ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0 [weight = wt], by( marketffi_q2008) stats(mean)

tabstat  mkt_ecgm_lu mkt_fcgm_lu mkt_fcgm1_lu marketffi_lu dirpayts_lu marketgo_lu farmdc_lu prod_fc_lu oth_fc_lu is65 isofffarmy if ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0 [weight = wt], by( marketffi_lu_q2008) stats(mean)

tabstat  mkt_ecgm_lu mkt_fcgm_lu mkt_fcgm1_lu marketffi_lu dirpayts_lu marketgo_lu farmdc_lu prod_fc_lu oth_fc_lu isofffarmy if ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0 & year == 2008 [weight = wt], by(cpagecat) stats(mean)
	

* Supplementary Statistics for BI paper	
gen gmperlu = fcatlegm/cpnolu
tabstat region1-region8 gmperha fsizuaa fulltime isofffarmy isspofffarmy teagasc age_holder is65 pers adult if year == 2008 & ncattle > 0 & fsizesu >= 2 & droporig == 0 [weight = wt], by(system) stats(mean)

tabstat spnolu cpnolu [weight=wt] if fsizesu >= 2 & droporig == 0 ,by(year) stats(sum)

tabstat cpavnocw cpavno06 cpavno61 cpavno12 cpavno2p [weight=wt] if (system >= 2 & system <=3) & ncattle > 0 & fsizesu >= 2 & droporig == 0 ,by(year) stats(sum)

gen cpavno012 =  cpavno06 + cpavno61
gen cpavn1224 = cpavno12 + cpavno2p

local cattle1_vlist = "cpavnocw cpavnohc cpavno06 cpavno61 cpavno12 cpavno2p cpavno012 cpavn1224"

gen tis2004 = year == 2004 & (ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0)
gen tis2009 = year == 2009 & (ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0)

*Exists in 2004 and 2009
sort farmcode
by farmcode: egen is2004 = max(tis2004)
by farmcode: egen is2009 = max(tis2009)

foreach var in `cattle1_vlist' {

	gen has_`var'_wt = `var' > 0
	gen t`var'_2004 = `var' if year == 2004
	gen t`var'_2009 = `var' if year == 2009
	replace t`var'_2004 = 0 if t`var'_2004 == .
	replace t`var'_2009 = 0 if t`var'_2009 == .
	sort farmcode
	by farmcode: egen `var'_2004 = max(t`var'_2004)
	by farmcode: egen `var'_2009 = max(t`var'_2009)
	gen `var'_d =  `var'_2009 - `var'_2004 if is2004 == 1 & is2009 == 1
	gen `var'_p =  `var'_d/`var'_2004
}

tabstat has_cpavnocw has_cpavno06 has_cpavno61 has_cpavno12 has_cpavno2p [weight=wt] if (system >= 2 & system <=3) & ncattle > 0 & fsizesu >= 2 & droporig == 0 ,by(year) stats(mean)

tabstat has_cpavnocw has_cpavno06 has_cpavno61 has_cpavno12 has_cpavno2p [weight=wt] if (system >= 2 & system <=3) & ncattle > 0 & fsizesu >= 2 & droporig == 0 ,by(year) stats(sum)

tab cpagecat year [iweight = wt] if (system >= 2 & system <=3) & ncattle > 0 & fsizesu >= 2 & droporig == 0  & year >= 2004 & cpagecat > 0 & cpagecat <= 6


* Percentile Changes


local i = 2004

* Quintile in 2004
gen tmarketffi_q`i' = marketffi_q`i'
replace tmarketffi_q`i' =0 if tmarketffi_q`i' == .
by farmcode: egen mtmarketffi_q`i' = max(tmarketffi_q`i')

* Number of Cattle in both years

tabstat  cpavnocw cpavnohc cpavno06 cpavno61 cpavno12 cpavno2p cpavnocw_d cpavnohc_d cpavno06_d cpavno61_d cpavno12_d cpavno2p_d if ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0 & year == 2004 [weight = wt], by(mtmarketffi_q2004) stats(mean)

tabstat  cpavnocw cpavnohc cpavno06 cpavno61 cpavno12 cpavno2p cpavnocw_d cpavnohc_d cpavno06_d cpavno61_d cpavno12_d cpavno2p_d if ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0 & year == 2004 [weight = wt], by(mkt_fcgm1_q2004) stats(mean)
tabstat  cpavnocw cpavnohc cpavno06 cpavno61 cpavno12 cpavno2p if ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0 & (is2004 == 0 | is2009 == 0) [weight = wt], by(year) stats(mean)

tab mtmarketffi_q2004 if ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0 & year == 2004 & is2004 == 1 & is2009 == 1


gen efficiency = farmdc_ha/marketgo_ha
foreach var in `cattle1_vlist' {

	regress `var'_p `var' mkt_ecgm_ha marketffi_ha dirpayts_ha efficiency prod_fc_ha oth_fc_ha is65 isofffarmy if ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0 & year == 2004 & `var'_p < 1 & is2004 == 1 & is2009 == 1  [weight = wt]

	tab mtmarketffi_q2004 if ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0 & year == 2004 & `var'_p < 1 & is2004 == 1 & is2009 == 1 [weight = wt], sum(`var'_p)
}


* Balanced
tabstat  cpavnocw cpavnohc cpavno06 cpavno61 cpavno12 cpavno2p if ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0 & (is2004 == 1 & is2009 == 1) & year >= 2004 [weight = wt], by(year) stats(mean)
tabstat  cpavnocw_p cpavnohc_p cpavno06_p cpavno61_p cpavno12_p cpavno2p_p if ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0 & (is2004 == 1 & is2009 == 1) & year >= 2004 & cpavnocw_p < 1 & cpavnohc_p < 1 & cpavno06_p < 1 & cpavno61_p < 1 & cpavno12_p < 1 & cpavno2p_p < 1 [weight = wt], by(year) stats(mean)

foreach var in `cattle1_vlist' {

	tab mtmarketffi_q2004 if ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0 & year == 2004 & is2004 == 1 & is2009 == 1 [weight = wt], sum(`var'_d)
	tab mtmarketffi_q2004 if ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0 & year == 2004 & is2004 == 1 & is2009 == 1 [weight = wt], sum(`var')


}
*Attrition and new entrants
tabstat  cpavnocw cpavnohc cpavno06 cpavno61 cpavno12 cpavno2p if ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0 & (is2004 == 0 | is2009 == 0) & year >= 2004 [weight = wt], by(year) stats(mean)


capture log close
log using `outdatadir'\BeefAnalysis.log, replace 

*****************************************************
*****************************************************
* RERC Beef Analysis Tables
*****************************************************
*****************************************************

*Table 1

tab cpagecat [iweight=wt] if ncattle > 0 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 & year == 1996
tab cpagecat [iweight=wt] if ncattle > 0 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 & year == 2008 
tabstat dpavnohd  cptotcno-cpavno2p cpavnobl  if ncattle > 0 & year == 2008 & fsizesu >= 2 & droporig == 0 [weight = wt], by(system) stats(mean)


*Table 2

tab cpagecat system [iweight=wt] if ncattle > 0 & fsizesu >= 2 & droporig == 0 & year == 2008 & cpagecat > 0

tab year cpagecat  [iweight=wt] if ncattle > 0 & fsizesu >= 2 & droporig == 0 & cpagecat > 0

tabstat dpavnohd  cptotcno-cpavno2p cpavnobl  if ncattle > 0 & year == 2008 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 [weight = wt], by(cpagecat) stats(sum)
tabstat dpavnohd  cptotcno-cpavno2p cpavnobl  if (system >= 2 & system <=3) & ncattle > 0 & year == 2008 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 [weight = wt], by(cpagecat) stats(sum)
tabstat  region1-region8 gmperha fsizuaa fulltime isofffarmy teagasc age_holder is65 dpcfb*  if ncattle > 0 & year == 2008 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 [weight = wt], by(cpagecat) stats(mean)

* Technical
* Mainly Summer Production    1
* Mainly Winter               2
* Both Summer and w           3


tab year cpseaprd [iweight=wt] if ncattle > 0 & fsizesu >= 2 & droporig == 0 & cpagecat > 0
tab cpagecat cpseaprd [iweight=wt] if ncattle > 0 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 & year == 2008
tab cpseaprd region [iweight=wt] if ncattle > 0 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 & year == 2008
tabstat  dpcfb*  if ncattle > 0 & year == 2008 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 [weight = wt], by(cpseaprd) stats(mean)


*Output

gen co_netdy = cotftdvl - cotffdvl
local co_out_vlist = "cosalesv copurval cosubsid covalcno co_netdy"
foreach var in  `co_out_vlist' {
	gen `var'_oha = `var'/cpforacs
	gen `var'_olu = `var'/fnocatlu
}

tabstat  co*_oha  if ncattle > 0 & year == 2008 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 [weight = wt], by(cpagecat) stats(mean)
tabstat  co*_olu  if ncattle > 0 & year == 2008 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 [weight = wt], by(cpagecat) stats(mean)

tabstat  co*_oha  if ncattle > 0 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 [weight = wt], by(year) stats(mean)
tabstat  co*_olu  if ncattle > 0 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 [weight = wt], by(year) stats(mean)


** Gross Margin

* Correct for different definition pre 2000
replace cdgrsmar = cogrosso - cdtotldc

gen cogm_nosub = cdgrsmar - cosubsid
gen cogo_nosub = cogrosso - cosubsid
gen co_stock = fnocatlu/cpforacs

local co_gm_vlist = "cdgrsmar cogm_nosub cosubsid cogrosso cogo_nosub cdtotldc"
foreach var in  `co_gm_vlist' {
	gen `var'_mha = `var'/cpforacs
	gen `var'_mlu = `var'/fnocatlu
}
tabstat  *_mha cpforacs fnocatlu co_stock if ncattle > 0 & year == 2008 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 [weight = wt], by(cpagecat) stats(mean)
tabstat  *_mlu cpforacs fnocatlu co_stock if ncattle > 0 & year == 2008 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 [weight = wt], by(cpagecat) stats(mean)

tabstat  *_mha  cpforacs fnocatlu co_stock if ncattle > 0 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 [weight = wt], by(year) stats(mean)
tabstat  *_mlu  cpforacs fnocatlu co_stock if ncattle > 0 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 [weight = wt], by(year) stats(mean)


* Inputs
gen co_othmiscdc = cdmiscdc - ivmallc - iaisfcat - itecattl - imiscctl - flabccct

local co_inp_vlist = "cdconcen cdpastur cdwinfor cdmilsub ivmallc iaisfcat itecattl imiscctl flabccct co_othmiscdc cdtotldc"
foreach var in  `co_inp_vlist' {
	gen `var'_iha = `var'/cpforacs
	gen `var'_ilu = `var'/fnocatlu
}

* table 7
tabstat  *_iha  if ncattle > 0 & year == 2008 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 [weight = wt], by(cpagecat) stats(mean)
tabstat  *_ilu  if ncattle > 0 & year == 2008 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 [weight = wt], by(cpagecat) stats(mean)

tabstat  *_iha  if ncattle > 0 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 [weight = wt], by(year) stats(mean)
tabstat  *_ilu  if ncattle > 0 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 [weight = wt], by(year) stats(mean)

* Distributional Analysis - GM

gen cogm_nosub_mha_q = .
local i = 1994
while `i' <= 2009 {

	xtile cogm_nosub_mha_q`i' = cogm_nosub_mha if year == `i' & ncattle > 0 & fsizesu >= 2 & droporig == 0 & cpagecat != 0, nq(5)
	replace cogm_nosub_mha_q = cogm_nosub_mha_q`i' if year == `i' & ncattle > 0 & fsizesu >= 2 & droporig == 0 & cpagecat != 0
	local i = `i' + 1
}

* Table 8
tab year cogm_nosub_mha_q [weight = wt] if ncattle > 0 & fsizesu >= 2 & droporig == 0 & cpagecat != 0, sum(cogm_nosub_mha) nost nofreq noobs


gen cogm_nosub_mha_neg = cogm_nosub_mha < 0
tab year  [weight = wt] if ncattle > 0 & fsizesu >= 2 & droporig == 0 & cpagecat != 0, sum(cogm_nosub_mha_neg) 

tabstat  *_mha  cpforacs fnocatlu co_stock if ncattle > 0 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 & cogm_nosub_mha_neg == 1 [weight = wt], by(year) stats(mean)
tabstat  *_mha  cpforacs fnocatlu co_stock if ncattle > 0 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 & cogm_nosub_mha_neg == 0 [weight = wt], by(year) stats(mean)


* table 9
tab  cpagecat cogm_nosub_mha_q2008 if year == 2008 & ncattle > 0 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 [iweight = wt]

* table 10
sort cogm_nosub_mha_q
by cogm_nosub_mha_q: tabstat  *_mha  cpforacs fnocatlu co_stock if ncattle > 0 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 [weight = wt], by(year) stats(mean)
by cogm_nosub_mha_q: tabstat  *_mlu  cpforacs fnocatlu co_stock if ncattle > 0 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 [weight = wt], by(year) stats(mean)
by cogm_nosub_mha_q: tabstat  cogm_nosub_mlu cogo_nosub_mlu cdtotldc_mlu cdconcen_ilu cdpastur_ilu cdwinfor_ilu cdmilsub_ilu ivmallc_ilu iaisfcat_ilu itecattl_ilu if ncattle > 0 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 [weight = wt], by(year) stats(mean)
by cogm_nosub_mha_q: tab year cpagecat if ncattle > 0 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 [iweight = wt]


* Off-farm employment
tab year cogm_nosub_mha_q [weight = wt] if ncattle > 0 & fsizesu >= 2 & droporig == 0 & cpagecat != 0, sum(isofffarmy) nost nofreq noobs

* Net Margins Analysis

tabstat  ffiperhectare marketffi_ha mkt_fcgm_ha prod_fc_ha oth_fc_ha farmdc_ha mkt_fcgm1_ha  dirpayts_ha isofffarmy is65 if (system >= 2 & system <=3) & ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0 [weight = wt], by(year) stats(mean)


*Table 8
tabstat  ffiperhectare marketffi_ha mkt_fcgm_ha prod_fc_ha oth_fc_ha  farmdc_ha mkt_fcgm1_ha  dirpayts_ha isofffarmy is65 if (system >= 2 & system <=3) & ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0 [weight = wt], by(mkt_fcgm1_q2008) stats(mean)
tabstat  ffiperhectare marketffi_ha mkt_fcgm_ha prod_fc_ha oth_fc_ha  farmdc_ha mkt_fcgm1_ha  dirpayts_ha isofffarmy is65 if (system >= 2 & system <=3) & ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0 [weight = wt], by(mkt_fcgm1_q2004) stats(mean)


* Cost Structure
tabstat  ffiperhectare marketffi_ha mkt_fcgm_ha prod_fc_ha oth_fc_ha  farmdc_ha mkt_fcgm1_ha  dirpayts_ha isofffarmy is65 if (system >= 2 & system <=3) & ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0 & mkt_fcgm1_q == 1 [weight = wt], by(year) stats(mean)
tabstat  ffiperhectare marketffi_ha mkt_fcgm_ha prod_fc_ha oth_fc_ha  farmdc_ha mkt_fcgm1_ha  dirpayts_ha isofffarmy is65 if (system >= 2 & system <=3) & ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0 & mkt_fcgm1_q == 5 [weight = wt], by(year) stats(mean)


* Incorporating Labour

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
scalar sc_agewage_2008 = 17339*1.02
scalar sc_agewage_2009 = 17339



gen ave_Wage = (sc_agewage_1996)*(year == 1996) + (sc_agewage_1997)*(year == 1997) + (sc_agewage_1998)*(year == 1998) + (sc_agewage_1999)*(year == 1999) + (sc_agewage_2000)*(year == 2000) + (sc_agewage_2001)*(year == 2001) + (sc_agewage_2002)*(year == 2002) + (sc_agewage_2003)*(year == 2003) + (sc_agewage_2004)*(year == 2004) + (sc_agewage_2005)*(year == 2005) + (sc_agewage_2006)*(year == 2006) + (sc_agewage_2007)*(year == 2007) + (sc_agewage_2008)*(year == 2008) + (sc_agewage_2009)*(year == 2009)
gen wage_cost = flabunpd*ave_Wage

gen wage_cost2_ha = wage_cost/fsizuaa
gen wage_cost3_ha = (ave_Wage*flabsmds/(48*5))/fsizuaa

gen farmgo_ha = farmgo/fsizuaa
capture gen farmdc_ha = farmdc/fsizuaa

tab cpagecat if cpagecat > 0, gen(cpagecat)

gen mkt_fcgm2_ha = mkt_fcgm1_ha - wage_cost2_ha
gen mkt_fcgm3_ha = mkt_fcgm1_ha - wage_cost3_ha
gen marketffi3_ha = marketffi_ha - wage_cost3_ha
gen ffi3_ha = ffiperhectare - wage_cost3_ha
* Table 14
tabstat  mkt_fcgm1_ha  mkt_fcgm3_ha marketffi3_ha wage_cost3_ha  if (system >= 2 & system <=3) & ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0 & year == 2008 [weight = wt], by(mkt_fcgm1_q) stats(mean)

gen pos_marketffi3_ha = marketffi3_ha > 0 & marketffi3_ha != .
gen pos_mkt_fcgm1_ha = mkt_fcgm1_ha > 0 & mkt_fcgm1_ha != .
* Table 15
tabstat  isofffarmy is65 flabunpd fnocatlu co_stock fsizuaa region1-region8 if (system >= 2 & system <=3) & ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0 & year == 2008 [weight = wt], by(mkt_fcgm1_q) stats(mean)

* other variables
tabstat pos_marketffi3_ha pos_mkt_fcgm1_ha 
*Table 9
local cattle1_vlist = "cpavnocw cpavno06 cpavno61 cpavno12 cpavno2p"
foreach var in `cattle1_vlist' {

	tab mtmarketffi_q2004 if ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0 & year == 2004 & is2004 == 1 & is2009 == 1 [weight = wt], sum(`var'_d)
	tab mtmarketffi_q2004 if ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0 & year == 2004 & is2004 == 1 & is2009 == 1 [weight = wt], sum(`var')


}


local cattle1_vlist = "cpavno012 cpavn1224"
foreach var in `cattle1_vlist' {

	tab mtmarketffi_q2004 if ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0 & year == 2004 & is2004 == 1 & is2009 == 1 [weight = wt], sum(`var'_d)
	tab mtmarketffi_q2004 if ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0 & year == 2004 & is2004 == 1 & is2009 == 1 [weight = wt], sum(`var')


}


