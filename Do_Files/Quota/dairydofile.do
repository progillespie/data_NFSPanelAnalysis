* Set directory macros
local startdir: pwd // save current location

local dodir      ///
   "D:\Data\data_NFSPanelAnalysis\Do_Files\Quota"

local outdatadir    ///
   "D:\Data\data_NFSPanelAnalysis\OutData"

local sub_do ///
   "D:\Data\data_NFSPanelAnalysis\Do_Files\RAW_79_83\sub_do"


/*-----------TURNED OFF---------------------------------------------
-----------BACK ON ---------------------------------------------*/

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



/* These are the best mappings I could come up with for these vars
     but they are NOT what's defined in the System Guide, hence
     I hardcode them here.                */
rename LAND_VALUE_EST_BEG_OF_YEAR_EU  fainvfrm
rename LAND_RENTED_IN_EU              fortfmer



* ===================================================================
* Vars which are not "derived" according to IB, but do need some
*   level of calculation due to differences in survey over time
* ===================================================================
*--------------------------------------------
* fbelclbl 
*--------------------------------------------
capture gen double CLOSING_BALANCE_EU = 0
replace CLOSING_BALANCE_EU =    ///
  E_CLOSING_BALANCE_EU           + ///
  N_CLOSING_BALANCE_EU             ///
  if year < 1984


capture drop fbelclbl
gen double fbelclbl = 0
replace fbelclbl = CLOSING_BALANCE_EU    ///
                                      ///
  if N_LOAN_AMOUNT_BORROWED_EU ==0     & ///
     CLOSING_BALANCE_EU        > 0
*--------------------------------------------

*TODO sort out age variable. Worker code 1 most likely correct one
*--------------------------------------------
* ogagehld 
*--------------------------------------------
*rename FARM_MD_AGE              ogagehld 
gen ogagehld = rnormal(55, 15) 
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
qui do renameIB2SAS.do             // do renaming file



* No longer need to be in raw_sub_do directory, so return to dodir
cd `dodir'

* Obs with missing farmcodes are useless to us, and I think they were
*  introduced in merging process anyway
drop if missing(FC)

save temporary_data.dta, replace
describe,short



use  temporary_data.dta, clear



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
gen double w        = 1 // This is the sample weight (none in 79-83)
gen double fortnfer = 0 // Only have combined var. Assigned to fmer
gen double foadvfee = 0 // Don't have, won't have.
gen int ffszsyst    = 1 // Need to do to SGM (SGO) for this
rename MILK_QUOTA_OWN_CY_LT     dqownqty // Quota var, NA 79 - 83
rename MILK_QUOTA_TOT_LEASED_LT dqrentgl // Quota var, NA 79 - 83
rename MILK_QUOTA_LET_LT        dqletgal // Quota var, NA 79 - 83
rename MILK_QUOTA_TOTAL_CY_LT   dqcuryer // Quota var, NA 79 - 83
gen double ogmarsth = 0 //non-derived var to calc, may be impossible
gen double oojobhld = 0 //FARM_MD_OTHER_GAINFUL_ACT_EMP_TY.Don't have
*!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!



/*-----------TURNED OFF---------------------------------------------
local data "cod84"
if "`data'"=="cod84"{

    
  local raw8409 ///
    "D:\Data\data_NFSPanelAnalysis\OrigData\RAW_84_09"
  local raw7983 ///
    "D:\Data\data_NFSPanelAnalysis\OrigData\RAW_79_83"

  insheet using `raw8409'/cod8409.csv, comma clear
  *do necessaryvars


  cd `raw8409'/sub_do  
    


  * Destring all numeric vars, ignoring commas (a non-numeric char)
  qui destring, replace ignore(",")



  rename cffrmcod farmcode



  * Switch to IB names (for deriving additional variables)
  *qui do create_renameSAS2IB_code.do // update names 
  qui do renameSAS2IB.do       // do renaming      


  * Move to directory with derived var definitions.
  * NOTE: DON'T COPY THE DEFINITIONS (other than as backup). Rather, 
  *  CD TO THE FOLDER, AND RUN THE CODE FROM THERE. Using copies 
  *  increases the risk that variable definitions will be out of 
  *  sync from one project to the next. 


  * CD and calc. derived vars that 84-09 data needs
  cd `raw7983'/sub_do
  qui do D_INSURANCE_EU/D_INSURANCE_EU
  cd `raw8409'/sub_do


  * Rest of this code uses SAS names, so switch back.
  *qui do create_renameIB2SAS_code.do // update names 
  qui do renameIB2SAS.do       // do renaming      
  
}

