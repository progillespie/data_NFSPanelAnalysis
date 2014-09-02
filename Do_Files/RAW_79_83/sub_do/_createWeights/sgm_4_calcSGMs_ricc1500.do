* This file uses SGM vars and SGM coefficients to calculate
*  category and whole farm SGMs for the NFS/FADN
*  farm typology. 

local origdatadir "D:\\Data/data_NFSPanelAnalysis/OrigData/FarmPriceVolMSM"
local outdatadir "D:/Data/data_NFSPanelAnalysis/OutData"

 
local cat_sgms ""

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

capture drop SGM_`category'
egen SGM_`category' = rowtotal(`vlist')
replace SGM_`category'= SGM_`category' * `coef_var'   

local cat_sgms "`cat_sgms' SGM_`category'"



* - - - - - - - - - - - - - - - - - - - - - - - - - - -
* Barley
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category   "Barley"
local coef_var  "d04_ecu_per_ha "
local crop_codes "1141 1146 1571 1147 1577"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local vlist ""
foreach code of local crop_codes{
    local vlist "`vlist' CY_HECTARES_HA`code'"
    capture confirm variable CY_HECTARES_HA`code'
    if _rc!=0 gen CY_HECTARES_HA`code' = 0
}

capture drop SGM_`category'
egen SGM_`category' = rowtotal(`vlist')
replace SGM_`category'= SGM_`category' * `coef_var'   

local cat_sgms "`cat_sgms' SGM_`category'"



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

capture drop SGM_`category'
egen SGM_`category'= rowtotal(`vlist')
replace SGM_`category'= SGM_`category' * `coef_var'

local cat_sgms "`cat_sgms' SGM_`category'"



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

capture drop SGM_`category'
egen SGM_`category'= rowtotal(`vlist')
replace SGM_`category'= SGM_`category' * `coef_var'

local cat_sgms "`cat_sgms' SGM_`category'"



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

capture drop SGM_`category'
egen SGM_`category'= rowtotal(`vlist')
replace SGM_`category'= SGM_`category' * `coef_var'

local cat_sgms "`cat_sgms' SGM_`category'"



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

capture drop SGM_`category'
egen SGM_`category' = rowtotal(`vlist')
replace SGM_`category'= SGM_`category' * `coef_var'   

local cat_sgms "`cat_sgms' SGM_`category'"



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

capture drop SGM_`category'
egen SGM_`category' = rowtotal(`vlist')
replace SGM_`category'= SGM_`category' * `coef_var'   

*local cat_sgms "`cat_sgms' SGM_`category'"



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

capture drop SGM_`category'
egen SGM_`category' = rowtotal(`vlist')
replace SGM_`category'= SGM_`category' * `coef_var'   

local cat_sgms "`cat_sgms' SGM_`category'"



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

capture drop SGM_`category'
egen SGM_`category' = rowtotal(`vlist')
replace SGM_`category'= SGM_`category' * `coef_var'   

local cat_sgms "`cat_sgms' SGM_`category'"



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

capture drop SGM_`category'
egen SGM_`category' = rowtotal(`vlist')
replace SGM_`category'= SGM_`category' * `coef_var'   

local cat_sgms "`cat_sgms' SGM_`category'"



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

capture drop SGM_`category'
egen SGM_`category' = rowtotal(`vlist')
replace SGM_`category'= SGM_`category' * `coef_var'   

*local cat_sgms "`cat_sgms' SGM_`category'"



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

capture drop SGM_`category'
egen SGM_`category' = rowtotal(`vlist')
replace SGM_`category'= SGM_`category' * `coef_var'   

*local cat_sgms "`cat_sgms' SGM_`category'"



* - - - - - - - - - - - - - - - - - - - - - - - - - - -
*Permanent grassland and meadow - pasture and meadow
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "Pasture"
local coef_var "f01_ecu_per_ha"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
capture drop SGM_`category'
gen SGM_`category' = . 
replace SGM_`category' = TOTAL_PASTURE_HA
replace SGM_`category'= SGM_`category' * `coef_var'   

*local cat_sgms "`cat_sgms' SGM_`category'"



