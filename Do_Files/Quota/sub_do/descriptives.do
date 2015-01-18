* ------------------------------------------------------------------
* Descriptives
* ------------------------------------------------------------------
args outdatadir



describe


quietly {

  capture mkdir `outdatadir'/descriptives  

  * -------------------
  * Financial Summary 
  * -------------------
  local tabname "financials.csv" 
  qui capture tabout YE_AR                           ///
    if FARM_SYSTEM == 1 & D_SOIL_GROUP < 3      ///
    [aweight=UAA_WEIGHT]                        ///
    using `outdatadir'/descriptives/`tabname'   ///
    ,  sum oneway replace style(csv)            ///
       cell(                                    ///
            mean d_farm_gross_output            ///  
            mean d_farm_direct_costs            ///    
            mean d_farm_gross_margin            ///  
            mean d_farm_total_overhead_costs_eu ///
            mean d_farm_family_income           ///
           )
  if _rc == 0 local tablist "`tablist' `tabname'"
  if _rc != 0 local prob_tablist "`prob_tablist' `tabname'"
  
  
  
  * -------------------
  * GO decomposition
  * -------------------
  local tabname "GOdecomp.csv" 
  qui capture tabout YE_AR                         ///
    if FARM_SYSTEM == 1 & D_SOIL_GROUP < 3         ///
    [aweight=UAA_WEIGHT]                           ///
    using `outdatadir'/descriptives/`tabname'      ///
    ,  sum oneway replace style(csv)               ///
       cell(                                       ///
             mean d_farm_gross_output              /// 
             mean SINGLE_FARM_PAYMENT_NET_VALUE_EU /// 
             mean SUPER_LEVY_CHARGE_EU             /// 
             mean SHEEP_WELFARE_SCHEME_TOTAL_EU    /// 
             mean d_inter_enterpise_transfers_eu   /// 
             mean d_total_livestock_gross_output   /// 
             mean OTHER_RECEIPTS_IN_CASH_EU        /// 
             mean OTHER_SUBS_PAYMENTS_TOTAL_EU     /// 
             mean PROTEIN_PAYMENTS_TOTAL_EU        /// 
             mean OTHER_RECEIPTS_IN_KIND_EU        /// 
             mean LAND_LET_OUT_EU                  /// 
             mean d_total_crops_gross_output_eu    /// 
             mean SALE_OF_TURF_VALUE_EU            /// 
             mean MILK_QUOTA_LET_EU                /// 
             mean MISC_GRANTS_SUBSIDIES_EU         /// 
             mean USED_IN_HOUSE_OTHER_EU           /// 
             mean SUPER_LEVY_REFUND_EU             /// 
           ) 
  if _rc == 0 local tablist "`tablist' `tabname'"
  if _rc != 0 local prob_tablist "`prob_tablist' `tabname'"
  
  
  * -------------------
  * DC decomposition
  * -------------------
  local tabname "DCdecomp.csv" 
  qui capture tabout YE_AR                            ///
    if FARM_SYSTEM == 1 & D_SOIL_GROUP < 3       ///
    [aweight=UAA_WEIGHT]                         ///
    using `outdatadir'/descriptives/`tabname'    ///
    ,  sum oneway replace style(csv)             ///
       cell(                                     ///
            mean d_farm_direct_costs             /// 
            mean d_poultry_total_direct_costs_eu /// 
            mean dc_fodder_crops_sold_eu         /// 
            mean csh_crp_op_inv_fed_eu_1         /// 
            mean d_horses_direct_costs_eu        /// 
            mean d_dc_inv_misc_csh_crop          /// 
            mean csh_crp_cy_fed_eu_1             /// 
            mean d_dairy_total_direct_costs_eu   /// 
            mean d_other_direct_costs_eu         /// 
            mean d_dc_select_crops               /// 
            mean s_home_grown_seed_value_eu      /// 
            mean d_cattle_total_direct_costs_eu  /// 
            mean d_total_livestock_direct_costs  /// 
            mean oth_csh_crop_dc                 /// 
            mean d_milk_fed_to_livestock_eu      /// 
            mean d_sheep_total_direct_costs_eu   /// 
            mean waste_hay_dc                    /// 
            mean s_setaside_dc                   /// 
            mean d_inter_enterpise_transfers_eu  /// 
            mean d_pigs_total_direct_costs_eu    /// 
            mean waste_sil_dc                    /// 
            mean d_total_crops_direct_costs_eu   /// 
           ) 
  if _rc == 0 local tablist "`tablist' `tabname'"
  if _rc != 0 local prob_tablist "`prob_tablist' `tabname'"
  
  
  
  * -------------------
  * OH decomposition
  * -------------------
  local tabname "OHdecomp.csv" 
  qui capture tabout YE_AR                              ///
    if FARM_SYSTEM == 1 & D_SOIL_GROUP < 3         ///
    [aweight=UAA_WEIGHT]                           ///
    using `outdatadir'/descriptives/`tabname'      ///
    ,  sum oneway replace style(csv)               ///
       cell(                                       ///
            mean d_farm_total_overhead_costs_eu    ///
            mean d_depreciation_of_machinery_eu    ///
            mean BUILDINGS_REPAIRS_UPKEEP_EU       ///
            mean TOTAL_COST_OF_LEASE_EU            ///
            mean LAND_RENTED_IN_EU                 ///
            mean LAND_GENERAL_UPKEEP_EU            ///
            mean d_car_electricity_telephone_eu    ///
            mean ANNUITIES_EU                      ///
            mean d_machine_operating_expenses_eu   ///
            mean d_depreciation_of_buildings_eu    ///
            mean d_hired_labour_casual_excl_eu     ///
            mean d_misc_overhead_costs_eu          ///
            mean d_depreciation_of_land_imps_eu    ///
            mean d_intrst_pay_incl_hp_interest_eu  ///
            mean pm_TOTAL_COST_OF_LEASE_EU         ///
           ) 
  if _rc == 0 local tablist "`tablist' `tabname'"
  if _rc != 0 local prob_tablist "`prob_tablist' `tabname'"
  
  
  
  * -------------------
  * Farm structures
  * -------------------
  local tabname "structures1.csv" 
  qui capture tabout YE_AR                           ///
    if FARM_SYSTEM == 1 & D_SOIL_GROUP < 3      ///
    [aweight=UAA_WEIGHT]                        ///
    using `outdatadir'/descriptives/`tabname'   ///
    ,  sum oneway replace style(csv)            ///
       cell(                                    ///
            mean UAA_SIZE                       ///
            mean LAND_FARMED_HA                 ///
            mean WOODLAND_HA                    ///
            mean NON_AGRI_AREA_HA               ///
            mean OTHER_LAND_USE_HA              ///
            mean D_SOIL_GROUP                   ///
           ) 
  if _rc == 0 local tablist "`tablist' `tabname'"
  if _rc != 0 local prob_tablist "`prob_tablist' `tabname'"
  
  
  gen double sh_owned   = LAND_OWNED        / UAA_SIZE
  gen double sh_rented  = LAND_RENTED_IN_HA / UAA_SIZE
  gen double sh_let     = LAND_LET_OUT_HA   / UAA_SIZE
  gen double sh_pasture = TOTAL_PASTURE_HA  / UAA_SIZE
  
  
  local tabname "structures2.csv" 
  qui capture tabout YE_AR                              ///
    if FARM_SYSTEM == 1 & D_SOIL_GROUP < 3         ///
    [aweight=UAA_WEIGHT]                           ///
    using `outdatadir'/descriptives/`tabname'      ///
    ,  sum oneway replace style(csv)               ///
       cell(                                       ///
            mean sh_owned                          ///
            mean sh_rented                         ///
            mean sh_let                            ///
            mean sh_pasture                        ///
            mean COMMONAGE_DAIRY_LU_EQUIV          ///
            mean COMMONAGE_TOTAL_HA                ///
            mean DEROGATION_GT170KGN_YN            ///
           ) 
  if _rc == 0 local tablist "`tablist' `tabname'"
  if _rc != 0 local prob_tablist "`prob_tablist' `tabname'"
  
  
  local tabname "structures3.csv" 
  qui capture tabout YE_AR                                ///
    if FARM_SYSTEM == 1 & D_SOIL_GROUP < 3           ///
    [aweight=UAA_WEIGHT]                             ///
    using `outdatadir'/descriptives/`tabname'        ///
    ,  sum oneway replace style(csv)                 ///
       cell(                                         ///
            mean FARM_MD_MARITAL_STATUS              ///
            mean FARM_MD_OTHER_GAINFUL_ACT_EMP_TY    ///
            mean FARM_MD_OCCUPATION_CODE             ///
            mean FARM_MD_INCOME_RECEIVED_CODE        ///
            mean FARM_MD_GENDER                      ///
            mean FARM_MD_PRIVATE_PUBLIC_SECTOR       ///
            mean FARM_MD_OTHER_JOB_WEEKS_NO          ///
            mean FARM_MD_AGE                         ///
            mean FARM_MD_SECTOR_CODE                 ///
            mean FARM_MD_HOURS_TYPICAL_WEEK_NO       ///
           )
  if _rc == 0 local tablist "`tablist' `tabname'"
  if _rc != 0 local prob_tablist "`prob_tablist' `tabname'"
  
  
  local tabname "structures4.csv" 
  qui capture tabout YE_AR                              ///
    if FARM_SYSTEM == 1 & D_SOIL_GROUP < 3         ///
    [aweight=UAA_WEIGHT]                           ///
    using `outdatadir'/descriptives/`tabname'      ///
    ,  sum oneway replace style(csv)               ///
       cell(                                       ///
            mean FARM_PRIMARY_EDUCATION_NO         ///
            mean FARM_SECOND_LEVEL_EDUCATION_NO    ///
            mean FARM_THIRD_LEVEL_EDUCATION_NO     ///
           )
  if _rc == 0 local tablist "`tablist' `tabname'"
  if _rc != 0 local prob_tablist "`prob_tablist' `tabname'"
  
  
  local tabname "structures5.csv" 
  qui capture tabout YE_AR                              ///
    if FARM_SYSTEM == 1 & D_SOIL_GROUP < 3         ///
    [aweight=UAA_WEIGHT]                           ///
    using `outdatadir'/descriptives/`tabname'      ///
    ,  sum oneway replace style(csv)               ///
       cell(                                       ///
            mean MILK_QUOTA_TOT_LEASED_EU          ///
            mean MILK_QUOTA_TOT_LEASED_LT          ///
            mean MILK_QUOTA_INHERITED_LT           ///
            mean MILK_QUOTA_SOLD_LT                ///
            mean MILK_QUOTA_GIFT_GIVEN_EU          ///
            mean MILK_QUOTA_LET_EU                 ///
            mean MILK_QUOTA_TOT_PURCH_LT           ///
            mean MILK_QUOTA_INHERITED_EU           ///
            mean MILK_QUOTA_SOLD_EU                ///
            mean MILK_QUOTA_TOTAL_CY_LT            ///
            mean MILK_QUOTA_OWN_CY_LT              ///
            mean MILK_QUOTA_TOT_PURCH_EU           ///
            mean MILK_QUOTA_LET_LT                 ///
            mean MILK_QUOTA_GIFT_GIVEN_LT          ///
           ) 
  if _rc == 0 local tablist "`tablist' `tabname'"
  if _rc != 0 local prob_tablist "`prob_tablist' `tabname'"
  

  local tabname "structures6.csv" 
  qui capture tabout YE_AR                              ///
    if FARM_SYSTEM == 1 & D_SOIL_GROUP < 3         ///
    [aweight=UAA_WEIGHT]                           ///
    using `outdatadir'/descriptives/`tabname'      ///
    ,  sum oneway replace style(csv)               ///
       cell(                                       ///
            mean d_dairy_stocking_rate /// 
            mean d_milk_yield          ///
            mean d_milk_price          ///
            mean d_labour_intensity_ha ///
            mean d_labour_intensity_lu ///
           ) 
  if _rc == 0 local tablist "`tablist' `tabname'"
  if _rc != 0 local prob_tablist "`prob_tablist' `tabname'"


}