ds, varwidth(32)

cd `startdir'

-----------BACK ON ---------------------------------------------*/

* Time index (panel's first year = 1)
qui summ year 
gen t = year - `r(min)' + 1



* ===================================================================
* Create Price indices   TEMPORARY FIX -- indices for the wrong years
* ===================================================================
gen     PTotalOutputs    = 0
local price_vlist "`price_vlist' PTotalOutputs"
replace PTotalOutputs    = 105.3       if t==0
replace PTotalOutputs    = 105.3       if t==1
replace PTotalOutputs    = 98.8        if t==2
replace PTotalOutputs    = 98.0        if t==3
replace PTotalOutputs    = 94.0        if t==4
replace PTotalOutputs    = 100.0       if t==5
replace PTotalOutputs    = 104.3       if t==6
replace PTotalOutputs    = 100.0       if t==7
replace PTotalOutputs    = 99.6        if t==8
replace PTotalOutputs    = 101.8       if t==9
replace PTotalOutputs    = 102.3       if t==10
replace PTotalOutputs    = 107.42      if t==11


gen     PPrimeCattle     = 0
local price_vlist "`price_vlist' PPrimeCattle"
replace PPrimeCattle     = 101.0       if t==0
replace PPrimeCattle     = 101.0       if t==1
replace PPrimeCattle     = 95.2        if t==2
replace PPrimeCattle     = 93.4        if t==3
replace PPrimeCattle     = 90.9        if t==4
replace PPrimeCattle     = 100.0       if t==5
replace PPrimeCattle     = 92.5        if t==6
replace PPrimeCattle     = 95.2        if t==7
replace PPrimeCattle     = 93.3        if t==8
replace PPrimeCattle     = 101.9       if t==9
replace PPrimeCattle     = 105.6       if t==10
replace PPrimeCattle     = 113.49      if t==11


gen     PCowSlaughter    = 0
local price_vlist "`price_vlist' PCowSlaughter"
replace PCowSlaughter    = 108.7       if t==0
replace PCowSlaughter    = 108.7       if t==1
replace PCowSlaughter    = 102.8       if t==2
replace PCowSlaughter    = 98.8        if t==3
replace PCowSlaughter    = 87.6        if t==4
replace PCowSlaughter    = 100.0       if t==5
replace PCowSlaughter    = 86.7        if t==6
replace PCowSlaughter    = 83.2        if t==7
replace PCowSlaughter    = 86.4        if t==8
replace PCowSlaughter    = 103.2       if t==9
replace PCowSlaughter    = 107.1       if t==10
replace PCowSlaughter    = 118         if t==11


gen     PStoreCattle     = 0
local price_vlist "`price_vlist' PStoreCattle"
replace PStoreCattle     = 99.1        if t==0
replace PStoreCattle     = 99.1        if t==1
replace PStoreCattle     = 95.9        if t==2
replace PStoreCattle     = 89.6        if t==3
replace PStoreCattle     = 83.0        if t==4
replace PStoreCattle     = 100.0       if t==5
replace PStoreCattle     = 97.2        if t==6
replace PStoreCattle     = 100.7       if t==7
replace PStoreCattle     = 102.8       if t==8
replace PStoreCattle     = 112.3       if t==9
replace PStoreCattle     = 104.6       if t==10
replace PStoreCattle     = 107.46      if t==11


gen     PTotalCattle     = 0
local price_vlist "`price_vlist' PTotalCattle"
replace PTotalCattle     = 101.7       if t==0
replace PTotalCattle     = 101.7       if t==1
replace PTotalCattle     = 96.3        if t==2
replace PTotalCattle     = 93.4        if t==3
replace PTotalCattle     = 89.1        if t==4
replace PTotalCattle     = 100.0       if t==5
replace PTotalCattle     = 92.3        if t==6
replace PTotalCattle     = 94.4        if t==7
replace PTotalCattle     = 93.6        if t==8
replace PTotalCattle     = 103.3       if t==9
replace PTotalCattle     = 105.6       if t==10
replace PTotalCattle     = 113.22      if t==11