* - - - - - - - - - - - - - - - - - - - - - - - - - - -
*Permanent grassland and meadow - rough grazings
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "RoughGrazing"
local coef_var "f02_ecu_per_ha"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
capture drop SGM_`category'
gen SGM_`category' = . 
replace SGM_`category' = ROUGH_GRAZING_HA
replace SGM_`category'= SGM_`category' * `coef_var'   

*local cat_sgms "`cat_sgms' SGM_`category'"



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

capture drop SGM_`category'
egen SGM_`category' = rowtotal(`vlist')
replace SGM_`category'= SGM_`category' * `coef_var'   

local cat_sgms "`cat_sgms' SGM_`category'"



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

capture drop SGM_`category'
egen SGM_`category' = rowtotal(`vlist')
replace SGM_`category'= SGM_`category' * `coef_var'   
* Mushroom coefficient is in 100 m2 terms
* CY_HECTARES_HA looks like it's actually in 100 m2 (largest
*  values are in the thousands!
replace SGM_`category'= SGM_`category'

local cat_sgms "`cat_sgms' SGM_`category'"



* - - - - - - - - - - - - - - - - - - - - - - - - - - -
*Set aside land - left fallow
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "SetAside"
local coef_var "i06a_ecu_per_ha"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
capture drop SGM_`category'
gen double SGM_`category' = .
replace SGM_`category' = FALLOW_SETASIDE_HA
replace SGM_`category'= SGM_`category' * `coef_var'   

local cat_sgms "`cat_sgms' SGM_`category'"



* - - - - - - - - - - - - - - - - - - - - - - - - - - -
*Equidae
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "Equidae"
local coef_var "j01_ecu_per_head"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
capture drop SGM_`category'
gen double SGM_`category' = .
replace SGM_`category' = D_HORSES_FOR_SGMS_AVGNO
replace SGM_`category'= SGM_`category' * `coef_var'   

local cat_sgms "`cat_sgms' SGM_`category'"



* - - - - - - - - - - - - - - - - - - - - - - - - - - -
*Bovine under one year old - total
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "BovineLT1"
local coef_var "j02_ecu_per_head"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
capture drop SGM_`category'
gen double SGM_`category' = .
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
* Only surplus calves are counted! Defined as 
*  calves - dairy cows - other cows 
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
mvencode D_LT1YR_FOR_SO_AVGNO  ///
         D_HERD_SIZE_AVG_NO    ///
         D_COWS_AVG_NO         ///
  , mv(0) override

replace SGM_`category' = ///
  D_LT1YR_FOR_SO_AVGNO    - ///
  D_HERD_SIZE_AVG_NO      - ///
  D_COWS_AVG_NO
replace SGM_`category' = 0 if SGM_`category' < 0 
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
replace SGM_`category'= SGM_`category' * `coef_var'   

local cat_sgms "`cat_sgms' SGM_`category'"



* - - - - - - - - - - - - - - - - - - - - - - - - - - -
*Bovine under 2 years - males
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "Bovine1_2M"
local coef_var "j03_ecu_per_head"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
capture drop SGM_`category'
gen double SGM_`category' = .
replace SGM_`category' = D_MALE_CATTLE_1_2YRS_AVG_NO
replace SGM_`category'= SGM_`category' * `coef_var' if year > 1983
* DONE: this category doesn't exist for 79-83 data, turn on for > 83

local cat_sgms "`cat_sgms' SGM_`category'"



* - - - - - - - - - - - - - - - - - - - - - - - - - - -
*Bovine under 2 years - females
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "Bovine1_2F"
local coef_var "j04_ecu_per_head"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
capture drop SGM_`category'
gen double SGM_`category' = .
replace SGM_`category' = D_FEMALE_CATTLE_1_2YRS_AVG_NO 
replace SGM_`category'= SGM_`category' * `coef_var' if year > 1983  
* DONE: this category doesn't exist for 79-83 data, turn on for > 83

local cat_sgms "`cat_sgms' SGM_`category'"



* - - - - - - - - - - - - - - - - - - - - - - - - - - -
*Bovine 2 years and older - males
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "BovineGT2M"
local coef_var "j05_ecu_per_head"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
capture drop SGM_`category'
gen double SGM_`category' = .
replace SGM_`category' = D_MALEGT2YRS_FOR_SGMS_AVGNO
replace SGM_`category'= SGM_`category' * `coef_var' if year > 1983   
* DONE: this category doesn't exist for 79-83 data, turn on for > 83

local cat_sgms "`cat_sgms' SGM_`category'"



