local this_file_calculates "D_FARM_GROSS_OUTPUT"

local nonexist_vlist "`nonexist_vlist' D_TOTAL_LIVESTOCK_GROSS_OUTPUT"
local nonexist_vlist "`nonexist_vlist' D_TOTAL_CROPS_GROSS_OUTPUT_EU"
local nonexist_vlist "`nonexist_vlist' HIRED_MACHINERY_IN_CASH_EU"
local nonexist_vlist "`nonexist_vlist' HIRED_MACHINERY_IN_KIND_EU"
local nonexist_vlist "`nonexist_vlist' OTHER_RECEIPTS_IN_CASH_EU"
local nonexist_vlist "`nonexist_vlist' OTHER_RECEIPTS_IN_KIND_EU"
local nonexist_vlist "`nonexist_vlist' SALE_OF_TURF_VALUE_EU"
local nonexist_vlist "`nonexist_vlist' USED_IN_HOUSE_OTHER_EU"
local nonexist_vlist "`nonexist_vlist' MISC_GRANTS_SUBSIDIES_EU"
local nonexist_vlist "`nonexist_vlist' PROTEIN_PAYMENTS_TOTAL_EU"
local nonexist_vlist "`nonexist_vlist' SHEEP_WELFARE_SCHEME_TOTAL_EU"
local nonexist_vlist "`nonexist_vlist' OTHER_SUBS_TOTAL_EU"
local nonexist_vlist "`nonexist_vlist' LAND_LET_OUT_EU"
local nonexist_vlist "`nonexist_vlist' MILK_QUOTA_LET_EU"
local nonexist_vlist "`nonexist_vlist' SINGLE_FARM_PAYMENT_NET_VALUE_EU"
local nonexist_vlist "`nonexist_vlist' D_INTER_ENTERPRISE_TRANSFERS_EU"



capture drop `this_file_calculates'
gen  `this_file_calculates' =             ///
 D_TOTAL_LIVESTOCK_GROSS_OUTPUT    + ///
 D_TOTAL_CROPS_GROSS_OUTPUT_EU     + ///
 HIRED_MACHINERY_IN_CASH_EU        + ///
 HIRED_MACHINERY_IN_KIND_EU        + ///
 OTHER_RECEIPTS_IN_CASH_EU         + ///
 OTHER_RECEIPTS_IN_KIND_EU         + ///
 SALE_OF_TURF_VALUE_EU             + ///
 USED_IN_HOUSE_OTHER_EU            + ///
 MISC_GRANTS_SUBSIDIES_EU          + ///
 PROTEIN_PAYMENTS_TOTAL_EU         + ///
 SHEEP_WELFARE_SCHEME_TOTAL_EU     + ///
 OTHER_SUBS_TOTAL_EU               + ///
 LAND_LET_OUT_EU                   + ///
 MILK_QUOTA_LET_EU                 + ///
 SINGLE_FARM_PAYMENT_NET_VALUE_EU  - ///
 D_INTER_ENTERPRISE_TRANSFERS_EU

replace `this_file_calculates' =       ///
 `this_file_calculates'                 + ///
 SUPER_LEVY_REFUND_EU                     ///
 if SUPER_LEVY_REFUND_EU > SUPER_LEVY_CHARGE_EU


foreach var of local nonexist_vlist{
	summ `var'
} 
