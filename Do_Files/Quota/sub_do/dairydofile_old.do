args outdatadir

/*-----------TURNED OFF---------------------------------------------
*TODO: the temoporarily off lines
*TODO: the TEMPORARY FIXES -- off until var fixed


* Set directory macros
local startdir: pwd // save current location

local dodir      ///
   "D:\Data\data_NFSPanelAnalysis\Do_Files\Quota"

local outdatadir    ///
   "D:\Data\data_NFSPanelAnalysis\OutData"

local sub_do ///
   "D:\Data\data_NFSPanelAnalysis\Do_Files\RAW_79_83\sub_do"



* Load data
cd `outdatadir'
use nfs_7983.dta, clear



* Calculate derived variables
cd `sub_do'
qui do D_FARM_GROSS_OUTPUT/D_FARM_GROSS_OUTPUT
qui do D_FUEL_LUBS_EU/D_FUEL_LUBS_EU
qui do D_INSURANCE_EU/D_INSURANCE_EU
qui do D_INT_PAY_INCL_HP_INT_EU/D_INT_PAY_INCL_HP_INT_EU
qui do D_INV_IN_LIMPROVEMENTS/D_INV_IN_LIMPROVEMENTS
qui do D_INVESTMENT_IN_BUILDINGS/D_INVESTMENT_IN_BUILDINGS
qui do D_INVESTMENT_IN_MACHINERY/D_INVESTMENT_IN_MACHINERY
qui do D_MACHINERY_OPERATING_EXP_EU/D_MACHINERY_OPERATING_EXP_EU
qui do D_MISC_OVERHEAD_COSTS_EU/D_MISC_OVERHEAD_COSTS_EU
qui do D_STANDARD_MAN_DAYS/D_STANDARD_MAN_DAYS
qui do D_TOTAL_CASUAL_LABOUR_EU/D_TOTAL_CASUAL_LABOUR_EU 
qui do D_HIRED_LABOUR_CASUAL_EXCL_EU/D_HIRED_LABOUR_CASUAL_EXCL_EU
qui do D_MACHINERY_RATES_EU/D_MACHINERY_RATES_EU
qui do UAA_SIZE/UAA_SIZE
qui do D_HERD_SIZE_AVG_NO/D_HERD_SIZE_AVG_NO
qui do D_EXPENDITURE_ON_LIME_EU/D_EXPENDITURE_ON_LIME_EU
qui do ///
  D_CROP_LIVESTOCK_GROSS_OUTPUT_EU/D_CROP_LIVESTOCK_GROSS_OUTPUT_EU
qui do D_TOTAL_MILK_PRODUCTION_LT/D_TOTAL_MILK_PRODUCTION_LT
qui do D_CONCENTRATES_FED_DAIRY_EU/D_CONCENTRATES_FED_DAIRY_EU
qui do D_DAIRY_PASTURE_EU/D_DAIRY_PASTURE_EU
qui do D_DAIRY_WINTER_FORAGE_EU/D_DAIRY_WINTER_FORAGE_EU
qui do D_BUTTER_FAT_MILK_KGS/D_BUTTER_FAT_MILK_KGS
qui do D_PROTEIN_MILK_KGS/D_PROTEIN_MILK_KGS
qui do D_FORAGE_AREA_HA/D_FORAGE_AREA_HA
qui do D_ALL_BULLS_AVG_NO/D_ALL_BULLS_AVG_NO
qui do D_FEED_AREA_EQUIV_HA/D_FEED_AREA_EQUIV_HA
qui do D_CLOS_INV_DAIRY_HERD_EU/D_CLOS_INV_DAIRY_HERD_EU
qui do D_VALUE_OF_FAMILY_LABOUR_EU/D_VALUE_OF_FAMILY_LABOUR_EU
qui do D_LABOUR_UNITS_TOTAL/D_LABOUR_UNITS_TOTAL



* These are called by D_FARM_GROSS_OUTPUT. No need to call them again 
*D_DAIRY_GROSS_OUTPUT_EU/D_DAIRY_GROSS_OUTPUT_EU
*D_GROSS_OUTPUT_CATTLE_EU/D_GROSS_OUTPUT_CATTLE_EU
*D_GROSS_OUTPUT_SHEEP_AND_WOOL_EU/D_GROSS_OUTPUT_SHEEP_AND_WOOL_EU




* = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
* Quota variables
* = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
* Milk quota doesn't exist for these years, but create 0 valued var 
*  for consistency of data
* = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

gen double MILK_QUOTA_OWN_CY_LT     = 0
gen double MILK_QUOTA_TOT_LEASED_LT = 0
gen double MILK_QUOTA_LET_LT        = 0
gen double MILK_QUOTA_TOTAL_CY_LT   = 0

* = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =


-----------BACK ON ---------------------------------------------*/



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



/* Use SAS varnames instead of IB varnames where available
     (I'm more confident in these)                    */
*qui do create_renameIB2SAS_code.do // update renaming file
qui do sub_do/renameIB2SAS.do             // do renaming file



* No longer need to be in raw_sub_do directory, so return to dodir
cd `dodir'

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
gen int ffszsyst    = 1 // Need to do to SGM (SGO) for this
rename MILK_QUOTA_OWN_CY_LT     dqownqty // Quota var, NA 79 - 83
rename MILK_QUOTA_TOT_LEASED_LT dqrentgl // Quota var, NA 79 - 83
rename MILK_QUOTA_LET_LT        dqletgal // Quota var, NA 79 - 83
rename MILK_QUOTA_TOTAL_CY_LT   dqcuryer // Quota var, NA 79 - 83
gen double ogmarsth = 0 //non-derived var to calc, may be impossible
gen double oojobhld = 0 //FARM_MD_OTHER_GAINFUL_ACT_EMP_TY.Don't have
*!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!




* Time index (panel's first year = 1)
qui summ year 
gen t = year - `r(min)' + 1


