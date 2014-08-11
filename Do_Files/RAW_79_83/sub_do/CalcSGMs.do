* This file uses SGM vars and SGM coefficients to calculate
*  category, enterprise, and whole farm SGMs for the NFS/FADN
*  farm typology. 

local outdatadir "D:/Data/data_NFSPanelAnalysis/OutData"

/*
qui do CreateSGMcoefs.do // Will leave coefs in dta, ready to merge

use `outdatadir'/nfs_7983.dta, clear
* TODO: Once I can ID regions, assign SGMregion to each farm
gen SGMregion = 1 // TODO: remove this ad-hoc assignment
sort year SGMregion
merge m:1 year SGMregion using "D:/Data/data_EUROSTAT/OutData/RAW_79_83/SGM_coef_7311.dta"
* TODO: Once I can ID regions, remove SGMregion > 1 condition
drop if year > 1983 | year < 1979 | SGMregion > 1



qui do CreateSGMvars.do

save `outdatadir'/tempSGM.dta
*/


use `outdatadir'/tempSGM.dta, clear



*-------------------------------------------------------------------- 
* Calculate SGMs
*-------------------------------------------------------------------- 

* - - - - - - - - - - - - - - - - - - - - - - - - - - -
* Common wheat and spelt
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "CommonWheat"
local coef_var "d01_ecu_per_ha"
local crop_codes "1111 1116 1117"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local vlist ""
foreach code of local crop_codes{
    local vlist "`vlist' CY_HECTARES_HA`code'"
    capture confirm variable CY_HECTARES_HA`code'
    if _rc!=0 gen CY_HECTARES_HA`code' = 0

}

egen SGM_`category' = rowtotal(`vlist')
replace SGM_`category'= SGM_`category' * `coef_var'   




* - - - - - - - - - - - - - - - - - - - - - - - - - - -
* Barley
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category   "Barley"
local coef_code  "d04_ecu_per_ha "
local crop_codes "1141 1146 1571 1147 1577"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local vlist ""
foreach code of local crop_codes{
    local vlist "`vlist' CY_HECTARES_HA`code'"
    capture confirm variable CY_HECTARES_HA`code'
    if _rc!=0 gen CY_HECTARES_HA`code' = 0
}

egen SGM_`category' = rowtotal(`vlist')
replace SGM_`category'= SGM_`category' * `coef_var'   



* - - - - - - - - - - - - - - - - - - - - - - - - - - -
* Oats
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "Oats"
local coef_var "d05_ecu_per_ha"
local crop_codes "1151 1156 1157"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local vlist ""
foreach code of local crop_codes{
    local vlist "`vlist' CY_HECTARES_HA`code'"
    capture confirm variable CY_HECTARES_HA`code'
    if _rc!=0 gen CY_HECTARES_HA`code' = 0
}

egen SGM_`category'= rowtotal(`vlist')
replace SGM_`category'= SGM_`category' * `coef_var'



* - - - - - - - - - - - - - - - - - - - - - - - - - - -
* Peas, field beans and sweet lupines
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "Peas"
local coef_var "d09e_1_ecu_per_ha"
local crop_codes "1211 1271 1291"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local vlist ""
foreach code of local crop_codes{
    local vlist "`vlist' CY_HECTARES_HA`code'"
    capture confirm variable CY_HECTARES_HA`code'
    if _rc!=0 gen CY_HECTARES_HA`code' = 0
}

egen SGM_`category'= rowtotal(`vlist')
replace SGM_`category'= SGM_`category' * `coef_var'



* - - - - - - - - - - - - - - - - - - - - - - - - - - -
* Potatoes
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "Potatoes"
local coef_var "d10_ecu_per_ha"
local crop_codes "1311 1317"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local vlist ""
foreach code of local crop_codes{
    local vlist "`vlist' CY_HECTARES_HA`code'"
    capture confirm variable CY_HECTARES_HA`code'
    if _rc!=0 gen CY_HECTARES_HA`code' = 0
}

egen SGM_`category'= rowtotal(`vlist')
replace SGM_`category'= SGM_`category' * `coef_var'