gen     PSheep           = 0
local price_vlist "`price_vlist' PSheep"
replace PSheep           = 109.6       if t==0
replace PSheep           = 109.6       if t==1
replace PSheep           = 112.4       if t==2
replace PSheep           = 96.5        if t==3
replace PSheep           = 88.7        if t==4
replace PSheep           = 100.0       if t==5
replace PSheep           = 142.9       if t==6
replace PSheep           = 121.3       if t==7
replace PSheep           = 119.5       if t==8
replace PSheep           = 117.7       if t==9
replace PSheep           = 109.6       if t==10
replace PSheep           = 112.21      if t==11


gen     PMilk            = 0
local price_vlist "`price_vlist' PMilk"
replace PMilk            = 105.4       if t==0
replace PMilk            = 105.4       if t==1
replace PMilk            = 97.8        if t==2
replace PMilk            = 101.1       if t==3
replace PMilk            = 98.4        if t==4
replace PMilk            = 100.0       if t==5
replace PMilk            = 104.3       if t==6
replace PMilk            = 97.1        if t==7
replace PMilk            = 95.6        if t==8
replace PMilk            = 95.3        if t==9
replace PMilk            = 93.5        if t==10
replace PMilk            = 90.13       if t==11


gen     PCereals         = 0
local price_vlist "`price_vlist' PCereals"
replace PCereals         = 115.8       if t==0
replace PCereals         = 115.8       if t==1
replace PCereals         = 94.8        if t==2
replace PCereals         = 99.0        if t==3
replace PCereals         = 104.8       if t==4
replace PCereals         = 100.0       if t==5
replace PCereals         = 104.5       if t==6
replace PCereals         = 91.8        if t==7
replace PCereals         = 109.0       if t==8
replace PCereals         = 100.9       if t==9
replace PCereals         = 96.6        if t==10
replace PCereals         = 110.56      if t==11


gen     PSugarBeet       = 0
local price_vlist "`price_vlist' PSugarBeet"
replace PSugarBeet       = 96.0        if t==0
replace PSugarBeet       = 96.0        if t==1
replace PSugarBeet       = 97.6        if t==2
replace PSugarBeet       = 98.6        if t==3
replace PSugarBeet       = 99.5        if t==4
replace PSugarBeet       = 100.0       if t==5
replace PSugarBeet       = 102.8       if t==6
replace PSugarBeet       = 103.8       if t==7
replace PSugarBeet       = 103.8       if t==8
replace PSugarBeet       = 103.8       if t==9
replace PSugarBeet       = 103.7       if t==10
replace PSugarBeet       = 103.7       if t==11


gen     PPotatoes        = 0
local price_vlist "`price_vlist' PPotatoes"
replace PPotatoes        = 85.2        if t==0
replace PPotatoes        = 85.2        if t==1
replace PPotatoes        = 73.0        if t==2
replace PPotatoes        = 146.5       if t==3
replace PPotatoes        = 118.2       if t==4
replace PPotatoes        = 100.0       if t==5
replace PPotatoes        = 152.1       if t==6
replace PPotatoes        = 148.0       if t==7
replace PPotatoes        = 154.2       if t==8
replace PPotatoes        = 97.6        if t==9
replace PPotatoes        = 145.5       if t==10
replace PPotatoes        = 236.31      if t==11


gen     PVeg             = 0
local price_vlist "`price_vlist' PVeg"
replace PVeg             = 96.3        if t==0
replace PVeg             = 96.3        if t==1
replace PVeg             = 92.1        if t==2
replace PVeg             = 97.8        if t==3
replace PVeg             = 97.2        if t==4
replace PVeg             = 100.0       if t==5
replace PVeg             = 105.4       if t==6
replace PVeg             = 114.9       if t==7
replace PVeg             = 110.0       if t==8
replace PVeg             = 110.7       if t==9
replace PVeg             = 116.1       if t==10
replace PVeg             = 123.65      if t==11


