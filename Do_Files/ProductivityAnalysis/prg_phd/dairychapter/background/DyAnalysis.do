
 
*****************************************************
*****************************************************
* RERC Dairy Analysis Tables
*
*
* Patrick R. Gillespie - 20/07/2011
* To be run by pg-DyAnalysis.do (not interactively)
*****************************************************
*****************************************************

capture log close
capture cmdlog close

log using dyanalysis, replace
cmdlog using dyanalysis, replace




*************************************************************************
* Herd structure
*************************************************************************
*Table 1 
*cpagecat = Age of buying/selling 
tab cpagecat [iweight=wt] if ncattle > 0 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 & year == 1996

tab cpagecat [iweight=wt] if ncattle > 0 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 & year == 2008 


*dpavnohd = Dairy herd size
*cptotcno = Total cattle numbers	
*cpavnocw = Cows (avg no)	
*cpavnohc = Hfr-in-calf (avg no.)	
*cpavno06 = Calves < 6 mths (avg no)	
*cpavno61 = 6 - 12 months cattle (avg no)
*cpavno12 = Cattle 1-2y.o. (avg no)
*cpavno2 = Cattle > 2 y.o. (avg no)
*cpavnobl = Beef stock bulls (avg no)
tabstat dpavnohd  cptotcno-cpavno2p cpavnobl  if ncattle > 0 & year == 2008 & fsizesu >= 2 & droporig == 0 [weight = wt], by(system) stats(mean)

*Table 2
tab cpagecat system [iweight=wt] if ncattle > 0 & fsizesu >= 2 & droporig == 0 & year == 2008 & cpagecat > 0


*cpagecat = Age of buying/selling
tab year cpagecat  [iweight=wt] if ncattle > 0 & fsizesu >= 2 & droporig == 0 & cpagecat > 0

*dpavnohd = Herd size
*cptotcno = Total cattle numbers	
*cpavnocw = Cows (avg no)	
*cpavnohc = Hfr-in-calf (avg no.)	
*cpavno06 = Calves < 6 mths (avg no)	
*cpavno61 = 6 - 12 months cattle (avg no)
*cpavno12 = Cattle 1-2y.o. (avg no)
*cpavno2p = Cattle > 2 y.o. (avg no)
*cpavnobl = Beef stock bulls (avg no)
*cpagecat = Age of buying/selling
tabstat dpavnohd  cptotcno-cpavno2p cpavnobl  if ncattle > 0 & year == 2008 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 [weight = wt], by(cpagecat) stats(sum)

*dpavnohd = Herd size
*cptotcno = Total cattle numbers	
*cpavnocw = Cows (avg no)	
*cpavnohc = Hfr-in-calf (avg no.)	
*cpavno06 = Calves < 6 mths (avg no)	
*cpavno61 = 6 - 12 months cattle (avg no)
*cpavno12 = Cattle 1-2y.o. (avg no)
*cpavno2p = Cattle > 2 y.o. (avg no)
*cpavnobl = Beef stock bulls (avg no)
*cpagecat = Age of buying/selling
tabstat dpavnohd  cptotcno-cpavno2p cpavnobl  if (system >= 2 & system <=3) & ncattle > 0 & year == 2008 & fsizesu >= 2 & droporig == 0 & cpagecat >0 [weight = wt], by(cpagecat) stats(sum)

*cpagecat = Age of buying/selling
*fsizuaa = Size of farm (U.A.A.)    (ha.)
*dpcfbjan = Jan .  Calf births
*dpcfbfeb = Feb    Calf births
*dpcfbmar = Mar    Calf births
*dpcfbapr = Apr    Calf births
*dpcfbmay = May    Calf births
*dpcfbjun = Jun.   Calf births
*dpcfbjul = July   Calf births
*dpcfbaug = Aug.   Calf births
*dpcfbsep = Sept   Calf births
*dpcfboct = Oct.   Calf births
*dpcfbnov = Nov.   Calf births
*dpcfbdec = Dec.   Calf births
*dpcfbtot = Total  Calf births
tabstat  region1-region8 gmperha fsizuaa fulltime isofffarmy teagasc age_holder is65 dpcfb*  if ncattle > 0 & year == 2008 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 [weight = wt], by(cpagecat) stats(mean)
 
