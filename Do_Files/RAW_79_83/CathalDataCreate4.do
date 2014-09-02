clear 
set mem 500m
set more off
cd d:
use "D:\data\data_NFSPanelAnalysis\OrigData\2010\unpaid_labour_allyears.dta", clear
capture gen farmcode  = FARM_CODE
capture gen year      = YE_AR
capture gen ogagehld  = year - YEAR_BORN
capture gen oojobhld  = EMPLOYMENT_OUTSIDE_HOLDING  == 1
capture gen toojobsps = EMPLOYMENT_OUTSIDE_HOLDING if  WORKER_CODE == 2 &  MARITIAL_STATUS == 1
replace toojobsps     = 0 if toojobsps == .
capture drop oojobsps
sort farmcode year
by farmcode year: egen oojobsps = max(toojobsps)

keep if WORKER_CODE == 1
sort farmcode year
save D:\data\data_NFSPanelAnalysis\OrigData\2010\unpaid_labour_allyears_1.dta, replace


use "D:\data\data_NFSPanelAnalysis\OrigData\2010\cathal_data_allyears.dta", clear

gen farmcode =  FARM_CODE

gen year =  YE_AR

capture gen wt       = UAA_WEIGHT
capture gen flabsmds = 220
gen ftotallu         = D_TOTAL_LIVESTOCK_UNITS
gen fsizuaa          = UAA_SIZE

gen oanolt5y =  FARM_AGED_IN_DEC_LT5YRS_MALE_NO  + FARM_AGE_IN_DEC_LT5YRS_FEMALE_NO
gen oano515y =  FARM_AGED_IN_DEC_5_15YRS_MALE_NO + FARM_AGE_IN_DEC_5_15YRS_FEMLE_NO
gen oano1619 =  FARM_AGE_IN_DEC_16_19YRS_MALE_NO +  FARM_AGE_IN_DEC_16_19YRS_FMLE_NO
gen oano2024 =  FARM_AGE_IN_DEC_20_24YRS_MALE_NO + FARM_AGE_IN_DEC_20_24YRS_FMLE_NO
gen oano2544 =  FARM_AGE_IN_DEC_25_44YRS_MALE_NO + FARM_AGE_IN_DEC_25_44YRS_FMLE_NO
gen oano4564 =  FARM_AGE_IN_DEC_45_64YRS_MALE_NO + FARM_AGE_IN_DEC_45_64YRS_FMLE_NO
gen oanoge65 =  FARM_AGED_IN_DEC_GT65YRS_MALE_NO + FARM_AGE_IN_DEC_GT65YRS_FEMAL_NO
gen foadvfee =  TEAGASC_ADVISORY_FEES_EU

gen ooinchld = FARM_MD_INCOME_RECEIVED_CODE

*todo
gen ffszsyst = 1
gen system   = 1
*todo get more detailed variable
gen ffsolcod = D_SOIL_GROUP*100

gen region = REGION_CODE

gen cssuckcw = SUCKLER_WELFARE_SCHEME_TOTAL_EU
gen cs10mtbf = FIRST_BEEF_9MTH_PAY_TOT_RECVD_EU
gen cs22mtbf = SCND_BEEF_21MTH_PAY_TOT_RECVD_EU
gen csslaugh = SLTR_PREM_CATTLE_PAY_RECVD_TY_EU
gen csextens = EXT_PREM_PAY_PREV_TOT_RECVD_EU
gen csheadag = CATTLE_HEADAGE_TOTAL_EU
gen csmctopu = TOTAL_MONETARY_COMP_AMOUNTS_EU
gen cosubsid = CATTLE_SUBSIDIES_EU

gen fsubchen = DSAV_AREA_CMP_ALOW_TOT_PAY_TY_EU
gen fgrntsub = D_MISC_GRANTS_AND_SUBSIDIES_EU
gen fsubesag = ENVR_SENSITIV_PAY_CURR_SCHEME_EU
gen fsubreps = REPS_PAYMENTS_CURR_SCHEME_EU
gen fsubchpp = SINGLE_FARM_PAYMENT_NET_VALUE_EU
gen sosubsid = D_SUBSIDIES_EU
gen posubsid = SUBSIDIES_VALUE_EU
gen fsubyfig = YNG_FMR_INSTL_GRNT_TOT_PAY_TY_EU
gen fsubhors = HORSES_EQUINES_SUBSIDIES_RECEIPT
gen fsubtbco = TB_COMP_ETC_TOTAL_PAYMENTS_TY_EU
gen fsubforh = FORESTRY_HEADAGE_TOT_PAYMENTS_EU
gen dogpcomp = MILK_GREEN_POUND_COMPENSATION_EU
gen dotomkgl = D_TOTAL_MILK_PRODUCTION_LT
gen fsubastp = D_ARABLE_AID_SETSDE_TOT_PAY_RECD
gen fsubcatp = D_CEREAL_AID_TOTAL_PAYMENT_RECD
gen fsubrptp = D_AREA_AID_RAPE_TOTAL_PAY_RECD
gen fsubpbtp = D_AREA_AID_PEA_BEAN_TOT_PAY_RECD
gen fsublitp = D_AREA_AID_LINSEED_TOT_PAY_RECD
gen fsubmztp = D_AREA_AID_MAIZE_TOTAL_PAY_RECD
gen fsubvstp = VOLUNTARY_SETASIDE_CURRENT_EU
gen dqcomlrd = COMPULSARY_REDUCTION_COMPNSTN_EU