/* Doing this by insheeting and merging now

* ===================================================================
* Create Price indices   TODO: 79 and the last couple of years
* ===================================================================
gen     PTotalOutputs    = 0
local price_vlist "`price_vlist' PTotalOutputs"
replace PTotalOutputs = 71          if year == 1979 // Temp -- update
replace PTotalOutputs = 71          if year == 1980
replace PTotalOutputs = 83.41862845 if year == 1981
replace PTotalOutputs = 90.37871034 if year == 1982
replace PTotalOutputs = 96.00818833 if year == 1983
replace PTotalOutputs = 98.77175026 if year == 1984
replace PTotalOutputs = 96.11054248 if year == 1985
replace PTotalOutputs = 95.59877175 if year == 1986
replace PTotalOutputs = 99.48822927 if year == 1987
replace PTotalOutputs = 109.9283521 if year == 1988
replace PTotalOutputs = 115.4554759 if year == 1989
replace PTotalOutputs = 102.3541453 if year == 1990
replace PTotalOutputs = 98.46468782 if year == 1991
replace PTotalOutputs = 100.1023541 if year == 1992
replace PTotalOutputs = 106.6530194 if year == 1993
replace PTotalOutputs = 108.2906858 if year == 1994
replace PTotalOutputs = 110.3       if year == 1995
replace PTotalOutputs = 105.3       if year == 1996
replace PTotalOutputs = 98.8        if year == 1997
replace PTotalOutputs = 98          if year == 1998
replace PTotalOutputs = 94          if year == 1999
replace PTotalOutputs = 100         if year == 2000
replace PTotalOutputs = 104.26      if year == 2001
replace PTotalOutputs = 99.95       if year == 2002
replace PTotalOutputs = 99.61       if year == 2003
replace PTotalOutputs = 101.82      if year == 2004
replace PTotalOutputs = 102.3       if year == 2005
replace PTotalOutputs = 107.43      if year == 2006
replace PTotalOutputs = 118         if year == 2007
replace PTotalOutputs = 122.3       if year == 2008
replace PTotalOutputs = 103         if year == 2009
replace PTotalOutputs = 115.3       if year == 2010
replace PTotalOutputs = 115.3       if year == 2011 // Temp -- update
replace PTotalOutputs = 115.3       if year == 2012 // Temp -- update


gen     PPrimeCattle     = 0
local price_vlist "`price_vlist' PPrimeCattle"
replace PPrimeCattle = 75          if year == 1979 // Temp -- update
replace PPrimeCattle = 75          if year == 1980
replace PPrimeCattle = 92.19620959 if year == 1981
replace PPrimeCattle = 101.0033445 if year == 1982
replace PPrimeCattle = 107.8037904 if year == 1983
replace PPrimeCattle = 112.3745819 if year == 1984
replace PPrimeCattle = 109.2530658 if year == 1985
replace PPrimeCattle = 105.3511706 if year == 1986
replace PPrimeCattle = 112.9319955 if year == 1987
replace PPrimeCattle = 129.2084727 if year == 1988
replace PPrimeCattle = 124.303233  if year == 1989
replace PPrimeCattle = 111.4827202 if year == 1990
replace PPrimeCattle = 106.5774805 if year == 1991
replace PPrimeCattle = 106.4659978 if year == 1992
replace PPrimeCattle = 115.6075808 if year == 1993
replace PPrimeCattle = 119.3979933 if year == 1994
replace PPrimeCattle = 119.4       if year == 1995
replace PPrimeCattle = 101         if year == 1996
replace PPrimeCattle = 95.2        if year == 1997
replace PPrimeCattle = 93.4        if year == 1998
replace PPrimeCattle = 90.9        if year == 1999
replace PPrimeCattle = 100         if year == 2000
replace PPrimeCattle = 92.45       if year == 2001
replace PPrimeCattle = 95.21       if year == 2002
replace PPrimeCattle = 93.33       if year == 2003
replace PPrimeCattle = 101.87      if year == 2004
replace PPrimeCattle = 105.59      if year == 2005
replace PPrimeCattle = 113.49      if year == 2006
replace PPrimeCattle = 111.2       if year == 2007
replace PPrimeCattle = 128         if year == 2008
replace PPrimeCattle = 115.1       if year == 2009
replace PPrimeCattle = 115.9       if year == 2010
replace PPrimeCattle = 115.9       if year == 2011 // Temp -- update
replace PPrimeCattle = 115.9       if year == 2012 // Temp -- update



gen     PCowSlaughter    = 0
local price_vlist "`price_vlist' PCowSlaughter"
replace PCowSlaughter = 101         if year == 1979 // Temp -- update
replace PCowSlaughter = 101         if year == 1980
replace PCowSlaughter = 123.5531629 if year == 1981
replace PCowSlaughter = 133.9165545 if year == 1982
replace PCowSlaughter = 133.243607  if year == 1983
replace PCowSlaughter = 133.9165545 if year == 1984
replace PCowSlaughter = 131.2247645 if year == 1985
replace PCowSlaughter = 126.9179004 if year == 1986
replace PCowSlaughter = 134.1857335 if year == 1987
replace PCowSlaughter = 157.6043069 if year == 1988
replace PCowSlaughter = 155.8546433 if year == 1989
replace PCowSlaughter = 134.589502  if year == 1990
replace PCowSlaughter = 119.2462988 if year == 1991
replace PCowSlaughter = 127.1870794 if year == 1992
replace PCowSlaughter = 142.5302826 if year == 1993
replace PCowSlaughter = 146.8371467 if year == 1994
replace PCowSlaughter = 135.6       if year == 1995
replace PCowSlaughter = 108.7       if year == 1996
replace PCowSlaughter = 102.8       if year == 1997
replace PCowSlaughter = 98.8        if year == 1998
replace PCowSlaughter = 87.6        if year == 1999
replace PCowSlaughter = 100         if year == 2000
replace PCowSlaughter = 86.66       if year == 2001
replace PCowSlaughter = 83.16       if year == 2002
replace PCowSlaughter = 86.42       if year == 2003
replace PCowSlaughter = 103.21      if year == 2004
replace PCowSlaughter = 107.07      if year == 2005
replace PCowSlaughter = 118         if year == 2006
replace PCowSlaughter = 115.2       if year == 2007
replace PCowSlaughter = 137.4       if year == 2008
replace PCowSlaughter = 120.8       if year == 2009
replace PCowSlaughter = 124.7       if year == 2010
replace PCowSlaughter = 124.7       if year == 2011 // Temp -- update
replace PCowSlaughter = 124.7       if year == 2012 // Temp -- update


gen     PStoreCattle     = 0
local price_vlist "`price_vlist' PStoreCattle"
replace PStoreCattle = 70          if year == 1979 // Temp -- update
replace PStoreCattle = 70          if year == 1980
replace PStoreCattle = 87.88209607 if year == 1981
replace PStoreCattle = 97.48908297 if year == 1982
replace PStoreCattle = 103.8209607 if year == 1983
replace PStoreCattle = 109.1703057 if year == 1984
replace PStoreCattle = 107.6419214 if year == 1985
replace PStoreCattle = 100.9825328 if year == 1986
replace PStoreCattle = 111.1353712 if year == 1987
replace PStoreCattle = 132.4235808 if year == 1988
replace PStoreCattle = 127.2925764 if year == 1989
replace PStoreCattle = 109.1703057 if year == 1990
replace PStoreCattle = 101.8558952 if year == 1991
replace PStoreCattle = 102.8384279 if year == 1992
replace PStoreCattle = 112.6637555 if year == 1993
replace PStoreCattle = 118.1222707 if year == 1994
replace PStoreCattle = 114.7       if year == 1995
replace PStoreCattle = 99.1        if year == 1996
replace PStoreCattle = 95.9        if year == 1997
replace PStoreCattle = 89.6        if year == 1998
replace PStoreCattle = 83          if year == 1999
replace PStoreCattle = 100         if year == 2000
replace PStoreCattle = 97.22       if year == 2001
replace PStoreCattle = 100.71      if year == 2002
replace PStoreCattle = 102.79      if year == 2003
replace PStoreCattle = 112.25      if year == 2004
replace PStoreCattle = 104.52      if year == 2005
replace PStoreCattle = 107.46      if year == 2006
replace PStoreCattle = 108.7       if year == 2007
replace PStoreCattle = 119.8       if year == 2008
replace PStoreCattle = 105.9       if year == 2009
replace PStoreCattle = 109.5       if year == 2010
replace PStoreCattle = 109.5       if year == 2011 // Temp -- update
replace PStoreCattle = 109.5       if year == 2012 // Temp -- update


gen     PTotalCattle     = 0
local price_vlist "`price_vlist' PTotalCattle"
replace PTotalCattle = 78          if year == 1979 // Temp -- update
replace PTotalCattle = 78          if year == 1980
replace PTotalCattle = 95.56313993 if year == 1981
replace PTotalCattle = 104.778157  if year == 1982
replace PTotalCattle = 110.3526735 if year == 1983
replace PTotalCattle = 114.334471  if year == 1984
replace PTotalCattle = 111.4903299 if year == 1985
replace PTotalCattle = 107.2810011 if year == 1986
replace PTotalCattle = 115.1308305 if year == 1987
replace PTotalCattle = 132.5369738 if year == 1988
replace PTotalCattle = 127.9863481 if year == 1989
replace PTotalCattle = 113.7656428 if year == 1990
replace PTotalCattle = 107.7360637 if year == 1991
replace PTotalCattle = 108.4186576 if year == 1992
replace PTotalCattle = 118.3162685 if year == 1993
replace PTotalCattle = 122.0705347 if year == 1994
replace PTotalCattle = 120.7       if year == 1995
replace PTotalCattle = 101.7       if year == 1996
replace PTotalCattle = 96.3        if year == 1997
replace PTotalCattle = 93.4        if year == 1998
replace PTotalCattle = 89.1        if year == 1999
replace PTotalCattle = 100         if year == 2000
replace PTotalCattle = 92.26       if year == 2001
replace PTotalCattle = 94.41       if year == 2002
replace PTotalCattle = 93.64       if year == 2003
replace PTotalCattle = 103.25      if year == 2004
replace PTotalCattle = 105.58      if year == 2005
replace PTotalCattle = 113.22      if year == 2006
replace PTotalCattle = 111         if year == 2007
replace PTotalCattle = 127.8       if year == 2008
replace PTotalCattle = 114.4       if year == 2009
replace PTotalCattle = 115.9       if year == 2010
replace PTotalCattle = 115.9       if year == 2011 // Temp -- update
replace PTotalCattle = 115.9       if year == 2012 // Temp -- update


gen     PSheep           = 0
local price_vlist "`price_vlist' PSheep"
replace PSheep = 113         if year == 1979 // Temp - update
replace PSheep = 113         if year == 1980
replace PSheep = 136.3949483 if year == 1981
replace PSheep = 139.0355913 if year == 1982
replace PSheep = 146.0390356 if year == 1983
replace PSheep = 143.9724455 if year == 1984
replace PSheep = 140.0688863 if year == 1985
replace PSheep = 140.5281286 if year == 1986
replace PSheep = 147.1871412 if year == 1987
replace PSheep = 150.9758898 if year == 1988
replace PSheep = 145.3501722 if year == 1989
replace PSheep = 114.8105626 if year == 1990
replace PSheep = 109.0700344 if year == 1991
replace PSheep = 80.94144661 if year == 1992
replace PSheep = 94.37428243 if year == 1993
replace PSheep = 101.9517796 if year == 1994
replace PSheep = 89.8        if year == 1995
replace PSheep = 109.6       if year == 1996
replace PSheep = 112.4       if year == 1997
replace PSheep = 96.5        if year == 1998
replace PSheep = 88.7        if year == 1999
replace PSheep = 100         if year == 2000
replace PSheep = 142.85      if year == 2001
replace PSheep = 121.29      if year == 2002
replace PSheep = 119.5       if year == 2003
replace PSheep = 117.65      if year == 2004
replace PSheep = 109.56      if year == 2005
replace PSheep = 112.21      if year == 2006
replace PSheep = 114.9       if year == 2007
replace PSheep = 120.2       if year == 2008
replace PSheep = 122.1       if year == 2009
replace PSheep = 142.8       if year == 2010
replace PSheep = 142.8       if year == 2011 // Temp -- update
replace PSheep = 142.8       if year == 2012 // Temp -- update


gen     PMilk            = 0
local price_vlist "`price_vlist' PMilk"
replace PMilk = 53.369  if year == 1979 // Temp - update
replace PMilk = 53.369  if year == 1980
replace PMilk = 60.638  if year == 1981
replace PMilk = 66.312  if year == 1982
replace PMilk = 71.809  if year == 1983
replace PMilk = 72.695  if year == 1984
replace PMilk = 75.089  if year == 1985
replace PMilk = 77.305  if year == 1986
replace PMilk = 80.585  if year == 1987
replace PMilk = 89.894  if year == 1988
replace PMilk = 101.950 if year == 1989
replace PMilk = 88.652  if year == 1990
replace PMilk = 84.663  if year == 1991
replace PMilk = 91.046  if year == 1992
replace PMilk = 98.848  if year == 1993
replace PMilk = 98.493  if year == 1994
replace PMilk = 105.200 if year == 1995
replace PMilk = 105.400 if year == 1996
replace PMilk = 97.800  if year == 1997
replace PMilk = 101.100 if year == 1998
replace PMilk = 98.400  if year == 1999
replace PMilk = 100.000 if year == 2000
replace PMilk = 104.310 if year == 2001
replace PMilk = 97.090  if year == 2002
replace PMilk = 95.560  if year == 2003
replace PMilk = 95.320  if year == 2004
replace PMilk = 93.510  if year == 2005
replace PMilk = 90.160  if year == 2006
replace PMilk = 111.000 if year == 2007
replace PMilk = 112.700 if year == 2008
replace PMilk = 78.100  if year == 2009
replace PMilk = 100.200 if year == 2010
replace PMilk = 100.200 if year == 2011 // Temp -- update
replace PMilk = 100.200 if year == 2012 // Temp -- update


gen     PCereals         = 0
local price_vlist "`price_vlist' PCereals"
replace PCereals = 114         if year == 1979 // Temp -- update
replace PCereals = 114         if year == 1980
replace PCereals = 122.7696405 if year == 1981
replace PCereals = 130.2263648 if year == 1982
replace PCereals = 156.9906791 if year == 1983
replace PCereals = 141.4114514 if year == 1984
replace PCereals = 131.2916112 if year == 1985
replace PCereals = 133.8215712 if year == 1986
replace PCereals = 136.6178429 if year == 1987
replace PCereals = 142.8761651 if year == 1988
replace PCereals = 141.5446072 if year == 1989
replace PCereals = 133.1557923 if year == 1990
replace PCereals = 126.4980027 if year == 1991
replace PCereals = 127.563249  if year == 1992
replace PCereals = 126.4980027 if year == 1993
replace PCereals = 116.644474  if year == 1994
replace PCereals = 130.6       if year == 1995
replace PCereals = 115.8       if year == 1996
replace PCereals = 94.8        if year == 1997
replace PCereals = 99          if year == 1998
replace PCereals = 104.8       if year == 1999
replace PCereals = 100         if year == 2000
replace PCereals = 104.45      if year == 2001
replace PCereals = 91.75       if year == 2002
replace PCereals = 108.97      if year == 2003
replace PCereals = 100.91      if year == 2004
replace PCereals = 96.61       if year == 2005
replace PCereals = 110.56      if year == 2006
replace PCereals = 185.4       if year == 2007
replace PCereals = 133.1       if year == 2008
replace PCereals = 94.6        if year == 2009
replace PCereals = 150.2       if year == 2010
replace PCereals = 150.2       if year == 2011 // Temp -- update
replace PCereals = 150.2       if year == 2012 // Temp -- update


gen     PSugarBeet       = 0
local price_vlist "`price_vlist' PSugarBeet"
replace PSugarBeet = 73          if year == 1979 // Temp -- update
replace PSugarBeet = 73          if year == 1980
replace PSugarBeet = 78.67435159 if year == 1981
replace PSugarBeet = 82.99711816 if year == 1982
replace PSugarBeet = 91.1623439  if year == 1983
replace PSugarBeet = 85.5907781  if year == 1984
replace PSugarBeet = 92.41114313 if year == 1985
replace PSugarBeet = 92.69932757 if year == 1986
replace PSugarBeet = 94.90874159 if year == 1987
replace PSugarBeet = 96.15754083 if year == 1988
replace PSugarBeet = 94.90874159 if year == 1989
replace PSugarBeet = 96.06147935 if year == 1990
replace PSugarBeet = 94.81268012 if year == 1991
replace PSugarBeet = 98.94332373 if year == 1992
replace PSugarBeet = 111.3352546 if year == 1993
replace PSugarBeet = 107.012488  if year == 1994
replace PSugarBeet = 100.6       if year == 1995
replace PSugarBeet = 96          if year == 1996
replace PSugarBeet = 97.6        if year == 1997
replace PSugarBeet = 98.6        if year == 1998
replace PSugarBeet = 99.5        if year == 1999
replace PSugarBeet = 100         if year == 2000
replace PSugarBeet = 102.84      if year == 2001
replace PSugarBeet = 103.78      if year == 2002
replace PSugarBeet = 103.78      if year == 2003
replace PSugarBeet = 103.8       if year == 2004
replace PSugarBeet = 103.7       if year == 2005
replace PSugarBeet = 103.7       if year == 2006
replace PSugarBeet = 103.7       if year == 2007
replace PSugarBeet = 103.7       if year == 2008
replace PSugarBeet = 103.7       if year == 2009
replace PSugarBeet = 103.7       if year == 2010
replace PSugarBeet = 103.7       if year == 2011 // Temp -- update
replace PSugarBeet = 103.7       if year == 2012 // Temp -- update


gen     PPotatoes        = 0
local price_vlist "`price_vlist' PPotatoes"
replace PPotatoes = 62          if year == 1979 // Temp -- update
replace PPotatoes = 62          if year == 1980
replace PPotatoes = 82.58354756 if year == 1981
replace PPotatoes = 107.3907455 if year == 1982
replace PPotatoes = 82.96915167 if year == 1983
replace PPotatoes = 132.9691517 if year == 1984
replace PPotatoes = 61.8251928  if year == 1985
replace PPotatoes = 93.89460154 if year == 1986
replace PPotatoes = 73.3933162  if year == 1987
replace PPotatoes = 56.87660668 if year == 1988
replace PPotatoes = 86.6966581  if year == 1989
replace PPotatoes = 64.26735219 if year == 1990
replace PPotatoes = 94.66580977 if year == 1991
replace PPotatoes = 86.37532134 if year == 1992
replace PPotatoes = 90.23136247 if year == 1993
replace PPotatoes = 114.3958869 if year == 1994
replace PPotatoes = 128.6       if year == 1995
replace PPotatoes = 85.2        if year == 1996
replace PPotatoes = 73          if year == 1997
replace PPotatoes = 146.5       if year == 1998
replace PPotatoes = 118.2       if year == 1999
replace PPotatoes = 100         if year == 2000
replace PPotatoes = 152.05      if year == 2001
replace PPotatoes = 148.03      if year == 2002
replace PPotatoes = 154.21      if year == 2003
replace PPotatoes = 97.62       if year == 2004
replace PPotatoes = 145.49      if year == 2005
replace PPotatoes = 236.31      if year == 2006
replace PPotatoes = 218.4       if year == 2007
replace PPotatoes = 179.1       if year == 2008
replace PPotatoes = 189.9       if year == 2009
replace PPotatoes = 197.6       if year == 2010
replace PPotatoes = 197.6       if year == 2011 // Temp -- update
replace PPotatoes = 197.6       if year == 2012 // Temp -- update


gen     PVeg             = 0
local price_vlist "`price_vlist' PVeg"
replace PVeg = 68          if year == 1979 // Temp -- update
replace PVeg = 68          if year == 1980
replace PVeg = 82.74706868 if year == 1981
replace PVeg = 70.35175879 if year == 1982
replace PVeg = 87.10217755 if year == 1983
replace PVeg = 88.44221106 if year == 1984
replace PVeg = 86.26465662 if year == 1985
replace PVeg = 84.67336683 if year == 1986
replace PVeg = 78.55946399 if year == 1987
replace PVeg = 81.40703518 if year == 1988
replace PVeg = 85.84589615 if year == 1989
replace PVeg = 83.7520938  if year == 1990
replace PVeg = 88.86097152 if year == 1991
replace PVeg = 80.82077052 if year == 1992
replace PVeg = 88.44221106 if year == 1993
replace PVeg = 89.61474037 if year == 1994
replace PVeg = 92.5        if year == 1995
replace PVeg = 96.3        if year == 1996
replace PVeg = 92.1        if year == 1997
replace PVeg = 97.8        if year == 1998
replace PVeg = 97.2        if year == 1999
replace PVeg = 100         if year == 2000
replace PVeg = 105.39      if year == 2001
replace PVeg = 114.93      if year == 2002
replace PVeg = 110.04      if year == 2003
replace PVeg = 110.69      if year == 2004
replace PVeg = 116.11      if year == 2005
replace PVeg = 123.65      if year == 2006
replace PVeg = 138.1       if year == 2007
replace PVeg = 139         if year == 2008
replace PVeg = 130.9       if year == 2009
replace PVeg = 130.9       if year == 2010
replace PVeg = 130.9       if year == 2011 // Temp -- update
replace PVeg = 130.9       if year == 2012 // Temp -- update


gen     PTotalCrop       = 0
local price_vlist "`price_vlist' PTotalCrop"
replace PTotalCrop = 85          if year == 1979 // Temp -- update
replace PTotalCrop = 85          if year == 1980
replace PTotalCrop = 96.47532729 if year == 1981
replace PTotalCrop = 102.9204431 if year == 1982
replace PTotalCrop = 112.9909366 if year == 1983
replace PTotalCrop = 117.2205438 if year == 1984
replace PTotalCrop = 98.69083585 if year == 1985
replace PTotalCrop = 106.6465257 if year == 1986
replace PTotalCrop = 102.4169184 if year == 1987
replace PTotalCrop = 101.9133938 if year == 1988
replace PTotalCrop = 108.5599194 if year == 1989
replace PTotalCrop = 100.7049345 if year == 1990
replace PTotalCrop = 104.5317221 if year == 1991
replace PTotalCrop = 101.7119839 if year == 1992
replace PTotalCrop = 106.0422961 if year == 1993
replace PTotalCrop = 106.143001  if year == 1994
replace PTotalCrop = 110.6       if year == 1995
replace PTotalCrop = 100.7       if year == 1996
replace PTotalCrop = 91.2        if year == 1997
replace PTotalCrop = 104.7       if year == 1998
replace PTotalCrop = 103.3       if year == 1999
replace PTotalCrop = 100         if year == 2000
replace PTotalCrop = 112.17      if year == 2001
replace PTotalCrop = 110.41      if year == 2002
replace PTotalCrop = 116.03      if year == 2003
replace PTotalCrop = 104.36      if year == 2004
replace PTotalCrop = 111.99      if year == 2005
replace PTotalCrop = 133.86      if year == 2006
replace PTotalCrop = 162.2       if year == 2007
replace PTotalCrop = 137.9       if year == 2008
replace PTotalCrop = 124.3       if year == 2009
replace PTotalCrop = 144         if year == 2010
replace PTotalCrop = 144         if year == 2011 // Temp -- update
replace PTotalCrop = 144         if year == 2012 // Temp -- update


gen     PTotalInputs     = 0
local price_vlist "`price_vlist' PTotalInputs"
replace PTotalInputs = 62          if year == 1979 // Temp -- update
replace PTotalInputs = 62          if year == 1980
replace PTotalInputs = 71.05022831 if year == 1981
replace PTotalInputs = 77.80821918 if year == 1982
replace PTotalInputs = 84.01826484 if year == 1983
replace PTotalInputs = 90.50228311 if year == 1984
replace PTotalInputs = 91.78082192 if year == 1985
replace PTotalInputs = 88.31050228 if year == 1986
replace PTotalInputs = 84.20091324 if year == 1987
replace PTotalInputs = 86.48401826 if year == 1988
replace PTotalInputs = 91.14155251 if year == 1989
replace PTotalInputs = 91.32420091 if year == 1990
replace PTotalInputs = 91.68949772 if year == 1991
replace PTotalInputs = 91.59817352 if year == 1992
replace PTotalInputs = 91.59817352 if year == 1993
replace PTotalInputs = 92.42009132 if year == 1994
replace PTotalInputs = 93.4        if year == 1995
replace PTotalInputs = 97.3        if year == 1996
replace PTotalInputs = 95.3        if year == 1997
replace PTotalInputs = 93          if year == 1998
replace PTotalInputs = 94.1        if year == 1999
replace PTotalInputs = 100         if year == 2000
replace PTotalInputs = 104.79      if year == 2001
replace PTotalInputs = 106.15      if year == 2002
replace PTotalInputs = 108.8       if year == 2003
replace PTotalInputs = 113.07      if year == 2004
replace PTotalInputs = 117.99      if year == 2005
replace PTotalInputs = 123.07      if year == 2006
replace PTotalInputs = 131.3       if year == 2007
replace PTotalInputs = 155.9       if year == 2008
replace PTotalInputs = 142.2       if year == 2009
replace PTotalInputs = 139.9       if year == 2010
replace PTotalInputs = 139.9       if year == 2011 // Temp -- update
replace PTotalInputs = 139.9       if year == 2012 // Temp -- update


gen     PCalfFeed        = 0
local price_vlist "`price_vlist' PCalfFeed"
replace PCalfFeed = 85          if year == 1979 // Temp -- update
replace PCalfFeed = 85          if year == 1980
replace PCalfFeed = 92.78794403 if year == 1981
replace PCalfFeed = 99.67707212 if year == 1982
replace PCalfFeed = 109.3649085 if year == 1983
replace PCalfFeed = 117.6533907 if year == 1984
replace PCalfFeed = 109.1496233 if year == 1985
replace PCalfFeed = 107.1044133 if year == 1986
replace PCalfFeed = 104.0904198 if year == 1987
replace PCalfFeed = 104.9515608 if year == 1988
replace PCalfFeed = 111.1948332 if year == 1989
replace PCalfFeed = 107.6426265 if year == 1990
replace PCalfFeed = 103.6598493 if year == 1991
replace PCalfFeed = 103.9827772 if year == 1992
replace PCalfFeed = 103.6598493 if year == 1993
replace PCalfFeed = 104.6286329 if year == 1994
replace PCalfFeed = 108.3       if year == 1995
replace PCalfFeed = 111.9       if year == 1996
replace PCalfFeed = 107.7       if year == 1997
replace PCalfFeed = 100.8       if year == 1998
replace PCalfFeed = 97.9        if year == 1999
replace PCalfFeed = 100         if year == 2000
replace PCalfFeed = 103.86      if year == 2001
replace PCalfFeed = 105.77      if year == 2002
replace PCalfFeed = 106.84      if year == 2003
replace PCalfFeed = 110.08      if year == 2004
replace PCalfFeed = 106.39      if year == 2005
replace PCalfFeed = 107.43      if year == 2006
replace PCalfFeed = 121.9       if year == 2007
replace PCalfFeed = 140.9       if year == 2008
replace PCalfFeed = 128.2       if year == 2009
replace PCalfFeed = 123.4       if year == 2010
replace PCalfFeed = 123.4       if year == 2011 // Temp -- update
replace PCalfFeed = 123.4       if year == 2012 // Temp -- update


gen     PCattleFeed      = 0
local price_vlist "`price_vlist' PCattleFeed"
replace PCattleFeed = 86          if year == 1979 // Temp -- update
replace PCattleFeed = 86          if year == 1980
replace PCattleFeed = 91.97465681 if year == 1981
replace PCattleFeed = 99.15522703 if year == 1982
replace PCattleFeed = 108.4477297 if year == 1983
replace PCattleFeed = 117.5290391 if year == 1984
replace PCattleFeed = 107.3917635 if year == 1985
replace PCattleFeed = 104.3294615 if year == 1986
replace PCattleFeed = 100.844773  if year == 1987
replace PCattleFeed = 102.1119324 if year == 1988
replace PCattleFeed = 108.2365364 if year == 1989
replace PCattleFeed = 105.5966209 if year == 1990
replace PCattleFeed = 101.4783527 if year == 1991
replace PCattleFeed = 102.0063358 if year == 1992
replace PCattleFeed = 102.8511088 if year == 1993
replace PCattleFeed = 104.5406547 if year == 1994
replace PCattleFeed = 106         if year == 1995
replace PCattleFeed = 110.7       if year == 1996
replace PCattleFeed = 104.4       if year == 1997
replace PCattleFeed = 98.3        if year == 1998
replace PCattleFeed = 96.5        if year == 1999
replace PCattleFeed = 100         if year == 2000
replace PCattleFeed = 106.41      if year == 2001
replace PCattleFeed = 107.84      if year == 2002
replace PCattleFeed = 107.74      if year == 2003
replace PCattleFeed = 111.71      if year == 2004
replace PCattleFeed = 108.85      if year == 2005
replace PCattleFeed = 111.23      if year == 2006
replace PCattleFeed = 126.7       if year == 2007
replace PCattleFeed = 147.4       if year == 2008
replace PCattleFeed = 132         if year == 2009
replace PCattleFeed = 122.9       if year == 2010
replace PCattleFeed = 122.9       if year == 2011 // Temp -- update
replace PCattleFeed = 122.9       if year == 2012 // Temp -- update


gen     PfertiliserNPK   = 0
local price_vlist "`price_vlist' PfertiliserNPK"
replace PfertiliserNPK = 84          if year == 1979 // Temp -- update
replace PfertiliserNPK = 84          if year == 1980
replace PfertiliserNPK = 95.421436   if year == 1981
replace PfertiliserNPK = 101.9771072 if year == 1982
replace PfertiliserNPK = 102.6014568 if year == 1983
replace PfertiliserNPK = 112.6951093 if year == 1984
replace PfertiliserNPK = 123.3090531 if year == 1985
replace PfertiliserNPK = 116.024974  if year == 1986
replace PfertiliserNPK = 91.77939646 if year == 1987
replace PfertiliserNPK = 96.87825182 if year == 1988
replace PfertiliserNPK = 104.0582726 if year == 1989
replace PfertiliserNPK = 104.0582726 if year == 1990
replace PfertiliserNPK = 105.723205  if year == 1991
replace PfertiliserNPK = 104.1623309 if year == 1992
replace PfertiliserNPK = 98.95941727 if year == 1993
replace PfertiliserNPK = 98.95941727 if year == 1994
replace PfertiliserNPK = 98.3        if year == 1995
replace PfertiliserNPK = 102.5       if year == 1996
replace PfertiliserNPK = 96.4        if year == 1997
replace PfertiliserNPK = 93.4        if year == 1998
replace PfertiliserNPK = 94.5        if year == 1999
replace PfertiliserNPK = 100         if year == 2000
replace PfertiliserNPK = 111.58      if year == 2001
replace PfertiliserNPK = 108.36      if year == 2002
replace PfertiliserNPK = 111.46      if year == 2003
replace PfertiliserNPK = 112.2       if year == 2004
replace PfertiliserNPK = 121.19      if year == 2005
replace PfertiliserNPK = 129.19      if year == 2006
replace PfertiliserNPK = 132.3       if year == 2007
replace PfertiliserNPK = 222.7       if year == 2008
replace PfertiliserNPK = 190.4       if year == 2009
replace PfertiliserNPK = 165.8       if year == 2010
replace PfertiliserNPK = 165.8       if year == 2010 // Temp -- update
replace PfertiliserNPK = 165.8       if year == 2012 // Temp -- update


gen     PfertiliserPK    = 0
local price_vlist "`price_vlist' PfertiliserPK"
replace PfertiliserPK = 75          if year == 1979 // Temp -- update
replace PfertiliserPK = 75          if year == 1980
replace PfertiliserPK = 87.47628083 if year == 1981
replace PfertiliserPK = 90.60721063 if year == 1982
replace PfertiliserPK = 90.89184061 if year == 1983
replace PfertiliserPK = 101.7077799 if year == 1984
replace PfertiliserPK = 109.772296  if year == 1985
replace PfertiliserPK = 97.81783681 if year == 1986
replace PfertiliserPK = 81.87855787 if year == 1987
replace PfertiliserPK = 88.80455408 if year == 1988
replace PfertiliserPK = 95.82542694 if year == 1989
replace PfertiliserPK = 94.87666034 if year == 1990
replace PfertiliserPK = 90.13282732 if year == 1991
replace PfertiliserPK = 90.51233397 if year == 1992
replace PfertiliserPK = 84.34535104 if year == 1993
replace PfertiliserPK = 86.43263757 if year == 1994
replace PfertiliserPK = 88.5        if year == 1995
replace PfertiliserPK = 92.7        if year == 1996
replace PfertiliserPK = 88.7        if year == 1997
replace PfertiliserPK = 88.5        if year == 1998
replace PfertiliserPK = 96.3        if year == 1999
replace PfertiliserPK = 100         if year == 2000
replace PfertiliserPK = 104.49      if year == 2001
replace PfertiliserPK = 103.29      if year == 2002
replace PfertiliserPK = 104.98      if year == 2003
replace PfertiliserPK = 106.24      if year == 2004
replace PfertiliserPK = 110.01      if year == 2005
replace PfertiliserPK = 115.92      if year == 2006
replace PfertiliserPK = 123.5       if year == 2007
replace PfertiliserPK = 234.3       if year == 2008
replace PfertiliserPK = 254.2       if year == 2009
replace PfertiliserPK = 193.2       if year == 2010
replace PfertiliserPK = 193.2       if year == 2011 // Temp -- update
replace PfertiliserPK = 193.2       if year == 2012 // Temp -- update


gen     PTotalFert       = 0
local price_vlist "`price_vlist' PTotalFert"
replace PTotalFert = 81          if year == 1979 // Temp -- update
replace PTotalFert = 81          if year == 1980
replace PTotalFert = 92.64112903 if year == 1981
replace PTotalFert = 98.48790323 if year == 1982
replace PTotalFert = 99.69758065 if year == 1983
replace PTotalFert = 109.4758065 if year == 1984
replace PTotalFert = 119.858871  if year == 1985
replace PTotalFert = 109.6774194 if year == 1986
replace PTotalFert = 88.20564516 if year == 1987
replace PTotalFert = 94.55645161 if year == 1988
replace PTotalFert = 101.0080645 if year == 1989
replace PTotalFert = 100.8064516 if year == 1990
replace PTotalFert = 103.0241935 if year == 1991
replace PTotalFert = 101.4112903 if year == 1992
replace PTotalFert = 95.76612903 if year == 1993
replace PTotalFert = 96.27016129 if year == 1994
replace PTotalFert = 96.4        if year == 1995
replace PTotalFert = 101         if year == 1996
replace PTotalFert = 94.8        if year == 1997
replace PTotalFert = 91.3        if year == 1998
replace PTotalFert = 93.3        if year == 1999
replace PTotalFert = 100         if year == 2000
replace PTotalFert = 113.43      if year == 2001
replace PTotalFert = 110.51      if year == 2002
replace PTotalFert = 113.02      if year == 2003
replace PTotalFert = 115.14      if year == 2004
replace PTotalFert = 124.46      if year == 2005
replace PTotalFert = 133.1       if year == 2006
replace PTotalFert = 136.4       if year == 2007
replace PTotalFert = 220.6       if year == 2008
replace PTotalFert = 185         if year == 2009
replace PTotalFert = 162.2       if year == 2010
replace PTotalFert = 162.2       if year == 2011 // Temp -- update
replace PTotalFert = 162.2       if year == 2012 // Temp -- update


gen     PSeeds           = 0
local price_vlist "`price_vlist' PSeeds"
replace PSeeds = 53          if year == 1979 // Temp -- update
replace PSeeds = 53          if year == 1980
replace PSeeds = 55.92563904 if year == 1981
replace PSeeds = 61.65762974 if year == 1982
replace PSeeds = 65.76297444 if year == 1983
replace PSeeds = 74.20604183 if year == 1984
replace PSeeds = 72.42447715 if year == 1985
replace PSeeds = 77.45933385 if year == 1986
replace PSeeds = 78.31138652 if year == 1987
replace PSeeds = 75.60030984 if year == 1988
replace PSeeds = 75.60030984 if year == 1989
replace PSeeds = 77.45933385 if year == 1990
replace PSeeds = 78.46630519 if year == 1991
replace PSeeds = 83.57862122 if year == 1992
replace PSeeds = 84.19829589 if year == 1993
replace PSeeds = 89.62044926 if year == 1994
replace PSeeds = 98          if year == 1995
replace PSeeds = 103.4       if year == 1996
replace PSeeds = 100.5       if year == 1997
replace PSeeds = 102         if year == 1998
replace PSeeds = 102.1       if year == 1999
replace PSeeds = 100         if year == 2000
replace PSeeds = 103.68      if year == 2001
replace PSeeds = 107.35      if year == 2002
replace PSeeds = 115.15      if year == 2003
replace PSeeds = 116.14      if year == 2004
replace PSeeds = 115.66      if year == 2005
replace PSeeds = 120.11      if year == 2006
replace PSeeds = 130.8       if year == 2007
replace PSeeds = 141.9       if year == 2008
replace PSeeds = 131.6       if year == 2009
replace PSeeds = 122.1       if year == 2010
replace PSeeds = 122.1       if year == 2011 // Temp -- update
replace PSeeds = 122.1       if year == 2012 // Temp -- update


gen     PMotorFuels      = 0
local price_vlist "`price_vlist' PMotorFuels"
replace PMotorFuels = 41          if year == 1979 // Temp -- update
replace PMotorFuels = 41          if year == 1980
replace PMotorFuels = 55.74112735 if year == 1981
replace PMotorFuels = 64.09185804 if year == 1982
replace PMotorFuels = 72.16423104 if year == 1983
replace PMotorFuels = 75.71329158 if year == 1984
replace PMotorFuels = 78.70563674 if year == 1985
replace PMotorFuels = 61.65622825 if year == 1986
replace PMotorFuels = 62.14335421 if year == 1987
replace PMotorFuels = 60.61238692 if year == 1988
replace PMotorFuels = 66.04036186 if year == 1989
replace PMotorFuels = 69.58942241 if year == 1990
replace PMotorFuels = 71.25956855 if year == 1991
replace PMotorFuels = 65.62282533 if year == 1992
replace PMotorFuels = 67.710508   if year == 1993
replace PMotorFuels = 65.55323591 if year == 1994
replace PMotorFuels = 66          if year == 1995
replace PMotorFuels = 71.8        if year == 1996
replace PMotorFuels = 73.5        if year == 1997
replace PMotorFuels = 70.5        if year == 1998
replace PMotorFuels = 75.6        if year == 1999
replace PMotorFuels = 100         if year == 2000
replace PMotorFuels = 95.78       if year == 2001
replace PMotorFuels = 94.73       if year == 2002
replace PMotorFuels = 99.06       if year == 2003
replace PMotorFuels = 110.17      if year == 2004
replace PMotorFuels = 131.72      if year == 2005
replace PMotorFuels = 144.08      if year == 2006
replace PMotorFuels = 147.3       if year == 2007
replace PMotorFuels = 173.6       if year == 2008
replace PMotorFuels = 143.5       if year == 2009
replace PMotorFuels = 168.6       if year == 2010
replace PMotorFuels = 168.6       if year == 2011 // Temp -- update
replace PMotorFuels = 168.6       if year == 2012 // Temp -- update


gen     PElectricity     = 0
local price_vlist "`price_vlist' PElectricity"
replace PElectricity = 62          if year == 1979 // Temp -- update
replace PElectricity = 62          if year == 1980
replace PElectricity = 77.88554801 if year == 1981
replace PElectricity = 92.53152279 if year == 1982
replace PElectricity = 98.73908826 if year == 1983
replace PElectricity = 104.6556741 if year == 1984
replace PElectricity = 110.8632396 if year == 1985
replace PElectricity = 113.7730359 if year == 1986
replace PElectricity = 106.013579  if year == 1987
replace PElectricity = 101.842871  if year == 1988
replace PElectricity = 100.8729389 if year == 1989
replace PElectricity = 96.99321048 if year == 1990
replace PElectricity = 96.02327837 if year == 1991
replace PElectricity = 96.02327837 if year == 1992
replace PElectricity = 96.02327837 if year == 1993
replace PElectricity = 96.02327837 if year == 1994
replace PElectricity = 96          if year == 1995
replace PElectricity = 97.5        if year == 1996
replace PElectricity = 99.4        if year == 1997
replace PElectricity = 100         if year == 1998
replace PElectricity = 100         if year == 1999
replace PElectricity = 100         if year == 2000
replace PElectricity = 101.48      if year == 2001
replace PElectricity = 105.93      if year == 2002
replace PElectricity = 119.57      if year == 2003
replace PElectricity = 125.69      if year == 2004
replace PElectricity = 135.71      if year == 2005
replace PElectricity = 141.61      if year == 2006
replace PElectricity = 157.6       if year == 2007
replace PElectricity = 159.9       if year == 2008
replace PElectricity = 167.4       if year == 2009
replace PElectricity = 156.9       if year == 2010
replace PElectricity = 156.9       if year == 2011 // Temp -- update
replace PElectricity = 156.9       if year == 2012 // Temp -- update


gen     PTotalEnergy     = 0
local price_vlist "`price_vlist' PTotalEnergy"
replace PTotalEnergy = 44          if year == 1979 // Temp -- update
replace PTotalEnergy = 44          if year == 1980
replace PTotalEnergy = 59.76243504 if year == 1981
replace PTotalEnergy = 68.67112101 if year == 1982
replace PTotalEnergy = 76.54046028 if year == 1983
replace PTotalEnergy = 80.62360802 if year == 1984
replace PTotalEnergy = 84.26132146 if year == 1985
replace PTotalEnergy = 70.3043801  if year == 1986
replace PTotalEnergy = 69.48775056 if year == 1987
replace PTotalEnergy = 67.55753526 if year == 1988
replace PTotalEnergy = 71.86340015 if year == 1989
replace PTotalEnergy = 74.23904974 if year == 1990
replace PTotalEnergy = 75.57535264 if year == 1991
replace PTotalEnergy = 71.1952487  if year == 1992
replace PTotalEnergy = 72.97698589 if year == 1993
replace PTotalEnergy = 71.3437268  if year == 1994
replace PTotalEnergy = 71.7        if year == 1995
replace PTotalEnergy = 76.6        if year == 1996
replace PTotalEnergy = 78.2        if year == 1997
replace PTotalEnergy = 75.9        if year == 1998
replace PTotalEnergy = 80.2        if year == 1999
replace PTotalEnergy = 100         if year == 2000
replace PTotalEnergy = 97.08       if year == 2001
replace PTotalEnergy = 97.14       if year == 2002
replace PTotalEnergy = 102.92      if year == 2003
replace PTotalEnergy = 112.58      if year == 2004
replace PTotalEnergy = 131.7       if year == 2005
replace PTotalEnergy = 143.12      if year == 2006
replace PTotalEnergy = 148.1       if year == 2007
replace PTotalEnergy = 168.9       if year == 2008
replace PTotalEnergy = 146.1       if year == 2009
replace PTotalEnergy = 164.7       if year == 2010
replace PTotalEnergy = 164.7       if year == 2011 // Temp -- update
replace PTotalEnergy = 164.7       if year == 2012 // Temp -- update


gen     PPlantProtection = 0
local price_vlist "`price_vlist' PPlantProtection"
replace PPlantProtection = 57          if year == 1979 // Temp -- update
replace PPlantProtection = 57          if year == 1980
replace PPlantProtection = 65.54694229 if year == 1981
replace PPlantProtection = 71.4039621  if year == 1982
replace PPlantProtection = 73.29888028 if year == 1983
replace PPlantProtection = 77.95004307 if year == 1984
replace PPlantProtection = 80.01722653 if year == 1985
replace PPlantProtection = 80.36175711 if year == 1986
replace PPlantProtection = 80.27562446 if year == 1987
replace PPlantProtection = 82.25667528 if year == 1988
replace PPlantProtection = 83.37639966 if year == 1989
replace PPlantProtection = 86.13264427 if year == 1990
replace PPlantProtection = 88.80275624 if year == 1991
replace PPlantProtection = 89.66408269 if year == 1992
replace PPlantProtection = 91.73126615 if year == 1993
replace PPlantProtection = 95.00430663 if year == 1994
replace PPlantProtection = 97.5        if year == 1995
replace PPlantProtection = 100.8       if year == 1996
replace PPlantProtection = 100.4       if year == 1997
replace PPlantProtection = 100.8       if year == 1998
replace PPlantProtection = 100.6       if year == 1999
replace PPlantProtection = 100         if year == 2000
replace PPlantProtection = 100.83      if year == 2001
replace PPlantProtection = 101.64      if year == 2002
replace PPlantProtection = 101.61      if year == 2003
replace PPlantProtection = 103.22      if year == 2004
replace PPlantProtection = 102.69      if year == 2005
replace PPlantProtection = 101.72      if year == 2006
replace PPlantProtection = 101.7       if year == 2007
replace PPlantProtection = 103.2       if year == 2008
replace PPlantProtection = 105.1       if year == 2009
replace PPlantProtection = 105.2       if year == 2010
replace PPlantProtection = 105.2       if year == 2011 // Temp -- update
replace PPlantProtection = 105.2       if year == 2012 // Temp -- update


gen     PVetExp          = 0
local price_vlist "`price_vlist' PVetExp"
replace PVetExp = 36          if year == 1979 // Temp -- update
replace PVetExp = 36          if year == 1980
replace PVetExp = 40.04441155 if year == 1981
replace PVetExp = 46.33604737 if year == 1982
replace PVetExp = 50.62916358 if year == 1983
replace PVetExp = 57.51295337 if year == 1984
replace PVetExp = 64.54478164 if year == 1985
replace PVetExp = 66.76535899 if year == 1986
replace PVetExp = 66.39526277 if year == 1987
replace PVetExp = 68.61584012 if year == 1988
replace PVetExp = 71.35455218 if year == 1989
replace PVetExp = 74.019245   if year == 1990
replace PVetExp = 77.05403405 if year == 1991
replace PVetExp = 79.57068838 if year == 1992
replace PVetExp = 81.56920799 if year == 1993
replace PVetExp = 83.04959289 if year == 1994
replace PVetExp = 85.8        if year == 1995
replace PVetExp = 89.3        if year == 1996
replace PVetExp = 92.3        if year == 1997
replace PVetExp = 94.7        if year == 1998
replace PVetExp = 95.9        if year == 1999
replace PVetExp = 100         if year == 2000
replace PVetExp = 104.66      if year == 2001
replace PVetExp = 109.36      if year == 2002
replace PVetExp = 114.67      if year == 2003
replace PVetExp = 115.78      if year == 2004
replace PVetExp = 117.62      if year == 2005
replace PVetExp = 122.43      if year == 2006
replace PVetExp = 126.2       if year == 2007
replace PVetExp = 128.9       if year == 2008
replace PVetExp = 130.9       if year == 2009
replace PVetExp = 131.1       if year == 2010
replace PVetExp = 131.1       if year == 2011 // Temp -- update
replace PVetExp = 131.1       if year == 2012 // Temp -- update


gen     POtherInputs     = 0
local price_vlist "`price_vlist' POtherInputs"
replace POtherInputs = 42          if year == 1979 // Temp -- update
replace POtherInputs = 42          if year == 1980
replace POtherInputs = 50.0792393  if year == 1981
replace POtherInputs = 56.89381933 if year == 1982
replace POtherInputs = 61.6481775  if year == 1983
replace POtherInputs = 66.40253566 if year == 1984
replace POtherInputs = 69.96830428 if year == 1985
replace POtherInputs = 71.71156894 if year == 1986
replace POtherInputs = 73.6133122  if year == 1987
replace POtherInputs = 76.06973059 if year == 1988
replace POtherInputs = 77.65451664 if year == 1989
replace POtherInputs = 79.23930269 if year == 1990
replace POtherInputs = 81.93343899 if year == 1991
replace POtherInputs = 84.15213946 if year == 1992
replace POtherInputs = 85.65768621 if year == 1993
replace POtherInputs = 87.48019017 if year == 1994
replace POtherInputs = 90.3        if year == 1995
replace POtherInputs = 91.2        if year == 1996
replace POtherInputs = 92.7        if year == 1997
replace POtherInputs = 93.6        if year == 1998
replace POtherInputs = 95.9        if year == 1999
replace POtherInputs = 100         if year == 2000
replace POtherInputs = 105.92      if year == 2001
replace POtherInputs = 110.35      if year == 2002
replace POtherInputs = 114.09      if year == 2003
replace POtherInputs = 116.91      if year == 2004
replace POtherInputs = 121         if year == 2005
replace POtherInputs = 124.04      if year == 2006
replace POtherInputs = 128.9       if year == 2007
replace POtherInputs = 136.8       if year == 2008
replace POtherInputs = 139.2       if year == 2009
replace POtherInputs = 137.3       if year == 2010
replace POtherInputs = 137.3       if year == 2011 // Temp -- update
replace POtherInputs = 137.3       if year == 2012 // Temp -- update


gen     CPI              = 0
local price_vlist "`price_vlist' CPI"
replace CPI = 33          if year == 1979 // Temp -- update
replace CPI = 33          if year == 1980
replace CPI = 39.24117856 if year == 1981
replace CPI = 47.24637899 if year == 1982
replace CPI = 55.3255098  if year == 1983
replace CPI = 61.07936282 if year == 1984
replace CPI = 66.33218802 if year == 1985
replace CPI = 69.91412617 if year == 1986
replace CPI = 72.64077709 if year == 1987
replace CPI = 74.96528196 if year == 1988
replace CPI = 76.53955288 if year == 1989
replace CPI = 79.60113499 if year == 1990
replace CPI = 82.30757358 if year == 1991
replace CPI = 84.94141594 if year == 1992
replace CPI = 87.48965842 if year == 1993
replace CPI = 88.80200329 if year == 1994
replace CPI = 90.93325137 if year == 1995
replace CPI = 93.20658266 if year == 1996
replace CPI = 94.69788798 if year == 1997
replace CPI = 96.1183563  if year == 1998
replace CPI = 98.42519685 if year == 1999
replace CPI = 100         if year == 2000
replace CPI = 104.9       if year == 2001
replace CPI = 109.7254    if year == 2002
replace CPI = 113.565789  if year == 2003
replace CPI = 116.0642364 if year == 2004
replace CPI = 118.9658423 if year == 2005
replace CPI = 123.724476  if year == 2006
replace CPI = 129.7869753 if year == 2007
replace CPI = 135.1082413 if year == 2008
replace CPI = 128.2987859 if year == 2009
replace CPI = 130.0281714 if year == 2010
replace CPI = 130.0281714 if year == 2011
replace CPI = 130.0281714 if year == 2012


gen     PTransportcap    = 0
local price_vlist "`price_vlist' PTransportcap"
replace PTransportcap = 31          if year == 1979 // Temp -- update
replace PTransportcap = 31          if year == 1980
replace PTransportcap = 36.2292725  if year == 1981
replace PTransportcap = 43.62004409 if year == 1982
replace PTransportcap = 51.07907163 if year == 1983
replace PTransportcap = 56.39129507 if year == 1984
replace PTransportcap = 61.24094645 if year == 1985
replace PTransportcap = 64.54795756 if year == 1986
replace PTransportcap = 67.0653279  if year == 1987
replace PTransportcap = 69.2114184  if year == 1988
replace PTransportcap = 70.66485818 if year == 1989
replace PTransportcap = 73.49145251 if year == 1990
replace PTransportcap = 75.9901619  if year == 1991
replace PTransportcap = 78.42184708 if year == 1992
replace PTransportcap = 80.77450249 if year == 1993
replace PTransportcap = 81.98612003 if year == 1994
replace PTransportcap = 83.95378691 if year == 1995
replace PTransportcap = 86.05263158 if year == 1996
replace PTransportcap = 88.50877193 if year == 1997
replace PTransportcap = 89.8245614  if year == 1998
replace PTransportcap = 92.36842105 if year == 1999
replace PTransportcap = 100         if year == 2000
replace PTransportcap = 101.3157895 if year == 2001
replace PTransportcap = 104.0513158 if year == 2002
replace PTransportcap = 108.3065789 if year == 2003
replace PTransportcap = 109.6236842 if year == 2004
replace PTransportcap = 109.6236842 if year == 2005
replace PTransportcap = 111.0421053 if year == 2006
replace PTransportcap = 116.4831684 if year == 2007
replace PTransportcap = 121.2589783 if year == 2008
replace PTransportcap = 122         if year == 2009 // Temp -- update
replace PTransportcap = 122         if year == 2010 // Temp -- update
replace PTransportcap = 122         if year == 2011 // Temp -- update
replace PTransportcap = 122         if year == 2012 // Temp -- update


gen     POthercap        = 0
local price_vlist "`price_vlist' POthercap"
replace POthercap = 32          if year == 1979 // Temp -- update
replace POthercap = 32          if year == 1980
replace POthercap = 38.26343789 if year == 1981
replace POthercap = 46.06917923 if year == 1982
replace POthercap = 53.94700887 if year == 1983
replace POthercap = 59.5574978  if year == 1984
replace POthercap = 64.67944261 if year == 1985
replace POthercap = 68.17213251 if year == 1986
replace POthercap = 70.83084567 if year == 1987
replace POthercap = 73.09743274 if year == 1988
replace POthercap = 74.63247882 if year == 1989
replace POthercap = 77.61777798 if year == 1990
replace POthercap = 80.25678243 if year == 1991
replace POthercap = 82.82499947 if year == 1992
replace POthercap = 85.30974945 if year == 1993
replace POthercap = 86.58939569 if year == 1994
replace POthercap = 88.66754119 if year == 1995
replace POthercap = 90.88422972 if year == 1996
replace POthercap = 91.97812215 if year == 1997
replace POthercap = 94.62169553 if year == 1998
replace POthercap = 96.35369189 if year == 1999
replace POthercap = 100         if year == 2000
replace POthercap = 104.7402005 if year == 2001
replace POthercap = 105.473382  if year == 2002
replace POthercap = 107.044485  if year == 2003
replace POthercap = 109.9772106 if year == 2004
replace POthercap = 109.7677302 if year == 2005
replace POthercap = 109.2440292 if year == 2006
replace POthercap = 114.5969866 if year == 2007
replace POthercap = 119.2954631 if year == 2008
replace POthercap = 120         if year == 2009 // Temp -- update
replace POthercap = 120         if year == 2010 // Temp -- update
replace POthercap = 120         if year == 2011 // Temp -- update
replace POthercap = 120         if year == 2012 // Temp -- update


* Convert punts to Euro
*  Actually, looks like Euro already
local punt_to_euro = .787564
local time_cond    "!missing(t)"
local monetary_vlist "`monetary_vlist' fainvmch" // ok  
local monetary_vlist "`monetary_vlist' fainvbld" // ok 
local monetary_vlist "`monetary_vlist' fainvlim" // ok
*local monetary_vlist "`monetary_vlist' fvalflab" // Dodgy (hard-coded ag wage)
local monetary_vlist "`monetary_vlist' fdcaslab" // ok 
local monetary_vlist "`monetary_vlist' fohirlab" // ok 
local monetary_vlist "`monetary_vlist' fointpay" // ok 
local monetary_vlist "`monetary_vlist' fomacopt" // ok 
local monetary_vlist "`monetary_vlist' fobldmnt" // ok 
local monetary_vlist "`monetary_vlist' foupkpld" // ok 
local monetary_vlist "`monetary_vlist' foexlime" // ok
local monetary_vlist "`monetary_vlist' foannuit" // ok 
local monetary_vlist "`monetary_vlist' forates"  // ok 
local monetary_vlist "`monetary_vlist' foinsure" // ok 
local monetary_vlist "`monetary_vlist' fofuellu" // ok 
local monetary_vlist "`monetary_vlist' foelecfs" // ok 
local monetary_vlist "`monetary_vlist' fophonfs" // ok 
local monetary_vlist "`monetary_vlist' fortfmer" // Don't have, alt.
local monetary_vlist "`monetary_vlist' fortnfer" // Don't have,set =0
local monetary_vlist "`monetary_vlist' fomiscel" // ok 
local monetary_vlist "`monetary_vlist' fdairygo" // ok 
local monetary_vlist "`monetary_vlist' fcropsgo" // ok 
local monetary_vlist "`monetary_vlist' fcplivgo" // ok 
local monetary_vlist "`monetary_vlist' fgrtsubs" // ok 
local monetary_vlist "`monetary_vlist' iaisfdy"  // ok
local monetary_vlist "`monetary_vlist' iaisfcat" // ok
local monetary_vlist "`monetary_vlist' iaisfshp" // ok


/*  Dodgy formula for D_VALUE_OF_FAMILY_LABOUR_EU (fvalflab)
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


/*
* Only six subs actually used! (those with comments)
local monetary_vlist "`monetary_vlist' fbelclbl" // Set=0,can be calc
local monetary_vlist "`monetary_vlist' fsubhors"
local monetary_vlist "`monetary_vlist' fsubtbco" // Don't have,set =0
local monetary_vlist "`monetary_vlist' fsubforh" // Don't have,set =0
local monetary_vlist "`monetary_vlist' fsubesag" // Don't have,set =0
local monetary_vlist "`monetary_vlist' fsubyfig" // Don't have,set =0
local monetary_vlist "`monetary_vlist' fsubreps" // Don't have,set =0
local monetary_vlist "`monetary_vlist' fsubscno"
local monetary_vlist "`monetary_vlist' fsubscen"
local monetary_vlist "`monetary_vlist' fsubsccp"
local monetary_vlist "`monetary_vlist' fsubscpp"
local monetary_vlist "`monetary_vlist' fsubsctp"
local monetary_vlist "`monetary_vlist' fsub10no"
local monetary_vlist "`monetary_vlist' fsub10en"
local monetary_vlist "`monetary_vlist' fsub10cp"
local monetary_vlist "`monetary_vlist' fsub10pp"
local monetary_vlist "`monetary_vlist' fsub10tp"
local monetary_vlist "`monetary_vlist' fsub22no"
local monetary_vlist "`monetary_vlist' fsub22en"
local monetary_vlist "`monetary_vlist' fsub22cp"
local monetary_vlist "`monetary_vlist' fsub22pp"
local monetary_vlist "`monetary_vlist' fsub22tp"
local monetary_vlist "`monetary_vlist' fsubspno"
local monetary_vlist "`monetary_vlist' fsubspen"
local monetary_vlist "`monetary_vlist' fsubspcp"
local monetary_vlist "`monetary_vlist' fsubsppp"
local monetary_vlist "`monetary_vlist' fsubsptp"
local monetary_vlist "`monetary_vlist' fsubexno"
local monetary_vlist "`monetary_vlist' fsubexen"
local monetary_vlist "`monetary_vlist' fsubexcp"
local monetary_vlist "`monetary_vlist' fsubexpp"
local monetary_vlist "`monetary_vlist' fsubextp"
local monetary_vlist "`monetary_vlist' fsubchno"
local monetary_vlist "`monetary_vlist' fsubchen"
local monetary_vlist "`monetary_vlist' fsubchcp"
local monetary_vlist "`monetary_vlist' fsubchpp"
local monetary_vlist "`monetary_vlist' fsubchtp"
local monetary_vlist "`monetary_vlist' fsubepno"
local monetary_vlist "`monetary_vlist' fsubepen"
local monetary_vlist "`monetary_vlist' fsubepcp"
local monetary_vlist "`monetary_vlist' fsubeppp"
local monetary_vlist "`monetary_vlist' fsubeptp"
local monetary_vlist "`monetary_vlist' fsubshno"
local monetary_vlist "`monetary_vlist' fsubshen"
local monetary_vlist "`monetary_vlist' fsubshcp"
local monetary_vlist "`monetary_vlist' fsubshpp"
local monetary_vlist "`monetary_vlist' fsubshtp"
local monetary_vlist "`monetary_vlist' fsubgpcm"
local monetary_vlist "`monetary_vlist' fsubtups"
local monetary_vlist "`monetary_vlist' fsubasac"
local monetary_vlist "`monetary_vlist' fsubaspd"
local monetary_vlist "`monetary_vlist' fsubascp"
local monetary_vlist "`monetary_vlist' fsubaspp"
local monetary_vlist "`monetary_vlist' fsubastp"
local monetary_vlist "`monetary_vlist' fsubcaac"
local monetary_vlist "`monetary_vlist' fsubcapd"
local monetary_vlist "`monetary_vlist' fsubcacp"
local monetary_vlist "`monetary_vlist' fsubcapp"
local monetary_vlist "`monetary_vlist' fsubcatp"
local monetary_vlist "`monetary_vlist' fsubrpac"
local monetary_vlist "`monetary_vlist' fsubrppd"
local monetary_vlist "`monetary_vlist' fsubrpcp"
local monetary_vlist "`monetary_vlist' fsubrppp"
local monetary_vlist "`monetary_vlist' fsubrptp"
local monetary_vlist "`monetary_vlist' fsubpbac"
local monetary_vlist "`monetary_vlist' fsubpbpd"
local monetary_vlist "`monetary_vlist' fsubpbcp"
local monetary_vlist "`monetary_vlist' fsubpbpp"
local monetary_vlist "`monetary_vlist' fsubpbtp"
local monetary_vlist "`monetary_vlist' fsubliac"
local monetary_vlist "`monetary_vlist' fsublipd"
local monetary_vlist "`monetary_vlist' fsublicp"
local monetary_vlist "`monetary_vlist' fsublipp"
local monetary_vlist "`monetary_vlist' fsublitp"
local monetary_vlist "`monetary_vlist' fsubmzac"
local monetary_vlist "`monetary_vlist' fsubmzpd"
local monetary_vlist "`monetary_vlist' fsubmzcp"
local monetary_vlist "`monetary_vlist' fsubmzpp"
local monetary_vlist "`monetary_vlist' fsubmztp"
local monetary_vlist "`monetary_vlist' fsubvstp"
local monetary_vlist "`monetary_vlist' dpclinvd"
local monetary_vlist "`monetary_vlist' dotomkvl"
local monetary_vlist "`monetary_vlist' dosubsvl"
local monetary_vlist "`monetary_vlist' ddconval"
local monetary_vlist "`monetary_vlist' ddpastur"
local monetary_vlist "`monetary_vlist' ddwinfor"
local monetary_vlist "`monetary_vlist' ddmiscdc"
local monetary_vlist "`monetary_vlist' foadvfee" 

foreach var of local monetary_vlist {
	replace `var' = `var' / `punt_to_euro' if `time_cond'

}

*/
*/



