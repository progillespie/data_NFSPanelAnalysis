*******************************************
* Create Allocation of Concentrates
*******************************************




** I_CONCENTRATES_FED_DAIRY

gen temp_conc_fed = 1 if CROP_CODE == 1110 | CROP_CODE == 1111 | CROP_CODE == 1112 | CROP_CODE == 1113 | CROP_CODE == 1116 | CROP_CODE == 1117 | CROP_CODE == 1130 | CROP_CODE == 1131 | CROP_CODE == 1133 | CROP_CODE == 1140 | CROP_CODE == 1141 | CROP_CODE == 1146 | CROP_CODE == 1147 | CROP_CODE == 1150 | CROP_CODE == 1151 | CROP_CODE == 1153 | CROP_CODE == 1156 | CROP_CODE == 1157 | CROP_CODE == 1160 | CROP_CODE == 1161 | CROP_CODE == 1166 | CROP_CODE == 1190 | CROP_CODE == 1191 | CROP_CODE == 1196 | CROP_CODE == 1570 | CROP_CODE == 1571 | CROP_CODE == 1576 | CROP_CODE == 1577 | CROP_CODE == 1280 | CROP_CODE == 1281 | CROP_CODE == 1283 | CROP_CODE == 1286   
replace temp_conc_fed = 0 if temp_conc_fed == .

gen i_concentrates_fed_dairy = (FED_DAIRY_TONNES_HA / FED_TOTAL_TONNES_HA) * (OP_INV_FED_VALUE_EU + CY_FED_VALUE_EU) if temp_conc_fed == 1 
replace i_concentrates_fed_dairy = 0 if i_concentrates_fed_dairy  == .

gen I_CONCENTRATES_FED_DAIRY = i_concentrates_fed_dairy

* Don't have I_CONCENTRATES_FED_DAIRY in the data. Taken out of following loop
foreach var in  FED_DAIRY_TONNES_HA FED_TOTAL_TONNES_HA OP_INV_FED_VALUE_EU CY_FED_VALUE_EU I_CONCENTRATES_FED_DAIRY {
	replace `var' = 0 if `var' == .
}


** I_CONCENTRATES_FED_CATTLE

gen i_concentrates_fed_cattle = (FED_CATTLE_TONNES_HA / FED_TOTAL_TONNES_HA) * (OP_INV_FED_VALUE_EU + CY_FED_VALUE_EU) if temp_conc_fed == 1 
replace i_concentrates_fed_cattle = 0 if i_concentrates_fed_cattle == .

replace FED_CATTLE_TONNES_HA = 0 if FED_CATTLE_TONNES_HA == .
replace i_concentrates_fed_cattle = 0 if i_concentrates_fed_cattle == .

* CHANGE-7983: assign Stata derived var (no sys. var to test against)
gen I_CONCENTRATES_FED_CATTLE = i_concentrates_fed_cattle 




** I_CONCENTRATES_FED_SHEEP

gen i_concentrates_fed_sheep = (FED_SHEEP_TONNES_HA / FED_TOTAL_TONNES_HA) * (OP_INV_FED_VALUE_EU + CY_FED_VALUE_EU) if temp_conc_fed == 1 
replace i_concentrates_fed_sheep = 0 if i_concentrates_fed_sheep == .

replace FED_SHEEP_TONNES_HA = 0 if FED_SHEEP_TONNES_HA == .
replace i_concentrates_fed_sheep = 0 if i_concentrates_fed_sheep == .

* CHANGE-7983: assign Stata derived var (no sys. var to test against)
gen I_CONCENTRATES_FED_SHEEP = i_concentrates_fed_sheep




** I_CONCENTRATES_FED_PIGS

gen i_concentrates_fed_pigs = (FED_PIGS_TONNES_HA / FED_TOTAL_TONNES_HA) * (OP_INV_FED_VALUE_EU + CY_FED_VALUE_EU) if temp_conc_fed == 1 | CROP_CODE == 1270 | CROP_CODE == 1271 | CROP_CODE == 1273 | CROP_CODE == 1276 | CROP_CODE == 1277 
replace i_concentrates_fed_pigs = 0 if i_concentrates_fed_pigs == .

replace FED_PIGS_TONNES_HA = 0 if FED_PIGS_TONNES_HA == .
replace i_concentrates_fed_pigs = 0 if i_concentrates_fed_pigs == .

* CHANGE-7983: assign Stata derived var (no sys. var to test against)
gen I_CONCENTRATES_FED_PIGS = i_concentrates_fed_pigs




** I_CONCENTRATES_FED_POULTRY

gen i_concentrates_fed_poultry = (FED_POULTRY_TONNES_HA / FED_TOTAL_TONNES_HA) * (OP_INV_FED_VALUE_EU + CY_FED_VALUE_EU) if temp_conc_fed == 1 
replace i_concentrates_fed_poultry = 0 if i_concentrates_fed_poultry == .

replace FED_POULTRY_TONNES_HA = 0 if FED_POULTRY_TONNES_HA == .
replace i_concentrates_fed_poultry= 0 if i_concentrates_fed_poultry== .

* CHANGE-7983: assign Stata derived var (no sys. var to test against)
gen I_CONCENTRATES_FED_POULTRY = i_concentrates_fed_poultry




** I_CONCENTRATES_FED_HORSES

gen i_concentrates_fed_horses = (FED_HORSES_TONNES_HA / FED_TOTAL_TONNES_HA) * (OP_INV_FED_VALUE_EU + CY_FED_VALUE_EU) if temp_conc_fed == 1 
replace i_concentrates_fed_horses = 0 if i_concentrates_fed_horses == .

replace FED_HORSES_TONNES_HA = 0 if FED_HORSES_TONNES_HA == .
replace i_concentrates_fed_horses = 0 if i_concentrates_fed_horses == .

* CHANGE-7983: assign Stata derived var (no sys. var to test against)
gen I_CONCENTRATES_FED_HORSES = i_concentrates_fed_horses




** I_TOTAL_AND_HOME_GROWN_SEED_EU
gen total_eu = CROP_PROTECTION_EU + PURCHASED_SEED_EU + TRANSPORT_GROSS_COST_EU + TRANSPORT_SUBSIDY_EU + MACHINERY_HIRE_EU + MISCELLANEOUS_EU
replace total_eu = 0 if total_eu == .

gen i_total_and_home_grown_seed_eu = total_eu +  HOME_GROWN_SEED_VALUE_EU
replace i_total_and_home_grown_seed_eu = 0 if i_total_and_home_grown_seed_eu == .