gen dosubsvl = DAIRY_SUPPORT_VALUE_EU
gen fsubsctp = SUCKLER_COW_PYMNT_RECEIVED_TY_EU
gen dogrosso = D_DAIRY_GROSS_OUTPUT_EU
gen dotomkvl = D_TOTAL_MILK_PRODUCTION_EU
gen dovalclf = D_DARY_VAL_DRPD_CLVS_SLD_TRNS_EU
gen favlfrey = D_SALES_ANIMALS_DAIRY_HERD_EU

gen favlfrby = LAND_VALUE_EST_BEG_OF_YEAR_EU
gen fsizldow = LAND_OWNED_HA
gen fsizldrt = LAND_RENTED_IN_HA
gen fsizldlt = LAND_LET_OUT_HA
gen faprldvl = LAND_VALUE_PURCHASES_EU
gen faprldac = LAND_VALUE_PURCHASES_HA
gen faslldvl = LAND_VALUE_SALES_EU
gen faslldac = LAND_VALUE_SALES_HA
gen daforare = D_FORAGE_AREA_HA
gen cpforacs = D_CATTLE_FORAGE_AREA
gen spforacs = D_SHEEP_FORAGE_AREA_HA
gen hpforacs = D_TOTAL_FORAGE_HECTARES_HA
gen fsizfort = FARM_FORESTRY_HA
gen fsizfrac = D_FARM_TOTAL_FORAGE_AREA_HA

gen dpnolu   = D_DAIRY_LVESTCK_UNITS_INCL_BULLS
gen spnolu   = D_SHEEP_LIVESTOCK_UNITS
gen cpnolu   = D_CATTLE_LIVESTOCK_UNITS
gen fsizeadj = D_TOTAL_FORAGE_HECTARES_HA
gen flivstgm = D_TOTAL_LIVESTOCK_GROSS_MARGIN

gen doslcmvl = WHOLE_MILK_SOLD_TO_CREAMERY_EU
gen domlkbon = CREAMERY_BONUSES_EU
gen domlkpen = CREAMERY_PENALTIES_EU
gen dosllmvl = LMLK_SOLD_W_RETAIL_EU
gen domkfdvl = D_MILK_FED_TO_LIVESTOCK_EU
gen domkalvl = D_MILK_ALLOWANCES_EU
gen doslmkvl = D_MILK_SOLD_EU
gen doslcmgl = WHOLE_MILK_SOLD_TO_CREAMERY_LT
gen dosllmgl = LMLK_SOLD_W_RETAIL_LT
gen domkfdgl = D_MILK_FED_TO_LIVESTOCK_LT
gen doslmkgl = D_MILK_SOLD_LT
gen dotochbv = DAIRY_COWS_SH_BULLS_TRANS_OUT_EU
gen dotochbn = DAIRY_COWS_SH_BULLS_TRANS_OUT_NO
gen dopchbno = DAIRY_COWS_SH_BULLS_PURCHASES_NO
gen dopchbvl = DAIRY_COWS_SH_BULLS_PURCHASES_EU
gen dotichbv = DAIRY_COWS_SH_BULLS_TRANS_IN_EU
gen dotichbn = DAIRY_COWS_SH_BULLS_TRANS_OUT_NO
gen doreplct = D_DAIRY_HERD_REPLACE_COST_EU
gen doschbvl = DAIRY_CWS_SH_BULLS_SLS_BRDING_EU + DAIRY_CWS_SH_BULLS_SALES_CULL_EU
gen doschbno = DAIRY_CWS_SH_BULLS_SLS_BRDING_NO + DAIRY_CWS_SH_BULLS_SALES_CULL_NO
gen dosldhrd = D_SALES_ANIMALS_DAIRY_HERD_EU
gen docfslvl = DAIRY_CALVES_SALES_EU
gen docfslno = DAIRY_CALVES_SALES_NO
gen doprdhrd = DAIRY_COWS_SH_BULLS_PURCHASES_EU
gen dovlcnod = D_DAIRY_HERD_VALUE_CHANGE_EU
gen docftfvl = DAIRY_CALVES_TRANSFER_EU
gen docftfno = DAIRY_COWS_SH_BULLS_PURCHASES_NO
gen ddmiscdc = D_DAIRY_PROD_MISC_DIRECT_COST_EU
gen ivmalldy = VET_MED_ALLOC_DAIRY_HERD_EU
gen iaisfdy  = AI_SER_FEES_ALLOC_DAIRY_HERD_EU
gen itedairy = TRANSPORT_ALLOC_DAIRY_HERD_EU
gen imiscdry = MISCELLANEOUS_ALLOC_DAIRY_HRD_EU
gen flabccdy = CASUAL_LABOUR_ALLOC_DAIRY_HRD_EU
gen ddconval = D_CONCENTRATES_FED_DAIRY_EU
gen ddpastur = D_DAIRY_PASTURE_EU
gen ddwinfor = D_DAIRY_WINTER_FORAGE_EU