* - - - - - - - - - - - - - - - - - - - - - - - - - - -
* Sugar beet
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "SugarBeet"
local coef_var "d11_ecu_per_ha"
local crop_codes "1321 1327"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local vlist ""
foreach code of local crop_codes{
    local vlist "`vlist' CY_HECTARES_HA`code'"
    capture confirm variable CY_HECTARES_HA`code'
    if _rc!=0 gen CY_HECTARES_HA`code' = 0
}

egen SGM_`category' = rowtotal(`vlist')
replace SGM_`category'= SGM_`category' * `coef_var'   



* - - - - - - - - - - - - - - - - - - - - - - - - - - -
* Fodder roots and brassicas
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "FodderRoots"
local coef_var "d12_ecu_per_ha"
local crop_codes "9041 9051 9061 9071 9081"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local vlist ""
foreach code of local crop_codes{
    local vlist "`vlist' CY_HECTARES_HA`code'"
    capture confirm variable CY_HECTARES_HA`code'
    if _rc!=0 gen CY_HECTARES_HA`code' = 0
}

egen SGM_`category' = rowtotal(`vlist')
replace SGM_`category'= SGM_`category' * `coef_var'   




* - - - - - - - - - - - - - - - - - - - - - - - - - - -
* Other oil-seed or fibre plants - others
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "Oilseed"
local coef_var "d13d1d_ecu_per_ha"
local crop_codes "1431 1436"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local vlist ""
foreach code of local crop_codes{
    local vlist "`vlist' CY_HECTARES_HA`code'"
    capture confirm variable CY_HECTARES_HA`code'
    if _rc!=0 gen CY_HECTARES_HA`code' = 0
}

egen SGM_`category' = rowtotal(`vlist')
replace SGM_`category'= SGM_`category' * `coef_var'   




* - - - - - - - - - - - - - - - - - - - - - - - - - - -
* Fresh vegetables, melons, strawberries - outdoor - open field
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "VegOpenField"
local coef_var "d14a_ecu_per_ha"
local crop_codes "2211 2221 2231 2251 2261 2271 2281 2291 2311 2321 2341 2371 2381 2431 2441 2451 2461 2491 2511 2531 2601 2611 2631 2651 2991"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local vlist ""
foreach code of local crop_codes{
    local vlist "`vlist' CY_HECTARES_HA`code'"
    capture confirm variable CY_HECTARES_HA`code'
    if _rc!=0 gen CY_HECTARES_HA`code' = 0
}

egen SGM_`category' = rowtotal(`vlist')
replace SGM_`category'= SGM_`category' * `coef_var'   




* - - - - - - - - - - - - - - - - - - - - - - - - - - -
* Fresh vegetables, melons, strawberries - under glass
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "VegUnderGlass"
local coef_var "d15_ecu_per_ha"
local crop_codes "2215 2225 2235 2255 2265 2275 2285 2295 2315 2325 2345 2375 2385 2435 2445 2455 2465 2495 2515 2535 2605 2615 2635 2655 2995"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local vlist ""
foreach code of local crop_codes{
    local vlist "`vlist' CY_HECTARES_HA`code'"
    capture confirm variable CY_HECTARES_HA`code'
    if _rc!=0 gen CY_HECTARES_HA`code' = 0
}

egen SGM_`category' = rowtotal(`vlist')
replace SGM_`category'= SGM_`category' * `coef_var'   




* - - - - - - - - - - - - - - - - - - - - - - - - - - -
* Forage plants - other green fodder - green maize
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "GreenMaize"
local coef_var "d18b1_ecu_per_ha"
local crop_codes "9021"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local vlist ""
foreach code of local crop_codes{
    local vlist "`vlist' CY_HECTARES_HA`code'"
    capture confirm variable CY_HECTARES_HA`code'
    if _rc!=0 gen CY_HECTARES_HA`code' = 0
}

egen SGM_`category' = rowtotal(`vlist')
replace SGM_`category'= SGM_`category' * `coef_var'   




