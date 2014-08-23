* Scalars
scalar sc_simulation = 1


* Directory macros

local OrigData = "D:\DATA\Data_NFSPanelANalysis\OrigData\FarmPriceVolMSM"


local s = sc_simulation
local OutData = "D:\data\Data_NFSPanelANalysis\OutData\FarmPriceVolMSM"
local OutDataO = "D:\data\Data_NFSPanelANalysis\OutData\FarmPriceVolMSM\\`s'"


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

*keep FARM_CODE YE_AR d_total_livestock_gross_output d_total_crops_gross_output_eu HIRED_MACHINERY_IN_CASH_EU HIRED_MACHINERY_IN_KIND_EU OTHER_RECEIPTS_IN_CASH_EU OTHER_RECEIPTS_IN_KIND_EU SALE_OF_TURF_VALUE_EU USED_IN_HOUSE_OTHER_EU MISC_GRANTS_SUBSIDIES_EU PROTEIN_PAYMENTS_TOTAL_EU SHEEP_WELFARE_SCHEME_TOTAL_EU OTHER_SUBS_PAYMENTS_TOTAL_EU LAND_LET_OUT_EU MILK_QUOTA_LET_EU SUPER_LEVY_REFUND_EU SUPER_LEVY_CHARGE_EU SINGLE_FARM_PAYMENT_NET_VALUE_EU d_inter_enterpise_transfers_eu

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

drop var*
drop s_*
drop m_*

save "`OutDataO'\farm_gross_output.dta", replace
