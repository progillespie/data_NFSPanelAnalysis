* Create whatever derived variables are needed for this variable and
*  calculate the variable itself.


local startdir: pwd // Save current working directory location


* Move into the root of the variable's directory
local this_file_calculates "D_OTHER_GROSS_OUTPUT_EU"
qui cd  `this_file_calculates'
local vardir: pwd


* Needed variables get their own subdirectories. Look for subfolders
*  and use their names to determine which variables you need to
*  calculate for this variable.
local vars_needed: dir "." dirs *


foreach var_needed of local vars_needed {
	di "Deriving `var_needed'"
	qui do `var_needed'/`var_needed'.do
}



* Create a list of variables which may not exist for the early years
local nonexist_vlist "`nonexist_vlist' BREEDING_STAGS_CLOS_INV_NO"
local nonexist_vlist "`nonexist_vlist' BREEDING_STAGS_OP_INV_NO"
local nonexist_vlist "`nonexist_vlist' BREEDING_STAGS_OP_INV_EU"
local nonexist_vlist "`nonexist_vlist' BREEDING_HINDS_CLOS_INV_NO"
local nonexist_vlist "`nonexist_vlist' BREEDING_HINDS_OP_INV_NO"
local nonexist_vlist "`nonexist_vlist' BREEDING_HINDS_CLOS_INV_EU"
local nonexist_vlist "`nonexist_vlist' OTHER_DEER_LT1YR_CLOS_INV_NO"
local nonexist_vlist "`nonexist_vlist' OTHER_DEER_LT1YR_OP_INV_NO"
local nonexist_vlist "`nonexist_vlist' OTHER_DEER_LT1YR_CLOS_INV_EU"
local nonexist_vlist "`nonexist_vlist' OTHER_DEER_GT1YR_CLOS_INV_NO"
local nonexist_vlist "`nonexist_vlist' OTHER_DEER_GT1YR_OP_INV_NO"
local nonexist_vlist "`nonexist_vlist' OTHER_DEER_GT1YR_CLOS_INV_EU"
local nonexist_vlist "`nonexist_vlist' D_DEER_SALES_EU"


* Check if those vars exist, and if not create them as zero vectors
foreach var of local nonexist_vlist {

	capture confirm variable `var'

	if _rc!=0{

		if "`var'"== "OTHER_SUBS_TOTAL_EU"{
		   gen OTHER_SUBS_TOTAL_EU = 0
		}

		else {
		   gen `var' = 0
		}

	}

}

* BREEDING_STAGS_OP_INV_PERUNIT_EU
* BREEDING_HINDS_CLOS_INV_PERUNIT_EU
* OTHER_DEER_LT1YR_CLOS_INV_PERUNIT_EU
* OTHER_DEER_GT1YR_CLOS_INV_PERUNIT_EU

*  changed to

* BREEDING_STAGS_OP_INV_EU
* BREEDING_HINDS_CLOS_INV_EU
* OTHER_DEER_LT1YR_CLOS_INV_EU
* OTHER_DEER_GT1YR_CLOS_INV_EU


capture drop `this_file_calculates'
gen `this_file_calculates' =   ///
(BREEDING_STAGS_CLOS_INV_NO    - BREEDING_STAGS_OP_INV_NO)      * ///
(BREEDING_STAGS_OP_INV_EU)     + ///
///
(BREEDING_HINDS_CLOS_INV_NO    - BREEDING_HINDS_OP_INV_NO)      * ///
(BREEDING_HINDS_CLOS_INV_EU)   + ///
///
(OTHER_DEER_LT1YR_CLOS_INV_NO  - OTHER_DEER_LT1YR_OP_INV_NO)    * ///
(OTHER_DEER_LT1YR_CLOS_INV_EU) + ///
///
(OTHER_DEER_GT1YR_CLOS_INV_NO  - OTHER_DEER_GT1YR_OP_INV_NO)    * ///
(OTHER_DEER_GT1YR_CLOS_INV_EU) + ///
///
D_DEER_SALES_EU



cd `startdir'