gen     PTotalCrop       = 0
local price_vlist "`price_vlist' PTotalCrop"
replace PTotalCrop       = 100.7       if t==0
replace PTotalCrop       = 100.7       if t==1
replace PTotalCrop       = 91.2        if t==2
replace PTotalCrop       = 104.7       if t==3
replace PTotalCrop       = 103.3       if t==4
replace PTotalCrop       = 100.0       if t==5
replace PTotalCrop       = 112.2       if t==6
replace PTotalCrop       = 110.4       if t==7
replace PTotalCrop       = 116.0       if t==8
replace PTotalCrop       = 104.4       if t==9
replace PTotalCrop       = 112.0       if t==10
replace PTotalCrop       = 133.86      if t==11


gen     PTotalInputs     = 0
local price_vlist "`price_vlist' PTotalInputs"
replace PTotalInputs     = 97.3        if t==0
replace PTotalInputs     = 97.3        if t==1
replace PTotalInputs     = 95.3        if t==2
replace PTotalInputs     = 93.0        if t==3
replace PTotalInputs     = 94.1        if t==4
replace PTotalInputs     = 100.0       if t==5
replace PTotalInputs     = 104.8       if t==6
replace PTotalInputs     = 106.1       if t==7
replace PTotalInputs     = 108.8       if t==8
replace PTotalInputs     = 113.1       if t==9
replace PTotalInputs     = 118.0       if t==10
replace PTotalInputs     = 123.07      if t==11


gen     PCalfFeed        = 0
local price_vlist "`price_vlist' PCalfFeed"
replace PCalfFeed        = 111.9       if t==0
replace PCalfFeed        = 111.9       if t==1
replace PCalfFeed        = 107.7       if t==2
replace PCalfFeed        = 100.8       if t==3
replace PCalfFeed        = 97.9        if t==4
replace PCalfFeed        = 100.0       if t==5
replace PCalfFeed        = 103.9       if t==6
replace PCalfFeed        = 105.8       if t==7
replace PCalfFeed        = 106.8       if t==8
replace PCalfFeed        = 110.1       if t==9
replace PCalfFeed        = 116.4       if t==10
replace PCalfFeed        = 107.43      if t==11


gen     PCattleFeed      = 0
local price_vlist "`price_vlist' PCattleFeed"
replace PCattleFeed      = 110.7       if t==0
replace PCattleFeed      = 110.7       if t==1
replace PCattleFeed      = 104.4       if t==2
replace PCattleFeed      = 98.3        if t==3
replace PCattleFeed      = 96.5        if t==4
replace PCattleFeed      = 100.0       if t==5
replace PCattleFeed      = 106.4       if t==6
replace PCattleFeed      = 107.8       if t==7
replace PCattleFeed      = 107.7       if t==8
replace PCattleFeed      = 111.7       if t==9
replace PCattleFeed      = 108.9       if t==10
replace PCattleFeed      = 111.23      if t==11


gen     PfertiliserNPK   = 0
local price_vlist "`price_vlist' PfertiliserNPK"
replace PfertiliserNPK   = 102.5       if t==0
replace PfertiliserNPK   = 102.5       if t==1
replace PfertiliserNPK   = 96.4        if t==2
replace PfertiliserNPK   = 93.4        if t==3
replace PfertiliserNPK   = 94.5        if t==4
replace PfertiliserNPK   = 100.0       if t==5
replace PfertiliserNPK   = 111.6       if t==6
replace PfertiliserNPK   = 108.4       if t==7
replace PfertiliserNPK   = 111.5       if t==8
replace PfertiliserNPK   = 112.2       if t==9
replace PfertiliserNPK   = 121.2       if t==10
replace PfertiliserNPK   = 129.19      if t==11


gen     PfertiliserPK    = 0
local price_vlist "`price_vlist' PfertiliserPK"
replace PfertiliserPK    = 92.7        if t==0
replace PfertiliserPK    = 92.7        if t==1
replace PfertiliserPK    = 88.7        if t==2
replace PfertiliserPK    = 88.5        if t==3
replace PfertiliserPK    = 96.3        if t==4
replace PfertiliserPK    = 100.0       if t==5
replace PfertiliserPK    = 104.5       if t==6
replace PfertiliserPK    = 103.3       if t==7
replace PfertiliserPK    = 105.0       if t==8
replace PfertiliserPK    = 106.2       if t==9
replace PfertiliserPK    = 110.0       if t==10
replace PfertiliserPK    = 115.92      if t==11