* - - - - - - - - - - - - - - - - - - - - - - - - - - -
*Heifers, 2 years and older
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "BovineGT2F"
local coef_var "j06_ecu_per_head"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
capture drop SGM_`category'
gen double SGM_`category' = .
replace SGM_`category' = D_FEMALEGT2YRS_FOR_SGMS_AVGNO
replace SGM_`category'= SGM_`category' * `coef_var' if year > 1983
* DONE: this category doesn't exist for 79-83 data, turn on for > 84

local cat_sgms "`cat_sgms' SGM_`category'"



* - - - - - - - - - - - - - - - - - - - - - - - - - - -
*Dairy cows
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "DairyCows"
local coef_var "j07_ecu_per_head"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
capture drop SGM_`category'
gen double SGM_`category' = .
replace SGM_`category' = D_HERD_SIZE_AVG_NO
replace SGM_`category'= SGM_`category' * `coef_var'   

local cat_sgms "`cat_sgms' SGM_`category'"



* - - - - - - - - - - - - - - - - - - - - - - - - - - -
*Bovine 2 years old and over - other cows
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "OtherCows"
local coef_var "j08_ecu_per_head"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
capture drop SGM_`category'
gen double SGM_`category' = .
replace SGM_`category' = D_COWS_AVG_NO
replace SGM_`category'= SGM_`category' * `coef_var'   

local cat_sgms "`cat_sgms' SGM_`category'"



* - - - - - - - - - - - - - - - - - - - - - - - - - - -
*Sheep - total
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "Sheep"
local coef_var "j09_ecu_per_head"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
capture drop SGM_`category'
gen double SGM_`category' = .
replace SGM_`category' = D_TOTAL_SHEEP_AVG_NO
replace SGM_`category' = D_EWES_AVG_NO ///
  if D_EWES_AVG_NO > 0
replace SGM_`category'= SGM_`category' * `coef_var'   

*local cat_sgms "`cat_sgms' SGM_`category'"



* - - - - - - - - - - - - - - - - - - - - - - - - - - -
*Sheep - breeding females
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "SheepBreedingF"
local coef_var "j09a_ecu_per_head"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
capture drop SGM_`category'
gen double SGM_`category' = .
replace SGM_`category' = D_EWES_AVG_NO
replace SGM_`category'= SGM_`category' * `coef_var'   

local cat_sgms "`cat_sgms' SGM_`category'"



* - - - - - - - - - - - - - - - - - - - - - - - - - - -
*Sheep, others
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "SheepOthers"
local coef_var "j09b_ecu_per_head"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
capture drop SGM_`category'
gen double SGM_`category' = .
replace SGM_`category' = D_SHEEP_FOR_SGMS_AVGNO
replace SGM_`category' = 0 ///
  if D_EWES_AVG_NO > 0
replace SGM_`category'= SGM_`category' * `coef_var'   

local cat_sgms "`cat_sgms' SGM_`category'"



* - - - - - - - - - - - - - - - - - - - - - - - - - - -
*Pigs - piglets under 20 kg
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "PigsLT20kg"
local coef_var "j11_ecu_per_head"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
capture drop SGM_`category'
gen double SGM_`category' = .
replace SGM_`category' = D_WEANERS_AVG_NO
replace SGM_`category' = D_FEMALE_PIGS_FOR_SGMS_AVGNO ///
  if D_FEMALE_PIGS_FOR_SGMS_AVGNO > 0
replace SGM_`category'= SGM_`category' * `coef_var'   

local cat_sgms "`cat_sgms' SGM_`category'"



* - - - - - - - - - - - - - - - - - - - - - - - - - - -
*Pigs - breeding sows over 50 kg
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "PigsGT50kg"
local coef_var "j12_ecu_per_head"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
capture drop SGM_`category'
gen double SGM_`category' = .
replace SGM_`category' = D_FEMALE_PIGS_FOR_SGMS_AVGNO
replace SGM_`category'= SGM_`category' * `coef_var'   

local cat_sgms "`cat_sgms' SGM_`category'"



