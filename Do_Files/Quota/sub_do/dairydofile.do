args outdatadir

if "`outdatadir'" == ""   local outdatadir "D:\Data\data_NFSPanelAnalysis\OutData\Quota"

* ===================================================================
* Vars which are not "derived" according to IB, but do need some
*   level of calculation due to differences in survey over time
* ===================================================================
*--------------------------------------------
* fbelclbl 
gen double fbelclbl = 0
*--------------------------------------------
/*capture gen double CLOSING_BALANCE_EU = 0
replace CLOSING_BALANCE_EU =    ///
  E_CLOSING_BALANCE_EU           + ///
  N_CLOSING_BALANCE_EU             ///
  if year < 1984


capture drop fbelclbl
gen double fbelclbl = 0
replace fbelclbl = CLOSING_BALANCE_EU    ///
  if N_LOAN_AMOUNT_BORROWED_EU ==0     & ///
     CLOSING_BALANCE_EU        > 0
*/
*--------------------------------------------

*TODO sort out age variable. Worker code 1 most likely correct one
*--------------------------------------------
* ogagehld 
*--------------------------------------------
rename FARM_MD_AGE              ogagehld 
*gen ogagehld = rnormal(55, 15) 
*--------------------------------------------


*--------------------------------------------
* ogmarsth // Maybe impossible. Ask Brian about Worker Codes.
*--------------------------------------------
*rename FARM_MD_MARITAL_STATUS   ogmarsth 
*--------------------------------------------


*--------------------------------------------
* ogsexhld 
*--------------------------------------------
gen double ogsexhld = 0
replace    ogsexhld = 1 if SEX == 4
rename SEX SEX_RAW_CODES // another var is called SEX later in code
*--------------------------------------------


*--------------------------------------------
* oano515y
*--------------------------------------------

*--------------------------------------------


*--------------------------------------------
* oano619y
*--------------------------------------------

*--------------------------------------------


*--------------------------------------------
* oojobhld 
*--------------------------------------------

*--------------------------------------------


*--------------------------------------------
* dpclinvd 
*--------------------------------------------

*--------------------------------------------
* ===================================================================






* Obs with missing farmcodes are useless to us, and I think they were
*  introduced in merging process anyway
rename FARM_CODE farmcode
rename YE_AR     year 
drop if missing(farmcode)


describe,short


rename UAA_WEIGHT w 





*!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
*!!!TEMPORARY FIXES!!!
*!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
* Subsidies (keeping in model for later years, but 0 for now)
gen double fsubtbco = 0
gen double fsubforh = 0
gen double fsubesag = 0
gen double fsubsptp = 0
gen double fsubyfig = 0
gen double fsubreps = 0

* Vars to be derived
gen double oanolt5y = 0 //non-derived var to calc
gen double oano515y = 0 //non-derived var to calc
gen double oano619y = 0 //non-derived var to calc


* Vars which I know I can't do any better for
gen double fortnfer = 0 // Only have combined var. Assigned to fmer
gen ffszsyst    = FARM_SYSTEM // Need to do to SGM (SGO) for this
rename MILK_QUOTA_OWN_CY_LT     dqownqty 
rename MILK_QUOTA_TOT_LEASED_LT dqrentgl 
rename MILK_QUOTA_LET_LT        dqletgal 
rename MILK_QUOTA_TOTAL_CY_LT   dqcuryer 
gen double ogmarsth = 0 //non-derived var to calc, may be impossible
gen double oojobhld = 0 //FARM_MD_OTHER_GAINFUL_ACT_EMP_TY.Don't have
*!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


* Everything is already in euro (via 1.21 conversion rate)