* Output file listing
di "The following files have been written to" _newline(2) "`outdatadir'/descriptives"
foreach tabentry of local tablist{

  di "`tabentry'"

}

* Error list if applicable
if "`prob_tablist'" != "" {
  di "The following files received an error"
  foreach tabentry of local prob_tablist{

    di "`tabentry'"

  }
}	










/*


*----------------------------------


	* Structural Differences (slide 11)
	*----------------------------------
	
	* For viewing in Stata
	gen totlab_cow = labourinputhours/dairycows
	tabstat  dairycows 		///
		 othercattlelus		///
		 totaluaa 		///
		 daforare 		///
		 stockingdensity 	///
		 totlab_cow 		///
		 milkyield 		///
		 if year>=2007 [weight=wt] 

	/*-- TURNED OFF ------------------
	* Same data exported to Excel
	preserve

	collapse year			    ///
		 dairycows 		    ///
		 othercattlelus		    ///
		 totaluaa 		    ///
		 daforare 		    ///
		 stockingdensity 	    ///
		 totlab_cow 		    ///
		 milkyield 		    ///
		 if year==2008 [weight=wt], by(country)

	local cumulative_N = `cumulative_N' + _N
	di `cumulative_N'
	local rownumber = 1 + `cumulative_N'
	export excel using 			            ///
	 `outdatadir'/simplified.xlsx, 	        	    ///
	sheet("slide 11")			            ///
	cell(A`rownumber')			            ///
	sheetmodify

	restore
	---- BACK ON --------------------*/


	*----------------------------------
	* Proportions of farmers by age (slide 12)
	*----------------------------------
	preserve

	do dy_sub_do/age.do

	/*-- TURNED OFF ------------------

	export excel using 			 ///
	    `outdatadir'/simplified.xlsx,        /// 
	    sheet("slide 12 (data`filenumber')") /// 
	    cell(A2)                             /// 
	    firstrow(variables)                  /// 
	    sheetmodify

	---- BACK ON --------------------*/

	restore

	*----------------------------------
	* Differences in Farm Financials (slide 13)
	*----------------------------------
	preserve

	do dy_sub_do/fin_farm.do
	
	/*-- TURNED OFF ------------------

	export excel using                      /// 
	   `outdatadir'/simplified.xlsx,        /// 
	   sheet("slide 13 (data`filenumber')") /// 
	   cell(A2)                             /// 
	   firstrow(variables)                  /// 
	   sheetmodify

	---- BACK ON --------------------*/
	restore
	

	*----------------------------------
	* Gross margin per litre cost groups (slide 14)
	*----------------------------------

	replace fdairygm = fdairygo - fdairydc
	gen fdairytct_lt = fdairytct/dotomkgl
	
	/*-----------------------------------------------
	 P.Gillespie:
	  Create cost groupings in this format: yyyy_g 
	   (i.e. 4 digit year then group number). This
	   format allows you to easily collapse the 
	   dataset by year AND cost grouping (collapse 
	   usually allows only one grouping variable). 
	-----------------------------------------------*/
	
	
	* Create 3 groups of farms by total costs per hectare in each year
	gen str ct_lt_cat = "" //<- "" purposefully set to empty string
	
	
	* Create 3 groups of farms by total costs per litre in each year
	local i = 1999
	while `i' < 2008{
	
	
		* creates grouping for the year, but missing in other years.
		xtile ct_lt_cat_`i'=fdairytct_lt [weight=wt] if year==`i' /*
	  	*/    , nq(3)
	
	
		/* Thia's convention is to number the categories from highest 
		    cost to lowest cost, so reassign values to match that by 
		    subtracting from 4. */ 
		replace ct_lt_cat_`i' = 4 - ct_lt_cat_`i' if year==`i'
	
	
		* adds the 4 digit year to front, still missing in other years
		egen tmp_cat = concat(year ct_lt_cat_`i'), punct("_")
	
	
		* One var that fills up as you go through the loop (no missings)
		replace ct_lt_cat = tmp_cat if year == `i'
		drop ct_lt_cat_`i' tmp_cat
		local i = `i'+1
	
	
	}
	
	save data`filenumber'_out.dta, replace
	
	*----------------------------------
	* Create a csv with 3 rows per year (one per group) with group totals 
	* per unit measures.
	*----------------------------------
	
	*------------
	* Per litre
	*------------
	* gsort allows descending order, sort does not
	gsort year -fdairytct_lt
	
	preserve
	collapse (sum) doslmkgl fdairygo fdairydc fdairyoh fdairygm /*
	*/       [weight=wt], by(ct_lt_cat)
	
	
	* generate per ha measures using sums of each group in each year
	* which is what you have from the collapse statement
	foreach var in fdairygo fdairydc fdairyoh fdairygm {
	
		gen `var'_lt = `var'/doslmkgl
	
	}
	
	
	* separate year and group info in ct_lt_cat
	gen year = substr(ct_lt_cat, 1, 4)
	replace ct_lt_cat = substr(ct_lt_cat, -1, 1)
	
	
	* then store as numeric vars instead of strings and create the csv
	destring year ct_lt_cat, replace
	
	
	sort ct_lt_cat year
	
	
	*outsheet using `outdatadir'/ct_cat_lt.csv, comma replace
	
	/*-- TURNED OFF ------------------

	export excel using 			         ///
	 `outdatadir'/simplified.xlsx		         ///
	 if year == 2007,			         ///
	sheet("slide 14 (data`filenumber')")             ///
	cell(A2)				         ///
	firstrow(variables)			         ///
	sheetmodify
		
	---- BACK ON --------------------*/
	
	restore
	
	
	
	preserve
	collapse (mean) ogagehld [weight=wt], by(ct_lt_cat)
	
	
	* separate year and group info in ct_lt_cat
	gen year = substr(ct_lt_cat, 1, 4)
	replace ct_lt_cat = substr(ct_lt_cat, -1, 1)
	
	
	* then store as numeric vars instead of strings and create the csv
	destring year ct_lt_cat, replace
	
	
	sort ct_lt_cat year
	outsheet using `outdatadir'/ct_cat_lt_mean_age`filenumber'.csv, comma replace
	macro list _outdatadir
	*use `outdatadir'/`intdata3', clear


	restore

	save data`filenumber'_out.dta, replace
	*----------------------------------
	* Decomposition of Direct Costs (slide 15)
	*----------------------------------

	preserve

	gen othct = 		///
	   seedsandplants     + ///
	   cropprotection     +	///
	   othercropspecific  +	///
	   forestryspecificcosts

	collapse year totalspecificcosts fdgrzlvstk fertilisers ///
		 otherlivestocksp othct daforare dotomkgl 	///
		 dpnolu flabunpd 				///
		  if year>=2007, by(country)


	* suffix for naming vars in following loop
	local suffix_list ""
	local suffix_list  "`suffix_list ' pct"
	local suffix_list  "`suffix_list ' ha"
	local suffix_list  "`suffix_list ' lt"
	local suffix_list  "`suffix_list ' lu"
	local suffix_list  "`suffix_list ' labu"


	foreach suffix of local suffix_list {

	   * choose correct denominator based on suffix
	   if "`suffix'" == "pct"{
	   local denom "totalspecificcosts"
	   }
	   if "`suffix'" == "ha"{
	   local denom "daforare"
	   }
	   if "`suffix'" == "lt"{
	   local denom "dotomkgl" //dosmkgl
	   }
	   if "`suffix'" == "lu"{
	   local denom "dpnolu"
	   }
	   if "`suffix'" == "labu"{
	   local denom "flabunpd"
	   }
	   
	   gen fdgrz_`suffix' = fdgrzlvstk/`denom'
	   label var fdgrz_`suffix' "Feed"

	   gen fert_`suffix' = fertilisers/`denom'
	   label var fert_`suffix' "Fertilser"

	   gen othlvstk_`suffix' = otherlivestockspecific/`denom'
	   label var othlvstk_`suffix' "Other Livestock Costs"

	   gen othct_`suffix' = othct/`denom'
	   label var othct_`suffix' "Other Costs"
	   
	   capture drop rowname
	   gen rowname = "`suffix'"

	   mkmat fdgrz_`suffix'                         ///
		     fert_`suffix'                      ///
		     othlvstk_`suffix'                  ///
		     othct_`suffix'                     ///
		     , matrix(`suffix')                 ///
		       rownames(rowname) 
	   matrix `suffix'`filenumber' = [`suffix'']
	   matrix drop `suffix'
	}	
	

	matrix DC`filenumber' = [pct`filenumber', ha`filenumber', lt`filenumber', lu`filenumber', labu`filenumber']

	/*-- TURNED OFF ------------------

	local rownumber2 = 2 + `filenumber'
	local suffix "pct"
	export excel country fdgrz_`suffix'         	  ///
		     fert_`suffix'                        /// 
		     othlvstk_`suffix'                    /// 
		     othct_`suffix'                       /// 
		     using  `outdatadir'/simplified.xlsx, /// 
		     sheet("slide 15")                    /// 
		     cell(A`rownumber2')                  /// 
		     sheetmodify

	---- BACK ON --------------------*/

	restore	

	local filenumber = `filenumber' + 1 
}	

local filenumber = 1
use data`filenumber'_out.dta, clear
gen cntry = 1
local filenumber = 2
qui append using data`filenumber'_out.dta
replace cntry = 2 if cntry == .



*----------------------------------
* Impute costs and allocate to enterprise
*----------------------------------

*--Creates imputed costs for unpaid family factors 
do sub_do/FADNimputemethod.do     

*--Allocates costs to dairy enterprise 
do sub_do/FADNallocationmethod.do 


*----------------------------------
* Tables
*----------------------------------

/* If selecting just BMW in Ireland, then stick "bmw" in logfile 
    names. Now you won't overwrite logs for whole Ireland dataset. */
if `BMWonly'==1 {
	local bmwarg = "bmw"
}