gen fainvlst = D_INVESTMENT_IN_LIVESTOCK
gen fainvbld = D_INVESTMENT_IN_BUILDINGS
gen fainvmch = D_INVESTMENT_IN_MACHINERY
gen fainvlim = D_INVEST_IN_LAND_IMPROVEMENTS
gen flabunpd = D_LABOUR_UNITS_UNPAID

* Cattle
*local canimal_vlist = "cpavno12 cpavno2p cpavnobl dpavnohd cpavnocw cpavnohc cpavno06 cpavno61 cpavn12m cpavn12f cpavn2pm cpavn2pf cosalesv copurval covalcno" 

gen cpavno12 = D_CATTLE_1_2YRS_AVG_NO
gen cpavno2p = D_CATTLE_GT2YRS_AVG_NO
gen cpavnobl = D_BEEF_STOCK_BULLS_AVG_NO
gen dpavnohd = D_HERD_SIZE_AVG_NO
gen cpavnocw = D_COWS_AVG_NO
gen cpavnohc = D_HEIFER_IN_CALF_AVG_NO
gen cpavno06 = D_CALVES_LT6MTHS_AVG_NO
gen cpavno61 = D_CALVES_6_12MTHS_AVG_NO
gen cpavn12m = D_MALE_CATTLE_1_2YRS_AVG_NO
gen cpavn12f = D_FEMALE_CATTLE_1_2YRS_AVG_NO
gen cpavn2pm = D_MALE_CATTLE_GT2YRS_AVG_NO
gen cpavn2pf = D_FEMALE_CATTLE_GT2YRS_AVG_NO
gen cosalesv = D_SALES_INCL_HSE_CONSUMPTION_EU
gen copurval = CATTLE_TOTAL_PURCHASES_EU
gen covalcno = D_VALUE_OF_CHANGE_OF_NUMBERS_EUR

*local canimal2_vlist = "gen coslmfno = gen cdmiscdc = gen ivmallc = gen iaisfcat = gen itecattl = gen imiscctl = gen flabccct = gen cdconcen = gen cdpastur = gen cdwinfor = gen cdmilsub = gen "

gen coslmfno = CATTLE_FINISHED_MALE_SALES_NO
gen cdmiscdc = D_LIVESTOCK_MISC_DIRECT_COSTS_EU
gen ivmallc  = VET_MED_ALLOC_CATTLE_EU
gen iaisfcat = AI_SERVICE_FEES_ALLOC_CATTLE_EU
gen itecattl = TRANSPORT_ALLOC_CATTLE_EU
gen imiscctl = MISCELLANEOUS_ALLOC_CATTLE_EU
gen flabccct = CASUAL_LABOUR_ALLOC_CATTLE_EU
gen cdconcen = D_CONCENTRATES_FED_CATTLE_EU
gen cdpastur = D_TOTAL_PASTURE_EU
gen cdwinfor = D_CATTLE_WINTER_FORAGE_EU
gen cdmilsub = D_MILK_AND_MILK_SUBSTITUTES_NO

*local cattle_vlist = "coslcf coslwn coslst coslfc coslbh cosloc coprcf coprwn coprst coprbh coproc cotftd cotffd coslms coslfs coprms coprfs coslfm coslff "

gen coslcfno = CATTLE_CALVES_SALES_NO
gen coslwnno = CATTLE_WEANLINGS_SALES_NO  
gen coslstno =  CATTLE_STORES_MALE_SALES_NO + CATTLE_STORES_FEMALE_SALES_NO
gen coslfcno = CATTLE_CALVES_SALES_NO
gen coslbhno = CATTLE_BREEDING_ANIMALS_SALES_NO
gen coslocno = CATTLE_OTHER_SALES_NO
gen coprcfno = CATTLE_CALVES_PURCHASES_NO
gen coprwnno = CATTLE_WEANLINGS_PURCHASES_NO
gen coprstno =  CATTLE_STORES_MALE_PURCHASES_NO + CATTLE_STORS_FEMALE_PURCHASES_NO
gen coprbhno =  CATTLE_BREED_REPLCEMENTS_PURC_NO
gen coprocno = CATTLE_OTHER_PURCHASES_NO
gen cotftdno = DAIRY_CALVES_TRANSFER_NO

gen cotffdno = D_TRANSFERS_FROM_DAIRY_HERD_NO
gen coslmsno = CATTLE_STORES_MALE_SALES_NO
gen coslfsno = CATTLE_STORES_FEMALE_SALES_NO
gen coprmsno =  CATTLE_STORES_MALE_PURCHASES_NO
gen coprfsno = CATTLE_STORS_FEMALE_PURCHASES_NO
gen coslfmno = CATTLE_FINISHED_MALE_SALES_NO
gen coslffno = CATTLE_FINISHED_FEMALE_SALES_NO


gen coslcfvl = CATTLE_CALVES_SALES_EU
gen coslwnvl = CATTLE_WEANLINGS_SALES_EU
gen coslstvl = CATTLE_STORES_MALE_SALES_EU + CATTLE_STORES_FEMALE_SALES_EU
gen coslfcvl = CATTLE_FINISHED_MALE_SALES_EU + CATTLE_FINISHED_FEMALE_SALES_EU
gen coslbhvl = CATTLE_BREEDING_ANIMALS_SALES_EU
gen coslocvl = CATTLE_OTHER_SALES_EU
gen coprcfvl = CATTLE_CALVES_PURCHASES_EU
gen coprwnvl = CATTLE_WEANLINGS_PURCHASES_EU
gen coprstvl = CATTLE_STORES_MALE_PURCHASES_EU + CATTLE_STORS_FEMALE_PURCHASES_EU
gen coprbhvl = CATTLE_BREED_REPLCEMTS_PURCHS_EU
gen coprocvl = CATTLE_OTHER_PURCHASES_EU
gen cotftdvl = DAIRY_CALVES_TRANSFER_EU
gen cotffdvl = D_TRANSFER_FROM_DAIRY_HERD_EU
gen coslmsvl = CATTLE_STORES_MALE_SALES_EU
gen coslfsvl = CATTLE_STORES_FEMALE_SALES_EU
gen coprmsvl = CATTLE_STORES_MALE_PURCHASES_EU
gen coprfsvl = CATTLE_STORS_FEMALE_PURCHASES_EU 
gen coslfmvl = CATTLE_FINISHED_MALE_SALES_EU
gen coslffvl = CATTLE_FINISHED_FEMALE_SALES_EU

* Sheep

*local sheep1_vlist = "sosalean sdother ivmallsp iaisfshp itesheep imiscshp flabccsh sdconval sdwinfor sdroots sdpastur" 

gen sosalean = D_SHEEP_SALES_EU
gen sdother  = D_OTHER_DIRECT_COSTS_EU
gen ivmallsp = VET_MED_ALLOC_SHEEP_EU
gen iaisfshp = AI_SERVICE_FEES_ALLOC_SHEEP_EU
gen itesheep = TRANSPORT_ALLOC_SHEEP_EU
gen imiscshp = MISCELLANEOUS_ALLOC_SHEEP_EU
gen flabccsh = CASUAL_LABOUR_ALLOC_SHEEP_EU
gen sdconval = D_CONCENTRATES_FED_SHEEP_EU
gen sdwinfor = D_SHEEP_WINTER_FORAGE_EU
gen sdroots  = D_ROOTS_DIRECT_COSTS_EU
gen sdpastur = D_SHEEP_PASTURE_EU

gen soslflno = FAT_LAMBS_SALES_NO
gen soslslno = STORE_LAMBS_SALES_NO
gen soslhgno = FAT_HOGGETS_SALES_NO + BREEDING_HOGGETS_SALES_NO
gen soslbhno = BREEDING_HOGGETS_SALES_NO
gen soslerno = CULL_EWES_RAMS_SALES_NO
gen soslbeno = BREEDING_EWES_SALES_NO
gen soconhno = USED_IN_HOUSE_NO
gen soprslno = STORE_LAMBS_PURCHASES_NO
gen soprbdno = BREEDING_HOGGETS_PURCHASES_NO

gen soslflvl = FAT_LAMBS_SALES_EU
gen soslslvl = STORE_LAMBS_SALES_EU
gen soslhgvl = FAT_HOGGETS_SALES_EU + BREEDING_HOGGETS_SALES_EU
gen soslbhvl = BREEDING_HOGGETS_PURCHASES_EU
gen soslervl = BREEDING_HOGGETS_SALES_EU
gen soslbevl = BREEDING_EWES_SALES_EU
gen soconhvl = USED_IN_HOUSE_EU
gen soprslvl = STORE_LAMBS_PURCHASES_EU
gen soprbdvl =  BREEDING_HOGGETS_PURCHASES_EU


*DC

gen fdpurcon = D_PURCHASED_CONCENTRATES_EU
gen fdpurblk = D_PURCHASED_BULKY_FEED_EU
gen fdferfil = FERT_USED_VALUE_EU
gen fdcrppro = s_CROP_PROTECTION_EU
gen fdpursed = s_PURCHASED_SEED_EU
gen fdmachir = s_MACHINERY_HIRE_EU
gen fdtrans  = D_TRANSPORT_COSTS_EU
gen fdlivmnt = D_LIVESTOCK_MAINTENANCE_EU
gen fdcaslab = D_TOTAL_CASUAL_LABOUR_EU
gen fdmiscel = D_MISC_DIRECT_COSTS_EU
gen fdfodadj = D_FODDER_ADJUSTMENT_EU
gen fdvetmed = D_VET_AND_MEDICINE_EU
gen fdaifees = D_AI_AND_SERVICE_FEES_EU
gen forntcon = LAND_RENTED_IN_EU
gen focarelp = D_CAR_ELECTRICITY_TELEPHONE_EU
gen fohirlab = D_HIRED_LABOUR_CASUAL_EXCL_EU
gen fointpay = D_INTRST_PAY_INCL_HP_INTEREST_EU
gen fomacdpr = D_DEPRECIATION_OF_MACHINERY_EU
gen fomacopt = D_MACHINRY_OPERATING_EXPENSES_EU
gen foblddpr = D_DEPRECIATION_OF_BUILDINGS_EU
gen fobldmnt = BUILDINGS_REPAIRS_UPKEEP_EU
gen fodprlim = D_DEPRECIATION_OF_LAND_IMPS_EU
gen foupkpld = LAND_GENERAL_UPKEEP_EU
gen foannuit = ANNUITIES_EU
gen fomiscel = D_MISC_OVERHEAD_COSTS_EU
gen forates  = D_MACHINERY_RATES_EU
gen fortfmer = LAND_VALU_RENT_PAID_TO_FAMILY_EU


*Pigs
/* 
local pigs_vlist = "pdmiscdc pdtotfed pdvetmed pdtrans iaisfpig imiscpig flabccpg fpigsdc iballpig ibhaypvl  ibstrpvl ibsilpvl"
foreach var in `pigs_vlist' {
	gen `var' = 0
} 
*/

gen pdmiscdc = D_PIGS_MISC_DIRECT_COSTS_EU
gen pdtotfed = D_PIGS_TOTAL_FEED_EU
gen pdvetmed = VET_MED_ALLOC_PIGS_EU
gen pdtrans  = TRANSPORT_ALLOC_PIGS_EU
gen iaisfpig = AI_SERVICE_FEES_ALLOC_PIGS_EU
gen imiscpig = MISCELLANEOUS_ALLOC_PIGS_EU
gen flabccpg = CASUAL_LABOUR_ALLOC_PIGS_EU
gen fpigsdc  = D_PIGS_TOTAL_DIRECT_COSTS_EU
gen iballpig = s_ALLOC_PIGS_QTY

*dont have vars for below hay, silage, straw allocated to pigs so = 0
gen ibhaypvl = 0
gen ibstrpvl = 0
gen ibsilpvl = 0



*Poultry
/*
local po_inp_vlist = "fpoultdc ivmallpy itepolty imiscpty flabccpy icallpyv edtotldc"
foreach var in `po_inp_vlist' {
	gen `var' = 0
}
*/

gen fpoultdc = D_POULTRY_DIRECT_COSTS_EU
gen ivmallpy = VET_MED_ETC_ALLOC_POULTRY_EU
gen itepolty = TRANSPORT_ALLOC_POULTRY_EU
gen imiscpty = MISCELLANEOUS_ALLOC_POULTRY_EU
gen flabccpy = CASUAL_LABOUR_ALLOC_POULTRY_EU
gen icallpyv = CONC_ALLOC_POULTRY_50KGBAGS_EU
gen edtotldc = fpoultdc


* Horse
/*
local h_inp_vlist = "fhorsedc icallhvl ivmallh iaisfhrs itehorse imischrs iballhrs ibhayhvl ibstrhvl ibsilhvl hdtotldc"
foreach var in `h_inp_vlist' {
	gen `var' = 0
}
*/

gen fhorsedc = D_HORSES_DIRECT_COSTS_EU
gen icallhvl = CONC_ALLOC_HORSES_50KGBAGS_EU
gen ivmallh  = VET_MED_ALLOC_HORSES_EU
gen iaisfhrs = AI_SERVICE_FEES_ALLOC_HORSES_EU
gen itehorse = TRANSPORT_ALLOC_HORSES_EU
gen imischrs = MISCELLANEOUS_ALLOC_HORSES_EU
gen iballhrs = s_ALLOC_HORSES_QTY
*dont have vars for below hay, silage, straw allocated to horses so = 0
gen ibhayhvl = 0
gen ibstrhvl = 0
gen ibsilhvl = 0
gen hdtotldc = fhorsedc


gen farmgo   = D_FARM_GROSS_OUTPUT
gen farmffi  = D_FARM_FAMILY_INCOME
gen fdairygo = D_DAIRY_GROSS_OUTPUT_EU
gen fcatlego = D_GROSS_OUTPUT_CATTLE_EU
gen fsheepgo = D_GROSS_OUTPUT_SHEEP_AND_WOOL_EU
gen fpigsgo  = D_GROSS_OUTPUT_PIGS_EU
gen fpoultgo = D_POULTRY_GROSS_OUTPUT_EU
gen fhorsego = D_GROSS_OUTPUT_HORSES_EU
gen fothergo = D_OTHER_GROSS_OUTPUT_EU
gen fcropsgo = D_TOTAL_CROPS_GROSS_OUTPUT_EU
gen farmdc   = D_FARM_DIRECT_COSTS
gen farmohct = D_FARM_TOTAL_OVERHEAD_COSTS_EU
gen fdairygm = D_DAIRY_GROSS_MARGIN_EU
gen fcatlegm = D_CATTLE_GROSS_MARGIN_EU
gen fsheepgm = D_SHEEP_GROSS_MARGIN_EU
gen fpigsgm  = D_PIGS_GROSS_MARGIN_EU
gen fpoultgm = D_POULTRY_GROSS_MARGIN_EU
gen fhorsegm = D_HORSES_GROSS_MARGIN_EU
gen fothergm = D_OTHER_GROSS_MARGIN_EU
gen fcropsgm = D_TOTAL_CROPS_GROSS_MARGIN_EU
gen fdairydc = D_DAIRY_TOTAL_DIRECT_COSTS_EU
gen fcatledc = D_CATTLE_TOTAL_DIRECT_COSTS_EU
gen fsheepdc = D_SHEEP_TOTAL_DIRECT_COSTS_EU

gen frhiremh = HIRED_MACHINERY_IN_CASH_EU + HIRED_MACHINERY_IN_KIND_EU
gen frevoth  = OTHER_RECEIPTS_IN_CASH_EU + OTHER_RECEIPTS_IN_KIND_EU
gen finttran = D_INTER_ENTERPISE_TRANSFERS_EU

gen dafedare = D_FEED_AREA_EQUIV_HA
gen dpcfbtot = BIRTHS_JAN_NO + BIRTHS_FEB_NO + BIRTHS_MAR_NO + BIRTHS_APR_NO + BIRTHS_MAY_NO + BIRTHS_JUN_NO + BIRTHS_JUL_NO + BIRTHS_AUG_NO + BIRTHS_SEP_NO + BIRTHS_OCT_NO + BIRTHS_NOV_NO + BIRTHS_DEC_NO


*****************************************************
* Subsidies
*****************************************************

*gen dirpayts = fsubhors + fsubtbco + fsubforh + fsubesag + fsubyfig + fsubreps + fsub10tp + fsub22tp + fsubastp + fsubcatp + fsubchtp + fsubeptp + fsubextp + fsubgpcm + fsublitp + fsubmztp + fsubpbtp + fsubrptp + fsubsctp + fsubshtp + fsubsptp + fsubtups + fsubvstp


* Create Residual from Grants and subsidies
gen fgrntsub_resid = max(0,D_MISC_GRANTS_AND_SUBSIDIES_EU - (ENVR_SENSITIV_TOT_PAY_JAN_DEC_EU + REPS_TOTAL_PAYMENTS_JAN_DEC_EU))

* Single farm payment
gen sfp = 0
replace sfp = SINGLE_FARM_PAYMENT_NET_VALUE_EU if year >= 2005

replace fgrntsub_resid = fgrntsub_resid - sfp if year >= 2005
replace fgrntsub_resid = 0 if fgrntsub_resid == .
* Single farm payment

replace fgrntsub_resid = max(0,fgrntsub_resid - DSAV_AREA_CMP_ALOW_TOT_PAY_TY_EU)

* Total Subsidies
gen dirpayts = 0

*gen cattle_subs = SUCKLER_COW_PYMNT_RECEIVED_TY_EU + FIRST_BEEF_9MTH_PAY_TOT_RECVD_EU + SCND_BEEF_21MTH_PAY_TOT_RECVD_EU + SLTR_PREM_CATTLE_PAY_RECVD_TY_EU + EXT_PREM_PAY_PREV_TOT_RECVD_EU + CATTLE_HEADAGE_TOTAL_EU + TOTAL_MONETARY_COMP_AMOUNTS_EU

gen cattle_subs = FIRST_BEEF_9MTH_PAY_TOT_RECVD_EU + SCND_BEEF_21MTH_PAY_TOT_RECVD_EU + SLTR_PREM_CATTLE_PAY_RECVD_TY_EU + EXT_PREM_PAY_PREV_TOT_RECVD_EU + TOTAL_MONETARY_COMP_AMOUNTS_EU

gen cattle_subs_lfa = CATTLE_SUBSIDIES_EU if year < 1993
replace cattle_subs_lfa = SUCKLER_COW_PYMNT_RECEIVED_TY_EU + CATTLE_HEADAGE_TOTAL_EU  if year >= 1993

*disadv_area_comp_allow_total_payments_ty_eu, from 2001 this is DACAS and pre 2001 it was Cattle Head current year entitlement
gen lfa = DSAV_AREA_CMP_ALOW_TOT_PAY_TY_EU
replace lfa = lfa + cattle_subs_lfa

*Cattle Subsidy
replace dirpayts = dirpayts + cattle_subs

*Suckler Welfare
gen suckler_welfare = 0
replace suckler_welfare = SUCKLER_COW_PYMNT_RECEIVED_TY_EU if year >= 2008
**The above line was incorrect ?? cosubsid is the TOTAL_CATTLE_SUBSIDIES_RECEIVED_TY_EU which should equal 
**the sum of all the various cattle subsidies, i.e. cattle_subs above.
**the var which should be used is fsubsctp, = SVY_SUBSIDIES_GRANTS/SUCKLER_COW_PAYMENT_RECEIVED_TY_EU (From 2008 inclusive)

replace dirpayts = dirpayts + suckler_welfare

*Sheep and Pigs Subsidy
gen sheep_subs = D_SUBSIDIES_EU + SUBSIDIES_VALUE_EU

replace dirpayts = dirpayts + sheep_subs

* Other grants and subsidies 
gen fgrnt_subs = (ENVR_SENSITIV_TOT_PAY_JAN_DEC_EU + YNG_FMR_INSTL_GRNT_TOT_PAY_TY_EU + REPS_TOTAL_PAYMENTS_JAN_DEC_EU)

replace dirpayts = dirpayts + fgrntsub_resid + fgrnt_subs

*Cattle Head current year entitlemen(?)
replace dirpayts = dirpayts + lfa 

*SFP
replace dirpayts = dirpayts + sfp 

*Other subsidies
gen other_subs = HORSES_EQUINES_SUBSIDIES_RECEIP + TB_COMP_ETC_TOTAL_PAYMENTS_TY_EU + FORESTRY_HEADAGE_TOT_PAYMENTS_EU	       	     

replace dirpayts = dirpayts  + other_subs 

*Tillage and Dairy Subsidy
gen tillage_subs = MILK_GREEN_POUND_COMPENSATION_EU + D_ARABLE_AID_SETSDE_TOT_PAY_RECD + D_CEREAL_AID_TOTAL_PAYMENT_RECD + D_AREA_AID_RAPE_TOTAL_PAY_RECD + D_AREA_AID_PEA_BEAN_TOT_PAY_RECD + D_AREA_AID_LINSEED_TOT_PAY_RECD + D_AREA_AID_MAIZE_TOTAL_PAY_RECD + VOLUNTARY_SETASIDE_CURRENT_EU
		 

replace dirpayts = dirpayts + tillage_subs

