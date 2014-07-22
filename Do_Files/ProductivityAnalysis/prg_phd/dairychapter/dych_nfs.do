* This file manipulates the NFS variable to create weighted averages
* which are printed to csv files. Graphs and table can easily be
* created from any statistical package from that point. 

* 9609v2 is a fairly full version of the data, althoug I may have 
* to switch to something else later on. I wanted to go back farther
* but the version that goes back to 84 is missing the weights.
clear
set mem 1500m

local cdir "~/Documents/projects/phd/dairychapter"
cd `cdir'
capture log close
log using `cdir'/dych_nfs.txt, replace text
use `cdir'/../productivity/data8409/9609v2
replace wt = int(w)

* Freq. tables - sex of holder
tab ogsexhld [weight=wt] if farmsys==1
tab ogsexhld [weight=wt] if farmsys!=1
tab oojobhld [weight=wt] if farmsys==1
tab oojobhld [weight=wt] if farmsys!=1
tab oojobsps [weight=wt] if farmsys==1
tab oojobsps [weight=wt] if farmsys!=1
tabstat oa* [weight=wt] if farmsys==1
tabstat oa* [weight=wt] if farmsys!=1
tabstat ogagehld [weight=wt] if farmsys==1
tabstat ogagehld [weight=wt] if farmsys!=1
tabstat ogagehld [weight=wt] if farmsys==1,by(year)
tabstat ogagehld [weight=wt] if farmsys!=1,by(year)
* Selected measures from Farm Financial Results by System of Farming
tabstat farmgo farmdc farmgm farmohct farmffi fdairygo fdairygm [weight=wt] if farmsys==1, by(year) stats(mean, n)
tabstat farmgo [weight=wt], by(year) stats(mean, n)

* Going against myself here but here's a histogram of farmer age
* Going against myself here but here's a histogram of farmer age
* with a normal dist superimposed on it. 
*hist ogagehld if farmsys==1 & ogagehld != 610 [weight = wt], discrete percent normal

keep if farmsys==1

outsheet using ~/Data/data_NFSPanelAnalysis/OutData/9609v2.csv, comma replace

collapse farmgo farmdc farmgm farmohct farmffi fsizunad fsizuaa flabtotl fdairygo fcatlego fsheepgo fpigsgo fpoultgo fhorsego fothergo flivstgo fcropsgo fcplivgo fgrntsub forntcon fomacopt fobldmnt foupkpld fohirlab fointpay fomiscel fdairygm dotomkgl [weight=wt], by(year) 

*collapse fdairygo fdairygm fsizuaa dotomkgl [weight=wt], by(year)
gen dgoha = fdairygo/fsizuaa
gen dgmha = fdairygm/fsizuaa

* Convert to litres. There are 4.54609 litres per imperial gallon 
gen dotomkli = dotomkgl * 4.54609
gen dgoli = (fdairygo/dotomkli)*100
gen dgmli = (fdairygm/dotomkli)*100

outsheet using ~/Data/gogm9609.csv, comma replace
drop dgoha dgmha dotomkli dgoli dgmli fdairygm dotomkgl
outsheet using ~/Data/nfsstats9609.csv, comma replace
cd `cdir'
shell R CMD BATCH dych_nfs.R dych_nfs.Rout
log close
*clear