* "bmw" passed into do files via args command. (See help file for args)
do sub_do/cex_vargen.do      `bmwarg' 	// variables for cex_ do-files

/*-- TURNED OFF ------------------

do sub_do/cex_decomp.do      `bmwarg' 	// cex is short for... 
do sub_do/cex_decomp_lt.do   `bmwarg'  	//  "Constant exchange rate adjustment"
do sub_do/cex_decomp_lu.do   `bmwarg'  	//
do sub_do/cex_decomp_ha.do   `bmwarg'  	// decomp is short for... 
do sub_do/cex_decomp_labu.do `bmwarg'  	//  "Decomposition into components"
do sub_do/cex_godecomp.do    `bmwarg'  	//  GO decomp (farm level only)

/* NOTE: 
The exchange rate adjustment is not constant in the most recent version. 
 It now just replaces the 08 and 09 exchange rates with rates that 
 follow a simple linear trend estimated from 99 to 07 (which are left
        as is).  */

---- BACK ON --------------------*/

replace fdairygo = cex_fdairygo
replace fdairydc = cex_fdairydc 
replace fdairyoh = cex_fdairyoh
replace fdairyec = cex_fdairyec

gen cex_wages = wages*exchangerate/cex


gen hrs_lu = labourinputhours/totallivestockunits



local structuralvars = "`structuralvars' dpnolu"
local structuralvars = "`structuralvars' othercattlelus"
local structuralvars = "`structuralvars' totaluaa"
local structuralvars = "`structuralvars' daforare"
local structuralvars = "`structuralvars' stockingdensity"
local structuralvars = "`structuralvars' hrs_lu"
local structuralvars = "`structuralvars' milkyield"
local structuralvars = "`structuralvars' ogagehld"
local  i = 1
matrix TTESTS = (0 , 0)

tabstat `structuralvars' [weight=wt], by(country)

* Do t tests for each var in the table and store t-stat in a matrix
foreach var of local structuralvars{
	ttest `var'	   	    , by(country) unequal
	matrix TTESTS = (TTESTS \ `r(t)', round(`r(p)', .001))
	local i	= `i'+1
}
matrix TTESTS = TTESTS[2..`i',1..2]
* Label the rows and the single column of the t-test matrix
matrix rownames TTESTS = `structuralvars'
matrix colnames TTESTS = t-stat p-value


matrix list TTESTS

*/