gen     PTotalFert       = 0
local price_vlist "`price_vlist' PTotalFert"
replace PTotalFert       = 101.0       if t==0
replace PTotalFert       = 101.0       if t==1
replace PTotalFert       = 94.8        if t==2
replace PTotalFert       = 91.3        if t==3
replace PTotalFert       = 93.3        if t==4
replace PTotalFert       = 100.0       if t==5
replace PTotalFert       = 113.4       if t==6
replace PTotalFert       = 110.5       if t==7
replace PTotalFert       = 113.0       if t==8
replace PTotalFert       = 115.1       if t==9
replace PTotalFert       = 124.5       if t==10
replace PTotalFert       = 133.1       if t==11


gen     PSeeds           = 0
local price_vlist "`price_vlist' PSeeds"
replace PSeeds           = 103.4       if t==1
replace PSeeds           = 103.4       if t==1
replace PSeeds           = 100.5       if t==2
replace PSeeds           = 102.0       if t==3
replace PSeeds           = 102.1       if t==4
replace PSeeds           = 100.0       if t==5
replace PSeeds           = 103.7       if t==6
replace PSeeds           = 107.4       if t==7
replace PSeeds           = 115.2       if t==8
replace PSeeds           = 116.1       if t==9
replace PSeeds           = 115.7       if t==10
replace PSeeds           = 120.11      if t==11


gen     PMotorFuels      = 0
local price_vlist "`price_vlist' PMotorFuels"
replace PMotorFuels      = 71.8        if t==0
replace PMotorFuels      = 71.8        if t==1
replace PMotorFuels      = 73.5        if t==2
replace PMotorFuels      = 70.5        if t==3
replace PMotorFuels      = 75.6        if t==4
replace PMotorFuels      = 100.0       if t==5
replace PMotorFuels      = 95.8        if t==6
replace PMotorFuels      = 94.7        if t==7
replace PMotorFuels      = 99.1        if t==8
replace PMotorFuels      = 110.2       if t==9
replace PMotorFuels      = 131.7       if t==10
replace PMotorFuels      = 144.08      if t==11


gen     PElectricity     = 0
local price_vlist "`price_vlist' PElectricity"
replace PElectricity     = 97.5        if t==0
replace PElectricity     = 97.5        if t==1
replace PElectricity     = 99.4        if t==2
replace PElectricity     = 100.0       if t==3
replace PElectricity     = 100.0       if t==4
replace PElectricity     = 100.0       if t==5
replace PElectricity     = 101.5       if t==6
replace PElectricity     = 105.9       if t==7
replace PElectricity     = 119.6       if t==8
replace PElectricity     = 125.7       if t==9
replace PElectricity     = 135.7       if t==10
replace PElectricity     = 141.61      if t==11


gen     PTotalEnergy     = 0
local price_vlist "`price_vlist' PTotalEnergy"
replace PTotalEnergy     = 76.6        if t==0
replace PTotalEnergy     = 76.6        if t==1
replace PTotalEnergy     = 78.2        if t==2
replace PTotalEnergy     = 75.9        if t==3
replace PTotalEnergy     = 80.2        if t==4
replace PTotalEnergy     = 100.0       if t==5
replace PTotalEnergy     = 97.1        if t==6
replace PTotalEnergy     = 97.1        if t==7
replace PTotalEnergy     = 102.9       if t==8
replace PTotalEnergy     = 112.6       if t==9
replace PTotalEnergy     = 131.7       if t==10
replace PTotalEnergy     = 143.12      if t==11

gen     PPlantProtection = 0
local price_vlist "`price_vlist' PPlantProtection"
replace PPlantProtection = 100.8       if t==0
replace PPlantProtection = 100.8       if t==1
replace PPlantProtection = 100.4       if t==2
replace PPlantProtection = 100.8       if t==3
replace PPlantProtection = 100.6       if t==4
replace PPlantProtection = 100.0       if t==5
replace PPlantProtection = 100.8       if t==6
replace PPlantProtection = 101.6       if t==7
replace PPlantProtection = 101.6       if t==8
replace PPlantProtection = 103.2       if t==9
replace PPlantProtection = 102.7       if t==10
replace PPlantProtection = 101.72      if t==11