merge m:1 year using `outdatadir'/cso_p_indices.dta, nogen


* Sample selection, keep only specialist dairy (non-hill farms) 
keep if FARM_SYSTEM == 1 & D_SOIL_GROUP < 3



/* create input allocation variable according to gross output */
capture drop alloc
gen     alloc = fdairygo / fcplivgo
replace alloc = 1 if alloc>1
replace alloc = 0 if alloc<0



/* Create Capital Input
    (end of year book values = machinery+buildings) */
gen C = alloc    *                           ///
         (                                ///
           ((fainvmch/PTransportcap)*100)  + ///
           ((fainvbld/POthercap)    *100)    ///
         )



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


* TODO is this still correct? What units are the raw data in?
/*convert early years to LITRES! and rename output var */
replace dotomkgl = dotomkgl * 4.546092 if t==0
replace dotomkgl = dotomkgl * 4.546092 if t==1
replace dotomkgl = dotomkgl * 4.546092 if t==2
replace dotomkgl = dotomkgl * 4.546092 if t==3
replace dotomkgl = dotomkgl * 4.546092 if t==4
replace dotomkgl = dotomkgl * 4.546092 if t==5
replace dotomkgl = dotomkgl * 4.546092 if t==6
rename  dotomkgl   Y1  



* TODO -- Conversion euro probably needs to happed BEFORE deflation.
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
drop if Y2<=0
drop if LANDFEED<=0
drop if LANDFAGE<=0
drop if L3<=0
drop if C<=0
drop if DC<=0
drop if H<=0 


tsset FC T



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



* NO IDEA WHAT JAMES WAS CODING HERE -- PRG
* Divide these by their number. If there are 104 2s, then answer 
*  is 86/1 = 86
count if PS==1
count if PS==2
count if PS==3
count if PS==4
count if PS==5
count if PS==6
count if PS==7
count if PS==8
count if PS==9
count if PS==10
count if PS==11



* partial productivity indicators
gen PH = Y2/H
gen PD = Y2/DC
gen PL = Y2/L3  // Temporarily off
gen PA = Y2/LANDFAGE
gen PC = Y2/C

bysort T: sum PH PD PL PA PC



*********************************************************************

* efficiency variables DROP ZEROS IF DOING DESCRIPTIVE STATS!!!!!!!!! 
 
*********************************************************************

*drop if AGE<14 // TEMOPORARY - No ages for 79 - 83 !
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
export excel using ../../code_NLogit/Quota/DAIRY.xls ///
  , firstrow(var) replace nolabel missing(0)

* Bring back full data
restore
* NOTE that you will have more vars here than you are sending to 
*  NLogit. Add to the "keep" command above if you want more for 
*  NLogit.


tabstat Y2 H C L3 DC LANDFAGE LANDFEED FSIZE ALLOC INTENSE AGE AI [weight = W] , by(year)

cd `startdir' // return Stata to start location
