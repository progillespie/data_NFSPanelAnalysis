* This file assigns farms to Particular Types according to the 
*   NFS/FADN Typology. Necessary SGMs are calculated on each farm. 
*   See 78/443/EEC and subsequent amendments. 



local outdatadir "D:/Data/data_NFSPanelAnalysis/OutData"

label var year "Year"

*-------------------------------------------------------------------- 
* Reference material
*-------------------------------------------------------------------- 



* - - - - - - - - - - - - - - - - - - - - - - - - - - -
* From Commission Decision 78/463/EEC
* Composition and thresholds
* - - - - - - - - - - - - - - - - - - - - - - - - - - -

* For reference to original document's formulae
*SGM_CommonWheat    E01
*SGM_Durum          E02
*SGM_Rye            E03
*SGM_Barley         E04
*SGM_Oats           E05
*SGM_GrainMaize     E06
*SGM_Rice           E07
*SGM_OtherCereals   E08
*SGM_DriedVeg       E09
*SGM_Potatoes       E10
*SGM_SugarBeet      E11
*SGM_FodderRoots    E12
*SGM_Industrial     E13
*SGM_VegOpenField   E14a
*SGM_VegMarket      E14b
*SGM_VegUnderGlass  E15
*SGM_FlowersOutdoor E16
*SGM_FlowersGlass   E17
*SGM_ForagePlants   E18
*SGM_Seeds          E19
*SGM_OtherCrops     E20
*SGM_PastureMeadow  G01
*SGM_FruitBerry     H01
*SGM_Citrus         H02
*SGM_Olive          H03
*SGM_Vineyards      H04
*SGM_Nurseries      H05
*SGM_OtherPerm      H06
*SGM_PermGlass      H07
*SGM_Equidae        K01
*SGM_BovineLT1      K02
*SGM_Bovine1_2M     K03
*SGM_Bovine1_2F     K04 
*SGM_BovineGT2M     K05 
*SGM_BovineGT2F     K06
*SGM_DairyCows      K07
*SGM_OtherCows      K08 
*SGM_Sheep          K09
*SGM_Goats          K10
*SGM_PigsLT20kg     K11
*SGM_PigsGT50kg     K12
*SGM_PigsOther      K13
*SGM_PoultryBroil   K14
*SGM_PoultryHens    K15
*SGM_PoultryOther   K16



* - - - - - - - - - - - - - - - - - - - - - - - - - - -
* Formula SGMs for which relevant Irish SGMs are parts (i.e. 
*   these categories would contain other parts in other Member States
*   but in Ireland those parts are effectively 0). 
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
capture egen double SGM_ForagePlants  = ///
  rowtotal(SGM_GreenMaize SGM_OtherGreenFodder)

capture egen double SGM_PastureMeadow = ///
  rowtotal(SGM_Pasture SGM_RoughGrazing)

capture gen  double SGM_Industrial    = SGM_Oilseed
capture gen  double SGM_DriedVeg      = SGM_Peas  

* - - - - - - - - - - - - - - - - - - - - - - - - - - -
* SGMs which aren't relevant for Ireland, but are needed for 
*   calculated Particular Types
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
capture gen double SGM_Durum          = 0
capture gen double SGM_Rye            = 0
capture gen double SGM_GrainMaize     = 0
capture gen double SGM_Rice           = 0
capture gen double SGM_OtherCereals   = 0
capture gen double SGM_VegMarket      = 0
capture gen double SGM_FlowersOutdoor = 0
capture gen double SGM_FlowersGlass   = 0
capture gen double SGM_Seeds          = 0
capture gen double SGM_OtherCrops     = 0
capture gen double SGM_FruitBerry     = 0
capture gen double SGM_Citrus         = 0
capture gen double SGM_Olive          = 0
capture gen double SGM_Vineyards      = 0
capture gen double SGM_OtherPerm      = 0
capture gen double SGM_PermGlass      = 0
capture gen double SGM_Goats          = 0



*-------------------------------------------------------------------- 
* Assignment of Particular Types
*-------------------------------------------------------------------- 

* Create empty variable for Particular Type codes. 
capture drop ParticularType
gen   int ParticularType = .
label var ParticularType ///
  "Particular Type per 78/463/EEC"


* ... and Threshold variables
capture drop Threshold*
gen double Threshold = .
gen double Threshold2= . 
gen double Threshold3= . 
label var Threshold ///
  "Threshold for farm types, overwritten for each system"
label var Threshold2 ///
  "Another threshold for farm types, overwritten for each system"



* The following code calculates the SGMs for comparing to the 
*  relevant threshold for each Particular Type, then does the 
*  comparison, and assigns fills in ParticularType85.