gen     PVetExp          = 0
local price_vlist "`price_vlist' PVetExp"
replace PVetExp          = 89.3        if t==0
replace PVetExp          = 89.3        if t==1
replace PVetExp          = 92.3        if t==2
replace PVetExp          = 94.7        if t==3
replace PVetExp          = 95.9        if t==4
replace PVetExp          = 100.0       if t==5
replace PVetExp          = 104.7       if t==6
replace PVetExp          = 109.4       if t==7
replace PVetExp          = 114.7       if t==8
replace PVetExp          = 115.8       if t==9
replace PVetExp          = 117.6       if t==10
replace PVetExp          = 122.43      if t==11


gen     POtherInputs     = 0
local price_vlist "`price_vlist' POtherInputs"
replace POtherInputs     = 91.2        if t==0
replace POtherInputs     = 91.2        if t==1
replace POtherInputs     = 92.7        if t==2
replace POtherInputs     = 93.6        if t==3
replace POtherInputs     = 95.9        if t==4
replace POtherInputs     = 100.0       if t==5
replace POtherInputs     = 105.9       if t==6
replace POtherInputs     = 110.4       if t==7
replace POtherInputs     = 114.1       if t==8
replace POtherInputs     = 116.9       if t==9
replace POtherInputs     = 121.0       if t==10
replace POtherInputs     = 124.04      if t==11


gen     CPI              = 0
local price_vlist "`price_vlist' CPI"
replace CPI              = 117.1       if t==0
replace CPI              = 117.1       if t==1
replace CPI              = 118.8       if t==2
replace CPI              = 121.7       if t==3
replace CPI              = 123.7       if t==4
replace CPI              = 130.6       if t==5
replace CPI              = 137         if t==6
replace CPI              = 143.3       if t==7
replace CPI              = 148.3       if t==8
replace CPI              = 151.6       if t==9
replace CPI              = 155.3       if t==10
replace CPI              = 160         if t==11


gen     PTransportcap    = 0
local price_vlist "`price_vlist' PTransportcap"
replace PTransportcap    = 96.736231   if t==0
replace PTransportcap    = 96.736231   if t==1
replace PTransportcap    = 97.4031069  if t==2
replace PTransportcap    = 98.3445787  if t==3
replace PTransportcap    = 99.2468225  if t==4
replace PTransportcap    = 100.0166667 if t==5
replace PTransportcap    = 101.3416667 if t==6
replace PTransportcap    = 102.9916667 if t==7
replace PTransportcap    = 103.95      if t==8
replace PTransportcap    = 104.3       if t==9
replace PTransportcap    = 105.6916667 if t==10
replace PTransportcap    = 106.6909091 if t==11


gen     POthercap        = 0
local price_vlist "`price_vlist' POthercap"
replace POthercap        = 93.2354049  if t==0
replace POthercap        = 93.2354049  if t==1
replace POthercap        = 94.2824859  if t==2
replace POthercap        = 96.0903955  if t==3
replace POthercap        = 98.2071563  if t==4
replace POthercap        = 100.0083333 if t==5
replace POthercap        = 101.9166667 if t==6
replace POthercap        = 103.1333333 if t==7
replace POthercap        = 103.3666667 if t==8
replace POthercap        = 103.6166667 if t==9
replace POthercap        = 104.3833333 if t==10
replace POthercap        = 105.3727273 if t==11
 