* - - - - - - - - - - - - - - - - - - - - - - - - - - -
*Forage plants - other green fodder - others
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "OtherGreenFodder"
local coef_var "d18b3_ecu_per_ha"
local crop_codes "9031"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local vlist ""
foreach code of local crop_codes{
    local vlist "`vlist' CY_HECTARES_HA`code'"
    capture confirm variable CY_HECTARES_HA`code'
    if _rc!=0 gen CY_HECTARES_HA`code' = 0
}

egen SGM_`category' = rowtotal(`vlist')
replace SGM_`category'= SGM_`category' * `coef_var'   




* - - - - - - - - - - - - - - - - - - - - - - - - - - -
*Permanent grassland and meadow - pasture and meadow
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "Pasture"
local coef_var "f01_ecu_per_ha"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
gen SGM_`category' = TOTAL_PASTURE_HA
replace SGM_`category'= SGM_`category' * `coef_var'   



* - - - - - - - - - - - - - - - - - - - - - - - - - - -
*Permanent grassland and meadow - rough grazings
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "RoughGrazing"
local coef_var "f02_ecu_per_ha"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
gen SGM_`category' = ROUGH_GRAZING_HA
replace SGM_`category'= SGM_`category' * `coef_var'   



* - - - - - - - - - - - - - - - - - - - - - - - - - - -
*Nurseries
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "Nurseries"
local coef_var "g05_ecu_per_ha"
local crop_codes "6011"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local vlist ""
foreach code of local crop_codes{
    local vlist "`vlist' CY_HECTARES_HA`code'"
    capture confirm variable CY_HECTARES_HA`code'
    if _rc!=0 gen CY_HECTARES_HA`code' = 0
}

egen SGM_`category' = rowtotal(`vlist')
replace SGM_`category'= SGM_`category' * `coef_var'   




* - - - - - - - - - - - - - - - - - - - - - - - - - - -
*Mushrooms
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "Mushrooms"
local coef_var "i02_ecu_per_100_m2"
local crop_codes "1391"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local vlist ""
foreach code of local crop_codes{
    local vlist "`vlist' CY_HECTARES_HA`code'"
    capture confirm variable CY_HECTARES_HA`code'
    if _rc!=0 gen CY_HECTARES_HA`code' = 0
}

egen SGM_`category' = rowtotal(`vlist')
replace SGM_`category'= SGM_`category' * `coef_var'   
* Mushroom coefficient is in 100 m2 terms, but the variable
*  measure the number of hectares (100 units of 100 m2 per
*  hectare). Multiply by 100 to get the correct SGM.
replace SGM_`category'= SGM_`category' * 100





* - - - - - - - - - - - - - - - - - - - - - - - - - - -
*Set aside land - left fallow
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "SetAside"
local coef_var "i06a_ecu_per_ha"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
gen SGM_`category' = FALLOW_SETASIDE_HA
replace SGM_`category'= SGM_`category' * `coef_var'   



* - - - - - - - - - - - - - - - - - - - - - - - - - - -
*Equidae
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "Equidae"
local coef_var "j01_ecu_per_head"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
gen SGM_`category' = D_HORSES_FOR_SGMS_AVGNO
replace SGM_`category'= SGM_`category' * `coef_var'   



* - - - - - - - - - - - - - - - - - - - - - - - - - - -
*Bovine under one year old - total
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "BovineLT1"
local coef_var "j02_ecu_per_head"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
gen SGM_`category' = D_LT1YR_FOR_SO_AVGNO
replace SGM_`category'= SGM_`category' * `coef_var'   



* - - - - - - - - - - - - - - - - - - - - - - - - - - -
*Bovine under 2 years - males
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "Bovine1_2M"
local coef_var "j03_ecu_per_head"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
*gen SGM_`category' = D_MALE_CATTLE_1_2YRS_AVG_NO
*replace SGM_`category'= SGM_`category' * `coef_var'   



* - - - - - - - - - - - - - - - - - - - - - - - - - - -
*Bovine under 2 years - females
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "Bovine1_2F"
local coef_var "j04_ecu_per_head"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
*gen SGM_`category' = D_FEMALE_CATTLE_1_2YRS_AVG_NO
*replace SGM_`category'= SGM_`category' * `coef_var'   



* - - - - - - - - - - - - - - - - - - - - - - - - - - -
*Bovine 2 years and older - males
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "BovineGT2M"
local coef_var "j05_ecu_per_head"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
*gen SGM_`category' = D_MALEGT2YRS_FOR_SGMS_AVGNO
*replace SGM_`category'= SGM_`category' * `coef_var'   



