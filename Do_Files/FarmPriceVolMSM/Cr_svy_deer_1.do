*******************************************
* Create svy_deer_1
*******************************************


* d_deer_livestock_units (i_lu_of_deer)
*--------------------------------------


rename d_deer_pasture_eu D_DEER_PASTURE_EU
rename var10 BREEDING_HINDS_CLOS_INV_PERUNIT_
rename var14 OTHER_DEER_LT1YR_CLOS_INV_PERUNI
rename var18 OTHER_DEER_GT1YR_CLOS_INV_PERUNI

* i_lu_of_deer
gen i_lu_of_deer = 0
replace i_lu_of_deer = 0.13 if DEER_TYPE_CODE == 1
replace i_lu_of_deer = 0.25 if DEER_TYPE_CODE == 2
replace i_lu_of_deer = 0.08 if DEER_TYPE_CODE == 3
replace i_lu_of_deer = 0.13 if DEER_TYPE_CODE == 4

gen d_deer_livestock_units = ((MTH12_TOTAL_BREEDING_FEMALES_NO + MTH12_TOTAL_BREEDING_MALES_NO + MTH12_TOTAL_DEER_LT1YR_NO + MTH12_TOTAL_DEER_GT1YR_NO + MTH12_TOTAL_OTHER_DEER_NO) / 12) * i_lu_of_deer
replace d_deer_livestock_units = 0 if d_deer_livestock_units == .

*D_DEER_SALES_EU
gen d_deer_sales_eu = 0
replace d_deer_sales_eu = (FINISHED_MALES_SALES_EU + FINISHED_FEMALES_SALES_EU + BREEDING_MALES_SALES_EU + BREEDING_FEMALES_SALES_EU + STORE_CALVES_FEMALE_SALES_EU + STORE_CALVES_MALE_SALES_EU + CULLS_SALES_EU + OTHER_INCL_ALLOWANCES_SALES_EU)
