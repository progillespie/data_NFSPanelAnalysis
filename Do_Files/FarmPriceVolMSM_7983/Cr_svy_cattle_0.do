*******************************************
* Create svy_cattle_0
*******************************************

*i_cattle_lu_home_grazing and i_dairy_lu_home_grazing   (d_cattle_livestock_units, d_cattle_lu_boarding_out, d_cattle_lu_boarding_in, d_dairy_livestock_units_incl_bulls, d_dairy_lu_boarding_out, d_dairy_lu_boarding_in)
*-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
* CHANGE-7983: create 0 variables
gen double var31  = 0
gen double var32  = 0
gen double var34  = 0
gen double var96  = 0
gen double var97  = 0
gen double var163 = 0
gen double var164 = 0
gen double var165 = 0
gen double var166 = 0
gen double var188 = 0
gen double var224 = 0
gen double CATTLE_FINISHED_FEMALE_SALES_EU  = 0
gen double CATTLE_FINISHED_FEMALE_SALES_NO  = 0
gen double CATTLE_FINISHED_MALE_SALES_EU    = 0
gen double CATTLE_FINISHED_MALE_SALES_NO    = 0
gen double CATTLE_STORES_FEMALE_SALES_EU    = 0
gen double CATTLE_STORES_FEMALE_SALES_NO    = 0
gen double CATTLE_BREEDING_ANIMALS_SALES_EU = 0
gen double CATTLE_BREEDING_ANIMALS_SALES_NO = 0
gen double CATTLE_STORES_MALE_PURCHASES_EU  = 0
gen double CATTLE_STORES_MALE_PURCHASES_NO  = 0
gen double CATTLE_STORES_MALE_SALES_EU      = 0
gen double CATTLE_STORES_MALE_SALES_NO      = 0
gen double MTH12_TOTAL_SUCKLER_COWS_NO      = 0
gen double CATTLE_SUCKLER_COWS_CLOS_INV_NO  = 0
gen double CATTLE_SUCKLER_COWS_OP_INV_NO    = 0
gen double CATTLE_SUCKLER_COWS_CLOS_INV_EU  = 0
gen double CATTLE_OTHER_CLOS_INV_NO         = 0
gen double CATTLE_OTHER_OP_INV_NO           = 0
gen double CATTLE_OTHER_CLOS_INV_EU         = 0
gen double CATTLE_OTHER_OP_INV_EU           = 0





*d_cattle_livestock_units 

rename var31 DAIRY_COWS_SH_BULLS_SLS_BREED_NO  
rename var32 DAIRY_COWS_SH_BULLS_SLS_BREED_EU
rename var34 DAIRY_COWS_SH_BULLS_SALES_CUL_EU
rename var35 DY_COWS_SH_BULS_TRNSFR_IN_NO  // ok
rename var36 DY_COWS_SH_BULS_TRNSFR_IN_EU // ok
rename var37 DY_COWS_SH_BULS_TRNSFR_OUT_NO // ok
rename var38 DY_COWS_SH_BULS_TRNSFR_OUT_EU // ok
rename var54 CATTLE_CALVS_6MTHS_1YR_OP_INV_NO // ok
rename var55 CATTLE_CALVS_6MTHS_1YR_OP_INV_EU // ok
rename var71 CATTLE_IN_CALF_HEFRS_CLOS_INV_NO // ok
rename var72 CATTLE_IN_CALF_HEFRS_CLOS_INV_EU // ok
rename var75 CATTLE_CALVS_LT6MTHS_CLOS_INV_NO // ok
rename var76 CATTLE_CALVS_LT6MTHS_CLOS_INV_EU // ok
rename var77 CATL_CALVS_6MTHS_1YR_CLOS_INV_NO // ok
rename var78 CATL_CALVS_6MTHS_1YR_CLOS_INV_EU // ok
rename var96 CTL_STORES_FMALE_PURCHASES_NO
rename var97 CTL_STORES_FMALE_PURCHASES_EU
rename var98 CTL_BREED_REPLCMENTS_PURCH_NO // ok
rename var99 CTL_BREED_REPLCMENTS_PURCH_EU // ok
rename var107 CATTLE_RECPTS_FOR_BULL_SRVICE_EU // ok
rename var124 CTL_BREDING_HRD_CULS_SALES_NO // ok
rename var125 CTL_BREDING_HRD_CULS_SALES_EU // ok
rename var163 MTH12_TOT_CATTLE_ML_1_2YRS_NO
rename var164 MTH12_TOT_CATTLE_FL_1_2YRS_NO
rename var165 MTH12_TOT_CATTLE_ML_GT2YRS_NO
rename var166 MTH12_TOT_CATTLE_FL_GT2YRS_NO
rename var188 D_DAIRY_LIVSTK_UNITS_INC_BULLS
rename var224 D_DY_VAL_DROPD_CLVS_SLD_TRANS_EU
rename DAIRY_COWS_SH_BULLS_PURCHASES_EU DY_COWS_SH_BULLS_PURCHASES_EU
rename DAIRY_COWS_SH_BULLS_PURCHASES_NO DY_COWS_SH_BULLS_PURCHASES_NO
rename CATTLE_FINISHED_FEMALE_SALES_EU CTL_FINISHED_FEMALE_SALES_EU 			
rename CATTLE_FINISHED_FEMALE_SALES_NO CTL_FINISHED_FEMALE_SALES_NO
rename CATTLE_BREEDING_ANIMALS_SALES_EU CTL_BREEDING_ANIMALS_SALES_EU	
rename CATTLE_BREEDING_ANIMALS_SALES_NO CTL_BREEDING_ANIMALS_SALES_NO
rename CATTLE_STORES_MALE_PURCHASES_EU CTL_STORES_MALE_PURCHASES_EU
rename CATTLE_STORES_MALE_PURCHASES_NO CTL_STORES_MALE_PURCHASES_NO



gen d_cattle_livestock_units = ((MTH12_TOTAL_SUCKLER_COWS_NO * 0.9) + (MTH12_TOTAL_OTHER_COWS_NO * 0.9) + (MTH12_TOTAL_IN_CALF_HEIFERS_NO * 0.7) + (MTH12_TOTAL_CALVES_LT6MTHS_NO * 0.2) + (MTH12_TOTAL_CALVES_6_12MTHS_NO * 0.4) + (MTH12_TOT_CATTLE_ML_1_2YRS_NO * 0.7) + (MTH12_TOT_CATTLE_FL_1_2YRS_NO * 0.7) + (MTH12_TOT_CATTLE_ML_GT2YRS_NO * 1) + (MTH12_TOT_CATTLE_FL_GT2YRS_NO * 1) + (MTH12_TOTAL_BEEF_STOCK_BULLS_NO * 1)) / 12
replace d_cattle_livestock_units = 0 if d_cattle_livestock_units == .

* d_dairy_livestock_units_incl_bulls

gen d_dairy_livstk_units_inc_bulls = ((MTH12_TOTAL_DAIRY_COWS_NO / 12) * 1 + (MTH12_TOTAL_DAIRY_STOCK_BULLS_NO / 12) * 1)
replace d_dairy_livstk_units_inc_bulls =0 if d_dairy_livstk_units_inc_bulls == .