* Technical
* Mainly Summer Production    1
* Mainly Winter               2
* Both Summer and w           3
 
*cpseaprd = Seasonality of production 
tab year cpseaprd [iweight=wt] if ncattle > 0 & fsizesu >= 2 & droporig == 0 & cpagecat > 0

*cpagecat = Age of buying/selling
*cpseaprd = Seasonality of production

tab cpagecat cpseaprd [iweight=wt] if ncattle > 0 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 & year == 2008

*cpseaprd = Seasonality of production
tab cpseaprd region [iweight=wt] if ncattle > 0 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 & year == 2008

*cpseaprd = Seasonality of production
*dpcfbjan = Jan .  Calf births
*dpcfbfeb = Feb    Calf births
*dpcfbmar = Mar    Calf births
*dpcfbapr = Apr    Calf births
*dpcfbmay = May    Calf births
*dpcfbjun = Jun.   Calf births
*dpcfbjul = July   Calf births
*dpcfbaug = Aug.   Calf births
*dpcfbsep = Sept   Calf births
*dpcfboct = Oct.   Calf births
*dpcfbnov = Nov.   Calf births
*dpcfbdec = Dec.   Calf births
*dpcfbtot = Total  Calf births
tabstat  dpcfb*  if ncattle > 0 & year == 2008 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 [weight = wt], by(cpseaprd) stats(mean)




*************************************************************************
*Output
*************************************************************************


*Already defined by pg-DyAnalysis.do
*gen co_netdy = cotftdvl - cotffdvl 
*local co_out_vlist = "cosalesv copurval cosubsid covalcno co_netdy"
*foreach var in  `co_out_vlist' {
*          gen `var'_oha = `var'/cpforacs
*          gen `var'_olu = `var'/fnocatlu
* }