* - - - - - - - - - - - - - - - - - - - - - - - - - - -
*Heifers, 2 years and older
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "BovineGT2F"
local coef_var "j06_ecu_per_head"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
*gen SGM_`category' = D_FEMALEGT2YRS_FOR_SGMS_AVGNO
*replace SGM_`category'= SGM_`category' * `coef_var'   



* - - - - - - - - - - - - - - - - - - - - - - - - - - -
*Dairy cows
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "DairyCows"
local coef_var "j07_ecu_per_head"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
gen SGM_`category' = D_HERD_SIZE_AVG_NO
replace SGM_`category'= SGM_`category' * `coef_var'   



* - - - - - - - - - - - - - - - - - - - - - - - - - - -
*Bovine 2 years old and over - other cows
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "OtherCows"
local coef_var "j08_ecu_per_head"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
gen SGM_`category' = D_COWS_AVG_NO
replace SGM_`category'= SGM_`category' * `coef_var'   



* - - - - - - - - - - - - - - - - - - - - - - - - - - -
*Sheep - total
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "Sheep"
local coef_var "j09_ecu_per_head"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
gen SGM_`category' = D_TOTAL_SHEEP_AVG_NO
replace SGM_`category'= SGM_`category' * `coef_var'   



* - - - - - - - - - - - - - - - - - - - - - - - - - - -
*Sheep - breeding females
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "SheepBreedingF"
local coef_var "j09a_ecu_per_head"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
gen SGM_`category' = D_EWES_AVG_NO
replace SGM_`category'= SGM_`category' * `coef_var'   



* - - - - - - - - - - - - - - - - - - - - - - - - - - -
*Sheep, others
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "SheepOthers"
local coef_var "j09b_ecu_per_head"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
gen SGM_`category' = D_SHEEP_FOR_SGMS_AVGNO
replace SGM_`category'= SGM_`category' * `coef_var'   



* - - - - - - - - - - - - - - - - - - - - - - - - - - -
*Pigs - piglets under 20 kg
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "PigsLT20kg"
local coef_var "j11_ecu_per_head"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
gen SGM_`category' = D_WEANERS_AVG_NO
replace SGM_`category'= SGM_`category' * `coef_var'   



* - - - - - - - - - - - - - - - - - - - - - - - - - - -
*Pigs - breeding sows over 50 kg
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "PigsGT50kg"
local coef_var "j12_ecu_per_head"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
gen SGM_`category' = D_FEMALE_PIGS_FOR_SGMS_AVGNO
replace SGM_`category'= SGM_`category' * `coef_var'   



* - - - - - - - - - - - - - - - - - - - - - - - - - - -
*Pigs - others
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "PigsOther"
local coef_var "j13_ecu_per_head"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
gen SGM_`category' = D_BOARS_PIGSGT20KG_SGMS_AVGNO
replace SGM_`category'= SGM_`category' * `coef_var'   



* - - - - - - - - - - - - - - - - - - - - - - - - - - -
*Poultry - broilers
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "PoultryBroil"
local coef_var "j14_ecu_per_100_hds"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
gen SGM_`category' = D_POULTRY1_FOR_SGMS_AVGNO
replace SGM_`category'= SGM_`category' * `coef_var'   



* - - - - - - - - - - - - - - - - - - - - - - - - - - -
*Laying hens
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "PoultryHens"
local coef_var "j15_ecu_per_100_hds"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
gen SGM_`category' = D_POULTRY2_FOR_SGMS_AVGNO
replace SGM_`category'= SGM_`category' * `coef_var'   



* - - - - - - - - - - - - - - - - - - - - - - - - - - -
*Poultry - others
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "PoultryOther"
local coef_var "j16_ecu_per_100_hds"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
gen SGM_`category' = D_POULTRY3_FOR_SGMS_AVGNO
replace SGM_`category'= SGM_`category' * `coef_var'   
