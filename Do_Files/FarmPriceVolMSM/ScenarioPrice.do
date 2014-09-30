local lvar1 = "$var1"

local vlist0 = "s_c_FERT_USED_VALUE CY_SALES CY_FED CY_CLOSING OP_INV_SALES OP_INV_FED OP_INV_SEED OP_INV_CLOSING OP_INV CROP_PROTECTION PURCHASED_SEED TRANSPORT_GROSS_COST TRANSPORT_SUBSIDY MACHINERY_HIRE MISCELLANEOUS"

foreach var in `vlist0' {
	if "`lvar1'" == "`var'" {
		qui replace dp`var' = 1.1
	}
}

local prvlist0 = "FAT_LAMBS_SALES STORE_LAMBS_SALES FAT_HOGGETS_SALES BREEDING_HOGGETS_SALES CULL_EWES_RAMS_SALES BREEDING_EWES_SALES USED_IN_HOUSE STORE_LAMBS_PURCHASES EWES_RAMS_PURCHASES BREEDING_HOGGETS_PURCHASES"
foreach var in `prvlist0' {
	if "`lvar1'" == "`var'" {
		qui replace dp`var' = 1.1
	}
}


local prvlist1 = "DAIRY_CALVES_TRANSFER DAIRY_CALVES_SALES DY_COWS_SH_BULS_TRNSFR_OUT DY_COWS_SH_BULLS_PURCHASES DY_COWS_SH_BULS_TRNSFR_IN CATTLE_CALVES_SALES CATTLE_WEANLINGS_SALES"
foreach var in `prvlist1' {
	if "`lvar1'" == "`var'" {
		qui replace dp`var' = 1.1
	}
}

local prvlist2 = "CATTLE_STORES_MALE_SALES CATTLE_STORES_FEMALE_SALES CATTLE_FINISHED_MALE_SALES CTL_FINISHED_FEMALE_SALES CTL_BREEDING_ANIMALS_SALES CATTLE_OTHER_SALES CTL_BREDING_HRD_CULS_SALES"
foreach var in `prvlist2' {
	if "`lvar1'" == "`var'" {
		qui replace dp`var' = 1.1
	}
}

local prvlist3 = "CATTLE_CALVES_PURCHASES CATTLE_WEANLINGS_PURCHASES CTL_STORES_MALE_PURCHASES CTL_STORES_FMALE_PURCHASES CTL_BREED_REPLCMENTS_PURCH CATTLE_OTHER_PURCHASES"
foreach var in `prvlist3' {
	if "`lvar1'" == "`var'" {
		qui replace dp`var' = 1.1
	}
}


local prvlist4 = "s_b_ALLOC_DAIRY_HERD s_b_ALLOC_CATTLE s_b_ALLOC_SHEEP s_b_ALLOC_HORSES s_b_ALLOC_DEER s_b_ALLOC_GOATS"
foreach var in `prvlist4' {
	if "`lvar1'" == "`var'" {
		qui replace dp`var' = 1.1
	}
}

local prvlist5 = "CONC_PURCHASED_50KGBAGS CONC_ALLC_DARY_HRD_50KGBGS CONC_ALLOC_CATTLE_50KGBAGS CONC_ALLOC_SHEEP_50KGBAGS CONC_ALLOC_HORSES_50KGBAGS CONC_ALLOC_PIGS_50KGBAGS CONC_ALLOC_PLTRY_50KGBAGS"
foreach var in `prvlist5' {
	if "`lvar1'" == "`var'" {
		qui replace dp`var' = 1.1
	}
}

local prvlist6 = "TRANSPORT_ALLOC_DAIRY_HERD TRANSPORT_ALLOC_CATTLE TRANSPORT_ALLOC_SHEEP TRANSPORT_ALLOC_HORSES TRANSPORT_ALLOC_PIGS TRANSPORT_ALLOC_POULTRY"
foreach var in `prvlist6' {
	if "`lvar1'" == "`var'" {
		qui replace dp`var' = 1.1
	}
}

local prvlist7 = "VET_MED_ALLOC_DAIRY_HERD VET_MED_ALLOC_CATTLE VET_MED_ALLOC_SHEEP VET_MED_ALLOC_HORSES VET_MED_ALLOC_PIGS VET_MED_ETC_ALLOC_POULTRY"
foreach var in `prvlist7' {
	if "`lvar1'" == "`var'" {
		qui replace dp`var' = 1.1
	}
}

local prvlist8 = "AI_SR_FEES_ALOC_DAIRY_HRD AI_SER_FEES_ALLOC_CATTLE AI_SER_FEES_ALLOC_SHEEP AI_SER_FEES_ALLOC_HORSES AI_SER_FEES_ALLOC_PIGS"
foreach var in `prvlist8' {
	if "`lvar1'" == "`var'" {
		qui replace dp`var' = 1.1
	}
}

local prvlist9 = "MISC_ALLOC_DAIRY_HERD MISCELLANEOUS_ALLOC_CATTLE MISCELLANEOUS_ALLOC_SHEEP MISCELLANEOUS_ALLOC_HORSES MISCELLANEOUS_ALLOC_PIGS MISC_ALLOC_POULTRY"
foreach var in `prvlist9' {
	if "`lvar1'" == "`var'" {
		qui replace dp`var' = 1.1
	}
}

local prvlist10 = "WHLE_MILK_SOLD_TO_CREAMERY LQDMLK_SOLD_WSALE_RETAIL"
foreach var in `prvlist10' {
	if "`lvar1'" == "`var'" {
		qui replace dp`var' = 1.1
	}
}