* - - - - - - - - - - - - - - - - - - - - - - - - - - -
*Pigs - others
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "PigsOther"
local coef_var "j13_ecu_per_head"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
capture drop SGM_`category'
gen double SGM_`category' = .
replace SGM_`category' = D_BOARS_PIGSGT20KG_SGMS_AVGNO
replace SGM_`category' = 0 ///
  if D_FEMALE_PIGS_FOR_SGMS_AVGNO > 0
replace SGM_`category'= SGM_`category' * `coef_var'   

local cat_sgms "`cat_sgms' SGM_`category'"



* - - - - - - - - - - - - - - - - - - - - - - - - - - -
*Poultry - broilers
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "PoultryBroil"
local coef_var "j14_ecu_per_100_hds"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
capture drop SGM_`category'
gen double SGM_`category' = .
replace SGM_`category' = D_POULTRY1_FOR_SGMS_AVGNO
replace SGM_`category'= SGM_`category' * `coef_var'   

local cat_sgms "`cat_sgms' SGM_`category'"



* - - - - - - - - - - - - - - - - - - - - - - - - - - -
*Laying hens
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "PoultryHens"
local coef_var "j15_ecu_per_100_hds"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
capture drop SGM_`category'
gen double SGM_`category' = .
replace SGM_`category' = D_POULTRY2_FOR_SGMS_AVGNO
replace SGM_`category'= SGM_`category' * `coef_var'   

local cat_sgms "`cat_sgms' SGM_`category'"



* - - - - - - - - - - - - - - - - - - - - - - - - - - -
*Poultry - others
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
local category "PoultryOther"
local coef_var "j16_ecu_per_100_hds"
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
capture drop SGM_`category'
gen double SGM_`category' = .
replace SGM_`category' = D_POULTRY3_FOR_SGMS_AVGNO
replace SGM_`category'= SGM_`category' * `coef_var'   

local cat_sgms "`cat_sgms' SGM_`category'"



*-------------------------------------------------------------------- 
* All relevant SGM cateogories have now been calculated
*-------------------------------------------------------------------- 



*-------------------------------------------------------------------- 
* SGMs which aren't relevant for Ireland, but are needed for 
*   calculating poles
*-------------------------------------------------------------------- 
capture drop SGM_Durum
gen double SGM_Durum          = 0

capture drop SGM_Rye
gen double SGM_Rye            = 0

capture drop SGM_GrainMaize
gen double SGM_GrainMaize     = 0

capture drop SGM_Rice
gen double SGM_Rice           = 0

capture drop SGM_OtherCereals
gen double SGM_OtherCereals   = 0

capture drop SGM_VegMarket
gen double SGM_VegMarket      = 0

capture drop SGM_FlowersOutdoor
gen double SGM_FlowersOutdoor = 0

capture drop SGM_FlowersGlass
gen double SGM_FlowersGlass   = 0

capture drop SGM_Seeds
gen double SGM_Seeds          = 0

capture drop SGM_OtherCrops
gen double SGM_OtherCrops     = 0

capture drop SGM_FruitBerry
gen double SGM_FruitBerry     = 0

capture drop SGM_Citrus
gen double SGM_Citrus         = 0

capture drop SGM_Olive
gen double SGM_Olive          = 0

capture drop SGM_Vineyards
gen double SGM_Vineyards      = 0

capture drop SGM_OtherPerm
gen double SGM_OtherPerm      = 0

capture drop SGM_PermGlass
gen double SGM_PermGlass      = 0

capture drop SGM_GoatsBreedF
gen double SGM_GoatsBreedF    = 0

capture drop SGM_GoatsOther
gen double SGM_GoatsOther     = 0

capture drop SGM_Rabbits
gen double SGM_Rabbits        = 0

capture drop SGM_Bees
gen double SGM_Bees           = 0

*-------------------------------------------------------------------- 



*-------------------------------------------------------------------- 
* Calculate poles 
*-------------------------------------------------------------------- 


* Ensure terms of equations are not missing
mvencode SGM_*, mv(0) override

capture drop P45
gen     P45  =        ///
  SGM_BovineLT1        + ///  
  SGM_Bovine1_2F       + ///
  SGM_BovineGT2F       + ///
  SGM_DairyCows

capture drop P46
gen     P46  =        ///
  P45                  + ///
  SGM_Bovine1_2M       + ///
  SGM_BovineGT2M       + ///
  SGM_OtherCows

