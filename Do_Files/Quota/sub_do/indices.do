* -------------------------------------------------------------------
* Create milk price index
* -------------------------------------------------------------------

gen constant_one = 1

* -------------------------------------------------------------------
* Create dairy concentrates price index
* -------------------------------------------------------------------
* Calc. concentrates fed to dairy and average price
qui ds icall*qt icall*q
local concqts "`r(varlist)'"
egen concqts = rowtotal(`concqts')
replace icallqty = concqts if icallqty == 0
gen icalldyq = icallqty - concqts
* tabstat icalldyq VAR11, by(year) // if you need convincing

gen prCONC = ddconval/icalldyq
replace prCONC = 0 if missing(prCONC)
pindex, p(prCONC) q(constant_one) method(laspeyres) base(1)
rename pindex_lasp_1 PFCONC
/*
* -------------------------------------------------------------------
* Create dairy pasture price index
* -------------------------------------------------------------------
ddpastur



* -------------------------------------------------------------------
* Create dairy winter forage price index
* -------------------------------------------------------------------
ddwinfor



* -------------------------------------------------------------------
* Create dairy pasture price index
* -------------------------------------------------------------------
fomacopt



* -------------------------------------------------------------------
* Create dairy pasture price index
* -------------------------------------------------------------------
foexlime

* Full list of dairy misc costs (full fdairydc is this + total dairy feed )
IB                                  SAS                  JC    Data
--                                  ---                  --    ----
VET_MED_ALLOC_DAIRY_HERD_EU         ivamalldy            NA    SAS
AI_SERVICE_FEES_ALLOC_DAIRY_HERD_EU iaisfdy              AI    JC
TRANSPORT_ALLOC_DAIRY_HERD_EU       itedairy             NA    SAS
MISCELLANEOUS_ALLOC_DAIRY_HERD_EU   imiscdry             NA    SAS
CASUAL_LABOUR_ALLOC_DAIRY_HERD_EU   flabccdy             NA    SAS
TOTAL_DEDUCTIONS_EU                 NO_SAS_CODE          NA    IB
SUPER_LEVY_CHARGE_EU                ddslvpay             NA    IB
SUPER_LEVY_REFUND_EU                part_of_frevoth      NA    IB
MILK_QUOTA_TOT_LEASED_EU            ddleaseq             NA    IB

*/

fds                      ///
ivmalldy                 ///  PVetExp
iaisfdy                  ///  PVetExp
itedairy                 ///  CPI Transport
imiscdry                 ///  CPI Other
flabccdy                 ///  wages?
TOTAL_DEDUCTIONS_EU      ///  AG INPUT
SUPER_LEVY_CHARGE_EU     ///  AG INPUT
SUPER_LEVY_REFUND_EU     ///  AG INPUT
MILK_QUOTA_TOT_LEASED_EU




* -------------------------------------------------------------------
* Create dairy pasture price index
* -------------------------------------------------------------------
*fofuellu
