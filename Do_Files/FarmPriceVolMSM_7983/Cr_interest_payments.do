*******************************************
* Create interest_payments_incl_hp_interest
*******************************************

* CHANGE-7983: create 0 variables
gen HP_TOTAL_REPAYMENTS_EU = 0


by  FARM_CODE YE_AR: egen s_TERM_TOTAL_INTEREST_DEBITED_EU = sum(TERM_TOTAL_INTEREST_DEBITED_EU)
by  FARM_CODE YE_AR: egen s_HP_TOTAL_REPAYMENTS_EU = sum(HP_TOTAL_REPAYMENTS_EU)

by  FARM_CODE YE_AR: egen rnk = rank(YE_AR),unique

keep if rnk == 1

drop rnk

keep  FARM_CODE YE_AR s_TERM_TOTAL_INTEREST_DEBITED_EU s_HP_TOTAL_REPAYMENTS_EU

sort FARM_CODE YE_AR

mvencode *, mv(0) override

gen d_intrst_pay_incl_hp_interest_eu = 0
replace d_intrst_pay_incl_hp_interest_eu = s_TERM_TOTAL_INTEREST_DEBITED_EU + (s_HP_TOTAL_REPAYMENTS_EU * 0.07)