capture drop GL
gen     GL   =        ///
  SGM_Equidae          + ///
  P46                  + /// 
  SGM_SheepBreedingF   + ///
  SGM_SheepOthers      + ///
  SGM_GoatsBreedF      + ///
  SGM_GoatsOther       



*- - - - - - - - - - - - - - - - - - 
* FCP1, FCP4, & P17 (conditionals)
*- - - - - - - - - - - - - - - - - - 

* Initialise at the base case (GL = 0, should be no neg!)

capture drop FCP1
gen     FCP1 =        ///
  SGM_FodderRoots      + ///
  SGM_GreenMaize       + ///
  SGM_OtherGreenFodder + /// 
  SGM_Pasture          + ///
  SGM_RoughGrazing

capture drop FCP4 
gen     FCP4 =        0

capture drop P17
gen     P17 =         ///
  SGM_Potatoes         + ///
  SGM_SugarBeet        + ///
  SGM_FodderRoots



* Replace for the case of GL>0

replace FCP1 =         0 ///
    if GL > 0

replace FCP4 =        ///
  SGM_FodderRoots      + ///
  SGM_GreenMaize       + ///
  SGM_OtherGreenFodder + ///
  SGM_Pasture          + ///
  SGM_RoughGrazing       ///
    if GL > 0

replace P17  =        ///
  SGM_Potatoes         + ///
  SGM_SugarBeet          ///
    if GL > 0

*- - - - - - - - - - - - - - - - - - 
* End - FCP1, FCP4, & P17 
*- - - - - - - - - - - - - - - - - - 



capture drop P151
gen     P151 =        ///
  SGM_CommonWheat      + ///
  SGM_Durum            + ///
  SGM_Rye              + ///
  SGM_Barley           + ///
  SGM_Oats             + ///
  SGM_GrainMaize       + ///
  SGM_OtherCereals

capture drop P15
gen     P15  =        ///
  P151                 + ///
  SGM_Rice

* Differs from document. Just crop codes 1431 & 1436.
capture drop P16
gen     P16  = SGM_Oilseed 

capture drop P51
gen     P51  =        /// 
  SGM_PigsLT20kg       + ///
  SGM_PigsGT50kg       + ///
  SGM_PigsOther 

capture drop P52
gen     P52  =        ///
  SGM_PoultryBroil     + ///
  SGM_PoultryHens      + ///
  SGM_PoultryOther

* Adapted from doc to match just what's relevant to IE.
capture drop P1
gen     P1   =        ///
  P15                  + ///
  SGM_Peas             + /// = Pulses
  SGM_Potatoes         + ///
  SGM_SugarBeet        + ///
  P16                  + ///
  SGM_VegOpenField     + ///
  SGM_Seeds            + ///
  SGM_SetAside         + ///
  FCP1 

capture drop P2
gen     P2   =        ///
  SGM_VegMarket        + ///
  SGM_VegUnderGlass    + ///
  SGM_FlowersOutdoor   + ///
  SGM_FlowersGlass     + ///
  SGM_Mushrooms        + ///
  SGM_Nurseries

capture drop P3
gen     P3   =        ///
  SGM_FruitBerry       + ///
  SGM_Citrus           + ///
  SGM_Olive            + ///
  SGM_Vineyards        + ///
  SGM_OtherPerm        + ///
  SGM_PermGlass

capture drop P4
gen     P4   =        ///
  GL                   + ///
  FCP4

capture drop P5
gen     P5   =        ///
  P51                  + ///
  P52                  + ///
  SGM_Rabbits        



local cat_sgms "`cat_sgms' FCP1 "


*-------------------------------------------------------------------- 
* Calculate whole farm SGMs
*-------------------------------------------------------------------- 


* Pole method
mvencode P1 P2 P3 P4 P5 SGM_Bees, mv(0) override
capture drop SGM_Farm
gen SGM_Farm = P1 + P2 + P3 + P4 + P5 + SGM_Bees




* Compare my calculated whole farm SGMs to the system calculate one
*  where possible. 
tw sc SGM_Farm TOTAL_SGMS if TOTAL_SGMS > 0 ///
  , aspect(1)                               ///
    xscale(range(0 500000))                 ///
    yscale(range(0 500000))

*TODO: I'm systematically overestimating the total SGMs. 
*       Check with Brian.