* - - - - - - - - - - - - - - - - - - - - - - - - - -
*111 Cereals, excluding rice
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  local var "CerealsExcRice"
  local code = 111
  local droplastdigit = int(`code'/10)
  local vlist "" //clear vlist
  local vlist "`vlist' SGM_CommonWheat"
  local vlist "`vlist' SGM_Durum"
  local vlist "`vlist' SGM_Rye"
  local vlist "`vlist' SGM_Barley"
  local vlist "`vlist' SGM_Oats"
  local vlist "`vlist' SGM_GrainMaize"
  local vlist "`vlist' SGM_OtherCereals"
  egen double SGMpart_`var' = rowtotal(`vlist')
  
  * Relevant threshold(s) 
  replace Threshold = (2/3) * SGM_Farm
  
  * Update farm type variable
  replace ParticularType = `code' ///
    if SGMpart_`var' > Threshold & ///
       PrincipalType == `droplastdigit'

  label define ParticularType `code' "`var'", modify
  label values ParticularType ParticularType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab ParticularType year, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -






* - - - - - - - - - - - - - - - - - - - - - - - - - -
*112 Rice
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  local var "Rice"
  local code = 112
  local droplastdigit = int(`code'/10)
  local vlist "" //clear vlist
  local vlist "`vlist' SGM_Rice"
  egen double SGMpart_`var' = rowtotal(`vlist')
  
  * Relevant threshold(s) 
  replace Threshold = (2/3) * SGM_Farm
  
  * Update farm type variable
  replace ParticularType = `code' ///
    if SGMpart_`var' > Threshold     & ///
       PrincipalType == `droplastdigit'

  label define ParticularType `code' "`var'", modify
  label values ParticularType ParticularType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab ParticularType year, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -






* - - - - - - - - - - - - - - - - - - - - - - - - - -
*113 Cereals, including rice
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  local var "CerealsIncRice"
  local code = 113
  local droplastdigit = int(`code'/10)
  local vlist "" //clear vlist
  local vlist "`vlist' SGM_CommonWheat"
  local vlist "`vlist' SGM_Durum"
  local vlist "`vlist' SGM_Rye"
  local vlist "`vlist' SGM_Barley"
  local vlist "`vlist' SGM_Oats"
  local vlist "`vlist' SGM_GrainMaize"
  local vlist "`vlist' SGM_Rice"
  local vlist "`vlist' SGM_OtherCereals"
  egen double SGMpart_`var' = rowtotal(`vlist')
  
  * Relevant threshold(s) 
  replace Threshold = (2/3) * SGM_Farm
  
  * Update farm type variable
  replace ParticularType = `code'       ///
    if SGMpart_`var'          >  Threshold & ///
       SGMpart_CerealsExcRice <= Threshold & ///
       SGMpart_Rice           <= Threshold & ///
       PrincipalType == `droplastdigit'

  label define ParticularType `code' "`var'", modify
  label values ParticularType ParticularType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab ParticularType year, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -






* - - - - - - - - - - - - - - - - - - - - - - - - - -
*121 Roots
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  local var "Roots"
  local code = 121
  local droplastdigit = int(`code'/10)

  local vlist "" //clear vlist
  local vlist "`vlist' SGM_Potatoes"
  local vlist "`vlist' SGM_SugarBeet"
  local vlist "`vlist' SGM_FodderRoots"
  egen double SGMpart_`var' = rowtotal(`vlist')
  
  * Relevant threshold(s) 
  replace Threshold = (2/3) * SGM_Farm
  
  * Update farm type variable
  replace ParticularType = `code' ///
    if SGMpart_`var' > Threshold & ///
       PrincipalType == `droplastdigit'

  label define ParticularType `code' "`var'", modify
  label values ParticularType ParticularType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab ParticularType year, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -






* - - - - - - - - - - - - - - - - - - - - - - - - - -
*122 Cereals and roots
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  local var "CerealsRoots"
  local code = 122
  local droplastdigit = int(`code'/10)
  local vlist "" //clear vlist
  local vlist "`vlist' SGM_CommonWheat"
  local vlist "`vlist' SGM_Durum"
  local vlist "`vlist' SGM_Rye"
  local vlist "`vlist' SGM_Barley"
  local vlist "`vlist' SGM_Oats"
  local vlist "`vlist' SGM_GrainMaize"
  local vlist "`vlist' SGM_Rice"
  local vlist "`vlist' SGM_OtherCereals"
  local vlist "`vlist' SGM_Potatoes"
  local vlist "`vlist' SGM_SugarBeet"
  local vlist "`vlist' SGM_FodderRoots"
  egen double SGMpart_`var' = rowtotal(`vlist')
  
  * Relevant threshold(s) 
  replace Threshold = (1/3) * SGM_Farm
  replace Threshold2= (2/3) * SGM_Farm
  
  * Update farm type variable
  replace ParticularType = `code'        ///
    if SGMpart_CerealsIncRice >  Threshold  & ///
       SGMpart_CerealsIncRice <= Threshold2 & ///
       SGMpart_Roots          >  Threshold  & ///
       SGMpart_Roots          <= Threshold2 & ///
       PrincipalType == `droplastdigit'

  label define ParticularType `code' "`var'", modify
  label values ParticularType ParticularType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab ParticularType year, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -






* - - - - - - - - - - - - - - - - - - - - - - - - - -
*123 Field crops, various
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  local var "FieldVarious"
  local code = 123
  local droplastdigit = int(`code'/10)
  local vlist "" //clear vlist
  local vlist "`vlist' SGM_CommonWheat"
  local vlist "`vlist' SGM_Durum"
  local vlist "`vlist' SGM_Rye"
  local vlist "`vlist' SGM_Barley"
  local vlist "`vlist' SGM_Oats"
  local vlist "`vlist' SGM_GrainMaize"
  local vlist "`vlist' SGM_Rice"
  local vlist "`vlist' SGM_OtherCereals"
  local vlist "`vlist' SGM_DriedVeg"
  local vlist "`vlist' SGM_Potatoes"
  local vlist "`vlist' SGM_SugarBeet"
  local vlist "`vlist' SGM_FodderRoots"
  local vlist "`vlist' SGM_Industrial"
  local vlist "`vlist' SGM_VegOpenField"
  local vlist "`vlist' SGM_ForagePlants"
  local vlist "`vlist' SGM_Seeds"
  local vlist "`vlist' SGM_OtherCrops"
  egen double SGMpart_`var' = rowtotal(`vlist')
  
  * Relevant threshold(s) 
  replace Threshold = (2/3) * SGM_Farm
  
  * Update farm type variable
  replace ParticularType = `code'        ///
    if SGMpart_`var' >  Threshold  & ///
       PrincipalType  != 11      & ///
       ParticularType != 121     & ///
       ParticularType != 122

  label define ParticularType `code' "`var'", modify
  label values ParticularType ParticularType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab ParticularType year, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -






* - - - - - - - - - - - - - - - - - - - - - - - - - -
*211 Market garden vegetables, open air
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  local var "VegMarket"
  local code = 211
  local droplastdigit = int(`code'/10)
  local vlist "" // clear vlist
  local vlist "`vlist' SGM_VegMarket"
  egen double SGMpart_`var' = rowtotal(`vlist')

  * Relevant threshold(s) 
  replace Threshold = (2/3) * SGM_Farm
  
  * Update farm type variable
  replace ParticularType = `code' ///
    if SGMpart_`var' > Threshold     & ///
       PrincipalType == `droplastdigit'

  label define ParticularType `code' "`var'", modify
  label values ParticularType ParticularType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab ParticularType year, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -






* - - - - - - - - - - - - - - - - - - - - - - - - - -
*212 Market garden vegetables, under glass
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  local var "VegUnderGlass"
  local code = 212
  local droplastdigit = int(`code'/10)
  local vlist "" // clear vlist
  local vlist "`vlist' SGM_VegUnderGlass"
  egen double SGMpart_`var' = rowtotal(`vlist')

  * Relevant threshold(s) 
  replace Threshold = (2/3) * SGM_Farm
  
  * Update farm type variable
  replace ParticularType = `code' ///
    if SGMpart_`var' > Threshold     & ///
       PrincipalType == `droplastdigit'

  label define ParticularType `code' "`var'", modify
  label values ParticularType ParticularType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab ParticularType year, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -






* - - - - - - - - - - - - - - - - - - - - - - - - - -
*213 Market garden vegetables, open air/under glass
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  local var "VegMarketGlass"
  local code = 213
  local droplastdigit = int(`code'/10)
  local vlist "" // clear vlist
  local vlist "`vlist' SGM_VegMarket"
  local vlist "`vlist' SGM_VegUnderGlass"
  egen double SGMpart_`var' = rowtotal(`vlist')

  * Relevant threshold(s) 
  replace Threshold = (2/3) * SGM_Farm
  
  * Update farm type variable
  replace ParticularType = `code'         ///
    if SGMpart_`var'         >  Threshold    & ///
       SGMpart_VegMarket     <= Threshold    & ///
       SGMpart_VegUnderGlass <= Threshold    & ///
       PrincipalType == `droplastdigit'

  label define ParticularType `code' "`var'", modify
  label values ParticularType ParticularType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab ParticularType year, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -






* - - - - - - - - - - - - - - - - - - - - - - - - - -
*214 Flowers, open air
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  local var "FlowersOutdoor"
  local code = 214
  local droplastdigit = int(`code'/10)
  local vlist "" // clear vlist
  local vlist "`vlist' SGM_FlowersOutdoor"
  egen double SGMpart_`var' = rowtotal(`vlist')

  * Relevant threshold(s) 
  replace Threshold = (2/3) * SGM_Farm
  
  * Update farm type variable
  replace ParticularType = `code' ///
    if SGMpart_`var' > Threshold     & ///
       PrincipalType == `droplastdigit'

  label define ParticularType `code' "`var'", modify
  label values ParticularType ParticularType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab ParticularType year, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -






* - - - - - - - - - - - - - - - - - - - - - - - - - -
*215 Flowers, under glass
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  local var "FlowersGlass"
  local code = 215
  local droplastdigit = int(`code'/10)
  local vlist "" // clear vlist
  local vlist "`vlist' SGM_FlowersGlass"
  egen double SGMpart_`var' = rowtotal(`vlist')

  * Relevant threshold(s) 
  replace Threshold = (2/3) * SGM_Farm
  
  * Update farm type variable
  replace ParticularType = `code' ///
    if SGMpart_`var' > Threshold     & ///
       PrincipalType == `droplastdigit'

  label define ParticularType `code' "`var'", modify
  label values ParticularType ParticularType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab ParticularType year, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -






* - - - - - - - - - - - - - - - - - - - - - - - - - -
*216 Flowers, open air/under glass
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  local var "FlowersOutGlass"
  local code = 216
  local droplastdigit = int(`code'/10)
  local vlist "" // clear vlist
  local vlist "`vlist' SGM_FlowersOutdoor"
  local vlist "`vlist' SGM_FlowersGlass"
  egen double SGMpart_`var' = rowtotal(`vlist')

  * Relevant threshold(s) 
  replace Threshold = (2/3) * SGM_Farm
  
  * Update farm type variable
  replace ParticularType = `code'         ///
    if SGMpart_`var'          >  Threshold    & ///
       SGMpart_FlowersOutdoor <= Threshold    & ///
       SGMpart_FlowersGlass   <= Threshold    & ///
       PrincipalType == `droplastdigit'

  label define ParticularType `code' "`var'", modify
  label values ParticularType ParticularType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab ParticularType year, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -






* - - - - - - - - - - - - - - - - - - - - - - - - - -
*217 Horticulture, various
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  local var "HortVarious"
  local code = 216
  local droplastdigit = int(`code'/10)
  local vlist "" // clear vlist
  local vlist "`vlist' SGM_VegMarket"
  local vlist "`vlist' SGM_VegUnderGlass"
  local vlist "`vlist' SGM_FlowersOutdoor"
  local vlist "`vlist' SGM_FlowersGlass"
  egen double SGMpart_`var' = rowtotal(`vlist')

  * Relevant threshold(s) 
  replace Threshold = (2/3) * SGM_Farm
  
  * Update farm type variable
  replace ParticularType = `code'         ///
    if SGMpart_`var'           >  Threshold    & ///
       SGMpart_VegMarket       <= Threshold    & ///
       SGMpart_VegUnderGlass   <= Threshold    & ///
       SGMpart_VegMarketGlass  <= Threshold    & ///
       SGMpart_FlowersOutdoor  <= Threshold    & ///
       SGMpart_FlowersGlass    <= Threshold    & ///
       SGMpart_FlowersOutGlass <= Threshold    & ///
       PrincipalType == `droplastdigit'

  label define ParticularType `code' "`var'", modify
  label values ParticularType ParticularType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab ParticularType year, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -

  




* None of the particular types associated with principal types 31 
*  and 32 are applicable to IE (SGMs always 0)

* TODO fix this cattle gender problem
capture gen int SGM_Bovine1_2M = 0
capture gen int SGM_Bovine1_2F = 0
capture gen int SGM_BovineGT2M = 0
capture gen int SGM_BovineGT2F = 0
  
  




* - - - - - - - - - - - - - - - - - - - - - - - - - -
*411 Specialized dairying
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  local var "DairySpecial"
  local code = 411
  local droplastdigit = int(`code'/10)
  
  local vlist "" //clear vlist
  local vlist "`vlist' SGM_DairyCows"
  egen double SGMpart_`var' = rowtotal(`vlist')
  
  * Relevant threshold(s) 
  replace Threshold = (2/3) * SGM_Farm
  
  * Update farm type variable
  replace ParticularType = `code' ///
    if SGMpart_`var'    > Threshold    & ///
       PrincipalType == `droplastdigit'

  label define ParticularType `code' "`var'", modify
  label values ParticularType ParticularType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab ParticularType year, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -






* - - - - - - - - - - - - - - - - - - - - - - - - - -
*412 Dairy, other
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  local var "DairyOther"
  local code = 412
  local droplastdigit = int(`code'/10)
  local vlist "" //clear vlist
  local vlist "`vlist' SGM_BovineLT1"
  local vlist "`vlist' SGM_Bovine1_2F"
  local vlist "`vlist' SGM_BovineGT2F"
  local vlist "`vlist' SGM_DairyCows"
  egen double SGMpart_`var' = rowtotal(`vlist')
  
  * Relevant threshold(s) 
  replace Threshold = (2/3) * SGM_Farm
  
  * Update farm type variable
  replace ParticularType = `code'                 ///
    if SGMpart_`var'        >  Threshold             & ///
       SGMpart_DairySpecial <= Threshold             & ///
       SGMpart_DairySpecial <= (2/3) * SGMpart_`var' & ///
       PrincipalType == `droplastdigit'

  label define ParticularType `code' "`var'", modify
  label values ParticularType ParticularType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab ParticularType year, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -






* - - - - - - - - - - - - - - - - - - - - - - - - - -
*421 Cattle, rearing/fattening, suckling
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  local var "CattleSuckling"
  local code = 421
  local droplastdigit = int(`code'/10)
  local vlist "" //clear vlist
  local vlist "`vlist' SGM_BovineLT1"
  local vlist "`vlist' SGM_Bovine1_2M"
  local vlist "`vlist' SGM_Bovine1_2F"
  local vlist "`vlist' SGM_BovineGT2M"
  local vlist "`vlist' SGM_BovineGT2F"
  local vlist "`vlist' SGM_DairyCows"
  local vlist "`vlist' SGM_OtherCows"
  egen double SGMpart_`var' = rowtotal(`vlist')
  
  * Relevant threshold(s) 
  replace Threshold3 = (2/3)  * SGM_Farm
  replace Threshold2 = (1/3)  * SGM_Farm
  replace Threshold  = (1/10) * SGM_Farm
  
  * Update farm type variable
  replace ParticularType = `code'          ///
    if SGMpart_`var'    >  Threshold3         & ///
       SGM_OtherCows    <= Threshold2         & ///
       SGM_DairyCows    >  Threshold          & ///
       PrincipalType == `droplastdigit'

  label define ParticularType `code' "`var'", modify
  label values ParticularType ParticularType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab ParticularType year, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -






* - - - - - - - - - - - - - - - - - - - - - - - - - -
*422 Cattle, rearing/fattening, other
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  local var "CattleOther"
  local code = 422
  local droplastdigit = int(`code'/10)
  *----------
  local vlist "" //clear vlist
  local vlist "`vlist' SGM_BovineLT1"
  local vlist "`vlist' SGM_Bovine1_2M"
  local vlist "`vlist' SGM_Bovine1_2F"
  local vlist "`vlist' SGM_BovineGT2M"
  local vlist "`vlist' SGM_BovineGT2F"
  local vlist "`vlist' SGM_DairyCows"
  local vlist "`vlist' SGM_OtherCows"
  egen double SGMpart_`var' = rowtotal(`vlist')

   * Relevant threshold(s) 
  replace Threshold3 = (2/3)  * SGM_Farm
  replace Threshold2 = (1/3)  * SGM_Farm
  replace Threshold  = (1/10) * SGM_Farm
  
  * Update farm type variable
  replace ParticularType = `code'          ///
    if SGMpart_`var'    >  Threshold3         & ///
       SGM_OtherCows    <= Threshold2         & ///
       SGM_DairyCows    <= Threshold          & ///
       PrincipalType == `droplastdigit'

  label define ParticularType `code' "`var'", modify
  label values ParticularType ParticularType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab ParticularType year, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -






* - - - - - - - - - - - - - - - - - - - - - - - - - -
*431 Dairying with cattle rearing/fattening
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  local var "CattleWithDairy"
  local code = 431
  local droplastdigit = int(`code'/10)
  local vlist "" //clear vlist
  local vlist "`vlist' SGM_BovineLT1"
  local vlist "`vlist' SGM_Bovine1_2M"
  local vlist "`vlist' SGM_Bovine1_2F"
  local vlist "`vlist' SGM_BovineGT2M"
  local vlist "`vlist' SGM_BovineGT2F"
  local vlist "`vlist' SGM_DairyCows"
  local vlist "`vlist' SGM_OtherCows "
  egen double SGMpart_`var' = rowtotal(`vlist')
  
  * Relevant threshold(s) 
  replace Threshold = (1/4)  * SGM_Farm
  replace Threshold2= (2/3)  * SGM_Farm
  
  * Update farm type variable
  replace ParticularType = `code' ///
    if SGMpart_`var' > Threshold2    & ///
       SGM_DairyCows > Threshold     & ///
       ParticularType != 41        & ///
       PrincipalType == `droplastdigit'

  label define ParticularType `code' "`var'", modify
  label values ParticularType ParticularType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab ParticularType year, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -






* - - - - - - - - - - - - - - - - - - - - - - - - - -
*432 Dairying with cattle rearing/fattening
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  local var "DairyWithCattle"
  local code = 432
  local droplastdigit = int(`code'/10)
  local vlist "" //clear vlist
  local vlist "`vlist' SGM_BovineLT1"
  local vlist "`vlist' SGM_Bovine1_2M"
  local vlist "`vlist' SGM_Bovine1_2F"
  local vlist "`vlist' SGM_BovineGT2M"
  local vlist "`vlist' SGM_BovineGT2F"
  local vlist "`vlist' SGM_DairyCows"
  local vlist "`vlist' SGM_OtherCows "
  egen double SGMpart_`var' = rowtotal(`vlist')
  
  * Relevant threshold(s) 
  replace Threshold2= (1/10)  * SGM_Farm
  replace Threshold2= (1/4)   * SGM_Farm
  replace Threshold3= (2/3)   * SGM_Farm
  
  * Update farm type variable
  replace ParticularType = `code' ///
    if SGMpart_`var' >  Threshold3    & ///
       SGM_DairyCows <= Threshold2    & ///
       SGM_DairyCows >  Threshold     & ///
       PrincipalType == `droplastdigit'

  label define ParticularType `code' "`var'", modify
  label values ParticularType ParticularType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab ParticularType year, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -






* - - - - - - - - - - - - - - - - - - - - - - - - - -
*441 Sheep
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  local var "Sheep"
  local code = 441
  local droplastdigit = int(`code'/10)
  local vlist "" //clear vlist
  local vlist "`vlist' SGM_Sheep"
  egen double SGMpart_`var' = rowtotal(`vlist')
  
  * Relevant threshold(s) 
  replace Threshold = (2/3) * SGM_Farm
  
  * Update farm type variable
  replace ParticularType = `code'    ///
    if SGMpart_`var'       >  Threshold   & ///
       PrincipalType == `droplastdigit'

  label define ParticularType `code' "`var'", modify
  label values ParticularType ParticularType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab ParticularType year, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -






* - - - - - - - - - - - - - - - - - - - - - - - - - -
*442 Cattle and sheep
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  local var "CattleSheep"
  local code = 442
  local droplastdigit = int(`code'/10)
  local vlist "" //clear vlist
  local vlist "`vlist' SGMpart_DairyWithCattle"
  local vlist "`vlist' SGM_Sheep"
  egen double SGMpart_`var' = rowtotal(`vlist')
  
  * Relevant threshold(s) 
  replace Threshold = (1/3) * SGM_Farm
  replace Threshold2= (2/3) * SGM_Farm
  
  * Update farm type variable
  replace ParticularType = `code'          ///
    if SGMpart_DairyWithCattle >  Threshold   & ///
       SGMpart_DairyWithCattle <= Threshold2  & ///
       SGMpart_Sheep           >  Threshold   & ///
       SGMpart_Sheep           <= Threshold2  & ///
       PrincipalType == `droplastdigit'

  label define ParticularType `code' "`var'", modify
  label values ParticularType ParticularType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab ParticularType year, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -






* - - - - - - - - - - - - - - - - - - - - - - - - - -
*443  Grazing livestock, various
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  local var "GrazingVarious"
  local code = 443
  local droplastdigit = int(`code'/10)
  local vlist "" //clear vlist
  local vlist "`vlist' SGM_PastureMeadow"
  local vlist "`vlist' SGM_Equidae"
  local vlist "`vlist' SGM_BovineLT1"
  local vlist "`vlist' SGM_Bovine1_2M"
  local vlist "`vlist' SGM_Bovine1_2F"
  local vlist "`vlist' SGM_BovineGT2M"
  local vlist "`vlist' SGM_BovineGT2F"
  local vlist "`vlist' SGM_DairyCows"
  local vlist "`vlist' SGM_OtherCows"
  local vlist "`vlist' SGM_Sheep"
  local vlist "`vlist' SGM_Goats"
  egen double SGMpart_`var' = rowtotal(`vlist')
  
  * Relevant threshold(s) 
  replace Threshold = (2/3) * SGM_Farm
  
  * Update farm type variable
  replace ParticularType = `code' ///
    if SGMpart_`var'    >  Threshold & ///
       PrincipalType  != 41        & ///
       PrincipalType  != 42        & ///
       PrincipalType  != 43        & ///
       ParticularType != 441       & ///
       ParticularType != 442       & ///
       PrincipalType == `droplastdigit'

  label define ParticularType `code' "`var'", modify
  label values ParticularType ParticularType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab ParticularType year, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -






* - - - - - - - - - - - - - - - - - - - - - - - - - -
*511 Pigs, rearing
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  local var "PigsRear"
  local code = 511
  local droplastdigit = int(`code'/10)
  local vlist "" //clear vlist
  local vlist "`vlist' SGM_PigsGT50kg"
  egen double SGMpart_`var' = rowtotal(`vlist')
  
  * Relevant threshold(s) 
  replace Threshold = (2/3) * SGM_Farm
  
  * Update farm type variable
  replace ParticularType = `code' ///
    if SGMpart_`var' > Threshold     & ///
       PrincipalType == `droplastdigit'

  label define ParticularType `code' "`var'", modify
  label values ParticularType ParticularType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab ParticularType year, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -






* - - - - - - - - - - - - - - - - - - - - - - - - - -
*512 Pigs, fattening
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  local var "PigsFat"
  local code = 51
  local droplastdigit = int(`code'/10)
  local vlist "" //clear vlist
  local vlist "`vlist' SGM_PigsLT20kg"
  local vlist "`vlist' SGM_PigsOther"
  egen double SGMpart_`var' = rowtotal(`vlist')
  
  * Relevant threshold(s) 
  replace Threshold = (2/3) * SGM_Farm
  
  * Update farm type variable
  replace ParticularType = `code' ///
    if SGMpart_`var' > Threshold     & ///
       PrincipalType == `droplastdigit'

  label define ParticularType `code' "`var'", modify
  label values ParticularType ParticularType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab ParticularType year, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -






* - - - - - - - - - - - - - - - - - - - - - - - - - -
*513 Pigs, mixed
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  local var "PigsMixed"
  local code = 51
  local droplastdigit = int(`code'/10)
  local vlist "" //clear vlist
  local vlist "`vlist' SGM_PigsLT20kg"
  local vlist "`vlist' SGM_PigsGT50kg"
  local vlist "`vlist' SGM_PigsOther"
  egen double SGMpart_`var' = rowtotal(`vlist')
  
  * Relevant threshold(s) 
  replace Threshold = (2/3) * SGM_Farm
  
  * Update farm type variable
  replace ParticularType = `code'     ///
    if SGMpart_`var'    >  Threshold     & ///
       SGMpart_PigsRear <= Threshold     & ///
       SGMpart_PigsFat  <= Threshold     & ///
       PrincipalType == `droplastdigit'

  label define ParticularType `code' "`var'", modify
  label values ParticularType ParticularType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab ParticularType year, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -






* - - - - - - - - - - - - - - - - - - - - - - - - - -
*521 Laying hens
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  local var "Hens"
  local code = 521
  local droplastdigit = int(`code'/10)
  local vlist "" //clear vlist
  local vlist "`vlist' SGM_PoultryHens"
  egen double SGMpart_`var' = rowtotal(`vlist')
  
  * Relevant threshold(s) 
  replace Threshold = (2/3) * SGM_Farm
  
  * Update farm type variable
  replace ParticularType = `code' ///
    if SGMpart_`var' >  Threshold      & ///
       PrincipalType == `droplastdigit'

  label define ParticularType `code' "`var'", modify
  label values ParticularType ParticularType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab ParticularType year, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -






* - - - - - - - - - - - - - - - - - - - - - - - - - -
*522 Table fowl
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  local var "TableFowl"
  local code = 522
  local droplastdigit = int(`code'/10)
  local vlist "" //clear vlist
  local vlist "`vlist' SGM_PoultryBroil"
  local vlist "`vlist' SGM_PoultryOther"
  egen double SGMpart_`var' = rowtotal(`vlist')
  
  * Relevant threshold(s) 
  replace Threshold = (2/3) * SGM_Farm
  
  * Update farm type variable
  replace ParticularType = `code' ///
    if SGMpart_`var' >  Threshold      & ///
       PrincipalType == `droplastdigit'

  label define ParticularType `code' "`var'", modify
  label values ParticularType ParticularType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab ParticularType year, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -






* - - - - - - - - - - - - - - - - - - - - - - - - - -
*523 Pigs and poultry, combined
* - - - - - - - - - - - - - - - - - - - - - - - - - -
*quietly {
  local var "PigsPoultryComb"
  local code = 523
  local droplastdigit = int(`code'/10)
  local vlist "" //clear vlist
  local vlist "`vlist' SGM_PigsLT20kg"
  local vlist "`vlist' SGM_PigsGT50kg"
  local vlist "`vlist' SGM_PigsOther"
  local vlist "`vlist' SGM_PoultryBroil"
  local vlist "`vlist' SGM_PoultryHens"
  local vlist "`vlist' SGM_PoultryOther"
  egen double SGMpart_`var' = rowtotal(`vlist')
  
  * Relevant threshold(s) 
  replace Threshold = (1/3) * SGM_Farm
  replace Threshold2= (2/3) * SGM_Farm

  capture egen double SGM_AllPigs    = ///
     rowtotal(SGM_PigsLT20kg  SGM_PigsGT50kg  SGM_PigsOther)

  capture egen double SGM_AllPoultry = ///
     rowtotal(SGM_PoultryBroil  SGM_PoultryHens  SGM_PoultryOther)
  
  * Update farm type variable
  replace ParticularType = `code' ///
    if SGM_AllPigs    >  Threshold      & ///
       SGM_AllPigs    <= Threshold2     & ///
       SGM_AllPoultry >  Threshold      & ///
       SGM_AllPoultry <= Threshold2     & ///
       PrincipalType == `droplastdigit'

  label define ParticularType `code' "`var'", modify
  label values ParticularType ParticularType
*}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab ParticularType year, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -






* - - - - - - - - - - - - - - - - - - - - - - - - - -
*524 Pigs and poultry, various 
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  local var "PigsPoultryVar"
  local code = 524
  local droplastdigit = int(`code'/10)
  local vlist "" //clear vlist
  local vlist "`vlist' SGM_PigsLT20kg"
  local vlist "`vlist' SGM_PigsGT50kg"
  local vlist "`vlist' SGM_PigsOther"
  local vlist "`vlist' SGM_PoultryBroil"
  local vlist "`vlist' SGM_PoultryHens"
  local vlist "`vlist' SGM_PoultryOther"
  egen double SGMpart_`var' = rowtotal(`vlist')
  
  * Relevant threshold(s) 
  replace Threshold = (2/3) * SGM_Farm
  
  * Update farm type variable
  replace ParticularType = `code' ///
    if SGMpart_`var' >  Threshold    & ///
       PrincipalType  != 51        & ///
       ParticularType != 521       & ///
       ParticularType != 522       & ///
       ParticularType != 523       & ///
       PrincipalType == `droplastdigit'

  label define ParticularType `code' "`var'", modify
  label values ParticularType ParticularType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab ParticularType year, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -






* - - - - - - - - - - - - - - - - - - - - - - - - - -
*611 Horticulture and permanent crops
*  (there are none of these in IE)
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  local var "HortAndPerm"
  local code = 611
  local droplastdigit = int(`code'/10)
  local vlist "" //clear vlist
  local vlist "`vlist' SGM_VegMarket"
  local vlist "`vlist' SGM_VegUnderGlass"
  local vlist "`vlist' SGM_FlowersOutdoor"
  local vlist "`vlist' SGM_FlowersGlass"
  local vlist "`vlist' SGM_FruitBerry"
  local vlist "`vlist' SGM_Citrus"
  local vlist "`vlist' SGM_Olive"
  local vlist "`vlist' SGM_Vineyards"
  local vlist "`vlist' SGM_Nurseries"
  local vlist "`vlist' SGM_OtherPerm"
  local vlist "`vlist' SGM_PermGlass"
  egen double SGMpart_`var' = rowtotal(`vlist')
  
  * 1:1 match with Principal Type 61
  
  * Update farm type variable
  replace ParticularType = `code'     ///
    if PrincipalType == 61
       

  label define ParticularType `code' "`var'", modify
  label values ParticularType ParticularType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab ParticularType year, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -






* - - - - - - - - - - - - - - - - - - - - - - - - - -
*621 Field crops and horticulture
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  local var "MixedCropOther"
  local code = 621
  local droplastdigit = int(`code'/10)
  local vlist "" //clear vlist
  local vlist "SGMpart_FieldVarious"
  local vlist "SGMpart_HortVarious"
  egen double SGMpart_`var' = rowtotal(`vlist')
  
  * Relevant threshold(s)
  replace Threshold = (1/3) * SGM_Farm
  replace Threshold2= (2/3) * SGM_Farm
  
  * Update farm type variable
  replace ParticularType = `code'         ///
    if SGMpart_FieldVarious >  Threshold  & ///
       SGMpart_FieldVarious <= Threshold2 & ///
       SGMpart_HortVarious  >  Threshold  & ///
       SGMpart_HortVarious  <= Threshold2 & ///
       PrincipalType == `droplastdigit'
  
  label define ParticularType `code' "`var'", modify
  label values ParticularType ParticularType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab ParticularType year, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -






* - - - - - - - - - - - - - - - - - - - - - - - - - -
*622 Field crops and vineyards
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  local var "FieldAndVine"
  local code = 622
  local droplastdigit = int(`code'/10)
  local vlist "" //clear vlist
  local vlist "SGMpart_FieldVarious"
  local vlist "SGM_Vineyards"
  egen double SGMpart_`var' = rowtotal(`vlist')
  
  * Relevant threshold(s)
  replace Threshold = (1/3) * SGM_Farm
  replace Threshold2= (2/3) * SGM_Farm
  
  * Update farm type variable
  replace ParticularType = `code'         ///
    if SGMpart_FieldVarious >  Threshold  & ///
       SGMpart_FieldVarious <= Threshold2 & ///
       SGM_Vineyards        >  Threshold  & ///
       SGM_Vineyards        <= Threshold2 & ///
       PrincipalType == `droplastdigit'
  
  label define ParticularType `code' "`var'", modify
  label values ParticularType ParticularType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab ParticularType year, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -






* - - - - - - - - - - - - - - - - - - - - - - - - - -
*623 Field crops and fruit/permanent crops, other
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  local var "FieldAndPerm"
  local code = 623
  local droplastdigit = int(`code'/10)
  local vlist "" //clear vlist
  local vlist "SGMe_FieldCrops"
  local vlist "SGMe_FruitPerm"
  local vlist "SGM_Vineyards"
  egen double SGMpart_`var' = rowtotal(`vlist')
  
  * Relevant threshold(s)
  replace Threshold = (1/3) * SGM_Farm
  replace Threshold2= (2/3) * SGM_Farm
  
  * Update farm type variable
  replace ParticularType = `code' ///
    if SGMe_FieldCrops >  Threshold  & ///
       SGMe_FieldCrops <= Threshold2 & ///
       SGMe_FruitPerm  >  Threshold  & ///
       SGMe_FruitPerm  <= Threshold2 & ///
       SGM_Vineyards   <= Threshold  & ///
       PrincipalType == `droplastdigit'
  
  label define ParticularType `code' "`var'", modify
  label values ParticularType ParticularType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab ParticularType year, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -






* - - - - - - - - - - - - - - - - - - - - - - - - - -
*624 Partially dominant field crops
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  local var "DominantField"
  local code = 624
  local droplastdigit = int(`code'/10)
  local vlist "" //clear vlist
  local vlist "SGMe_FieldCrops"
  local vlist "SGMe_FruitPerm"
  local vlist "SGM_Vineyards"
  egen double SGMpart_`var' = rowtotal(`vlist')
  
  * Relevant threshold(s)
  replace Threshold = (1/3) * SGM_Farm
  replace Threshold2= (2/3) * SGM_Farm
  
  * Update farm type variable
  replace ParticularType = `code' ///
    if SGMe_FieldCrops >  Threshold  & ///
       SGMe_FieldCrops <= Threshold2 & ///
       missing(ParticularType)     & ///
       PrincipalType == `droplastdigit'
  
  label define ParticularType `code' "`var'", modify
  label values ParticularType ParticularType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab ParticularType year, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -






* - - - - - - - - - - - - - - - - - - - - - - - - - -
*624 Partially dominant horticulture or permanent crops
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  local var "DomHortPerm"
  local code = 624
  local droplastdigit = int(`code'/10)
  local vlist "" //clear vlist
  local vlist "SGMe_Horticulture"
  local vlist "SGMe_FruitPerm"
  egen double SGMpart_`var' = rowtotal(`vlist')
  
  * Relevant threshold(s)
  replace Threshold = (1/3) * SGM_Farm
  replace Threshold2= (2/3) * SGM_Farm
  
  * Update farm type variable
  replace ParticularType = `code'   ///
    if SGMe_Horticulture >  Threshold  & ///
       SGMe_Horticulture <= Threshold2 & ///
       missing(ParticularType)       & ///
       PrincipalType == `droplastdigit'
  
  replace ParticularType = `code' ///
    if SGMe_FruitPerm >  Threshold   & ///
       SGMe_FruitPerm <= Threshold2  & ///
       missing(ParticularType)     & ///
       PrincipalType == `droplastdigit'
  
  label define ParticularType `code' "`var'", modify
  label values ParticularType ParticularType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab ParticularType year, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -






*711 Partially dominant dairying
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  local var "DomDairying"
  local code = 711
  local droplastdigit = int(`code'/10)
  local vlist "" //clear vlist
  local vlist "`vlist' SGMe_Grazing"
  egen double SGMpart_`var' = rowtotal(`vlist')
  
  * Relevant threshold(s) 
  replace Threshold = (1/3) * SGM_Farm
  replace Threshold2= (2/3) * SGM_Farm
 
  * Update farm type variable (drawing from remaining missings)
  replace ParticularType = `code'          ///
    if SGMe_Dairying >  Threshold             & ///
       SGMe_Dairying <= Threshold2            & ///
       SGM_DairyCows >  (2/3) * SGMe_Dairying & ///
       SGMe_Grazing  >  Threshold             & ///
       SGMe_Grazing  <= Threshold2            & ///
       missing(ParticularType)              & ///
       PrincipalType == `droplastdigit'

  
  label define ParticularType `code' "`var'", modify
  label values ParticularType ParticularType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab ParticularType year, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -






*712 Partially dominant grazing livestock other than
*      dairying
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  local var "DomDrystock"
  local code = 712
  local droplastdigit = int(`code'/10)
  local vlist "" //clear vlist
  local vlist "`vlist' SGMe_Grazing"
  egen double SGMpart_`var' = rowtotal(`vlist')
  
  * Relevant threshold(s) 
  replace Threshold = (1/3) * SGM_Farm
  replace Threshold2= (2/3) * SGM_Farm
 
  * Update farm type variable (drawing from remaining missings)
  replace ParticularType = `code' ///
    if SGMe_Grazing >  Threshold       & ///
       SGMe_Grazing <= Threshold2      & ///
       ParticularType != 711         & ///
       missing(ParticularType)       & ///
       PrincipalType == `droplastdigit'

  
  label define ParticularType `code' "`var'", modify
  label values ParticularType ParticularType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab ParticularType year, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -






* - - - - - - - - - - - - - - - - - - - - - - - - - -
*721 Pigs and poultry and dairying
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  local var "PigsPoultryDairy"
  local code = 721
  local droplastdigit = int(`code'/10)
  local vlist "" //clear vlist
  local vlist "`vlist' SGMe_Dairying"
  local vlist "`vlist' SGMe_PigsPoultryOther"
  egen double SGMpart_`var' = rowtotal(`vlist')
  
  * Relevant threshold(s) 
  replace Threshold = (1/3) * SGM_Farm
  replace Threshold2= (2/3) * SGM_Farm
  
  * Update farm type variable
  replace ParticularType = `code'                  ///
    if SGMe_Dairying         >  Threshold             & ///
       SGMe_Dairying         <= Threshold2            & ///
       SGM_DairyCows         >  (2/3) * SGMe_Dairying & ///
       SGMe_PigsPoultryOther >  Threshold             & ///
       SGMe_PigsPoultryOther <= Threshold2            & ///
       PrincipalType == `droplastdigit'
  
  
  label define ParticularType `code' "`var'", modify
  label values ParticularType ParticularType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab ParticularType year, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -






* - - - - - - - - - - - - - - - - - - - - - - - - - -
*722 Pigs and poultry and grazing livestock other 
*      than dairying
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  local var "PigsPoultryDry"
  local code = 722
  local droplastdigit = int(`code'/10)
  local vlist "" //clear vlist
  local vlist "`vlist' SGMe_Grazing"
  local vlist "`vlist' SGMe_PigsPoultryOther"
  egen double SGMpart_`var' = rowtotal(`vlist')
  
  * Relevant threshold(s) 
  replace Threshold = (1/3) * SGM_Farm
  replace Threshold2= (2/3) * SGM_Farm
  
  * Update farm type variable
replace ParticularType = `code'         ///
    if SGMe_Grazing          >  Threshold  & ///
       SGMe_Grazing          <= Threshold2 & ///
       SGMe_PigsPoultryOther >  Threshold  & ///
       SGMe_PigsPoultryOther <= Threshold2 & ///
       PrincipalType != 721              & ///
       PrincipalType == `droplastdigit'
  
  label define ParticularType `code' "`var'", modify
  label values ParticularType ParticularType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab ParticularType year, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -






* - - - - - - - - - - - - - - - - - - - - - - - - - -
*723 Partially dominant pigs and poultry
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  local var "DomPigsPoultry"
  local code = 723
  local droplastdigit = int(`code'/10)
  local vlist "" //clear vlist
  local vlist "`vlist' SGMe_PigsPoultryOther"
  egen double SGMpart_`var' = rowtotal(`vlist')
  
  * Relevant threshold(s) 
  replace Threshold = (1/3) * SGM_Farm
  replace Threshold2= (2/3) * SGM_Farm
  
  * Update farm type variable
  replace ParticularType = `code'         ///
    if SGMe_PigsPoultryOther >  Threshold  & ///
       SGMe_PigsPoultryOther <= Threshold2 & ///
       missing(ParticularType)           & ///
       PrincipalType == `droplastdigit'
 
  label define ParticularType `code' "`var'", modify
  label values ParticularType ParticularType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab ParticularType year, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -






* - - - - - - - - - - - - - - - - - - - - - - - - - -
*811 Field crops with dairying
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  local var "FieldAndDairy"
  local code = 811
  local droplastdigit = int(`code'/10)
  local vlist "" //clear vlist
  local vlist "`vlist' SGMe_FieldCrops"
  local vlist "`vlist' SGMe_Dairying"
  egen double SGMpart_`var' = rowtotal(`vlist')
  
  
  * Relevant threshold(s) 
  replace Threshold = (1/3) * SGM_Farm
  replace Threshold2= (2/3) * SGM_Farm
  
  * Update farm type variable
  replace ParticularType = `code'            ///
    if SGMe_FieldCrops >  Threshold             & ///
       SGMe_FieldCrops <= Threshold2            & ///
       SGMe_Dairying   >  Threshold             & ///
       SGMe_Dairying   <= Threshold2            & ///
       SGM_DairyCows   >  (2/3) * SGMe_Dairying & ///
       SGMe_FieldCrops >  SGMe_Dairying         & ///
       PrincipalType == `droplastdigit'

  label define ParticularType `code' "`var'", modify
  label values ParticularType ParticularType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab ParticularType year, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -






* - - - - - - - - - - - - - - - - - - - - - - - - - -
*812 Dairying with field crops
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  local var "DairyAndField"
  local code = 812
  local droplastdigit = int(`code'/10)
  local vlist "" //clear vlist
  local vlist "`vlist' SGMe_FieldCrops"
  local vlist "`vlist' SGMe_Dairying"
  egen double SGMpart_`var' = rowtotal(`vlist')
  
  
  * Relevant threshold(s) 
  replace Threshold = (1/3) * SGM_Farm
  replace Threshold2= (2/3) * SGM_Farm
  
  * Update farm type variable
  replace ParticularType = `code'            ///
    if SGMe_FieldCrops >  Threshold             & ///
       SGMe_FieldCrops <= Threshold2            & ///
       SGMe_Dairying   >  Threshold             & ///
       SGMe_Dairying   <= Threshold2            & ///
       SGM_DairyCows   >  (2/3) * SGMe_Dairying & ///
       SGMe_FieldCrops <= SGMe_Dairying         & ///
       PrincipalType == `droplastdigit'

  label define ParticularType `code' "`var'", modify
  label values ParticularType ParticularType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab ParticularType year, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -






* - - - - - - - - - - - - - - - - - - - - - - - - - -
*813 Field crops with grazing livestock other than 
*      dairying
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  local var "FieldAndDry"
  local code = 813
  local droplastdigit = int(`code'/10)
  local vlist "" //clear vlist
  local vlist "`vlist' SGMe_FieldCrops"
  local vlist "`vlist' SGMe_Grazing"
  egen double SGMpart_`var' = rowtotal(`vlist')
  
  * Relevant threshold(s) 
  replace Threshold = (1/3) * SGM_Farm
  replace Threshold2= (2/3) * SGM_Farm
  
  * Update farm type variable
  replace ParticularType = `code'    ///
    if SGMe_FieldCrops >  Threshold     & ///
       SGMe_FieldCrops <= Threshold2    & ///
       SGMe_Grazing    >  Threshold     & ///
       SGMe_Grazing    <= Threshold2    & /// 
       SGMe_FieldCrops >  SGMe_Grazing  & ///
       PrincipalType != 811           & ///
       PrincipalType != 812           & ///
       PrincipalType == `droplastdigit'

  label define ParticularType `code' "`var'", modify
  label values ParticularType ParticularType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab ParticularType year, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -






* - - - - - - - - - - - - - - - - - - - - - - - - - -
*814 Grazing livestock other than dairying with field
*      crops
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  local var "DryAndField"
  local code = 814
  local droplastdigit = int(`code'/10)
  local vlist "" //clear vlist
  local vlist "`vlist' SGMe_FieldCrops"
  local vlist "`vlist' SGMe_Grazing"
  egen double SGMpart_`var' = rowtotal(`vlist')
  
  
  * Relevant threshold(s) 
  replace Threshold = (1/3) * SGM_Farm
  replace Threshold2= (2/3) * SGM_Farm
  
  * Update farm type variable
  replace ParticularType = `code'    ///
    if SGMe_FieldCrops >  Threshold     & ///
       SGMe_FieldCrops <= Threshold2    & ///
       SGMe_Grazing    >  Threshold     & ///
       SGMe_Grazing    <= Threshold2    & /// 
       SGMe_FieldCrops <= SGMe_Grazing  & ///
       PrincipalType != 811           & ///
       PrincipalType != 812           & ///
       PrincipalType == `droplastdigit'

  label define ParticularType `code' "`var'", modify
  label values ParticularType ParticularType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab ParticularType year, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -






* - - - - - - - - - - - - - - - - - - - - - - - - - -
*821 Field crops and pigs and poultry
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  local var "FieldAndPigsPoultry"
  local code = 821
  local droplastdigit = int(`code'/10)
  local vlist "`vlist' SGMe_FieldCrops"
  local vlist "`vlist' SGMe_PigsPoultry"
  egen double SGMpart_`var' = rowtotal(`vlist')
  
  * Relevant threshold(s) 
  replace Threshold = (1/3) * SGM_Farm
  replace Threshold2= (2/3) * SGM_Farm

  * Update farm type variable - catch-all group... must be last
  replace ParticularType = `code' ///
    if SGMe_FieldCrops  >  Threshold  & ///
       SGMe_FieldCrops  <= Threshold2 & ///
       SGMe_PigsPoultry >  Threshold  & ///
       SGMe_PigsPoultry <= Threshold2 & ///
       PrincipalType == `droplastdigit'
  
  label define ParticularType `code' "`var'", modify
  label values ParticularType ParticularType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab ParticularType year, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -






* - - - - - - - - - - - - - - - - - - - - - - - - - -
*822 Crops --- livestock, various
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  local var "CropsLiveVar"
  local code = 822
  local droplastdigit = int(`code'/10)
  gen double SGMpart_`var' = SGM_Farm
  
  * No relevant threshold(s) -- can drop them now
  drop Threshol*

  * Update farm type variable - catch-all group... must be last
  replace ParticularType = `code' ///
    if missing(ParticularType)     & ///
       PrincipalType == `droplastdigit'

  label define ParticularType `code' "`var'", modify
  label values ParticularType ParticularType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab ParticularType year, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -
