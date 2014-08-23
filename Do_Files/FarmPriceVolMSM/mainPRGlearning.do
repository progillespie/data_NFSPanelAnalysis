*****************************************************************
* Price Model
*
* John Lennon and Cathal O'Donoghue (Teagasc REDP)
*
*****************************************************************

clear
set mem 1000m
set more off
set matsize 1000
set maxvar 30000

** run .do files in order

*****************************************************************
* Run Parameters
*****************************************************************

* Recreate base data
scalar sc_recreate_data = 1     // line 227

* Run Analysis
scalar sc_runanalysis = 0       // line 2465

* Type of Simulation

scalar sc_simulation = 1        // line 32
scalar sc_orig_data = 0         // line 37

* 1 Original Data - no simulation
if  sc_simulation == 1 {
	* Use Original Data
	scalar sc_orig_data = 1

}
if sc_orig_data == 1 {
	* Actual or CSO price
	scalar sc_sim_actprice = 0
	scalar sc_volchange = 0
	scalar sc_pricechange = 0
}


* 2. Actual volume  change and price change for those without variable
*      or farm attrition, but average change otherwise 
*scalar sc_volchange = 1 [actual volume change]
*scalar sc_pricechange = 1 [actual price change]

if sc_simulation == 2 {
	* Actual or CSO price
	scalar sc_sim_actprice = 1
	scalar sc_volchange = 1
	scalar sc_pricechange = 1
}

* 3. Actual price change for those without variable or farm attrition,
*      but average change otherwise. No Volume Change
*scalar sc_volchange = 0 [no volume change]
*scalar sc_pricechange = 1 [actual price change]
if sc_simulation == 3 {
	* Actual or CSO price
	scalar sc_sim_actprice = 1
	scalar sc_volchange = 0
	scalar sc_pricechange = 1
}

* 4. CSO price change for those without variable or farm attrition,
*   but average change otherwise. No Volume Change
*scalar sc_volchange = 0 [no volume change]
*scalar sc_pricechange = 2 [CSO price change]
if sc_simulation == 4 {
	* Actual or CSO price
	scalar sc_sim_actprice = 0
	scalar sc_volchange = 0
	scalar sc_pricechange = 2
}

* 4. Scenario price change for those without variable or farm
*      attrition, but average change otherwise. No Volume Change
*scalar sc_volchange = 0 [no volume change]
*scalar sc_pricechange = 3 [Scenario price change]

if sc_simulation == 5 {
	* Actual or CSO price
	scalar sc_sim_actprice = 0
	scalar sc_volchange = 0
	scalar sc_pricechange = 3
}


*****************************************************************
* Directories
*****************************************************************

*Do-Files
local dodir = "D:\data\Data_NFSPanelANalysis\Do_Files\FarmPriceVolMSM"
global dodir1 = "`dodir'"

* Original Data
local OrigData = "D:\DATA\Data_NFSPanelANalysis\OrigData\FarmPriceVolMSM"

* Output Data
local s = sc_simulation
local OutDataO = "D:\data\Data_NFSPanelANalysis\OutData\FarmPriceVolMSM\\`s'"
global OutDataO1 = "`OutDataO'"
local OutData = "D:\data\Data_NFSPanelANalysis\OutData\FarmPriceVolMSM"
global OutData1 = "`OutData'"

* create scalars for input costs




* Ensure that Output Data directories exist
capture mkdir `OutDataO'
capture mkdir `OutData'


*****************************************************************

* do `dodir'\CreateScalars.do






*Create Price scalars
*********************

do `dodir'\CreatePricescalar.do



*************************************
* Create Crop Fertiliser Level Tables 
*************************************

*************************************
* Merge Crop Level Cost Tables 
*************************************



* First set of imputations before Price Simulation

local vlist0 = "svy_crop_fertilizer_1 svy_crop_fertilizer_2 hay_silage_ha pasture_ha hay_ha silage_ha "  
local vlist1 = "pasture_hay_silage_ha svy_crop_expenses_1 svy_crops_casual_labour_1 svy_crop_disposal_1 svy_crops_1 merged_crop_tables_0  merged_crop_tables"


* Input file for relevant Output File


local svy_crop_fertilizer_1_in = "svy_crop_fertilizer"
local svy_crop_fertilizer_2_in = "svy_crop_fertilizer_1"
local hay_silage_ha_in = "svy_hay_silage"
local pasture_ha_in = "svy_farm"
local hay_ha_in = "hay_silage_ha"
local silage_ha_in = "hay_silage_ha"
local pasture_hay_silage_ha_in = "pasture_hay_silage_ha_0"
local svy_crop_expenses_1_in = "svy_crop_expenses"
local svy_crops_casual_labour_1_in = "svy_crops_casual_labour"
local svy_crop_disposal_1_in = "svy_crop_disposal"
local svy_crops_1_in = "svy_crops"
local merged_crop_tables_0_in = "svy_crops_1"
local merged_crop_tables_in = "merged_crop_tables_0"



* Input Directory for relevant Output File
local svy_crop_fertilizer_1_ind = "OrigData"
local svy_crop_fertilizer_2_ind = "OutData"
local hay_silage_ha_ind = "OrigData"
local pasture_ha_ind = "OrigData"
local hay_ha_ind = "OutData"
local silage_ha_ind = "OutData"
local pasture_hay_silage_ha_ind = "OutData"
local svy_crop_expenses_1_ind = "OrigData"
local svy_crops_casual_labour_1_ind = "OrigData"
local svy_crop_disposal_1_ind = "OrigData"
local svy_crops_1_ind = "OrigData"
local merged_crop_tables_0_ind = "OutData"
local merged_crop_tables_ind = "OutData"

* Merge File
local svy_crop_fertilizer_1_m = ""
local svy_crop_fertilizer_2_m = "enter_exit_nfs"
local hay_silage_ha_m = ""
local pasture_ha_m = "hay_silage_ha"
local hay_ha_m = ""
local silage_ha_m = ""
local pasture_hay_silage_ha_m = ""
local svy_crop_expenses_1_m = "svy_crop_fertilizer_2"
local svy_crops_casual_labour_1_m = "svy_crop_expenses_1"
local svy_crop_disposal_1_m = "svy_crops_casual_labour_1"
local svy_crops_1_m = "svy_crop_disposal_1"
local merged_crop_tables_0_m = "pasture_hay_silage_ha"
local merged_crop_tables_m = "enter_exit_nfs"


* Merge Directory
local svy_crop_fertilizer_1_md = ""
local svy_crop_fertilizer_2_md = "OrigData"
local hay_silage_ha_md = ""
local pasture_ha_md = "OutData"
local hay_ha_md = ""
local silage_ha_md = ""
local pasture_hay_silage_ha_md = ""
local svy_crop_expenses_1_md = "OutData"
local svy_crops_casual_labour_1_md = "OutData"
local svy_crop_disposal_1_md = "OutData"
local svy_crops_1_md = "OutData"
local merged_crop_tables_0_md = "OutData"
local merged_crop_tables_md = "OrigData"

* Sort List relevant Output File
local svy_crop_fertilizer_1_s = "FARM_CODE YE_AR CROP_CODE"
local svy_crop_fertilizer_2_s = "FARM_CODE YE_AR"
local hay_silage_ha_s = "FARM_CODE YE_AR"
local pasture_ha_s = "FARM_CODE YE_AR "
local hay_ha_s = "FARM_CODE YE_AR CROP_CODE"
local silage_ha_s = "FARM_CODE YE_AR CROP_CODE"
local pasture_hay_silage_ha_s = "FARM_CODE YE_AR CROP_CODE"
local svy_crop_expenses_1_s = "FARM_CODE YE_AR CROP_CODE"
local svy_crops_casual_labour_1_s = "FARM_CODE YE_AR CROP_CODE"
local svy_crop_disposal_1_s = "FARM_CODE YE_AR CROP_CODE"
local svy_crops_1_s = "FARM_CODE YE_AR CROP_CODE"
local merged_crop_tables_0_s = "FARM_CODE YE_AR CROP_CODE"
local merged_crop_tables_s = "FARM_CODE YE_AR "



if sc_recreate_data == 1 {
	foreach var in `vlist0' {

		*Directory
		local dir = "`var'_ind"
		di "`dir'"
			
		* Open Input file
		di "`var'_in: ``var'_in'"
		
		use "```dir'''\\``var'_in'", clear
		mvencode *, mv(0) override

		if "``var'_in'" == "hay_silage_ha" {
			
		}
		if "``var'_md'" != "" {
			local mdir = "`var'_md"
			di "`mdir'"
			di "`var'_md: ``var'_md'"
			sort ``var'_s'
			merge ``var'_s' using "```mdir'''\\``var'_m'"
			drop _merge
		}

		* Run Preparation File
		do `dodir'\Cr_`var'.do

		* Sort variables
		sort ``var'_s'
		* Save Output File
		save "`OutData'\\`var'", replace

	}

	*************************************
	* Merge Fodder crops together
	*************************************

	use "`OutData'\\pasture_ha.dta", clear
	sort FARM_CODE YE_AR CROP_CODE
	merge FARM_CODE YE_AR CROP_CODE using `OutData'\\hay_ha.dta
	drop _merge
	sort FARM_CODE YE_AR CROP_CODE
	merge FARM_CODE YE_AR CROP_CODE using `OutData'\\silage_ha.dta
	drop _merge
	order FARM_CODE YE_AR CROP_CODE d_pasture_adj_for_hay_silage_ha d_adjusted_hectarage_of_hay_ha d_adj_hectarage_of_silage_ha
	sort FARM_CODE YE_AR CROP_CODE
	save `OutData'\pasture_hay_silage_ha_0, replace


	* Save a file that was sorted in a different way
	use "`OutData'\svy_crop_fertilizer_2.dta", clear
	sort FARM_CODE YE_AR CROP_CODE
	save "`OutData'\svy_crop_fertilizer_2.dta", replace


	foreach var in `vlist1' {

		*Directory
		local dir = "`var'_ind"
		di "`dir'"
			
		* Open Input file
		di "`var'_in: ``var'_in'"
		
		use "```dir'''\\``var'_in'", clear
		mvencode *, mv(0) override

		if "``var'_in'" == "hay_silage_ha" {
			
		}
		if "``var'_md'" != "" {
			local mdir = "`var'_md"
			di "`mdir'"
			di "`var'_md: ``var'_md'"
			sort ``var'_s'
			merge ``var'_s' using "```mdir'''\\``var'_m'"
			drop _merge
		}

		* Run Preparation File
		do `dodir'\Cr_`var'.do

		* Sort variables
		sort ``var'_s'
		* Save Output File
		save "`OutData'\\`var'", replace

	}



	* Save a file that was sorted in a different way
	use "`OutData'\merged_crop_tables.dta", clear
	sort FARM_CODE YE_AR CROP_CODE
	save "`OutData'\merged_crop_tables.dta", replace




	*************************************
	* Create NFS Price Variables Crop Price Changes 
	* NB in earlier version of the model, we created price and simulated price at the same time
	*************************************

	* Assign Price create and simulation groups to the different variables used in the model

	do `dodir'\pricevlist.do

	local vlist0 = "s_c_FERT_USED_VALUE CY_SALES CY_FED CY_CLOSING OP_INV_SALES OP_INV_FED OP_INV_SEED OP_INV_CLOSING OP_INV CROP_PROTECTION PURCHASED_SEED TRANSPORT_GROSS_COST TRANSPORT_SUBSIDY MACHINERY_HIRE MISCELLANEOUS"  

	* Sort List relevant Output File
	local crop_s = "FARM_CODE YE_AR CROP_CODE"

	* All files are at crop level so we do not need to open or save
	use "`OutData'\merged_crop_tables.dta", clear

	global prvlist = "`vlist0'"
	* Run Price Calculator File
	do `dodir'\PriceCalculator.do
	* Sort variables
	sort `crop_s'
		

	save "`OutData'\merged_crop_tables_1.dta", replace
}
*************************************
* Simulate Crop Price Changes 
*************************************

local prvlist13 = "s_c_FERT_USED_VALUE"
local prvlist11 = "CY_SALES CY_FED CY_CLOSING OP_INV_SALES OP_INV_FED OP_INV_SEED OP_INV_CLOSING OP_INV "
local prvlist12 = "CROP_PROTECTION PURCHASED_SEED TRANSPORT_GROSS_COST TRANSPORT_SUBSIDY MACHINERY_HIRE MISCELLANEOUS"

* Sort List relevant Output File
local crop_s = "FARM_CODE YE_AR CROP_CODE"

use "`OutData'\merged_crop_tables_1.dta", clear
* Initialise
scalar sc_iteration = 1
global prvlist = "`prvlist13'"
* Run Price Calculator File
do `dodir'\PriceSimulator.do
global prvlist = "`prvlist11'"
* Run Price Calculator File
do `dodir'\PriceSimulator.do
global prvlist = "`prvlist12'"
* Run Price Calculator File
do `dodir'\PriceSimulator.do

* Sort variables
sort `crop_s'

save "`OutData'\merged_crop_tables_2.dta", replace

* Save count data
foreach var in `prvlist13' `prvlist12' {

	use "`OutData'\merged_crop_tables_2.dta", clear
	* Save Count Data
	keep FARM_CODE YE_AR CROP_CODE nonzero* hasvar* `var'_EU
	sort FARM_CODE YE_AR
	save "`OutDataO'\\`var'_count.dta", replace
}
foreach var in `prvlist11' {
	use "`OutData'\merged_crop_tables_2.dta", clear
	* Save Count Data
	keep FARM_CODE YE_AR CROP_CODE nonzero* hasvar* `var'_VALUE_EU
	sort FARM_CODE YE_AR
	save "`OutDataO'\\`var'_count.dta", replace
}


***************************************************************
* Create Intermediate Variables
***************************************************************

* First set of imputations before Price Simulation
local vlist0 = "i_concentrates hay_silage_fed GrazingDC OP_INV_VAL_EU Fodder_Unit_Cost Alloc_WinterForage FodderGO"

local file = "merged_crop_tables_2"
local file2 = "merged_crop_tables_3"

local dir = "`OutData'"
di "`dir'"
	
* Open Input file
use "`dir'\\`file'", clear
mvencode *, mv(0) override

* Run intermediate files
foreach var in `vlist0' {
	
	* Run Preparation File
	do `dodir'\Cr_`var'.do

}
* Sort variables
sort FARM_CODE YE_AR CROP_CODE
* Save Output File
save "`OutData'\\`file2'", replace

use "`OutData'\merged_crop_tables_3.dta", clear
keep FARM_CODE YE_AR nonzero* hasvar*
sort FARM_CODE YE_AR
save "`OutData'\crops_go_and_expnses_vars_count.dta", replace



***************************************************************
* Recreate intermediate variables and lower level derived variables
***************************************************************

*do `dodir'\recreate_the_i_variables_2_pvadj.do

* First set of imputations before Price Simulation
local vlist1 = "hay_sil_fed_unit_cost svy_hay_silage_0 svy_hay_silage_1 svy_horses_other_0 horses_boarding_in_out_com svy_horses_other_1 svy_sheep_0"


* Next set of imputations after Price Simulation
local vlist2 = "sheep_boarding_in_out_com svy_sheep_2 svy_cattle_0" 

local vlist3a = "cattle_dairy_boarding_com svy_cattle_2 svy_deer_1 svy_grazing_1"
local vlist3b = "sum_grazing_total_dc_eu svy_grazing_2 wint_forg_fed_unit_cost bulkfeed_fed_livestock_eu_1 bulkfeed_fed_livestock_eu_2"



* Next set of imputations after Price Simulation2
local vlist4 = "svy_livestock_expenses_1" 
local vlist5 = "svy_dairy_produce_1"
local vlist6 = "svy_subsidies_grants_1 svy_pigs_1 svy_poultry_1" 
local vlist7 = "car_electricity_telephone paid_labour hired_labour_casual_excl interest_payments machinery_op_expenses depreciation_of_machinery depreciation_of_buildings depreciation_of_land_imps misc_overhead_costs power_machinery_totals"

* Input file for relevant Output File
local hay_sil_fed_unit_cost_in = "merged_crop_tables_3"
local svy_hay_silage_0_in = "svy_hay_silage"
local svy_hay_silage_1_in = "svy_hay_silage_0"
local svy_horses_other_0_in = "svy_horses_other"
local horses_boarding_in_out_com_in = "svy_grazing"
local svy_horses_other_1_in = "svy_horses_other_0"
local svy_sheep_0_in = "svy_sheep"
local sheep_boarding_in_out_com_in = "svy_grazing"
local svy_sheep_2_in = "svy_sheep_1"
local svy_cattle_0_in = "svy_cattle"
local cattle_dairy_boarding_com_in = "svy_grazing"
local svy_cattle_2_in = "svy_cattle_1"
local svy_deer_1_in = "svy_deer"
local svy_grazing_1_in = "svy_grazing"
local sum_grazing_total_dc_eu_in = "merged_crop_tables_3"
local svy_grazing_2_in = "sum_grazing_total_dc_eu"
local wint_forg_fed_unit_cost_in = "merged_crop_tables_3"
local bulkfeed_fed_livestock_eu_1_in = "svy_purchased_bulkyfeed"
local bulkfeed_fed_livestock_eu_2_in = "bulkfeed_fed_livestock_eu_1"
local bulkfeed_fed_livestock_eu_in = "bulkfeed_fed_livestock_eu_3"
local svy_livestock_expenses_1_in = "svy_livestock_expenses"
local svy_dairy_produce_1_in = "svy_dairy_produce"
local svy_subsidies_grants_1_in = "svy_subsidies_grants"
local svy_pigs_1_in = "svy_pigs"
local svy_poultry_1_in = "svy_poultry"
local car_electricity_telephone_in = "svy_misc_receipts_expenses"
local paid_labour_in = "svy_paid_labour"
local hired_labour_casual_excl_in = "svy_farm"
local interest_payments_in = "svy_loans"
local machinery_op_expenses_in = "svy_misc_receipts_expenses"
local depreciation_of_machinery_in = "svy_asset"
local depreciation_of_buildings_in = "svy_asset"
local depreciation_of_land_imps_in = "svy_asset"
local misc_overhead_costs_in = "svy_fertilizer_lime_other"
local power_machinery_totals_in = "svy_other_machinery_totals"

* Input Directory for relevant Output File
local hay_sil_fed_unit_cost_ind = "OutData"
local svy_hay_silage_0_ind = "OrigData"
local svy_hay_silage_1_ind = "OutData"
local svy_horses_other_0_ind = "OrigData"
local horses_boarding_in_out_com_ind = "OrigData"
local svy_horses_other_1_ind = "OutData"
local svy_sheep_0_ind = "OrigData"
local sheep_boarding_in_out_com_ind = "OrigData"
local svy_sheep_2_ind = "OutData"
local svy_cattle_0_ind = "OrigData"
local cattle_dairy_boarding_com_ind = "OrigData"
local svy_cattle_2_ind = "OutData"
local svy_deer_1_ind = "OrigData"
local svy_grazing_1_ind = "OrigData"
local sum_grazing_total_dc_eu_ind = "OutData"
local svy_grazing_2_ind = "OutData"
local wint_forg_fed_unit_cost_ind = "OutData"
local bulkfeed_fed_livestock_eu_1_ind = "OrigData"
local bulkfeed_fed_livestock_eu_2_ind = "OutData"
local bulkfeed_fed_livestock_eu_ind = "OutData"
local svy_livestock_expenses_1_ind = "OrigData"
local svy_dairy_produce_1_ind = "OrigData"
local svy_subsidies_grants_1_ind = "OrigData"
local svy_pigs_1_ind = "OrigData"
local svy_poultry_1_ind = "OrigData"
local car_electricity_telephone_ind = "OrigData"
local paid_labour_ind = "OrigData"
local hired_labour_casual_excl_ind = "OrigData"
local interest_payments_ind = "OrigData"
local machinery_op_expenses_ind = "OrigData"
local depreciation_of_machinery_ind = "OrigData"
local depreciation_of_buildings_ind = "OrigData"
local depreciation_of_land_imps_ind = "OrigData"
local misc_overhead_costs_ind = "OrigData"
local power_machinery_totals_ind = "OrigData"

* Merge File
local hay_sil_fed_unit_cost_m = ""
local svy_hay_silage_0_m = "hay_sil_fed_unit_cost"
local svy_hay_silage_1_m = ""
local svy_horses_other_0_m = ""
local horses_boarding_in_out_com_m = ""
local svy_horses_other_1_m = "horses_boarding_in_out_com"
local svy_sheep_0_m = ""
local sheep_boarding_in_out_com_m = ""
local svy_sheep_2_m = "sheep_boarding_in_out_com"
local svy_cattle_0_m = ""
local cattle_dairy_boarding_com_m = ""
local svy_cattle_2_m = "cattle_dairy_boarding_com"
*local svy_grazing_1_m = "total_lu_home_grazing"
local svy_grazing_1_m = ""
local sum_grazing_total_dc_eu_m = ""
local svy_grazing_2_m = "svy_grazing_1"
local wint_forg_fed_unit_cost_m = ""
local bulkfeed_fed_livestock_eu_1_m = ""
local bulkfeed_fed_livestock_eu_2_m = "enter_exit_nfs"
local bulkfeed_fed_livestock_eu_m = ""
local svy_livestock_expenses_1_m = ""
local svy_dairy_produce_1_m = ""
local svy_subsidies_grants_1_m = ""
local svy_pigs_1_m = ""
local svy_poultry_1_m = ""
local car_electricity_telephone_m = "svy_car_expenses"
local paid_labour_m = ""
local hired_labour_casual_excl_m = "paid_labour"
local interest_payments_m = ""
local machinery_op_expenses_m = ""
local depreciation_of_machinery_m = ""
local depreciation_of_buildings_m = ""
local depreciation_of_land_imps_m = ""
local misc_overhead_costs_m = "svy_misc_receipts_expenses"
local power_machinery_totals_m = ""

* Merge Directory
local hay_sil_fed_unit_cost_md = ""
local svy_hay_silage_0_md = "OutData"
local svy_hay_silage_1_md = ""
local svy_horses_other_0_md = ""
local horses_boarding_in_out_com_md = ""
local svy_horses_other_1_md = "OrigData"
local svy_sheep_0_md = ""
local sheep_boarding_in_out_com_md = ""
local svy_sheep_2_md = "OutData"
local svy_cattle_0_md = ""
local cattle_dairy_boarding_com_md = ""
local svy_cattle_2_md = "OutData"
local svy_grazing_1_md = ""
local sum_grazing_total_dc_eu_md = ""
local svy_grazing_2_md = "OutData"
local wint_forg_fed_unit_cost_md = ""
local bulkfeed_fed_livestock_eu_1_md = ""
local bulkfeed_fed_livestock_eu_2_md = "OrigData"
local bulkfeed_fed_livestock_eu_md = ""
local svy_livestock_expenses_1_md = ""
local svy_dairy_produce_1_md = ""
local svy_subsidies_grants_1_md = ""
local svy_pigs_1_md = ""
local svy_poultry_1_md = ""
local car_electricity_telephone_md = "OrigData"
local paid_labour_md = ""
local hired_labour_casual_excl_md = "OutData"
local interest_payments_md = ""
local machinery_op_expenses_md = ""
local depreciation_of_machinery_md = ""
local depreciation_of_buildings_md = ""
local depreciation_of_land_imps_md = ""
local misc_overhead_costs_md = "OrigData"
local power_machinery_totals_md = ""

* Sort List relevant Output File
local hay_sil_fed_unit_cost_s = "FARM_CODE YE_AR"
local svy_hay_silage_0_s = "FARM_CODE YE_AR"
local svy_hay_silage_1_s = "FARM_CODE YE_AR"
local svy_horses_other_0_s = "FARM_CODE YE_AR"
local horses_boarding_in_out_com_s = "FARM_CODE YE_AR"
local svy_horses_other_1_s = "FARM_CODE YE_AR"
local svy_sheep_0_s = "FARM_CODE YE_AR"
local sheep_boarding_in_out_com_s = "FARM_CODE YE_AR"
local svy_sheep_2_s = "FARM_CODE YE_AR"
local svy_cattle_0_s = "FARM_CODE YE_AR"
local cattle_dairy_boarding_com_s = "FARM_CODE YE_AR"
local svy_cattle_2_s = "FARM_CODE YE_AR"
local svy_deer_1_s = "FARM_CODE YE_AR"
local svy_grazing_1_s = "FARM_CODE YE_AR"
local sum_grazing_total_dc_eu_s = "FARM_CODE YE_AR"
local svy_grazing_2_s = "FARM_CODE YE_AR"
local wint_forg_fed_unit_cost_s = "FARM_CODE YE_AR"
local bulkfeed_fed_livestock_eu_1_s = "FARM_CODE YE_AR"
local bulkfeed_fed_livestock_eu_2_s = "FARM_CODE YE_AR"
local bulkfeed_fed_livestock_eu_s = "FARM_CODE YE_AR"
local svy_livestock_expenses_1_s = "FARM_CODE YE_AR"
local svy_dairy_produce_1_s = "FARM_CODE YE_AR"
local svy_subsidies_grants_1_s = "FARM_CODE YE_AR"
local svy_pigs_1_s = "FARM_CODE YE_AR"
local svy_poultry_1_s = "FARM_CODE YE_AR"
local car_electricity_telephone_s = "FARM_CODE YE_AR"
local paid_labour_s = "FARM_CODE YE_AR"
local hired_labour_casual_excl_s = "FARM_CODE YE_AR"
local interest_payments_s = "FARM_CODE YE_AR"
local machinery_op_expenses_s = "FARM_CODE YE_AR"
local depreciation_of_machinery_s = "FARM_CODE YE_AR"
local depreciation_of_buildings_s = "FARM_CODE YE_AR"
local depreciation_of_land_imps_s = "FARM_CODE YE_AR"
local misc_overhead_costs_s = "FARM_CODE YE_AR"
local power_machinery_totals_s = "FARM_CODE YE_AR"

foreach var in `vlist1' {

	*Directory
	di "1"

	local dir = "`var'_ind"
	di "`dir'"
		
	* Open Input file
	use "```dir'''\\``var'_in'", clear
	mvencode *, mv(0) override

	if "``var'_md'" != "" {
		local mdir = "`var'_md"
		di "`mdir'"
		sort ``var'_s'
		merge ``var'_s' using "```mdir'''\\``var'_m'"
		drop _merge
	}

	* Run Preparation File
	do `dodir'\Cr_`var'.do

	* Sort variables
	sort ``var'_s'

	* Save Output File
	save "`OutData'\\`var'", replace
}

*************************************
* Create NFS Price Variables Price Changes 
*************************************

* Assign Price create and simulation groups to the different variables used in the model


* Sort List relevant Output File
local crop_s = "FARM_CODE YE_AR "

local prvlist0 = "FAT_LAMBS_SALES STORE_LAMBS_SALES FAT_HOGGETS_SALES BREEDING_HOGGETS_SALES CULL_EWES_RAMS_SALES BREEDING_EWES_SALES USED_IN_HOUSE STORE_LAMBS_PURCHASES EWES_RAMS_PURCHASES BREEDING_HOGGETS_PURCHASES"


local prvlist1 = "DAIRY_CALVES_TRANSFER DAIRY_CALVES_SALES DY_COWS_SH_BULS_TRNSFR_OUT DY_COWS_SH_BULLS_PURCHASES DY_COWS_SH_BULS_TRNSFR_IN CATTLE_CALVES_SALES CATTLE_WEANLINGS_SALES"
local prvlist2 = "CATTLE_STORES_MALE_SALES CATTLE_STORES_FEMALE_SALES CATTLE_FINISHED_MALE_SALES CTL_FINISHED_FEMALE_SALES CTL_BREEDING_ANIMALS_SALES CATTLE_OTHER_SALES CTL_BREDING_HRD_CULS_SALES"
local prvlist3 = "CATTLE_CALVES_PURCHASES CATTLE_WEANLINGS_PURCHASES CTL_STORES_MALE_PURCHASES CTL_STORES_FMALE_PURCHASES CTL_BREED_REPLCMENTS_PURCH CATTLE_OTHER_PURCHASES"


local prvlist4 = "s_b_ALLOC_DAIRY_HERD s_b_ALLOC_CATTLE s_b_ALLOC_SHEEP s_b_ALLOC_HORSES s_b_ALLOC_DEER s_b_ALLOC_GOATS"

local prvlist5 = "CONC_PURCHASED_50KGBAGS CONC_ALLC_DARY_HRD_50KGBGS CONC_ALLOC_CATTLE_50KGBAGS CONC_ALLOC_SHEEP_50KGBAGS CONC_ALLOC_HORSES_50KGBAGS CONC_ALLOC_PIGS_50KGBAGS CONC_ALLOC_PLTRY_50KGBAGS"
local prvlist6 = "TRANSPORT_ALLOC_DAIRY_HERD TRANSPORT_ALLOC_CATTLE TRANSPORT_ALLOC_SHEEP TRANSPORT_ALLOC_HORSES TRANSPORT_ALLOC_PIGS TRANSPORT_ALLOC_POULTRY"
local prvlist7 = "VET_MED_ALLOC_DAIRY_HERD VET_MED_ALLOC_CATTLE VET_MED_ALLOC_SHEEP VET_MED_ALLOC_HORSES VET_MED_ALLOC_PIGS VET_MED_ETC_ALLOC_POULTRY"
local prvlist8 = "AI_SR_FEES_ALOC_DAIRY_HRD AI_SER_FEES_ALLOC_CATTLE AI_SER_FEES_ALLOC_SHEEP AI_SER_FEES_ALLOC_HORSES AI_SER_FEES_ALLOC_PIGS"
local prvlist9 = "MISC_ALLOC_DAIRY_HERD MISCELLANEOUS_ALLOC_CATTLE MISCELLANEOUS_ALLOC_SHEEP MISCELLANEOUS_ALLOC_HORSES MISCELLANEOUS_ALLOC_PIGS MISC_ALLOC_POULTRY"


local prvlist10 = "WHLE_MILK_SOLD_TO_CREAMERY LQDMLK_SOLD_WSALE_RETAIL"


*************************************
* Create Price Changes Animal & BulkyFeed 1
*************************************

use "`OutData'\svy_sheep_0.dta", clear

* Run Price Simulation
local crop_s = "FARM_CODE YE_AR"
global prvlist = "`prvlist0'"
* Run Price Calculator File
do `dodir'\PriceCalculator.do
* Sort variables
sort `crop_s'
	

save "`OutData'\svy_sheep_0pc.dta", replace

*************************************
* Simulate Price Changes 
*************************************
use "`OutData'\svy_sheep_0pc.dta", clear
local i = 0
while `i' <= 0 {
global prvlist = "`prvlist0'"
	* Run Price Calculator File
	do `dodir'\PriceSimulator.do
	* Sort variables
	sort `crop_s'
	local i = `i' + 1
}


*Todo Change
save "`OutData'\svy_sheep_1.dta", replace


* Save count data

foreach var in `prvlist0' {

	use "`OutData'\svy_sheep_1.dta", clear
	* Save Count Data
	keep FARM_CODE YE_AR nonzero* hasvar* `var'_EU
	sort FARM_CODE YE_AR
	save "`OutDataO'\\`var'_count.dta", replace
}

*************************************
* Next Set of Simulations
*************************************

foreach var in `vlist2' {

	*Directory
	di "1"

	local dir = "`var'_ind"
	di "`dir'"
		
	* Open Input file
	use "```dir'''\\``var'_in'", clear
	mvencode *, mv(0) override

	if "``var'_md'" != "" {
		local mdir = "`var'_md"
		di "`mdir'"
		sort ``var'_s'
		merge ``var'_s' using "```mdir'''\\``var'_m'"
		drop _merge
	}

	* Run Preparation File
	do `dodir'\Cr_`var'.do

	* Sort variables
	sort ``var'_s'

	* Save Output File
	save "`OutData'\\`var'", replace
}



*************************************
* Create Price Changes Animal & BulkyFeed 2
*************************************

use "`OutData'\svy_cattle_0.dta", clear

	* Run Price Simulation
local i = 1
while `i' <= 3 {

	global prvlist = "`prvlist`i''"
	* Run Price Calculator File
	do `dodir'\PriceCalculator.do
	* Sort variables
	sort `crop_s'
		


	*************************************
	* Simulate Price Changes 
	*************************************

	global prvlist = "`prvlist`i''"
	* Run Price Calculator File
	do `dodir'\PriceSimulator.do
	* Sort variables
	sort `crop_s'

	local i = `i' + 1
}

*Todo Change
save "`OutData'\svy_cattle_1.dta", replace


* Save count data

local i = 1
while `i' <= 3 {

	foreach var in `prvlist1' {

		use "`OutData'\svy_cattle_1.dta", clear
		* Save Count Data
		keep FARM_CODE YE_AR nonzero* hasvar* `var'_EU
		sort FARM_CODE YE_AR
		save "`OutDataO'\\`var'_count.dta", replace
	}
	local i = `i' + 1
}


*************************************
* Next Set of Simulations
*************************************

foreach var in `vlist3a' {

	*Directory
	di "1"

	local dir = "`var'_ind"
	di "`dir'"
		
	* Open Input file
	use "```dir'''\\``var'_in'", clear
	mvencode *, mv(0) override

	if "``var'_md'" != "" {
		local mdir = "`var'_md"
		di "`mdir'"
		sort ``var'_s'
		merge ``var'_s' using "```mdir'''\\``var'_m'"
		drop _merge
	}

	* Run Preparation File
	do `dodir'\Cr_`var'.do

	* Sort variables
	sort ``var'_s'

	* Save Output File
	save "`OutData'\\`var'", replace
}

* Merge Files to produce i_total_lu_home_grazing
use "`OutData'\svy_cattle_2.dta", clear
sort  FARM_CODE YE_AR
merge FARM_CODE YE_AR using "`OutData'\svy_sheep_2.dta"
drop _merge
sort  FARM_CODE YE_AR 
merge FARM_CODE YE_AR using "`OutData'\svy_horses_other_1.dta"
drop _merge
sort  FARM_CODE YE_AR
merge FARM_CODE YE_AR using "`OutData'\svy_deer_1.dta"
drop _merge
sort  FARM_CODE YE_AR
merge FARM_CODE YE_AR using "`OutData'\svy_grazing_1.dta"
drop _merge
keep FARM_CODE YE_AR i_horses_lu_home_grazing i_sheep_lu_home_grazing i_cattle_lu_home_grazing i_dairy_lu_home_grazing d_deer_livestock_units 
mvencode *, mv(0) override
gen i_total_lu_home_grazing = i_horses_lu_home_grazing + i_sheep_lu_home_grazing + i_cattle_lu_home_grazing + i_dairy_lu_home_grazing + d_deer_livestock_units
sort  FARM_CODE YE_AR
save "`OutData'\total_lu_home_grazing.dta", replace


use `OutData'\svy_grazing_1, clear
sort  FARM_CODE YE_AR
merge FARM_CODE YE_AR using "`OutData'\total_lu_home_grazing.dta"
drop _merge
sort FARM_CODE YE_AR
save `OutData'\svy_grazing_1, replace

foreach var in `vlist3b' {

	*Directory
	di "1"

	local dir = "`var'_ind"
	di "`dir'"
		
	* Open Input file
	use "```dir'''\\``var'_in'", clear
	mvencode *, mv(0) override

	if "``var'_md'" != "" {
		local mdir = "`var'_md"
		di "`mdir'"
		sort ``var'_s'
		merge ``var'_s' using "```mdir'''\\``var'_m'"
		drop _merge
	}

	* Run Preparation File
	do `dodir'\Cr_`var'.do

	* Sort variables
	sort ``var'_s'

	* Save Output File
	save "`OutData'\\`var'", replace
}

*************************************
* Create Price Changes Animal & BulkyFeed 3
*************************************

use "`OutData'\bulkfeed_fed_livestock_eu_2.dta", clear


* Run Price Simulation

global prvlist = "`prvlist4'"
* Run Price Calculator File
do `dodir'\PriceCalculator.do
* Sort variables
sort `crop_s'
	


*************************************
* Simulate Price Changes 
*************************************

global prvlist = "`prvlist4'"
* Run Price Calculator File
do `dodir'\PriceSimulator.do
* Sort variables
sort `crop_s'

* Reduce dimensionality to one row per farm per year - collapse over  BULKYFEED_CODE
sort  FARM_CODE YE_AR
by FARM_CODE YE_AR: egen rnk1 = rank( YE_AR), unique
keep if rnk1 == 1
drop rnk1

*Todo Change
save "`OutData'\bulkfeed_fed_livestock_eu_3.dta", replace


* Save count data

foreach var in `prvlist4' {

	use "`OutData'\bulkfeed_fed_livestock_eu_3.dta", clear
	* Save Count Data
	keep FARM_CODE YE_AR nonzero* hasvar* `var'_EU
	sort FARM_CODE YE_AR
	save "`OutDataO'\\`var'_count.dta", replace
}




*************************************
* Next Set of Simulations
*************************************

foreach var in `vlist4' {

	*Directory
	di "1"

	local dir = "`var'_ind"
	di "`dir'"
		
	* Open Input file
	use "```dir'''\\``var'_in'", clear
	mvencode *, mv(0) override

	if "``var'_md'" != "" {
		local mdir = "`var'_md"
		di "`mdir'"
		sort ``var'_s'
		merge ``var'_s' using "```mdir'''\\``var'_m'"
		drop _merge
	}

	* Run Preparation File
	do `dodir'\Cr_`var'.do

	* Sort variables
	sort ``var'_s'

	* Save Output File
	save "`OutData'\\`var'", replace
}


*************************************
* Create Price Changes Animal & BulkyFeed 4
*************************************

use "`OutData'\svy_livestock_expenses_1.dta", clear

* Run Price Simulation
*5-8


local i = 5
while `i' <= 9 {
	global prvlist = "`prvlist`i''"
	* Run Price Calculator File
	do `dodir'\PriceCalculator.do
	* Sort variables
	sort `crop_s'
		


	*************************************
	* Simulate Price Changes 
	*************************************

	global prvlist = "`prvlist`i''"
	* Run Price Calculator File
	do `dodir'\PriceSimulator.do
	* Sort variables
	sort `crop_s'

	local i = `i' + 1
}

*Todo Change
save "`OutData'\svy_livestock_expenses_2.dta", replace


* Save count data

local i = 5
while `i' <= 9 {
	local prvlist = "`prvlist`i''"
	foreach var in `prvlist' {

		use "`OutData'\svy_livestock_expenses_2.dta", clear
		* Save Count Data
		keep FARM_CODE YE_AR nonzero* hasvar* `var'_EU
		sort FARM_CODE YE_AR
		save "`OutDataO'\\`var'_count.dta", replace
	}

	local i = `i' + 1
}



*************************************
* Next Set of Simulations
*************************************

foreach var in `vlist5' {

	*Directory
	di "1"

	local dir = "`var'_ind"
	di "`dir'"
		
	* Open Input file
	use "```dir'''\\``var'_in'", clear
	mvencode *, mv(0) override

	if "``var'_md'" != "" {
		local mdir = "`var'_md"
		di "`mdir'"
		sort ``var'_s'
		merge ``var'_s' using "```mdir'''\\``var'_m'"
		drop _merge
	}

	* Run Preparation File
	do `dodir'\Cr_`var'.do

	* Sort variables
	sort ``var'_s'

	* Save Output File
	save "`OutData'\\`var'", replace
}



*************************************
* Create Price Changes Animal & BulkyFeed 5
*************************************

use "`OutData'\svy_dairy_produce_1.dta", clear

* Run Price Simulation
*5-8


local i = 10
while `i' <= 10 {
	global prvlist = "`prvlist`i''"
	* Run Price Calculator File
	do `dodir'\PriceCalculator.do
	* Sort variables
	sort `crop_s'
		


	*************************************
	* Simulate Price Changes 
	*************************************

	global prvlist = "`prvlist`i''"
	* Run Price Calculator File
	do `dodir'\PriceSimulator.do
	* Sort variables
	sort `crop_s'

	local i = `i' + 1
}

*Todo Change
save "`OutData'\svy_dairy_produce_2.dta", replace


* Save count data

local i = 10
while `i' <= 10 {
	local prvlist = "`prvlist`i''"
	foreach var in `prvlist' {

		use "`OutData'\svy_dairy_produce_2.dta", clear
		* Save Count Data
		keep FARM_CODE YE_AR nonzero* hasvar* `var'_EU
		sort FARM_CODE YE_AR
		save "`OutDataO'\\`var'_count.dta", replace
	}

	local i = `i' + 1
}


*************************************
* Next Set of Simulations
*************************************

foreach var in `vlist6' `vlist7' {

	*Directory
	di "1"

	local dir = "`var'_ind"
	di "`dir'"
		
	* Open Input file
	use "```dir'''\\``var'_in'", clear
	mvencode *, mv(0) override

	if "``var'_md'" != "" {
		local mdir = "`var'_md"
		di "`mdir'"
		sort ``var'_s'
		merge ``var'_s' using "```mdir'''\\``var'_m'"
		drop _merge
	}

	* Run Preparation File
	do `dodir'\Cr_`var'.do

	* Sort variables
	sort ``var'_s'

	* Save Output File
	save "`OutData'\\`var'", replace
}



*******************************************************************
* Crops Direct Costs
*******************************************************************
*******************************************************************
* Fodder Crops Sold Direct Costs 
* Inv Misc Cash Crop Direct Costs
* Total Direct Cost Eu For Selected Crop Codes In The Main Total Crop Direct Cost Formula
* Total Direct Cost Eu For Other Cash Crops In The Main Total Crop Direct Cost Formula
* Total Direct Cost Eu For Other Cash Crops In The Main Total Crop Direct Cost Formula
* Setaside
*******************************************************************

* First set of imputations before Price Simulation
local vlist0 = "svy_crops_fodder_dc svy_hay_silage_fodder_dc svy_grazing_fodder_dc farm_boardingi_fod_dc_0 farm_boardingi_fod_dc_1"
local vlist1 = "FodderCrops_DC svy_misc_cash_crops_dc crops_total_dc other_cashcrops_ind_dc setaside_dc select_crops_dc oth_csh_crop_ind_dc"

* Input file for relevant Output File
local svy_crops_fodder_dc_in = "merged_crop_tables_3"
local svy_hay_silage_fodder_dc_in = "svy_hay_silage_1"
local svy_grazing_fodder_dc_in = "svy_grazing_2"
local farm_boardingi_fod_dc_0_in = "svy_cattle_2"
local farm_boardingi_fod_dc_1_in = "farm_boardingi_fod_dc_0"
local FodderCrops_DC_in = "FodderCrops_DC_1"
local svy_misc_cash_crops_dc_in = "merged_crop_tables_3"
local crops_total_dc_in = "merged_crop_tables_3"
local other_cashcrops_ind_dc_in = "merged_crop_tables_3"
local setaside_dc_in = "merged_crop_tables_3"
local other_cashcrops_ind_dc_in = "merged_crop_tables_3"
local select_crops_dc_in = "merged_crop_tables_3"
local oth_csh_crop_ind_dc_in = "merged_crop_tables_3"

* Input Directory for relevant Output File
local svy_crops_fodder_dc_ind = "OutData"
local svy_hay_silage_fodder_dc_ind = "OutData"
local svy_grazing_fodder_dc_ind = "OutData"
local farm_boardingi_fod_dc_0_ind = "OutData"
local farm_boardingi_fod_dc_1_ind = "OutData"
local FodderCrops_DC_ind = "OutData"
local svy_misc_cash_crops_dc_ind = "OutData"
local crops_total_dc_ind = "OutData"
local other_cashcrops_ind_dc_ind = "OutData"
local setaside_dc_ind = "OutData"
local other_cashcrops_ind_dc_ind = "OutData"
local select_crops_dc_ind = "OutData"
local oth_csh_crop_ind_dc_ind = "OutData"

* Merge File
local svy_crops_fodder_dc_m = ""
local svy_hay_silage_fodder_dc_m = "svy_grazing_1"
local svy_grazing_fodder_dc_m = "svy_grazing_1"
local farm_boardingi_fod_dc_0_m = "svy_sheep_2"
local farm_boardingi_fod_dc_1_m = "svy_horses_other_1"
local FodderCrops_DC_m = ""
local svy_misc_cash_crops_dc_m = ""
local crops_total_dc_m = ""
local other_cashcrops_ind_dc_m = ""
local setaside_dc_m = ""
local other_cashcrops_ind_dc_m = ""
local select_crops_dc_m = ""
local oth_csh_crop_ind_dc_m = ""

* Merge Directory
local svy_crops_fodder_dc_md = ""
local svy_hay_silage_fodder_dc_md = "OutData"
local svy_grazing_fodder_dc_md = "OutData"
local farm_boardingi_fod_dc_0_md = "OutData"
local farm_boardingi_fod_dc_1_md = "OutData"
local FodderCrops_DC_md = ""
local svy_misc_cash_crops_dc_md = ""
local crops_total_dc_md = ""
local other_cashcrops_ind_dc_md = ""
local setaside_dc_md = ""
local other_cashcrops_ind_dc_md = ""
local select_crops_dc_md = ""
local oth_csh_crop_ind_dc_md = ""

* Sort List relevant Output File
local svy_crops_fodder_dc_s = "FARM_CODE YE_AR"
local svy_hay_silage_fodder_dc_s = "FARM_CODE YE_AR"
local svy_grazing_fodder_dc_s = "FARM_CODE YE_AR"
local farm_boardingi_fod_dc_0_s = "FARM_CODE YE_AR"
local farm_boardingi_fod_dc_1_s = "FARM_CODE YE_AR"
local FodderCrops_DC_s = "FARM_CODE YE_AR"
local svy_misc_cash_crops_dc_s = "FARM_CODE YE_AR"
local crops_total_dc_s = "FARM_CODE YE_AR"
local other_cashcrops_ind_dc_s = "FARM_CODE YE_AR"
local setaside_dc_s = "FARM_CODE YE_AR"
local other_cashcrops_ind_dc_s = "FARM_CODE YE_AR"
local select_crops_dc_s = "FARM_CODE YE_AR"
local oth_csh_crop_ind_dc_s = "FARM_CODE YE_AR"

foreach var in `vlist0' {

	*Directory
	di "1"

	local dir = "`var'_ind"
	di "`dir'"
		
	* Open Input file
	use "```dir'''\\``var'_in'", clear
	mvencode *, mv(0) override

	if "``var'_md'" != "" {
		local mdir = "`var'_md"
		di "`mdir'"
		sort ``var'_s'
		merge ``var'_s' using "```mdir'''\\``var'_m'"
		drop _merge
	}

	* Run Preparation File
	do `dodir'\Cr_`var'.do

	* Sort variables
	sort ``var'_s'

	* Save Output File
	save "`OutData'\\`var'", replace
}


*****************************************************
* Merge Tables (by farm_code and ye_ar)
*****************************************************

use "`OutData'\svy_crops_fodder_dc.dta", clear
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\svy_hay_silage_fodder_dc.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\svy_grazing_fodder_dc.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\farm_boardingi_fod_dc_1.dta
drop _merge
mvencode *, mv(0) override
sort FARM_CODE YE_AR
save "`OutData'\FodderCrops_DC_1.dta", replace



foreach var in `vlist1' {

	*Directory
	di "1"

	local dir = "`var'_ind"
	di "`dir'"
		
	* Open Input file
	use "```dir'''\\``var'_in'", clear
	mvencode *, mv(0) override

	if "``var'_md'" != "" {
		local mdir = "`var'_md"
		di "`mdir'"
		sort ``var'_s'
		merge ``var'_s' using "```mdir'''\\``var'_m'"
		drop _merge
	}

	* Run Preparation File
	do `dodir'\Cr_`var'.do

	* Sort variables
	sort ``var'_s'

	* Save Output File
	save "`OutData'\\`var'", replace
}


*****************************************************
* Total Crops Direct Costs
*****************************************************


**D_TOTAL_CROPS_DIRECT_COSTS_EU

use "`OutData'\svy_hay_silage_1.dta", clear
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using "`OutData'\FodderCrops_DC.dta"
drop _merge
sort  FARM_CODE YE_AR 
merge FARM_CODE YE_AR using "`OutData'\svy_misc_cash_crops_dc.dta"
drop _merge
sort  FARM_CODE YE_AR
merge FARM_CODE YE_AR using "`OutData'\select_crops_dc.dta"
drop _merge
sort  FARM_CODE YE_AR
merge FARM_CODE YE_AR using "`OutData'\oth_csh_crop_ind_dc.dta"
drop _merge
sort  FARM_CODE YE_AR
merge FARM_CODE YE_AR using "`OutData'\setaside_dc.dta"
drop _merge
keep FARM_CODE YE_AR waste_hay_dc waste_sil_dc dc_fodder_crops_sold_eu d_dc_inv_misc_csh_crop d_dc_select_crops oth_csh_crop_dc s_setaside_dc
sort  FARM_CODE YE_AR
mvencode *, mv(0) override
gen d_total_crops_direct_costs_eu = 0
replace d_total_crops_direct_costs_eu = waste_hay_dc + waste_sil_dc + dc_fodder_crops_sold_eu + d_dc_inv_misc_csh_crop + d_dc_select_crops + oth_csh_crop_dc + s_setaside_dc
sort  FARM_CODE YE_AR
save "`OutData'\total_crops_direct_costs.dta", replace





*****************************************************
*****************************************************
*Livestock Direct Costs
*****************************************************
*****************************************************


* First set of imputations before Price Simulation
*Dairy DC
local vlist0 = "sum_i_conc_fed_dairy d_conc_fed_dairy_eu d_dairy_pasture_eu fed_dairy_tonnes_ha d_dairy_prod_misc_dc_eu"
*Cattle DC
local vlist1 = "sum_i_conc_fed_cattle d_conc_fed_cattle_eu d_total_pasture_eu fed_cattle_tonnes_ha fed_cattle_tonnes_ha d_livestock_misc_dc_eu d_milk_and_milk_subs_no"
*Sheep DC
local vlist2 = "sum_i_conc_fed_sheep d_conc_fed_sheep_eu d_sheep_pasture_eu d_roots_direct_costs_eu fed_sheep_tonnes_ha d_sheep_misc_dc_eu"
*Pigs Poultry etc DC
local vlist3 = "sum_i_conc_fed_pigs d_pigs_total_dc_eu sum_i_conc_fed_poultry d_poultry_total_dc_eu sum_i_conc_fed_horses d_horse_pasture_eu fed_horses_tonnes_ha horses_misc_dc_eu d_deer_pasture_eu fed_deer_tonnes_ha fed_goats_tonnes_ha deer_goats_misc_dc_eu"
*Inter-Enterprise Transfers 
local vlist4 = "d_inter_enterpise_trans_eu"
*Crops GO 
local vlist5 = "svy_crops_fodder_go svy_hay_silage_fodder_go svy_grazing_fodder_go curr_misc_cash_crops_go svy_misc_cash_crops_go"

* Input file for relevant Output File
local sum_i_conc_fed_dairy_in = "merged_crop_tables_3"
local d_conc_fed_dairy_eu_in = "svy_livestock_expenses_2"
local d_dairy_pasture_eu_in = "svy_cattle_2"
local fed_dairy_tonnes_ha_in = "merged_crop_tables_3"
local d_dairy_prod_misc_dc_eu_in = "svy_livestock_expenses_2"
local sum_i_conc_fed_cattle_in = "merged_crop_tables_3"
local d_conc_fed_cattle_eu_in = "svy_livestock_expenses_2"
local d_total_pasture_eu_in = "svy_cattle_2"
local fed_cattle_tonnes_ha_in = "merged_crop_tables_3"
local d_livestock_misc_dc_eu_in = "svy_livestock_expenses_2"
local d_milk_and_milk_subs_no_in = "svy_livestock_expenses_2"
local sum_i_conc_fed_sheep_in = "merged_crop_tables_3"
local d_conc_fed_sheep_eu_in = "svy_livestock_expenses_2"
local d_sheep_pasture_eu_in = "svy_sheep_2"
local d_roots_direct_costs_eu_in = "merged_crop_tables_3"
local fed_sheep_tonnes_ha_in = "merged_crop_tables_3"
local d_sheep_misc_dc_eu_in = "svy_livestock_expenses_2"
local sum_i_conc_fed_pigs_in = "merged_crop_tables_3"
local d_pigs_total_dc_eu_in = "svy_livestock_expenses_2"
local sum_i_conc_fed_poultry_in = "merged_crop_tables_3"
local d_poultry_total_dc_eu_in = "svy_livestock_expenses_2"
local sum_i_conc_fed_horses_in = "merged_crop_tables_3"
local d_horse_pasture_eu_in = "svy_horses_other_1"
local fed_horses_tonnes_ha_in = "merged_crop_tables_3"
local horses_misc_dc_eu_in = "svy_livestock_expenses_2"
local d_deer_pasture_eu_in = "merged_crop_tables_3"
local fed_deer_tonnes_ha_in = "merged_crop_tables_3"
local fed_goats_tonnes_ha_in = "merged_crop_tables_3"
local deer_goats_misc_dc_eu_in = "svy_livestock_expenses_2"
local d_inter_enterpise_trans_eu_in = "merged_crop_tables_3"
local svy_crops_fodder_go_in = "merged_crop_tables_3"
local svy_hay_silage_fodder_go_in = "svy_hay_silage_1"
local svy_grazing_fodder_go_in = "svy_grazing_2"
local curr_misc_cash_crops_go_in = "merged_crop_tables_3"
local svy_misc_cash_crops_go_in = "merged_crop_tables_3"

* Input Directory for relevant Output File
local sum_i_conc_fed_dairy_ind = "OutData"
local d_conc_fed_dairy_eu_ind = "OutData"
local d_dairy_pasture_eu_ind = "OutData"
local fed_dairy_tonnes_ha_ind = "OutData"
local d_dairy_prod_misc_dc_eu_ind = "OutData"
local sum_i_conc_fed_cattle_ind = "OutData"
local d_conc_fed_cattle_eu_ind = "OutData"
local d_total_pasture_eu_ind = "OutData"
local fed_cattle_tonnes_ha_ind = "OutData"
local d_livestock_misc_dc_eu_ind = "OutData"
local d_milk_and_milk_subs_no_ind = "OutData"
local sum_i_conc_fed_sheep_ind = "OutData"
local d_conc_fed_sheep_eu_ind = "OutData"
local d_sheep_pasture_eu_ind = "OutData"
local d_roots_direct_costs_eu_ind = "OutData"
local fed_sheep_tonnes_ha_ind = "OutData"
local d_sheep_misc_dc_eu_ind = "OutData"
local sum_i_conc_fed_pigs_ind = "OutData"
local d_pigs_total_dc_eu_ind = "OutData"
local sum_i_conc_fed_poultry_ind = "OutData"
local d_poultry_total_dc_eu_ind = "OutData"
local sum_i_conc_fed_horses_ind = "OutData"
local d_horse_pasture_eu_ind = "OutData"
local fed_horses_tonnes_ha_ind = "OutData"
local horses_misc_dc_eu_ind = "OutData"
local d_deer_pasture_eu_ind = "OutData"
local fed_deer_tonnes_ha_ind = "OutData"
local fed_goats_tonnes_ha_ind = "OutData"
local deer_goats_misc_dc_eu_ind = "OutData"
local d_inter_enterpise_trans_eu_ind = "OutData"
local svy_crops_fodder_go_ind = "OutData"
local svy_hay_silage_fodder_go_ind = "OutData"
local svy_grazing_fodder_go_ind = "OutData"
local curr_misc_cash_crops_go_ind = "OutData"
local svy_misc_cash_crops_go_ind = "OutData"
local curr_misc_cash_crops_go_1_ind = "OutData"

* Merge File
local sum_i_conc_fed_dairy_m = ""
local d_conc_fed_dairy_eu_m = ""
local d_dairy_pasture_eu_m = "svy_grazing_2"
local fed_dairy_tonnes_ha_m = ""
local d_dairy_prod_misc_dc_eu_m = "svy_dairy_produce_2"
local sum_i_conc_fed_cattle_m = ""
local d_conc_fed_cattle_eu_m = ""
local d_total_pasture_eu_m = "svy_grazing_2"
local fed_cattle_tonnes_ha_m = ""
local d_livestock_misc_dc_eu_m = ""
local d_milk_and_milk_subs_no_m = ""
local sum_i_conc_fed_sheep_m = ""
local d_conc_fed_sheep_eu_m = "sum_i_conc_fed_sheep"
local d_sheep_pasture_eu_m = "svy_grazing_2"
local d_roots_direct_costs_eu_m = "wint_forg_fed_unit_cost"
local fed_sheep_tonnes_ha_m = ""
local d_sheep_misc_dc_eu_m = ""
local sum_i_conc_fed_pigs_m = ""
local d_pigs_total_dc_eu_m = "sum_i_conc_fed_pigs"
local sum_i_conc_fed_poultry_m = ""
local d_poultry_total_dc_eu_m = "sum_i_conc_fed_poultry"
local sum_i_conc_fed_horses_m = ""
local d_horse_pasture_eu_m = "svy_grazing_2"
local fed_horses_tonnes_ha_m = ""
local horses_misc_dc_eu_m = ""
local d_deer_pasture_eu_m = "svy_grazing_2"
local fed_deer_tonnes_ha_m = ""
local fed_goats_tonnes_ha_m = ""
local deer_goats_misc_dc_eu_m = ""
local d_inter_enterpise_trans_eu_m = "svy_dairy_produce_2"
local svy_crops_fodder_go_m = ""
local svy_hay_silage_fodder_go_m = ""
local svy_grazing_fodder_go_m = ""
local curr_misc_cash_crops_go_m = "svy_subsidies_grants_1"
local svy_misc_cash_crops_go_m = ""


* Merge Directory
local sum_i_conc_fed_dairy_md = ""
local d_conc_fed_dairy_eu_md = ""
local d_dairy_pasture_eu_md = "OutData"
local fed_dairy_tonnes_ha_md = ""
local d_dairy_prod_misc_dc_eu_md = "OutData"
local sum_i_conc_fed_cattle_md = ""
local d_conc_fed_cattle_eu_md = ""
local d_total_pasture_eu_md = "OutData"
local fed_cattle_tonnes_ha_md = ""
local d_livestock_misc_dc_eu_md = ""
local d_milk_and_milk_subs_no_md = ""
local sum_i_conc_fed_sheep_md = ""
local d_conc_fed_sheep_eu_md = "OutData"
local d_sheep_pasture_eu_md = "OutData"
local d_roots_direct_costs_eu_md = "OutData"
local fed_sheep_tonnes_ha_md = ""
local d_sheep_misc_dc_eu_md = ""
local sum_i_conc_fed_pigs_md = ""
local d_pigs_total_dc_eu_md = "OutData"
local sum_i_conc_fed_poultry_md = ""
local d_poultry_total_dc_eu_md = "OutData"
local sum_i_conc_fed_horses_md = ""
local d_horse_pasture_eu_md = "OutData"
local fed_horses_tonnes_ha_md = ""
local horses_misc_dc_eu_md = ""
local d_deer_pasture_eu_md = "OutData"
local fed_deer_tonnes_ha_md = ""
local fed_goats_tonnes_ha_md = ""
local deer_goats_misc_dc_eu_md = ""
local d_inter_enterpise_trans_eu_md = "OutData"
local svy_crops_fodder_go_md = ""
local svy_hay_silage_fodder_go_md = ""
local svy_grazing_fodder_go_md = ""
local curr_misc_cash_crops_go_md = "OutData"
local svy_misc_cash_crops_go_md = ""

* Sort List relevant Output File
local sum_i_conc_fed_dairy_s = "FARM_CODE YE_AR"
local d_conc_fed_dairy_eu_s = "FARM_CODE YE_AR"
local d_dairy_pasture_eu_s = "FARM_CODE YE_AR"
local fed_dairy_tonnes_ha_s = "FARM_CODE YE_AR"
local d_dairy_prod_misc_dc_eu_s = "FARM_CODE YE_AR"
local sum_i_conc_fed_cattle_s = "FARM_CODE YE_AR"
local d_conc_fed_cattle_eu_s = "FARM_CODE YE_AR"
local d_total_pasture_eu_s = "FARM_CODE YE_AR"
local fed_cattle_tonnes_ha_s = "FARM_CODE YE_AR"
local d_livestock_misc_dc_eu_s = "FARM_CODE YE_AR"
local d_milk_and_milk_subs_no_s = "FARM_CODE YE_AR"
local sum_i_conc_fed_sheep_s = "FARM_CODE YE_AR"
local d_conc_fed_sheep_eu_s = "FARM_CODE YE_AR"
local d_sheep_pasture_eu_s = "FARM_CODE YE_AR"
local d_roots_direct_costs_eu_s = "FARM_CODE YE_AR"
local fed_sheep_tonnes_ha_s = "FARM_CODE YE_AR"
local d_sheep_misc_dc_eu_s = "FARM_CODE YE_AR"
local sum_i_conc_fed_pigs_s = "FARM_CODE YE_AR"
local d_pigs_total_dc_eu_s = "FARM_CODE YE_AR"
local sum_i_conc_fed_poultry_s = "FARM_CODE YE_AR"
local d_poultry_total_dc_eu_s = "FARM_CODE YE_AR"
local sum_i_conc_fed_horses_s = "FARM_CODE YE_AR"
local d_horse_pasture_eu_s = "FARM_CODE YE_AR"
local fed_horses_tonnes_ha_s = "FARM_CODE YE_AR"
local horses_misc_dc_eu_s = "FARM_CODE YE_AR"
local d_deer_pasture_eu_s = "FARM_CODE YE_AR"
local fed_deer_tonnes_ha_s = "FARM_CODE YE_AR"
local fed_goats_tonnes_ha_s = "FARM_CODE YE_AR"
local deer_goats_misc_dc_eu_s = "FARM_CODE YE_AR"
local d_inter_enterpise_trans_eu_s = "FARM_CODE YE_AR"
local svy_crops_fodder_go_s = "FARM_CODE YE_AR"
local svy_hay_silage_fodder_go_s = "FARM_CODE YE_AR"
local svy_grazing_fodder_go_s = "FARM_CODE YE_AR"
local curr_misc_cash_crops_go_s = "FARM_CODE YE_AR"
local svy_misc_cash_crops_go_s = "FARM_CODE YE_AR"

***************************************************************
* Dairy Total Direct Costs
***************************************************************

foreach var in `vlist0' {

	*Directory
	di "1"

	local dir = "`var'_ind"
	di "`dir'"
		
	* Open Input file
	use "```dir'''\\``var'_in'", clear
	mvencode *, mv(0) override

	if "``var'_md'" != "" {
		local mdir = "`var'_md"
		di "`mdir'"
		di "``var'_m'"
		sort ``var'_s'
		merge ``var'_s' using "```mdir'''\\``var'_m'"
		drop _merge
	}

	* Run Preparation File
	do `dodir'\Cr_`var'.do

	* Sort variables
	sort ``var'_s'

	* Save Output File
	save "`OutData'\\`var'", replace
}

** D_CONCENTRATES_FED_DAIRY_EU, D_DAIRY_PASTURE_EU, D_DAIRY_WINTER_FORAGE_EU AND D_DAIRY_PRODUCE_MISC_DIRECT_COST_EU TO GET D_DAIRY_TOTAL_DIRECT_COSTS_EU


use "`OutData'\svy_hay_silage_1.dta", clear
keep FARM_CODE YE_AR i_silage_fed_unit_cost i_hay_fed_unit_cost
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\bulkfeed_fed_livestock_eu_3.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\wint_forg_fed_unit_cost.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\fed_dairy_tonnes_ha.dta
drop _merge
mvencode *, mv(0) override
gen d_dairy_winter_forage_eu = 0
replace d_dairy_winter_forage_eu = s_bulkfeed_allocdairy_eu + (i_silage_fed_unit_cost * sil_fed_dairy_tns_ha_1) + (i_hay_fed_unit_cost * hay_fed_dairy_tns_ha_1) + (i_arable_silage_fed_unit_cost * asil_fed_dairy_tns_ha_1) + (i_fodder_beet_fed_unit_cost * fdrbt_fed_dairy_tns_ha_1) + (i_sugar_beet_fed_unit_cost * sgrbt_fed_dairy_tns_ha_1) + (i_maize_silage_fed_unit_cost * mz_sil_fed_dairy_tns_ha_1) + (i_oat_in_sheaf_fed_unit_cost * ots_shf_fed_dairy_tns_ha_1) + (i_mangolds_fed_unit_cost * mgolds_fed_dairy_tns_ha_1) + (i_rape_seed_fed_unit_cost * rseed_fed_dairy_tns_ha_1) + (i_straw_fed_unit_cost * stw_fed_dairy_tns_ha_1) + (i_sugar_fed_unit_cost * sug_fed_dairy_tns_ha_1) + (i_kale_fed_unit_cost * kale_fed_dairy_tns_ha_1) + ptn_beans_peas_fed_dairy_2 + potato_fed_dairy_2
sort FARM_CODE YE_AR
save "`OutData'\d_dairy_winter_forage_eu.dta", replace

*** D_DAIRY_TOTAL_DIRECT_COSTS_EU
*--------------------------------

use "`OutData'\d_conc_fed_dairy_eu.dta", clear
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\d_dairy_pasture_eu.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\d_dairy_winter_forage_eu.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\d_dairy_prod_misc_dc_eu.dta
drop _merge
sort FARM_CODE YE_AR
mvencode *, mv(0) override
gen d_dairy_total_direct_costs_eu = 0
replace d_dairy_total_direct_costs_eu = d_concentrates_fed_dairy_eu + d_dairy_pasture_eu + d_dairy_winter_forage_eu + d_dairy_prod_misc_dcost_eu 
sort FARM_CODE YE_AR
save "`OutData'\d_dairy_total_direct_costs.dta", replace




***************************************************************
* Cattle Total Direct Costs
***************************************************************

foreach var in `vlist1' {

	*Directory
	di "1"

	local dir = "`var'_ind"
	di "`dir'"
		
	* Open Input file
	use "```dir'''\\``var'_in'", clear
	mvencode *, mv(0) override

	if "``var'_md'" != "" {
		local mdir = "`var'_md"
		di "`mdir'"
		sort ``var'_s'
		merge ``var'_s' using "```mdir'''\\``var'_m'"
		drop _merge
	}

	* Run Preparation File
	do `dodir'\Cr_`var'.do

	* Sort variables
	sort ``var'_s'

	* Save Output File
	save "`OutData'\\`var'", replace
}

** Winder Forage
use "`OutData'\svy_hay_silage_1.dta", clear
keep FARM_CODE YE_AR i_silage_fed_unit_cost i_hay_fed_unit_cost
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\bulkfeed_fed_livestock_eu_3.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\wint_forg_fed_unit_cost.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\fed_cattle_tonnes_ha.dta
drop _merge
mvencode *, mv(0) override
gen d_cattle_winter_forage_eu = 0
replace d_cattle_winter_forage_eu = s_bulkfeed_alloccattle_eu + (i_silage_fed_unit_cost * sil_fed_cattle_tns_ha_1) + (i_hay_fed_unit_cost * hay_fed_cattle_tns_ha_1) + (i_arable_silage_fed_unit_cost * asil_fed_cattle_tns_ha_1) + (i_fodder_beet_fed_unit_cost * fdrbt_fed_cattle_tns_ha_1) + (i_sugar_beet_fed_unit_cost * sgrbt_fed_cattle_tns_ha_1) + (i_maize_silage_fed_unit_cost * mz_sil_fed_cattle_tns_ha_1) + (i_oat_in_sheaf_fed_unit_cost * ots_shf_fed_cattle_tns_ha_1) + (i_mangolds_fed_unit_cost * mgolds_fed_cattle_tns_ha_1) + (i_rape_seed_fed_unit_cost * rseed_fed_cattle_tns_ha_1) + (i_straw_fed_unit_cost * stw_fed_cattle_tns_ha_1) + (i_sugar_fed_unit_cost * sug_fed_cattle_tns_ha_1) + (i_kale_fed_unit_cost * kale_fed_cattle_tns_ha_1) + ptn_beans_peas_fed_cattle_2 + potato_fed_cattle_2
***FOR 2011 ON DUE TO CHANGE IN FORMULA IN 2011***
qui replace d_cattle_winter_forage_eu = s_bulkfeed_alloccattle_eu + (i_silage_fed_unit_cost * sil_fed_cattle_tns_ha_1) + (i_hay_fed_unit_cost * hay_fed_cattle_tns_ha_1) + (i_arable_silage_fed_unit_cost * asil_fed_cattle_tns_ha_1) + (i_fodder_beet_fed_unit_cost * fdrbt_fed_cattle_tns_ha_1) + (i_sugar_beet_fed_unit_cost * sgrbt_fed_cattle_tns_ha_1) + (i_maize_silage_fed_unit_cost * mz_sil_fed_cattle_tns_ha_1) + (i_oat_in_sheaf_fed_unit_cost * ots_shf_fed_cattle_tns_ha_1) + (i_mangolds_fed_unit_cost * mgolds_fed_cattle_tns_ha_1) + (i_rape_seed_fed_unit_cost * rseed_fed_cattle_tns_ha_1) + (i_straw_fed_unit_cost * stw_fed_cattle_tns_ha_1) + (i_sugar_fed_unit_cost * sug_fed_cattle_tns_ha_1) + (i_kale_fed_unit_cost * kale_fed_cattle_tns_ha_1) + ptn_beans_peas_fed_cattle_2 + potato_fed_cattle_op_2011_2 + potato_fed_cattle_cy_2011_2 if YE_AR>2010
sort FARM_CODE YE_AR
save "`OutData'\d_cattle_winter_forage_eu.dta", replace
   
*** D_CATTLE_TOTAL_DIRECT_COSTS_EU
*--------------------------------

use "`OutData'\d_conc_fed_cattle_eu.dta", clear
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\d_total_pasture_eu.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\d_cattle_winter_forage_eu.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\d_livestock_misc_dc_eu.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\d_milk_and_milk_subs_no.dta
drop _merge
sort FARM_CODE YE_AR
mvencode *, mv(0) override
gen d_cattle_total_direct_costs_eu = 0
replace d_cattle_total_direct_costs_eu = d_concentrates_fed_cattle_eu + d_total_pasture_eu + d_cattle_winter_forage_eu + d_livestock_misc_direct_costs_eu + d_milk_and_milk_substitutes_no 
sort FARM_CODE YE_AR
save "`OutData'\d_cattle_total_direct_costs.dta", replace



***************************************************************
* Sheep Total Direct Costs
***************************************************************

foreach var in `vlist2' {

	*Directory
	di "1"

	local dir = "`var'_ind"
	di "`dir'"
		
	* Open Input file
	use "```dir'''\\``var'_in'", clear
	mvencode *, mv(0) override

	if "``var'_md'" != "" {
		local mdir = "`var'_md"
		di "`mdir'"
		sort ``var'_s'
		merge ``var'_s' using "```mdir'''\\``var'_m'"
		drop _merge
	}

	* Run Preparation File
	do `dodir'\Cr_`var'.do

	* Sort variables
	sort ``var'_s'

	* Save Output File
	save "`OutData'\\`var'", replace
}


*** Winder Forage
use "`OutData'\svy_hay_silage_1.dta", clear
keep FARM_CODE YE_AR i_silage_fed_unit_cost i_hay_fed_unit_cost
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\bulkfeed_fed_livestock_eu_3.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\wint_forg_fed_unit_cost.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\fed_sheep_tonnes_ha.dta
drop _merge
mvencode *, mv(0) override
gen d_sheep_winter_forage_eu = 0
replace d_sheep_winter_forage_eu = s_bulkfeed_allocsheep_eu + (i_silage_fed_unit_cost * sil_fed_sheep_tns_ha_1) + (i_hay_fed_unit_cost * hay_fed_sheep_tns_ha_1) + (i_arable_silage_fed_unit_cost * asil_fed_sheep_tns_ha_1) + (i_maize_silage_fed_unit_cost * mz_sil_fed_sheep_tns_ha_1) + (i_oat_in_sheaf_fed_unit_cost * ots_shf_fed_sheep_tns_ha_1) +  (i_rape_seed_fed_unit_cost * rseed_fed_sheep_tns_ha_1) + (i_straw_fed_unit_cost * stw_fed_sheep_tns_ha_1) + (i_sugar_fed_unit_cost * sug_fed_sheep_tns_ha_1) + (i_kale_fed_unit_cost * kale_fed_sheep_tns_ha_1) + ptn_beans_peas_fed_sheep_2 + potato_fed_sheep_2
sort FARM_CODE YE_AR
save "`OutData'\d_sheep_winter_forage_eu.dta", replace


*** D_TOTAL_DIRECT_COSTS_EU (NFS SHOULD RENAME IT TO D_SHEEP_TOTAL_DIRECT_COSTS_EU WHICH WE WILL DO HERE)
*--------------------------------------------------------------------------------------------------------

use "`OutData'\d_conc_fed_sheep_eu.dta", clear
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\d_sheep_pasture_eu.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\d_sheep_winter_forage_eu.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\d_roots_direct_costs_eu.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\d_sheep_misc_dc_eu.dta
drop _merge
sort FARM_CODE YE_AR
mvencode *, mv(0) override
gen d_sheep_total_direct_costs_eu = 0
replace d_sheep_total_direct_costs_eu = d_concentrates_fed_sheep_eu + d_sheep_pasture_eu + d_sheep_winter_forage_eu + d_roots_direct_costs_eu + d_sheep_misc_direct_costs_eu 
sort FARM_CODE YE_AR
save "`OutData'\d_sheep_total_direct_costs.dta", replace


***************************************************************
* Pigs, Poultry & Horses Total Direct Costs
***************************************************************

foreach var in `vlist3' {

	*Directory
	di "1"

	local dir = "`var'_ind"
	di "`dir'"
		
	* Open Input file
	use "```dir'''\\``var'_in'", clear
	mvencode *, mv(0) override

	if "``var'_md'" != "" {
		local mdir = "`var'_md"
		di "`mdir'"
		sort ``var'_s'
		merge ``var'_s' using "```mdir'''\\``var'_m'"
		drop _merge
	}

	* Run Preparation File
	do `dodir'\Cr_`var'.do

	* Sort variables
	sort ``var'_s'

	* Save Output File
	save "`OutData'\\`var'", replace
}




* Horses Total Direct Costs

use "`OutData'\svy_hay_silage_1.dta", clear
keep FARM_CODE YE_AR i_silage_fed_unit_cost i_hay_fed_unit_cost
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\bulkfeed_fed_livestock_eu_3.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\wint_forg_fed_unit_cost.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\fed_horses_tonnes_ha.dta
drop _merge
gen d_horse_winter_forage_eu = 0
replace d_horse_winter_forage_eu = s_bulkfeed_allochorses_eu + (i_silage_fed_unit_cost * sil_fed_horses_tns_ha_1) + (i_hay_fed_unit_cost * hay_fed_horses_tns_ha_1) + (i_arable_silage_fed_unit_cost * asil_fed_horses_tns_ha_1) + (i_fodder_beet_fed_unit_cost * fdrbt_fed_horses_tns_ha_1) + (i_sugar_beet_fed_unit_cost * sgrbt_fed_horses_tns_ha_1) + (i_maize_silage_fed_unit_cost * mz_sil_fed_horses_tns_ha_1) + (i_oat_in_sheaf_fed_unit_cost * ots_shf_fed_horses_tns_ha_1) + (i_mangolds_fed_unit_cost * mgolds_fed_horses_tns_ha_1) + (i_rape_seed_fed_unit_cost * rseed_fed_horses_tns_ha_1) + (i_straw_fed_unit_cost * stw_fed_horses_tns_ha_1) + (i_sugar_fed_unit_cost * sug_fed_horses_tns_ha_1) + (i_kale_fed_unit_cost * kale_fed_horses_tns_ha_1)
sort FARM_CODE YE_AR
save "`OutData'\d_horse_winter_forage_eu.dta", replace


*** D_HORSES_DIRECT_COSTS_EU
*--------------------------------

use "`OutData'\sum_i_conc_fed_horses.dta", clear
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\d_horse_pasture_eu.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\d_horse_winter_forage_eu.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\horses_misc_dc_eu.dta
drop _merge
sort FARM_CODE YE_AR
mvencode *, mv(0) override
gen d_horses_direct_costs_eu = 0
replace d_horses_direct_costs_eu = CONC_ALLOC_HORSES_50KGBAGS_EU + VET_MED_ALLOC_HORSES_EU + AI_SER_FEES_ALLOC_HORSES_EU + TRANSPORT_ALLOC_HORSES_EU + MISCELLANEOUS_ALLOC_HORSES_EU + s_i_concentrates_fed_horses + d_horse_pasture_eu + d_horse_winter_forage_eu 
sort FARM_CODE YE_AR
save "`OutData'\d_horses_direct_costs.dta", replace


* Other Total Direct Costs

** D_GOAT_WINTER_FORAGE_EU
*---------------------------

use "`OutData'\svy_hay_silage_1.dta", clear
keep FARM_CODE YE_AR i_silage_fed_unit_cost i_hay_fed_unit_cost
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\bulkfeed_fed_livestock_eu_3.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\wint_forg_fed_unit_cost.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\fed_deer_tonnes_ha.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\fed_goats_tonnes_ha.dta
drop _merge
gen d_deer_winter_forage_eu = 0
replace d_deer_winter_forage_eu = s_bulkfeed_allocdeer_eu + (i_silage_fed_unit_cost * sil_fed_deer_tns_ha_1) + (i_hay_fed_unit_cost * hay_fed_deer_tns_ha_1) + (i_arable_silage_fed_unit_cost * asil_fed_deer_tns_ha_1) + (i_fodder_beet_fed_unit_cost * fdrbt_fed_deer_tns_ha_1) + (i_sugar_beet_fed_unit_cost * sgrbt_fed_deer_tns_ha_1) + (i_maize_silage_fed_unit_cost * mz_sil_fed_deer_tns_ha_1) + (i_oat_in_sheaf_fed_unit_cost * ots_shf_fed_deer_tns_ha_1) + (i_mangolds_fed_unit_cost * mgolds_fed_deer_tns_ha_1) + (i_rape_seed_fed_unit_cost * rseed_fed_deer_tns_ha_1) + (i_straw_fed_unit_cost * stw_fed_deer_tns_ha_1) + (i_sugar_fed_unit_cost * sug_fed_deer_tns_ha_1) + (i_kale_fed_unit_cost * kale_fed_deer_tns_ha_1)
gen d_goats_winter_forage_eu = 0
replace d_goats_winter_forage_eu = s_bulkfeed_allocgoats_eu + (i_silage_fed_unit_cost * sil_fed_goats_tns_ha_1) + (i_hay_fed_unit_cost * hay_fed_goats_tns_ha_1) + (i_arable_silage_fed_unit_cost * asil_fed_goats_tns_ha_1) + (i_fodder_beet_fed_unit_cost * fdrbt_fed_goats_tns_ha_1) + (i_sugar_beet_fed_unit_cost * sgrbt_fed_goats_tns_ha_1) + (i_maize_silage_fed_unit_cost * mz_sil_fed_goats_tns_ha_1) + (i_oat_in_sheaf_fed_unit_cost * ots_shf_fed_goats_tns_ha_1) + (i_mangolds_fed_unit_cost * mgolds_fed_goats_tns_ha_1) + (i_rape_seed_fed_unit_cost * rseed_fed_goats_tns_ha_1) + (i_straw_fed_unit_cost * stw_fed_goats_tns_ha_1) + (i_sugar_fed_unit_cost * sug_fed_goats_tns_ha_1) + (i_kale_fed_unit_cost * kale_fed_goats_tns_ha_1)
sort FARM_CODE YE_AR
save "`OutData'\d_deer_goats_winter_forage_eu.dta", replace

*** D_OTHER_DIRECT_COSTS_EU
*--------------------------------		

use "`OutData'\deer_goats_misc_dc_eu.dta", clear
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\d_deer_pasture_eu.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\d_deer_goats_winter_forage_eu.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\deer_goats_misc_dc_eu.dta
drop _merge
sort FARM_CODE YE_AR
mvencode *, mv(0) override
gen d_other_direct_costs_eu = 0
mvencode d_deer_pasture_eu d_deer_winter_forage_eu d_goats_winter_forage_eu, mv(0) override
*replace d_other_direct_costs_eu = d_deer_pasture_eu + d_deer_winter_forage_eu + d_goats_winter_forage_eu
replace d_other_direct_costs_eu = CONC_ALLOC_DEER_50KGBAGS_EU + d_deer_pasture_eu + CONC_ALLOC_GOATS_50KGBAGS_EU + CONC_ALLOC_OTHER_50KGBAGS_EU + VET_MED_ETC_ALLOC_DEER_EU + VET_MED_ETC_ALLOC_GOATS_EU + VET_MED_ETC_ALLOC_OTHER_EU + MISC_INCL_TRANS_ALLOC_DEER_EU + MISC_INCL_TRANS_ALLOC_GOATS_EU + MISC_INCL_TRANS_ALLOC_OTHER_EU + CASUAL_LABOUR_ALLOC_DEER_EU + CASUAL_LABOUR_ALLOC_GOATS_EU + CASUAL_LABOUR_ALLOC_OTHER_EU + d_deer_winter_forage_eu + d_goats_winter_forage_eu
sort FARM_CODE YE_AR
save "`OutData'\d_other_direct_costs.dta", replace



* Total Livestock Direct Costs

** D_TOTAL_LIVESTOCK_DIRECT_COSTS
*--------------------------------


use "`OutData'\d_dairy_total_direct_costs.dta", clear
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\d_cattle_total_direct_costs.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\d_sheep_total_direct_costs.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\d_pigs_total_dc_eu.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\d_poultry_total_dc_eu.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\d_horses_direct_costs.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\d_other_direct_costs.dta
drop _merge
keep FARM_CODE YE_AR d_dairy_total_direct_costs_eu d_cattle_total_direct_costs_eu d_sheep_total_direct_costs_eu d_pigs_total_direct_costs_eu d_poultry_total_direct_costs_eu d_horses_direct_costs_eu d_other_direct_costs_eu
mvencode *, mv(0) override
gen d_total_livestock_direct_costs = 0
replace d_total_livestock_direct_costs = d_dairy_total_direct_costs_eu + d_cattle_total_direct_costs_eu + d_sheep_total_direct_costs_eu + d_pigs_total_direct_costs_eu + d_poultry_total_direct_costs_eu + d_horses_direct_costs_eu + d_other_direct_costs_eu 
sort FARM_CODE YE_AR
save "`OutData'\d_total_livestock_direct_costs.dta", replace



***************************************************************
* Inter Enterpise Transfers
***************************************************************

foreach var in `vlist4' {

	*Directory
	di "1"

	local dir = "`var'_ind"
	di "`dir'"
		
	* Open Input file
	use "```dir'''\\``var'_in'", clear
	mvencode *, mv(0) override

	if "``var'_md'" != "" {
		local mdir = "`var'_md"
		di "`mdir'"
		sort ``var'_s'
		merge ``var'_s' using "```mdir'''\\``var'_m'"
		drop _merge
	}

	* Run Preparation File
	do `dodir'\Cr_`var'.do

	* Sort variables
	sort ``var'_s'

	* Save Output File
	save "`OutData'\\`var'", replace
}


***************************************************************
* Farm Direct Costs
***************************************************************

** D_FARM_DIRECT_COSTS
*---------------------

use "`OutData'\d_total_livestock_direct_costs.dta", clear
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\total_crops_direct_costs.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\d_inter_enterpise_trans_eu.dta
drop _merge
mvencode *, mv(0) override
gen d_farm_direct_costs = 0
replace d_farm_direct_costs = (d_total_livestock_direct_costs + d_total_crops_direct_costs_eu) - d_inter_enterpise_transfers_eu
sort FARM_CODE YE_AR
save "`OutDataO'\farm_direct_costs.dta", replace



***************************************************************
***************************************************************
* Crops Gross Output
***************************************************************
***************************************************************

***************************************************************
* Fodder Crops Sold Gross Output
* Inv Misc Cash Crop Gross Output
* Current Misc Cash Crop Gross Output
***************************************************************

foreach var in `vlist5' {

	*Directory
	di "1"

	local dir = "`var'_ind"
	di "`dir'"
		
	* Open Input file
	use "```dir'''\\``var'_in'", clear
	mvencode *, mv(0) override

	if "``var'_md'" != "" {
		local mdir = "`var'_md"
		di "`mdir'"
		sort ``var'_s'
		merge ``var'_s' using "```mdir'''\\``var'_m'"
		drop _merge
	}

	* Run Preparation File
	do `dodir'\Cr_`var'.do

	* Sort variables
	sort ``var'_s'

	* Save Output File
	save "`OutData'\\`var'", replace
}

use "`OrigData'\svy_misc_receipts_expenses.dta", clear
keep FARM_CODE YE_AR USED_IN_HOUSE_TURF_EU
replace USED_IN_HOUSE_TURF_EU = 0 if USED_IN_HOUSE_TURF_EU == .
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\svy_crops_fodder_go.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\svy_hay_silage_fodder_go.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\svy_grazing_fodder_go.dta
drop _merge
mvencode *, mv(0) override
gen go_fodder_crops_sold_eu = s_fodd_op_sls_val + s_fodd_cy_sls_val + d_hay_sales_op_eu + d_hay_sales_cu_eu + d_sil_sales_op_eu + d_sil_sales_cu_eu + BOARDING_IN_HORSES_EU + BOARDING_IN_SHEEP2_EU + BOARDING_IN_SHEEP1_EU + BOARDING_IN_CATTLE1_EU + BOARDING_IN_CATTLE2_EU + BOARDING_IN_DAIRY_EU + USED_IN_HOUSE_TURF_EU
replace go_fodder_crops_sold_eu = 0 if go_fodder_crops_sold_eu == .
sort FARM_CODE YE_AR
save "`OutData'\FodderCrops_GO.dta", replace






***************************************************************
* Total Crops Gross Output
***************************************************************
**D_TOTAL_CROPS_GROSS_OUTPUT_EU

use "`OutData'\FodderCrops_GO.dta", clear
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using "`OutData'\svy_misc_cash_crops_go.dta"
drop _merge
sort  FARM_CODE YE_AR 
merge FARM_CODE YE_AR using "`OutData'\curr_misc_cash_crops_go.dta"
drop _merge
sort  FARM_CODE YE_AR
mvencode *, mv(0) override
gen d_total_crops_gross_output_eu = 0
replace d_total_crops_gross_output_eu = go_fodder_crops_sold_eu + d_go_inv_misc_csh_crop + d_output_from_cur_misc_cash_crop
sort  FARM_CODE YE_AR
save "`OutData'\total_crops_gross_output.dta", replace


***************************************************************
***************************************************************
*Livestock Gross Output
***************************************************************
***************************************************************

***************************************************************
* Dairy Total Gross Output
***************************************************************

** D_DAIRY_GROSS_OUTPUT_EU
*-------------------------

use "`OutData'\svy_subsidies_grants_1.dta", clear
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\svy_cattle_2.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\svy_dairy_produce_2.dta
drop _merge
keep FARM_CODE YE_AR SLAUGHTER_PREMIUM_DAIRY_PAYMENT_  DAIRY_COWS_SH_BULLS_SUBSIDIES_EU d_total_milk_production_eu d_dy_val_dropd_clvs_sld_trans_eu d_dairy_herd_replace_cost_eu DAIRY_EFF_PROG_TOTAL_PAYMENT_EU DAIRY_COMP_FUND_TOTAL_PAYMENT_EU
sort FARM_CODE YE_AR
mvencode *, mv(0) override
gen d_dairy_gross_output_eu = 0
replace d_dairy_gross_output_eu = d_total_milk_production_eu + d_dy_val_dropd_clvs_sld_trans_eu + d_dairy_herd_replace_cost_eu + DAIRY_COWS_SH_BULLS_SUBSIDIES_EU + SLAUGHTER_PREMIUM_DAIRY_PAYMENT_ + DAIRY_EFF_PROG_TOTAL_PAYMENT_EU + DAIRY_COMP_FUND_TOTAL_PAYMENT_EU
sort FARM_CODE YE_AR
save "`OutData'\d_dairy_gross_output.dta", replace


***************************************************************
* Cattle Total Gross Output
***************************************************************

** D_GROSS_OUTPUT_CATTLE_EU
*--------------------------

use "`OutData'\svy_subsidies_grants_1.dta", clear
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\svy_cattle_2.dta
drop _merge
keep FARM_CODE YE_AR d_sales_incl_hse_consumption_eu CATTLE_TOTAL_PURCHASES_EU DY_COWS_SH_BULS_TRNSFR_IN_EU d_transfer_from_dairy_herd_eu d_value_of_change_of_numbers_eur SUCKLER_WELFARE_SCHEME_TOTAL_EU
sort FARM_CODE YE_AR
mvencode *, mv(0) override
gen d_gross_output_cattle_eu = 0
replace d_gross_output_cattle_eu = d_sales_incl_hse_consumption_eu - CATTLE_TOTAL_PURCHASES_EU + DY_COWS_SH_BULS_TRNSFR_IN_EU - d_transfer_from_dairy_herd_eu + d_value_of_change_of_numbers_eur + SUCKLER_WELFARE_SCHEME_TOTAL_EU
sort FARM_CODE YE_AR
save "`OutData'\d_gross_output_cattle.dta", replace


***************************************************************
* Sheep Total Gross Output
***************************************************************

** D_GROSS_OUTPUT_SHEEP_AND_WOOL_EU
*----------------------------------

use "`OutData'\svy_subsidies_grants_1.dta", clear
sort FARM_CODE YE_AR
keep FARM_CODE YE_AR SHEEP_WELFARE_SCHEME_TOTAL_EU
merge FARM_CODE YE_AR using `OutData'\svy_sheep_2.dta
drop _merge
keep FARM_CODE YE_AR d_sls_shep_only_incl_hse_cons_eu d_purchases_sheep_only_eu d_value_of_change_in_numbers_eu SHEEP_WELFARE_SCHEME_TOTAL_EU SUBSIDIES_HEADAGE_EU SUBSIDIES_EWE_PREMIUM_EU WOOL_SALES_VALUE_EU WOOL_CLOS_INV_VALUE_EU WOOL_OP_INV_VALUE_EU
mvencode *, mv(0) override
gen d_gross_output_sheep_and_wool_eu = 0
replace d_gross_output_sheep_and_wool_eu = d_sls_shep_only_incl_hse_cons_eu - d_purchases_sheep_only_eu + d_value_of_change_in_numbers_eu + (SUBSIDIES_HEADAGE_EU + SUBSIDIES_EWE_PREMIUM_EU) + WOOL_SALES_VALUE_EU + (WOOL_CLOS_INV_VALUE_EU - WOOL_OP_INV_VALUE_EU) if YE_AR < 2010
replace d_gross_output_sheep_and_wool_eu = d_sls_shep_only_incl_hse_cons_eu - d_purchases_sheep_only_eu + d_value_of_change_in_numbers_eu + (SUBSIDIES_HEADAGE_EU + SUBSIDIES_EWE_PREMIUM_EU + SHEEP_WELFARE_SCHEME_TOTAL_EU) + WOOL_SALES_VALUE_EU + (WOOL_CLOS_INV_VALUE_EU - WOOL_OP_INV_VALUE_EU) if YE_AR > 2009
*** NOTE - THE REASON FOR THE ABOVE IS THAT PREVIOUS TO 2010 THE "SHEEP_WELFARE_SCHEME_TOTAL_EU" WAS INCLUCED IN THE "D_FARM_GROSS_OUTPUT" VARIABLE, SO NEED TO DO THE OPPOSITE OF THE ABOVE FOR THIS VARIABLE WHEN I GET TO IT.
sort FARM_CODE YE_AR
save "`OutData'\d_gross_output_sheep_and_wool_eu.dta", replace


***************************************************************
* Pigs Total Gross Output
***************************************************************

** D_GROSS_OUTPUT_PIGS_EU
*------------------------

use "`OutData'\svy_pigs_1.dta", clear
gen d_gross_output_pigs_eu = 0
replace d_gross_output_pigs_eu = d_pig_sales_eu - d_pig_purchases + D_VALUE_OF_CHANGE_IN_NUM_PIGS_EU + USED_IN_HOUSE_EU
sort FARM_CODE YE_AR
save "`OutData'\d_gross_output_pigs_eu.dta", replace


***************************************************************
* Poultry Total Gross Output
***************************************************************

** D_GROSS_OUTPUT_POULTRY_EU
*------------------------

use "`OutData'\svy_poultry_1.dta", clear
keep FARM_CODE YE_AR d_sales_livestock_prod_eggs_eu ORDINARY_FOWL_SALES_EU ORDINARY_FOWL_PURCHASES_EU OTHER_FOWL_PURCHASES_EU EGGS_DOZ_USED_IN_HOUSE_EU EGGS_DOZ_OTHER_ALLOWANCES_EU SUBSIDIES_VALUE_EU d_closing_inventory_poultry_eu d_opening_inventory_poultry_eu
mvencode *, mv(0) override
gen d_poultry_gross_output_eu = 0
replace d_poultry_gross_output_eu = d_sales_livestock_prod_eggs_eu + ORDINARY_FOWL_SALES_EU - ORDINARY_FOWL_PURCHASES_EU - OTHER_FOWL_PURCHASES_EU + EGGS_DOZ_USED_IN_HOUSE_EU + EGGS_DOZ_OTHER_ALLOWANCES_EU + SUBSIDIES_VALUE_EU + d_closing_inventory_poultry_eu - d_opening_inventory_poultry_eu
sort FARM_CODE YE_AR
save "`OutData'\d_poultry_gross_output_eu.dta", replace




***************************************************************
* Horses Total Gross Output
***************************************************************

*D_GROSS_OUTPUT_HORSES_EU
*------------------------

use "`OutData'\svy_horses_other_1.dta", clear
keep FARM_CODE YE_AR d_horse_sales_eu HORSES_EQUINES_PURCHASES_EU d_closing_inventory_horses_eu d_opening_inventory_horses_eu
gen d_gross_output_horses_eu = 0
replace d_gross_output_horses_eu = d_horse_sales_eu - HORSES_EQUINES_PURCHASES_EU + d_closing_inventory_horses_eu - d_opening_inventory_horses_eu
sort FARM_CODE YE_AR
save "`OutData'\d_gross_output_horses.dta", replace



***************************************************************
* Other Total Gross Output
***************************************************************

** D_OTHER_GROSS_OUTPUT_EU
*-------------------------

use "`OutData'\svy_deer_1.dta", clear
keep FARM_CODE YE_AR BREEDING_STAGS_CLOS_INV_NO BREEDING_STAGS_OP_INV_NO BREEDING_STAGS_OP_INV_PERUNIT_EU BREEDING_HINDS_CLOS_INV_NO BREEDING_HINDS_OP_INV_NO BREEDING_HINDS_CLOS_INV_PERUNIT_ OTHER_DEER_LT1YR_CLOS_INV_NO OTHER_DEER_LT1YR_OP_INV_NO OTHER_DEER_LT1YR_CLOS_INV_PERUNI OTHER_DEER_GT1YR_CLOS_INV_NO OTHER_DEER_GT1YR_OP_INV_NO OTHER_DEER_GT1YR_CLOS_INV_PERUNI d_deer_sales_eu
*D_OTHER_GROSS_OUTPUT_EU
mvencode *, mv(0) override
gen d_other_gross_output_eu = 0
replace d_other_gross_output_eu = ((BREEDING_STAGS_CLOS_INV_NO - BREEDING_STAGS_OP_INV_NO) * BREEDING_STAGS_OP_INV_PERUNIT_EU) + ((BREEDING_HINDS_CLOS_INV_NO - BREEDING_HINDS_OP_INV_NO) * BREEDING_HINDS_CLOS_INV_PERUNIT_) + ((OTHER_DEER_LT1YR_CLOS_INV_NO - OTHER_DEER_LT1YR_OP_INV_NO) * OTHER_DEER_LT1YR_CLOS_INV_PERUNI)+ ((OTHER_DEER_GT1YR_CLOS_INV_NO - OTHER_DEER_GT1YR_OP_INV_NO) *  OTHER_DEER_GT1YR_CLOS_INV_PERUNI) + d_deer_sales_eu
sort FARM_CODE YE_AR
save "`OutData'\d_other_gross_output.dta", replace


***************************************************************
* Total Livestock Gross Output
***************************************************************


** D_TOTAL_LIVESTOCK_GROSS_OUTPUT
*--------------------------------


use "`OutData'\d_dairy_gross_output.dta", clear
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\d_gross_output_cattle.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\d_gross_output_sheep_and_wool_eu.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\d_gross_output_pigs_eu.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\d_poultry_gross_output_eu.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\d_gross_output_horses.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\d_other_gross_output.dta
drop _merge
keep FARM_CODE YE_AR d_dairy_gross_output_eu d_gross_output_cattle_eu d_gross_output_sheep_and_wool_eu d_gross_output_pigs_eu d_poultry_gross_output_eu d_gross_output_horses_eu d_other_gross_output_eu
mvencode *, mv(0) override
gen d_total_livestock_gross_output = 0
replace d_total_livestock_gross_output = d_dairy_gross_output_eu + d_gross_output_cattle_eu + d_gross_output_sheep_and_wool_eu + d_gross_output_pigs_eu + d_poultry_gross_output_eu + d_gross_output_horses_eu + d_other_gross_output_eu
sort FARM_CODE YE_AR
save "`OutData'\d_total_livestock_gross_output.dta", replace
 

***************************************************************
* Farm Gross Output
***************************************************************

** D_FARM_GROSS_OUTPUT
*---------------------


use "`OutData'\d_total_livestock_gross_output.dta", clear
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\total_crops_gross_output.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OrigData'\svy_misc_receipts_expenses.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\svy_subsidies_grants_1.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OrigData'\svy_farm.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\svy_dairy_produce_1.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\d_inter_enterpise_trans_eu.dta
drop _merge
keep FARM_CODE YE_AR d_total_livestock_gross_output d_total_crops_gross_output_eu HIRED_MACHINERY_IN_CASH_EU HIRED_MACHINERY_IN_KIND_EU OTHER_RECEIPTS_IN_CASH_EU OTHER_RECEIPTS_IN_KIND_EU SALE_OF_TURF_VALUE_EU USED_IN_HOUSE_OTHER_EU MISC_GRANTS_SUBSIDIES_EU PROTEIN_PAYMENTS_TOTAL_EU SHEEP_WELFARE_SCHEME_TOTAL_EU OTHER_SUBS_PAYMENTS_TOTAL_EU LAND_LET_OUT_EU MILK_QUOTA_LET_EU SUPER_LEVY_REFUND_EU SUPER_LEVY_CHARGE_EU SINGLE_FARM_PAYMENT_NET_VALUE_EU d_inter_enterpise_transfers_eu
mvencode *, mv(0) override
sort FARM_CODE YE_AR
gen super_levy_refund_cond = 0
replace super_levy_refund_cond = SUPER_LEVY_REFUND_EU if SUPER_LEVY_REFUND_EU > SUPER_LEVY_CHARGE_EU
gen SUPER_LEVY_REFUND_COND =  0
replace SUPER_LEVY_REFUND_COND  = SUPER_LEVY_REFUND_EU if SUPER_LEVY_REFUND_EU > SUPER_LEVY_CHARGE_EU
gen d_farm_gross_output = 0
replace d_farm_gross_output = d_total_livestock_gross_output + d_total_crops_gross_output_eu + HIRED_MACHINERY_IN_CASH_EU + HIRED_MACHINERY_IN_KIND_EU + OTHER_RECEIPTS_IN_CASH_EU + OTHER_RECEIPTS_IN_KIND_EU + SALE_OF_TURF_VALUE_EU + USED_IN_HOUSE_OTHER_EU + MISC_GRANTS_SUBSIDIES_EU + PROTEIN_PAYMENTS_TOTAL_EU + SHEEP_WELFARE_SCHEME_TOTAL_EU + OTHER_SUBS_PAYMENTS_TOTAL_EU + LAND_LET_OUT_EU + MILK_QUOTA_LET_EU + super_levy_refund_cond + SINGLE_FARM_PAYMENT_NET_VALUE_EU - d_inter_enterpise_transfers_eu if YE_AR < 2010
replace d_farm_gross_output = d_total_livestock_gross_output + d_total_crops_gross_output_eu + HIRED_MACHINERY_IN_CASH_EU + HIRED_MACHINERY_IN_KIND_EU + OTHER_RECEIPTS_IN_CASH_EU + OTHER_RECEIPTS_IN_KIND_EU + SALE_OF_TURF_VALUE_EU + USED_IN_HOUSE_OTHER_EU + MISC_GRANTS_SUBSIDIES_EU + PROTEIN_PAYMENTS_TOTAL_EU + OTHER_SUBS_PAYMENTS_TOTAL_EU + LAND_LET_OUT_EU + MILK_QUOTA_LET_EU + super_levy_refund_cond + SINGLE_FARM_PAYMENT_NET_VALUE_EU - d_inter_enterpise_transfers_eu if YE_AR > 2009
*** NOTE - THE REASON FOR THE ABOVE IS THAT PREVIOUS TO 2010 THE "SHEEP_WELFARE_SCHEME_TOTAL_EU" WAS INCLUCED IN THE "D_FARM_GROSS_OUTPUT" VARIABLE, AND FROM 2010 IT IS INCLUDED IN THE "D_GROSS_OUTPUT_SHEEP_AND_WOOL_EU" VARIABLE IN THE SHEEP TABLE
sort FARM_CODE YE_AR
save "`OutDataO'\farm_gross_output.dta", replace


***************************************************************
* Farm_Gross_Margin
***************************************************************

** D_FARM_GROSS_MARGIN_EU
*------------------------

use "`OutDataO'\farm_direct_costs.dta", clear
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutDataO'\farm_gross_output.dta
drop _merge
sort FARM_CODE YE_AR
mvencode *, mv(0) override
gen d_farm_gross_margin = 0
replace d_farm_gross_margin = d_farm_gross_output - d_farm_direct_costs
sort FARM_CODE YE_AR
save "`OutDataO'\farm_gross_margin.dta", replace


***************************************************************
* FARM TOTAL OVERHEAD COSTS
***************************************************************

** D_FARM_TOTAL_OVERHEAD_COSTS_EU
*--------------------------------

use "`OutData'\car_electricity_telephone.dta", clear
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\depreciation_of_buildings.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\depreciation_of_land_imps.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\depreciation_of_machinery.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\hired_labour_casual_excl.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\interest_payments.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\machinery_op_expenses.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\misc_overhead_costs.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OrigData'\svy_farm.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\power_machinery_totals.dta
drop _merge
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OrigData'\svy_other_machinery_totals.dta
drop _merge
keep FARM_CODE YE_AR LAND_RENTED_IN_EU d_car_electricity_telephone_eu d_hired_labour_casual_excl_eu d_intrst_pay_incl_hp_interest_eu d_machine_operating_expenses_eu d_depreciation_of_machinery_eu d_depreciation_of_buildings_eu BUILDINGS_REPAIRS_UPKEEP_EU LAND_GENERAL_UPKEEP_EU d_depreciation_of_land_imps_eu d_misc_overhead_costs_eu pm_TOTAL_COST_OF_LEASE_EU TOTAL_COST_OF_LEASE_EU ANNUITIES_EU
mvencode *, mv(0) override
gen d_farm_total_overhead_costs_eu = 0
replace d_farm_total_overhead_costs_eu = LAND_RENTED_IN_EU + d_car_electricity_telephone_eu + d_hired_labour_casual_excl_eu + d_intrst_pay_incl_hp_interest_eu + d_machine_operating_expenses_eu + d_depreciation_of_machinery_eu + d_depreciation_of_buildings_eu + BUILDINGS_REPAIRS_UPKEEP_EU + LAND_GENERAL_UPKEEP_EU + d_depreciation_of_land_imps_eu + d_misc_overhead_costs_eu + pm_TOTAL_COST_OF_LEASE_EU + TOTAL_COST_OF_LEASE_EU + ANNUITIES_EU
sort FARM_CODE YE_AR
save "`OutDataO'\farm_total_overhead_costs.dta", replace


***************************************************************
* FAMILY FARM INCOME
***************************************************************

* Original Sample
use "`OrigData'\svy_farm.dta", clear
gen origsubset = 1
keep FARM_CODE YE_AR origsubset
sort FARM_CODE YE_AR
save `OutData'\origsubset, replace

** D_FARM_FAMILY_INCOME
*------------------------


use "`OutDataO'\farm_gross_margin.dta", clear
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutDataO'\farm_total_overhead_costs.dta
drop _merge
sort FARM_CODE YE_AR
mvencode *, mv(0) override
gen d_farm_family_income = 0
replace d_farm_family_income = d_farm_gross_margin - d_farm_total_overhead_costs_eu
sort FARM_CODE YE_AR
merge FARM_CODE YE_AR using `OutData'\origsubset
drop _merge
keep if origsubset == 1
sort FARM_CODE YE_AR
save "`OutDataO'\farm_family_income.dta", replace


if  sc_runanalysis == 1 {

	******************************************************
	******************************************************
	* Analysis of baseline simulation
	******************************************************
	******************************************************
	capture log close
	log using `OutData'\TestAnalysisFFI.log, replace

	******************************************************
	* Family Farm Income
	******************************************************
	
	* Simulated Data
	use "`OutDataO'\farm_family_income.dta", clear
	* Simulated Components
	tabstat  d_farm_family_income d_farm_total_overhead_costs_eu d_farm_gross_margin d_farm_gross_output d_farm_direct_costs d_inter_enterpise_transfers_eu, by(YE_AR)
	
	* Actual Data
	use "`OrigData'\svy_farm.dta", clear
	* Actual Components
	tabstat  D_FARM_FAMILY_INCOME D_FARM_TOTAL_OVERHEAD_COSTS_EU D_FARM_GROSS_MARGIN D_FARM_GROSS_OUTPUT D_FARM_DIRECT_COSTS D_INTER_ENTERPISE_TRANSFERS_EU, by(YE_AR)
	
	
	* John's Data
	use D:\data\Data_NFSPanelANalysis\OutData\CreateNewPanel\pvAdjust_model\Farm_Family_Income\farm_family_income.dta, clear
	
	
	capture log close
	log using `OutDataO'\TestAnalysisGO.log, replace

	******************************************************
	* Gross Output
	******************************************************

	* Simulated Data
	use "`OutDataO'\farm_gross_output.dta", clear
	* Simulated Components
	tabstat  d_total_livestock_gross_output d_total_crops_gross_output_eu HIRED_MACHINERY_IN_CASH_EU HIRED_MACHINERY_IN_KIND_EU OTHER_RECEIPTS_IN_CASH_EU OTHER_RECEIPTS_IN_KIND_EU SALE_OF_TURF_VALUE_EU USED_IN_HOUSE_OTHER_EU MISC_GRANTS_SUBSIDIES_EU PROTEIN_PAYMENTS_TOTAL_EU SHEEP_WELFARE_SCHEME_TOTAL_EU OTHER_SUBS_PAYMENTS_TOTAL_EU LAND_LET_OUT_EU MILK_QUOTA_LET_EU super_levy_refund_cond SINGLE_FARM_PAYMENT_NET_VALUE_EU d_inter_enterpise_transfers_eu, by(YE_AR)
	
	* Actual Data
	use "`OrigData'\svy_farm.dta", clear
	sort FARM_CODE YE_AR
	merge FARM_CODE YE_AR using `OrigData'\svy_misc_receipts_expenses.dta
	drop _merge
	sort FARM_CODE YE_AR
	merge FARM_CODE YE_AR using `OrigData'\svy_crop_derived
	drop _merge
	sort FARM_CODE YE_AR
	merge FARM_CODE YE_AR using `OrigData'\svy_subsidies_grants
	drop _merge
	sort FARM_CODE YE_AR
	merge FARM_CODE YE_AR using "`OrigData'\svy_dairy_produce.dta"
	drop _merge
	rename var144 OTHER_SUBS_PAYMENTS_TOTAL_EU
	gen SUPER_LEVY_REFUND_COND =  0
	replace SUPER_LEVY_REFUND_COND  = SUPER_LEVY_REFUND_EU if SUPER_LEVY_REFUND_EU > SUPER_LEVY_CHARGE_EU

	* Actual Components
	tabstat  D_TOTAL_LIVESTOCK_GROSS_OUTPUT D_TOTAL_CROPS_GROSS_OUTPUT_EU HIRED_MACHINERY_IN_CASH_EU HIRED_MACHINERY_IN_KIND_EU OTHER_RECEIPTS_IN_CASH_EU OTHER_RECEIPTS_IN_KIND_EU SALE_OF_TURF_VALUE_EU USED_IN_HOUSE_OTHER_EU MISC_GRANTS_SUBSIDIES_EU PROTEIN_PAYMENTS_TOTAL_EU SHEEP_WELFARE_SCHEME_TOTAL_EU OTHER_SUBS_PAYMENTS_TOTAL_EU LAND_LET_OUT_EU MILK_QUOTA_LET_EU SUPER_LEVY_REFUND_COND SINGLE_FARM_PAYMENT_NET_VALUE_EU D_INTER_ENTERPISE_TRANSFERS_EU, by(YE_AR)

	capture log close
	log using `OutDataO'\TestAnalysisDC.log, replace

	******************************************************
	* Direct Costs
	******************************************************

	* Simulated Data
	use "`OutDataO'\farm_direct_costs.dta", clear
	sort FARM_CODE YE_AR
	merge FARM_CODE YE_AR using `OutData'\origsubset
	drop _merge
	keep if origsubset == 1
	* Simulated Components
	tabstat  d_total_livestock_direct_costs d_total_crops_direct_costs_eu d_inter_enterpise_transfers_eu, by(YE_AR)

	* Actual Data
	use "`OrigData'\svy_farm.dta", clear
	sort FARM_CODE YE_AR
	merge FARM_CODE YE_AR using `OrigData'\svy_crop_derived
	drop _merge
	tabstat  D_TOTAL_LIVESTOCK_DIRECT_COSTS D_TOTAL_CROPS_DIRECT_COSTS_EU D_INTER_ENTERPISE_TRANSFERS_EU, by(YE_AR)

	capture log close
	log using `OutDataO'\TestAnalysisOC.log, replace

	******************************************************
	* Overhead Costs
	******************************************************

	* Simulated Data
	use "`OutDataO'\farm_total_overhead_costs.dta", clear
	sort FARM_CODE YE_AR
	merge FARM_CODE YE_AR using `OutData'\origsubset
	drop _merge
	keep if origsubset == 1
	* Simulated Components
	tabstat  LAND_RENTED_IN_EU d_car_electricity_telephone_eu d_hired_labour_casual_excl_eu d_intrst_pay_incl_hp_interest_eu d_machine_operating_expenses_eu d_depreciation_of_machinery_eu d_depreciation_of_buildings_eu BUILDINGS_REPAIRS_UPKEEP_EU LAND_GENERAL_UPKEEP_EU d_depreciation_of_land_imps_eu d_misc_overhead_costs_eu pm_TOTAL_COST_OF_LEASE_EU TOTAL_COST_OF_LEASE_EU ANNUITIES_EU, by(YE_AR)
	
	* Actual Data
	use "`OrigData'\svy_farm.dta", clear
	* Todo are these variables available at the farm level in the live database
	*tabstat  LAND_RENTED_IN_EU D_CAR_ELECTRICITY_TELEPHONE_EU D_HIRED_LABOUR_CASUAL_EXCL_EU D_INTRST_PAY_INCL_HP_INTEREST_EU D_MACHINE_OPERATING_EXPENSES_EU D_DEPRECIATION_OF_MACHINERY_EU D_DEPRECIATION_OF_BUILDINGS_EU BUILDINGS_REPAIRS_UPKEEP_EU LAND_GENERAL_UPKEEP_EU D_DEPRECIATION_OF_LAND_IMPS_EU D_MISC_OVERHEAD_COSTS_EU PM_TOTAL_COST_OF_LEASE_EU TOTAL_COST_OF_LEASE_EU ANNUITIES_EU, by(YE_AR)

	capture log close
	log using `OutDataO'\TestAnalysisLGO.log, replace

	******************************************************
	* Livestock GO
	******************************************************

	* Simulated Data
	use "`OutData'\d_total_livestock_gross_output.dta", clear
	sort FARM_CODE YE_AR
	merge FARM_CODE YE_AR using `OutData'\origsubset
	drop _merge
	keep if origsubset == 1
	* Simulated Components
	tabstat  d_dairy_gross_output_eu d_gross_output_cattle_eu d_gross_output_sheep_and_wool_eu d_gross_output_pigs_eu d_poultry_gross_output_eu d_gross_output_horses_eu d_other_gross_output_eu, by(YE_AR)
	
	* Actual Data
	use "`OrigData'\svy_dairy_produce.dta", clear
	sort FARM_CODE YE_AR
	merge FARM_CODE YE_AR using `OrigData'\svy_cattle
	drop _merge
	sort FARM_CODE YE_AR
	merge FARM_CODE YE_AR using `OrigData'\svy_sheep
	drop _merge
	sort FARM_CODE YE_AR
	merge FARM_CODE YE_AR using `OrigData'\svy_pigs
	drop _merge
	sort FARM_CODE YE_AR
	merge FARM_CODE YE_AR using `OrigData'\svy_poultry
	drop _merge
	sort FARM_CODE YE_AR
	merge FARM_CODE YE_AR using `OrigData'\svy_horses_other
	drop _merge
	sort FARM_CODE YE_AR
	merge FARM_CODE YE_AR using `OrigData'\svy_deer
	drop _merge
	tabstat  D_DAIRY_GROSS_OUTPUT_EU D_GROSS_OUTPUT_CATTLE_EU D_GROSS_OUTPUT_SHEEP_AND_WOOL_EU D_GROSS_OUTPUT_PIGS_EU D_POULTRY_GROSS_OUTPUT_EU D_GROSS_OUTPUT_HORSES_EU, by(YE_AR)

	capture log close
	log using `OutDataO'\CropsGO.log, replace

	******************************************************
	* Crops GO
	******************************************************

	* Simulated Data
	use "`OutData'\total_crops_gross_output.dta", clear
	sort FARM_CODE YE_AR
	merge FARM_CODE YE_AR using `OutData'\origsubset
	drop _merge
	keep if origsubset == 1
	* Simulated Components
	tabstat  go_fodder_crops_sold_eu d_go_inv_misc_csh_crop d_output_from_cur_misc_cash_crop, by(YE_AR)
	
	* Actual Data
	use "`OrigData'\svy_crop_derived.dta", clear
	* Todo are these variables available at the farm level in the live database
	*tabstat GO_FODDER_CROPS_SOLD_EU D_GO_INV_MISC_CSH_CROP D_OUTPUT_FROM_CUR_MISC_CASH_CROP, by(YE_AR)

	capture log close
	log using `OutDataO'\LivestockDC.log, replace

	******************************************************
	* Livestock DC
	******************************************************

	* Simulated Data
	use "`OutData'\d_total_livestock_direct_costs.dta", clear
	sort FARM_CODE YE_AR
	merge FARM_CODE YE_AR using `OutData'\origsubset
	drop _merge
	keep if origsubset == 1
	* Simulated Components
	tabstat  d_dairy_total_direct_costs_eu d_cattle_total_direct_costs_eu d_sheep_total_direct_costs_eu d_pigs_total_direct_costs_eu d_poultry_total_direct_costs_eu d_horses_direct_costs_eu d_other_direct_costs_eu, by(YE_AR)
	
	* Actual Data
	use "`OrigData'\svy_dairy_produce.dta", clear
	sort FARM_CODE YE_AR
	merge FARM_CODE YE_AR using `OrigData'\svy_cattle
	drop _merge
	sort FARM_CODE YE_AR
	merge FARM_CODE YE_AR using `OrigData'\svy_sheep
	drop _merge
	sort FARM_CODE YE_AR
	merge FARM_CODE YE_AR using `OrigData'\svy_pigs
	drop _merge
	sort FARM_CODE YE_AR
	merge FARM_CODE YE_AR using `OrigData'\svy_poultry
	drop _merge
	sort FARM_CODE YE_AR
	merge FARM_CODE YE_AR using `OrigData'\svy_horses_other
	drop _merge
	sort FARM_CODE YE_AR
	merge FARM_CODE YE_AR using `OrigData'\svy_deer
	drop _merge
	
	gen D_SHEEP_TOTAL_DIRECT_COSTS_EU = D_TOTAL_DIRECT_COSTS_EU
	tabstat D_DAIRY_TOTAL_DIRECT_COSTS_EU D_CATTLE_TOTAL_DIRECT_COSTS_EU D_SHEEP_TOTAL_DIRECT_COSTS_EU D_PIGS_TOTAL_DIRECT_COSTS_EU  D_POULTRY_DIRECT_COSTS_EU D_HORSES_DIRECT_COSTS_EU D_OTHER_DIRECT_COSTS_EU, by(YE_AR)

	******************************************************
	* Dairy GO
	******************************************************
	capture log close
	log using `OutDataO'\DairyGO.log, replace

	* Simulated Data
	use "`OutData'\d_dairy_gross_output.dta", clear
	sort FARM_CODE YE_AR
	merge FARM_CODE YE_AR using `OutData'\origsubset
	drop _merge
	keep if origsubset == 1
	* Simulated Components
	tabstat  d_total_milk_production_eu d_dy_val_dropd_clvs_sld_trans_eu d_dairy_herd_replace_cost_eu DAIRY_COWS_SH_BULLS_SUBSIDIES_EU SLAUGHTER_PREMIUM_DAIRY_PAYMENT_ DAIRY_EFF_PROG_TOTAL_PAYMENT_EU DAIRY_COMP_FUND_TOTAL_PAYMENT_EU, by(YE_AR)
	
	* Actual Data
	use "`OrigData'\svy_dairy_produce.dta", clear
	sort FARM_CODE YE_AR
	merge FARM_CODE YE_AR using "`OrigData'\svy_subsidies_grants.dta"
	drop _merge
	sort FARM_CODE YE_AR
	merge FARM_CODE YE_AR using "`OrigData'\svy_cattle.dta"
	drop _merge
	rename var154 DAIRY_EFF_PROG_TOTAL_PAYMENT_EU
	rename var159 DAIRY_COMP_FUND_TOTAL_PAYMENT_EU
	rename var224 D_DY_VAL_DROPD_CLVS_SLD_TRANS_EU
	tabstat D_TOTAL_MILK_PRODUCTION_EU D_DY_VAL_DROPD_CLVS_SLD_TRANS_EU D_DAIRY_HERD_REPLACE_COST_EU DAIRY_COWS_SH_BULLS_SUBSIDIES_EU SLAUGHTER_PREMIUM_DAIRY_PAYMENT_ DAIRY_EFF_PROG_TOTAL_PAYMENT_EU DAIRY_COMP_FUND_TOTAL_PAYMENT_EU, by(YE_AR)
	
	log close
}