*cpagecat = Age of buying/selling
*cosalesv = Sales (incl hse. consumpti
*copurval = Purchases
*cosubsid = Subsidies
*covalc~a = 
*co_net~a = 
tabstat  co*_oha  if ncattle > 0 & year == 2008 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 [weight = wt], by(cpagecat) stats(mean)

*cpagecat = Age of buying/selling
*cosalesv = Sales (incl hse. consumpti
*copurval = Purchases
*cosubsid = Subsidies
*covalc~u = 
*co_net~u = 
tabstat  co*_olu  if ncattle > 0 & year == 2008 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 [weight = wt], by(cpagecat) stats(mean)

*cosalesv = Sales (incl hse. consumpti
*copurval = Purchases
*cosubsid = Subsidies
*covalc~a = 
*co_net~a = 
tabstat  co*_oha  if ncattle > 0 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 [weight = wt], by(year) stats(mean)

*cpagecat = Age of buying/selling
*cosalesv = Sales (incl hse. consumpti
*copurval = Purchases
*cosubsid = Subsidies
*covalc~u = 
*co_net~u = 
tabstat  co*_olu  if ncattle > 0 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 [weight = wt], by(year) stats(mean)




*************************************************************************
** Gross Margin
*************************************************************************

* Correct for different definition pre 2000
replace cdgrsmar = cogrosso - cdtotldc

*gen cogm_nosub = cdgrsmar - cosubsid

*gen cogo_nosub = cogrosso - cosubsid

*gen co_stock = fnocatlu/cpforacs
 
*local co_gm_vlist = "cdgrsmar cogm_nosub cosubsid cogrosso cogo_nosub cdtotldc"

*foreach var in  `co_gm_vlist' {
*         gen `var'_mha = `var'/cpforacs
*         gen `var'_mlu = `var'/fnocatlu
* }




******************************
* Tables
* cdgrsmar = Gross margin = = cogrosso - cdtotldc (see adjustments above)
******************************


* tabstat for 2008
******************
tabstat  *_mha cpforacs fnocatlu co_stock if ncattle > 0 & year == 2008 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 [weight = wt], by(cpagecat) stats(mean)

tabstat  *_mlu cpforacs fnocatlu co_stock if ncattle > 0 & year == 2008 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 [weight = wt], by(cpagecat) stats(mean)


* tabstat over all years
************************
tabstat  *_mha  cpforacs fnocatlu co_stock if ncattle > 0 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 [weight = wt], by(year) stats(mean)

tabstat  *_mlu  cpforacs fnocatlu co_stock if ncattle > 0 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 [weight = wt], by(year) stats(mean)




*************************************************************************
* Inputs
*************************************************************************


*gen co_othmiscdc = cdmiscdc - ivmallc - iaisfcat - itecattl - imiscctl - flabccct

*local co_inp_vlist = "cdconcen cdpastur cdwinfor cdmilsub ivmallc iaisfcat itecattl imiscctl flabccct co_othmiscdc cdtotldc"

*foreach var in  `co_inp_vlist' {
*         gen `var'_iha = `var'/cpforacs
*         gen `var'_ilu = `var'/fnocatlu
* }


* table 7
******************
tabstat  *_iha  if ncattle > 0 & year == 2008 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 [weight = wt], by(cpagecat) stats(mean)

tabstat  *_ilu  if ncattle > 0 & year == 2008 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 [weight = wt], by(cpagecat) stats(mean)

tabstat  *_iha  if ncattle > 0 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 [weight = wt], by(year) stats(mean)

tabstat  *_ilu  if ncattle > 0 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 [weight = wt], by(year) stats(mean)



*************************************************************************
* * Distributional Analysis - GM
*************************************************************************


*gen cogm_nosub_mha_q = .

*local i = 1994

*while `i' <= 2009 {
*         xtile cogm_nosub_mha_q`i' = cogm_nosub_mha if year == `i' & ncattle >0 & fsizesu >= 2 & droporig == 0 & cpagecat != 0, nq(5)
*         replace cogm_nosub_mha_q = cogm_nosub_mha_q`i' if year ==`i' & ncattle > 0 & fsizesu >= 2 & droporig == 0 & cpagecat != 0
*         local i = `i' + 1
* }


* Table 8
******************
tab year cogm_nosub_mha_q [weight = wt] if ncattle > 0 & fsizesu >= 2 & droporig == 0 & cpagecat != 0, sum(cogm_nosub_mha) nost nofreq noobs

*gen cogm_nosub_mha_neg = cogm_nosub_mha < 0

tab year  [weight = wt] if ncattle > 0 & fsizesu >= 2 & droporig == 0 & cpagecat != 0, sum(cogm_nosub_mha_neg) 

tabstat  *_mha  cpforacs fnocatlu co_stock if ncattle > 0 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 & cogm_nosub_mha_neg == 1 [weight = wt], by(year) stats(mean)


tabstat  *_mha  cpforacs fnocatlu co_stock if ncattle > 0 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 & cogm_nosub_mha_neg == 0 [weight = wt], by(year) stats(mean)


* table 9
******************
tab  cpagecat cogm_nosub_mha_q2008 if year == 2008 & ncattle > 0 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 [iweight = wt]


* table 10
******************
sort cogm_nosub_mha_q

by cogm_nosub_mha_q: tabstat  *_mha  cpforacs fnocatlu co_stock if ncattle > 0 & fsizesu >= 2 & droporig == 0 & cpagecat > 0 [weight = wt], by(year) stats(mean)

* Off-farm employment
tab year cogm_nosub_mha_q [weight = wt] if ncattle > 0 & fsizesu >= 2 & droporig == 0 & cpagecat != 0, sum(isofffarmy) nost nofreq noobs




*************************************************************************
* Net Margins Analysis
*************************************************************************


tabstat  ffiperhectare marketffi_ha mkt_fcgm_ha prod_fc_ha oth_fc_ha farmdc_ha mkt_fcgm1_ha  dirpayts_ha isofffarmy is65 if (system >= 2& system <=3) & ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0 [weight = wt], by(year) stats(mean)


*Table 8
******************
tabstat  ffiperhectare marketffi_ha mkt_fcgm_ha prod_fc_ha oth_fc_hafarmdc_ha mkt_fcgm1_ha  dirpayts_ha isofffarmy is65 if (system >= 2 & system <=3) & ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0 [weight = wt], by(mkt_fcgm1_q2008) stats(mean)


tabstat  ffiperhectare marketffi_ha mkt_fcgm_ha prod_fc_ha oth_fc_ha farmdc_ha mkt_fcgm1_ha  dirpayts_ha isofffarmy is65 if (system >= 2 & system <= 3) & ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0 [weight = wt], by(mkt_fcgm1_q2004) stats(mean)




*************************************************************************
* Cost Structure
*************************************************************************


tabstat  ffiperhectare marketffi_ha mkt_fcgm_ha prod_fc_ha oth_fc_ha farmdc_ha mkt_fcgm1_ha  dirpayts_ha isofffarmy is65 if (system >= 2 & system <=3) & ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0 & mkt_fcgm1_q == 1 [weight = wt], by(year) stats(mean)

tabstat  ffiperhectare marketffi_ha mkt_fcgm_ha prod_fc_ha oth_fc_ha
farmdc_ha mkt_fcgm1_ha  dirpayts_ha isofffarmy is65 if (system >= 2 & system <=3) & ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system ==3) & cpagecat != 0 & mkt_fcgm1_q == 5 [weight = wt], by(year) stats(mean)




*************************************************************************
* Incorporating Labour
*************************************************************************

 
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

*gen ave_Wage = (sc_agewage_1996)*(year == 1996) + (sc_agewage_1997)*
(year == 1997) + (sc_agewage_1998)*(year == 1998) + (sc_agewage_1999)*(year == 1999) + (sc_agewage_2000)*(year == 2000) + (sc_agewage_2001)*(year == 2001) + (sc_agewage_2002)*(year == 2002) + (sc_agewage_2003)*(year == 2003) + (sc_agewage_2004)*(year == 2004) + (sc_agewage_2005)*(year == 2005) + (sc_agewage_2006)*(year == 2006) + (sc_agewage_2007)*(year == 2007) + (sc_agewage_2008)*(year == 2008) + (sc_agewage_2009)*(year == 2009)

*gen wage_cost = flabunpd*ave_Wage
*gen wage_cost2_ha = wage_cost/fsizuaa
*gen wage_cost3_ha = (ave_Wage*flabsmds/(48*5))/fsizuaa
*gen farmgo_ha = farmgo/fsizuaa

*capture gen farmdc_ha = farmdc/fsizuaa

tab cpagecat if cpagecat > 0, gen(cpagecat)

*gen mkt_fcgm2_ha = mkt_fcgm1_ha - wage_cost2_ha
*gen mkt_fcgm3_ha = mkt_fcgm1_ha - wage_cost3_ha
*gen marketffi3_ha = marketffi_ha - wage_cost3_ha
*gen ffi3_ha = ffiperhectare - wage_cost3_ha


* Table 14
******************
tabstat  mkt_fcgm1_ha  mkt_fcgm3_ha marketffi3_ha wage_cost3_ha  if (system >= 2 & system <=3) & ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0 & year == 2008 [weight = wt], by(mkt_fcgm1_q) stats(mean)

*gen pos_marketffi3_ha = marketffi3_ha > 0 & marketffi3_ha != .

*gen pos_mkt_fcgm1_ha = mkt_fcgm1_ha > 0 & mkt_fcgm1_ha != .


* Table 15
******************
tabstat  isofffarmy is65 flabunpd fnocatlu co_stock fsizuaa region1-region8 if (system >= 2 & system <=3) & ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0 & year == 2008 [weight = wt], by(mkt_fcgm1_q) stats(mean)

* other variables
tabstat pos_marketffi3_ha pos_mkt_fcgm1_ha 


*Table 9
******************
*local cattle1_vlist = "cpavnocw cpavno06 cpavno61 cpavno12 cpavno2p"

*foreach var in `cattle1_vlist' {
* 
*       tab mtmarketffi_q2004 if ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0 & year == 2004 & is2004 == 1 & is2009 == 1 [weight = wt], sum(`var'_d)
*       tab mtmarketffi_q2004 if ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0 & year == 2004 & is2004 == 1 & is2009 == 1 [weight = wt], sum(`var')
* }

*local cattle1_vlist = "cpavno012 cpavn1224"

*foreach var in `cattle1_vlist' {
* 
*      tab mtmarketffi_q2004 if ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0 & year == 2004 & is2004 == 1 & is2009 == 1 [weight = wt], sum(`var'_d)
*         tab mtmarketffi_q2004 if ncattle > 0 & fsizesu >= 2 & droporig == 0 & (system == 2 | system == 3) & cpagecat != 0 & year == 2004 & is2004 == 1 & is2009 == 1 [weight = wt], sum(`var')
* }




*************************************************************************
* Clean up
*************************************************************************
log close
cmdlog close