/* Convert punts to Euro */
local punt_to_euro = .787564
local time_cond    "!missing(t)"
local monetary_vlist "`monetary_vlist' fainvmch"
local monetary_vlist "`monetary_vlist' fainvbld"
local monetary_vlist "`monetary_vlist' fainvlim"
*local monetary_vlist "`monetary_vlist' fvalflab" // TEMPORARILY off
local monetary_vlist "`monetary_vlist' fdcaslab"
local monetary_vlist "`monetary_vlist' fohirlab"
local monetary_vlist "`monetary_vlist' fointpay"
local monetary_vlist "`monetary_vlist' fomacopt"
local monetary_vlist "`monetary_vlist' fobldmnt"
local monetary_vlist "`monetary_vlist' foupkpld"
local monetary_vlist "`monetary_vlist' foexlime"
local monetary_vlist "`monetary_vlist' foannuit"
local monetary_vlist "`monetary_vlist' forates"
local monetary_vlist "`monetary_vlist' foinsure"
local monetary_vlist "`monetary_vlist' fofuellu"
local monetary_vlist "`monetary_vlist' foelecfs"
local monetary_vlist "`monetary_vlist' fophonfs"
local monetary_vlist "`monetary_vlist' fortfmer" // Don't have, alt.
local monetary_vlist "`monetary_vlist' fortnfer" // Don't have,set =0
local monetary_vlist "`monetary_vlist' fomiscel"
local monetary_vlist "`monetary_vlist' fdairygo"
local monetary_vlist "`monetary_vlist' fcropsgo"
local monetary_vlist "`monetary_vlist' fcplivgo"
local monetary_vlist "`monetary_vlist' fgrtsubs"
local monetary_vlist "`monetary_vlist' iaisfdy"
local monetary_vlist "`monetary_vlist' iaisfcat"
local monetary_vlist "`monetary_vlist' iaisfshp"
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
*/
set trace on
foreach var of local monetary_vlist {
	replace `var' = `var' / `punt_to_euro' if `time_cond'

}
set trace off


/* Sample selection, drop all non dairy 
       TEMPORARY FIX -- keep all until we establish farm types */
drop if ffszsyst!=1



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
/*
gen L1 = (alloc  *     ///   TEMPORARY FIXES -- off until var fixed
                (fvalflab + /// 
                 fdcaslab + ///
                 fohirlab)  ///
              ) / CPI * 100        
*/
*gen L2 = alloc * flabtotl   TEMPORARY FIXES -- off until var fixed
gen L3 = alloc * flabsmds



/* Create Herd size variable (average number) */
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
replace iaisfdy = iaisfdy/PVetExp*100
gen     AID = 0
replace AID = 1 if iaisfdy>0



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
rename dabotfat FAT
rename daproten PROTEIN
rename daforare LANDFAGE
rename dafedare LANDFEED



* TODO is this still correct? What units are the raw data in?
* Hectare to acres conversion
replace LANDFAGE = LANDFAGE * 2.47105 if T== 11
replace LANDFEED = LANDFEED * 2.47105 if T== 11
replace FSIZE    = FSIZE    * 2.47105 if T== 11



* create intensification variable (COW per acre)
gen INTENSE = dpavnohd/LANDFAGE



* TODO -- adjust DECOUP when data merged
gen DECOUP = 0
replace DECOUP = 1 if T==10
replace DECOUP = 1 if T==11



/* TEMPORARY FIX --Lose all obs. Off until vars shored up
* Investigate Attrition
* drop zero obs
drop if Y2<=0
drop if LANDFEED<=0
drop if LANDFAGE<=0
drop if L3<=0
drop if C<=0
drop if DC<=0
drop if H<=0 
*/



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
gen PL = Y2/L3
gen PA = Y2/LANDFAGE
gen PC = Y2/C

bysort T: sum PH PD PL PA PC



*********************************************************************

* efficiency variables DROP ZEROS IF DOING DESCRIPTIVE STATS!!!!!!!!! 
 
*********************************************************************

* drop if AGE<14

* drop if AGE>100

*********************************************************************
* create OFF-FARM SIZE interactions. 
*   SMALL  (0   - 64 ) 
*   MEDIUM (65  -112 ) 
*   LARGE  (     112+)
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



preserve
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
     FAT      ///
     PROTEIN  ///
     LANDFAGE ///
     LANDFEED ///
     ALLOC-   ///
     SIZE5


* Make data compatible with NLogit


* NLogit will not import correctly if there are missing values
*  i.e. the missing values will be blanks in the CSV file, and 
*  NLogit will not interpret them as missings 
* All other missing values can be set to 0
qui ds FC, not  // list of all vars EXCEPT farmcode 
local vlist "`r(varlist)'"

foreach var of local vlist{
    di "Checking for missing values in `var'"
    replace `var' = 0 if missing(`var')
    di _newline(2)

}

*drop if ALLOC < .6

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



cd `startdir' // return Stata to start location


quietly{
* Cleaning up
*erase temporary_data.dta, clear
}