* Time index (panel's first year = 1)
qui summ year 
gen t = year - `r(min)' + 1




/* 

 Dodgy formula for D_VALUE_OF_FAMILY_LABOUR_EU (fvalflab)


"sum(for $i in root/svy_unpaid_labour return
  if(
($i/@ye_ar -  $i/@year_born)
  >= 18)
  then (
	(
	    if(($i/@hours_worked div 1800) >  1) 
	    then 1 
	    else ($i/@hours_worked div 1800)
	 ) *
	 18652)
  else 
     if(
($i/@ye_ar -  $i/@year_born)
  >14)
  then (
	(
	    if(
	    ($i/@hours_worked div 1800) >  1) 
	    then 1 
	    else ($i/@hours_worked div 1800)
	 ) *
13036)
else
0)"


Hard coded values are 18652 and 13036, which are presumably average
 ag wages of some sort. Why would we suppose that this follows the
 general inflation trend (i.e. why think that we could just deflate
 by CPI or other macro deflator)?

*/



* -------------------------------------------------------------------
* Price indices
* -------------------------------------------------------------------
* Get CSO price indices (previously saved in Stata format, but
*  straightforward to get from cso.ie). 

merge m:1 year using `outdatadir'/cso_p_indices.dta, nogen


* Using aggregate price indices assumes no change in distributions of 
*   prices across farms (questionable).
*
* Also created farm level price indices where possible in indices.do
*   called by the main do file (better because its 
*   one less assumption). 
*   
* Still need indices even when I have quantities because we need to 
*   aggregate some inputs together (at the farm level) in order to 
*   estimate the model, ie. one variable for DC instead of several 
*   variables for all subcomponents. These need price effects taken
*   out if it's to work as a proxy for "volume of input" in some way. 
* -------------------------------------------------------------------



* Sample selection, keep only specialist dairy (non-hill farms) 
keep if FARM_SYSTEM == 1 & D_SOIL_GROUP < 3



/* create input allocation variable according to gross output */
capture drop alloc
gen     alloc = fdairygo / fcplivgo
replace alloc = 1 if alloc>1
replace alloc = 0 if alloc<0



/* Create Capital Input
    (end of year book values = machinery+buildings) */

capture rename D_DEPRECIATION_OF_BUILDINGS_EU  foblddpr
capture rename D_DEPRECIATION_OF_MACHINERY_EU  fomacdpr
capture rename D_DEPRECIATION_OF_LAND_IMPS_EU  fodprlim


gen C = alloc    *                        ///
         (                                ///
           ((fainvmch/PTransportcap)*100)  + ///
           ((fainvbld/POthercap)    *100)    ///
         )


/* Played with using depreciation, but looks like investment might be
    better according to Coelli (although I think there's more to do
    here). 
         (                                ///
           ((fomacdpr/PTransportcap)*100)  + ///
           ((foblddpr/POthercap)    *100)    ///
         )

*/
/* Create Labour Inputs */

gen L1 = (alloc  *     ///   
                (fdcaslab + ///
                 fohirlab)  ///
             ) / CPI * 100        

 * Took value of family labour out of L1 because I think the formula
*   is dodgy. Preferable to use real variable anyway.
                *(fvalflab + /// 

gen L2 = alloc * flabtotl   // ok
gen L3 = alloc * flabsmds   // ok



/* Create Herd size variable (average number) */
replace dpavnohd = MTH12_TOTAL_DAIRY_COWS_NO / 12
gen H = dpavnohd


* Raw data are already in litres.
/*convert early years to LITRES! and rename output var 
replace dotomkgl = dotomkgl * 4.546092 if t==0 */


rename  dotomkgl   Y1  



* Deflate Milk values
gen Y2=(dotomkvl/PMilk)*100



*Direct Costs
gen DC=  ///
  (ddconval       / PCattleFeed  *100) + ///
  (ddpastur       / PTotalFert   *100) + /// 
  (ddwinfor       / PTotalFert   *100) + ///
  (alloc*fomacopt / PTotalInputs *100) + ///
  (alloc*foexlime / PTotalFert   *100) + ///
  (alloc*fofuellu / PMotorFuels  *100)



* CREATE TIME DUMMIES
tab t, gen(T)



*----------------------------------
/* CREATE EFFICIENCY VARIABLES */
* divide ogagehld into dummies
*----------------------------------
rename ogagehld AGE
*----------------------------------
gen     AGE1 = 0
replace AGE1 = 1 if AGE<=30
*----------------------------------
gen     AGE2 = 0
replace AGE2 = 1 if AGE<=40
replace AGE2 = 0 if AGE<=31
*----------------------------------
gen     AGE3 = 0
replace AGE3 = 1 if AGE<=50
replace AGE3 = 0 if AGE<=41
*----------------------------------
gen     AGE4 = 0
replace AGE4 = 1 if AGE<=60
replace AGE4 = 0 if AGE<=51
*----------------------------------
gen     AGE5 = 0
replace AGE5 = 1 if AGE<=70
replace AGE5 = 0 if AGE<=61
*----------------------------------
gen     AGE6 = 0
replace AGE6 = 1 if AGE<=80
replace AGE6 = 0 if AGE<=71
*----------------------------------
gen     AGE7 = 0
replace AGE7 = 1 if AGE<=90
replace AGE7 = 0 if AGE<=81
*----------------------------------



/* create soil class dummies (1 is best, followed by 2 and 3) */
gen     SOIL1 = 0
replace SOIL1 = 1 if ffsolcod<300

gen     SOIL2 = 0
replace SOIL2 = 1 if ffsolcod<500
replace SOIL2 = 0 if ffsolcod<300

gen     SOIL3 = 0
replace SOIL3 = 1 if ffsolcod<700
replace SOIL3 = 0 if ffsolcod<500



/* create AI dummy (equal to 1 if farm spends any amount) */
*replace iaisfdy = iaisfdy/PVetExp*100
gen     AID = 0
*replace AID = 1 if iaisfdy>0 // Temporarily off 



/* create Bull Dummy equal to one if farm has atleast one Bull */
gen     BULL = 0
replace BULL = 1 if dpavnobl>0



/* create indebtedness variable (value of fbelclbls divided by end 
    of year value of farm) */
gen DEBTRAT=((fbelclbl/CPI*100)/(fainvfrm/CPI*100)*100)



* create subsidies ratios (value of subsidies/value of milk sales) 
gen SUBS1   = fsubsptp+fsubyfig+fsubreps+fsubtbco+fsubesag
gen SUBRAT1 = SUBS1/dotomkvl
gen SUBS2   = dosubsvl
gen SUBRAT2 = SUBS2/dotomkvl



/* create ratio of dairy land (feed area) to total land 
    (unadjusted farm size) */
gen LANDRAT = dafedare/fsizunad



/* create value per acre variable */
gen ACREVAL=((fainvfrm/CPI*100)*100)/fsizunad



/* create children dummy */
gen CHILD = 0
replace CHILD = 1 if oanolt5y>0
replace CHILD = 1 if oano515y>0
replace CHILD = 1 if oano619y>0



/* create married dummy */
gen MARRIED = 0
replace MARRIED = 1 if ogmarsth==1



/* create off-farm job dummy 1(holder) */
gen OFFFARM = 0
replace OFFFARM = 1 if oojobhld==1
replace OFFFARM = 1 if oojobhld==2



/* create averogagehld cow value variable (closing inventory of dairy 
    herd divided by average number of cows) */
gen COWVAL = dpclinvd/dpavnohd



/* gen extension variable (value and dummy) */
gen EXTEN = foadvfee
gen EXTEND = 0
replace EXTEND = 1 if foadvfee>0


*----------------------------------
* GENERATE SIZE DUMMIES
*----------------------------------
gen SIZE1 = 0
gen SIZE2 = 0
gen SIZE3 = 0
gen SIZE4 = 0
gen SIZE5 = 0
*----------------------------------
replace SIZE1 = 1 if fsizunad<=75
*----------------------------------
replace SIZE2 = 1 if fsizunad<=100
replace SIZE2 = 0 if fsizunad<75
*----------------------------------
replace SIZE3 = 1 if fsizunad<=125
replace SIZE3 = 0 if fsizunad<100
*----------------------------------
replace SIZE4 = 1 if fsizunad<=175
replace SIZE4 = 0 if fsizunad<125
*----------------------------------
replace SIZE5 = 1 if fsizunad>175
*----------------------------------



drop   dosubsvl
rename D_UAA_PUB_SIZE_CODE SZCLASS
rename alloc    ALLOC
rename ffszsyst SYS
rename t        T
rename w        W
rename farmcode FC
rename oojobhld JOBTYPE
rename ffsolcod SCLASS
rename ogsexhld SEX
rename iaisfdy  AI
rename fsizunad FSIZE
rename fainvfrm  FVALUE
rename oanolt5y CHILD5
rename oano515y CHILD15
rename oano619y CHILD19
rename fbelclbl LOAN
rename dqownqty QTOWN
rename dqrentgl QTLEASE
rename dqletgal QTLET
rename dqcuryer QT
*rename dabotfat FAT //  D_BUTTER_FAT_MILK_KGS TEMPORARY off
*rename daproten PROTEIN //  D_PROTEIN_MILK_KGS TEMPORARY off
rename daforare LANDFAGE
rename dafedare LANDFEED


* TODO is this still correct? What units are the raw data in?
* Hectare to acres conversion
/*
replace LANDFAGE = LANDFAGE * 2.47105 if T== 11
replace LANDFEED = LANDFEED * 2.47105 if T== 11
replace FSIZE    = FSIZE    * 2.47105 if T== 11
*/


* create intensification variable (COW per acre)
gen INTENSE = dpavnohd/LANDFAGE



* TODO -- adjust DECOUP when data merged
gen DECOUP = 0
replace DECOUP = 1 if year > 2005



* Investigate Attrition
* drop zero obs
drop if Y2       <= 0
drop if LANDFEED <= 0
drop if LANDFAGE <= 0
drop if L3       <= 0
drop if C        <= 0
drop if DC       <= 0
drop if H        <= 0

codebook year


xtset FC T



* Year ranges for each farm's participation
bysort FC: egen MAXT = max(T)
bysort FC: egen MINT = min(T)



* Degree of Attrition
gen TLAG = T-l.T
replace TLAG = 0 if TLAG==.
bysort T: sum TLAG




* Number of years each farm is in sample
gen COUNTER = 1
bysort FC: egen PS = sum(COUNTER) 



* partial productivity indicators
gen PH = Y2/H
gen PD = Y2/DC
gen PL = Y2/L3 
gen PA = Y2/LANDFAGE
gen PC = Y2/C

bysort T: sum PH PD PL PA PC



*********************************************************************

* efficiency variables DROP ZEROS IF DOING DESCRIPTIVE STATS!!!!!!!!! 
 
*********************************************************************

drop if AGE<14 
drop if AGE>100

*********************************************************************
* create OFF-FARM SIZE interactions. 
*   SMALL  (0   - 64 ) 
*   MEDIUM (65  -112 ) 
*   LARGE  (     112+)
*********************************************************************
gen SMALL  = 0
gen MEDIUM = 0
gen LARGE  = 0

replace SMALL  = 1 if FSIZE<65
replace MEDIUM = 1 if FSIZE<113
replace MEDIUM = 0 if FSIZE<65
replace LARGE  = 1 if FSIZE>112

gen SMLOFF = OFFFARM * SMALL
gen MEDOFF = OFFFARM * MEDIUM
gen LRGOFF = OFFFARM * LARGE


     *FAT      // Temporarily off
     *PROTEIN  // Temporarily off


* Each row must count as at least 1 farm! Couple of 0's to remove
drop if W     <  1 


preserve
drop if SZCLASS == 0 | SZCLASS == 7
tab SZCLASS, gen(SZCLASS)


* About to drop these, so output which index values were used
tabstat ///
    PMilk PCattleFeed PTotalFert PTotalInputs ///
    PMotorFuels  PTransportcap POthercap CPI  ///
  , by(year)



* Subset of vars to go to NLogit
keep ///
     year     ///
     INTENSE  ///
     DECOUP   ///
     AI       /// 
     SYS      ///
     T        ///
     W        ///
     FC       ///
     SCLASS   ///
     SZCLAS*  ///
     FSIZE    ///
     FVALUE   ///
     SEX      ///
     AGE      ///
     CHILD5   ///
     CHILD15  ///
     CHILD19  ///
     JOBTYPE  ///
     CHILD5   ///
     CHILD15  ///
     CHILD19  ///
     LOAN     ///
     Y1       ///
     QTOWN    ///
     QTLEASE  ///
     QTLET    ///
     QT       ///
     LANDFAGE ///
     LANDFEED ///
     ALLOC-   ///
     SIZE5      

* Make data compatible with NLogit


* NLogit will not import correctly if there are missing values
*  i.e. the missing values will be blanks in the CSV file, and 
*  NLogit will not interpret them as missings 
* All other missing values can be set to 0
qui mvencode _all, mv(0) override



drop if ALLOC < .6



* Save csv file for NLogit
outsheet using ../../code_NLogit/Quota/DAIRY.csv, comma replace noq

* Save in xls format
capture export excel using ../../code_NLogit/Quota/DAIRY.xls ///
  , firstrow(var) replace nolabel missing(0)

* Bring back full data
restore
* NOTE that you will have more vars here than you are sending to 
*  NLogit. Add to the "keep" command above if you want more for 
*  NLogit.


tabstat Y2 H C L3 DC LANDFAGE LANDFEED FSIZE ALLOC INTENSE AGE AI [weight = W] , by(year)

xtreg Y2 H C L3 DC LANDFAGE, fe
estimates store fe

xtreg Y2 H C L3 DC LANDFAGE, re
estimates store re

hausman fe re

/* Chow test borrowed from niie code (to use as a template)
gen group = year < 1984
testparm 			///
	lnlandval_ha_ni		///
	lnfdferfil_ha_ni	///
	lndaforare_lu_ni	///
	lnfdgrzlvstk_lu_ni	///
	lnflabpaid_lu_ni	///
	lnflabunpd_lu_ni	///
	ogagehld_ni		///
	lnfsizuaa_ni		///
	hasreps_ni		///
	lnmin_temp_ni		///
	azone2_ni		///
	ni
*/

* Testing my own program for creating various functional forms (inactive since computer crash)
*fform "x" "`x'" "" `norm' `xhomog'

cd `startdir' // return Stata to start location