gen dairy_subs = 0
replace dairy_subs = dairy_subs + COMPULSARY_REDUCTION_COMPNSTN_EU if year >= 2005

replace dairy_subs = dairy_subs + DAIRY_SUPPORT_VALUE_EU if year < 2005
		                

replace dirpayts = dirpayts + dairy_subs 

* Cow Protein Payment - ***NO SUCH VARIABLE***
*replace dirpayts = dirpayts + fsubsctp if year > 2008
**Line above: fsubsctp is SVY_SUBSIDIES_GRANTS/SUCKLER_COW_PAYMENT_RECEIVED_TY_EU (From 2008. inclusive?)
*This is included above already.


* as we forward simulate from 2004, we need to convert subsidies in 2004 to sfp

replace sfp = cattle_subs + sheep_subs + tillage_subs + dairy_subs if year == 2004
replace sfp = sfp + cattle_subs + sheep_subs + tillage_subs + dairy_subs if year == 2005

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




*slaughter_premium_dairy_payment_received_ty_eu
gen slaughter_premium_dy = dogrosso - (dotomkvl+dovalclf+dosubsvl*(year < 2005)+doreplct)


quietly gen marketgo = farmgo - dirpayts
quietly gen marketffi = farmffi - dirpayts


/*
*todo - I need total crops area [not fodder]
local crop_area_vlist = "wwhcuarq swhcuarq wbycuarq sbycuarq mbycuarq wotcuarq sotcuarq osrcuarq pbscuarq lsdcuarq potcuarq sbecuarq"
foreach var in `crop_area_vlist' {
	gen `var' = 0
}
*/

* wwhcuarq Wheat Winter 1116  
* swhcuarq Wheat Spring 1111  
* wbycuarq Barley Winter 1146  
* sbycuarq Barley Spring 1141  
* mbycuarq Malting Barley Spring 1571  
* wotcuarq Oats Winter 1156  
* sotcuarq Oats Spring 1151  
* osrcuarq Oilseed Rape Spring 1431 Oilseed Rape Winter 1436
* pbscuarq Protein Beans Spring 1271 Protein PeasSpring 1291
* lsdcuarq Linseed Spring 1561  
* potcuarq Potatoes Spring 1311  
* sbecuarq SugarBeet Spring 1321  				

gen wwhcuarq = c_1116_CY_HECTARES_HA 
gen swhcuarq = c_1111_CY_HECTARES_HA 
gen wbycuarq = c_1146_CY_HECTARES_HA 
gen sbycuarq = c_1141_CY_HECTARES_HA 
gen mbycuarq = c_1571_CY_HECTARES_HA 
gen wotcuarq = c_1156_CY_HECTARES_HA 
gen sotcuarq = c_1151_CY_HECTARES_HA 
gen osrcuarq = c_143_CY_HECTARES_HA 
gen pbscuarq = c_127_CY_HECTARES_HA 
gen lsdcuarq = c_1561_CY_HECTARES_HA 
gen potcuarq = c_1311_CY_HECTARES_HA 
gen sbecuarq = c_1321_CY_HECTARES_HA

gen DAIRY_PLATFORM = DAIRY_PLATFORM_HA



* Prices
local dodatadir \data\data_NFSPanelAnalysis\Do_Files
do `dodatadir'\PriceIndexCalc.do

sort farmcode year
merge farmcode year using D:\data\data_NFSPanelAnalysis\OrigData\2010\unpaid_labour_allyears_1.dta
drop _merge


gen dpcfbjan = BIRTHS_JAN_NO
gen dpcfbfeb = BIRTHS_FEB_NO
gen dpcfbmar = BIRTHS_MAR_NO
gen dpcfbapr = BIRTHS_APR_NO
gen dpcfbmay = BIRTHS_MAY_NO
gen dpcfbjun = BIRTHS_JUN_NO
gen dpcfbjul = BIRTHS_JUL_NO
gen dpcfbaug = BIRTHS_AUG_NO
gen dpcfbsep = BIRTHS_SEP_NO
gen dpcfboct = BIRTHS_OCT_NO
gen dpcfbnov = BIRTHS_NOV_NO
gen dpcfbdec = BIRTHS_DEC_NO

**save as something

do "D:\data\data_NFSPanelAnalysis\OrigData\2010\doFarmDerivedVars.do"
*drop  FARM_CODE- ALLOC_PIGS_QTY
save D:\data\data_NFSPanelAnalysis\OrigData\2010\Cathal_merge\dataallyears_out, replace
saveold D:\data\data_NFSPanelAnalysis\OrigData\2010\Cathal_merge\dataallyears_out1, replace
