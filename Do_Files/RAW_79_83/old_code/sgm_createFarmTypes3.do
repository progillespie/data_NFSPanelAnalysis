* This file uses calculated SGMs to create a system variable for NFS
*   farm data using the NFS/FADN farm typology.

local outdatadir "D:/Data/data_NFSPanelAnalysis/OutData"


qui do sgm_calcSGMs.do
save temp.dta, replace

use temp.dta, clear


* Recreate the list of category SGMs
qui ds SGM_*
local cat_sgms `r(varlist)'
* Remove SGM_farm from the list
local rm "SGM_farm"
local cat_sgms: list cat_sgms - rm
macro drop _rm 

* Print the list in single column (more readable)
foreach cat of local cat_sgms {

    local i=`i'+1
    di "`i')" _column(5) "`cat'" 

}

*-------------------------------------------------------------------- 
* Calculate SGMs
*-------------------------------------------------------------------- 




** From A-Z of FADN methodology p. 26
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
* Clustering schemes
** Ireland
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
*** 1000+6000+8130+8140+8220+8230 2,(3+4),(5+6),7,(8+9+10)
*** 2000 2,(3+4),(5+6),7,(8+9+10)
*** 3000 2,(3+4),(5+6),7,(8+9+10)
*** 4110 2,(3+4),(5+6),7,(8+9+10)
*** 4120+4310+4320+4440+7110+8110+8120 2,(3+4),(5+6),7,(8+9+10)
*** 4210 2,(3+4),(5+6),7,(8+9+10)
*** 4220+7120 2,(3+4),(5+6),7,(8+9+10)
*** 4410+4420+4430 2,(3+4),(5+6),7,(8+9+10)
*** 5000+7200+8210 2,(3+4),(5+6),7,(8+9+10)

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
egen double SGM_ForagePlants = rowtotal(SGM_GreenMaize SGM_OtherGreenFodder)
egen double SGM_PastureMeadow = rowtotal(SGM_Pasture SGM_RoughGrazing)
gen  double SGM_Industrial    = SGM_Oilseed
gen  double SGM_DriedVeg      = SGM_Peas  

* - - - - - - - - - - - - - - - - - - - - - - - - - - -
* SGMs which aren't relevant for Ireland, but are needed for 
*   calculated Principle Types
* - - - - - - - - - - - - - - - - - - - - - - - - - - -
gen double SGM_Durum          = 0
gen double SGM_Rye            = 0
gen double SGM_GrainMaize     = 0
gen double SGM_Rice           = 0
gen double SGM_OtherCereals   = 0
gen double SGM_VegMarket      = 0
gen double SGM_FlowersOutdoor = 0
gen double SGM_FlowersGlass   = 0
gen double SGM_Seeds          = 0
gen double SGM_OtherCrops     = 0
gen double SGM_FruitBerry     = 0
gen double SGM_Citrus         = 0
gen double SGM_Olive          = 0
gen double SGM_Vineyards      = 0
gen double SGM_OtherPerm      = 0
gen double SGM_PermGlass      = 0
gen double SGM_Goats          = 0




local vlist "`vlist' 


* From Commission Decision 78/463/EEC
* Composition and thresholds
/* - - - - - - - - - - - - - - - - - - - - - - - - - - -

**Principal types**
--------------------

* Create empty variable for Principle Type codes. It's categorical
*  so "int" type is appropriate.
capture drop PrincipleType85
gen int PrincipleType85 = .
label var PrincipleType78 ///
  "Principle Type per 78/463/EEC"

* The following code calculates the SGMs for comparing to the 
*  relevant threshold for each Principle Type, then does the 
*  comparison, and assigns fills in PrincipleType85.

11 Cereals
----------
local vlist ""
local vlist "`vlist' SGM_CommonWheat"
local vlist "`vlist' SGM_Durum"
local vlist "`vlist' SGM_Rye"
local vlist "`vlist' SGM_Barley"
local vlist "`vlist' SGM_Oats"
local vlist "`vlist' SGM_GrainMaize"
local vlist "`vlist' SGM_Rice"
local vlist "`vlist' SGM_OtherCereals"
egen double SGM_Cereals = rowtotal(`vlist')

capture drop Threshold
gen double Threshold = (2/3) * SGM_Farm

* Update farm type variable
replace PrincipleType78 = 11 ///
  if SGM_Cereals > Threshold
label define PrincipleType78 11 "Cereals", modify
label values PrincipleType78 PrincipleType78




12 Field Crops, other
----------
local vlist ""
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
Threshold: > 2/3 & Cereals threshold not met
egen double SGM_= rowtotal(`vlist')


21 Horticulture12 Field Crops, other
----------
local vlist ""
local vlist "`vlist' SGM_VegMarket"
local vlist "`vlist' SGM_VegUnderGlass"
local vlist "`vlist' SGM_FlowersOutdoor"
local vlist "`vlist' SGM_FlowersGlass"
Threshold:  > 2/3
egen double SGM_= rowtotal(`vlist')


31 Vineyards
----------
local vlist ""
local vlist "`vlist' SGM_Olive"
Threshold:  > 2/3
egen double SGM_= rowtotal(`vlist')


32 Fruit/permanent crops, other
----------
local vlist ""

local vlist "`vlist' SGM_PastureMeadow"
local vlist "`vlist' SGM_FruitBerry"
local vlist "`vlist' SGM_Citrus"
local vlist "`vlist' SGM_Olive"
local vlist "`vlist' SGM_Vineyards"
local vlist "`vlist' SGM_Nurseries"
local vlist "`vlist' SGM_PermGlass"
Threshold: > 2/3 & Vineyards threshold not met
egen double SGM_= rowtotal(`vlist')


41 Cattle, dairying 
----------
local vlist ""

local vlist "`vlist' SGM_BovineLT1"
local vlist "`vlist' SGM_Bovine1_2F"
local vlist "`vlist' SGM_BovineGT2F"
local vlist "`vlist' SGM_DairyCows"
Threshold:  > 2/3 & 
       SGM_DairyCows > 2/3 SGM_BovineLT1
                  SGM_Bovine1_2F
                  SGM_BovineGT2F
                  SGM_DairyCows
egen double SGM_= rowtotal(`vlist')


42 Cattle, rearing/fattening
----------
local vlist ""

local vlist "`vlist' SGM_BovineLT1"
local vlist "`vlist' SGM_Bovine1_2M"
local vlist "`vlist' SGM_Bovine1_2F"
local vlist "`vlist' SGM_BovineGT2M"
local vlist "`vlist' SGM_BovineGT2F"
local vlist "`vlist' SGM_DairyCows"
local vlist "`vlist' SGM_OtherCows"
Threshold:  > 2/3 & 
       SGM_DairyCows < 1/10
egen double SGM_= rowtotal(`vlist')

43 Cattle, mixed
----------
local vlist ""

local vlist "`vlist' SGM_BovineLT1"
local vlist "`vlist' SGM_Bovine1_2M"
local vlist "`vlist' SGM_Bovine1_2F"
local vlist "`vlist' SGM_BovineGT2M"
local vlist "`vlist' SGM_BovineGT2F"
local vlist "`vlist' SGM_DairyCows"
local vlist "`vlist' SGM_OtherCows "
Threshold:  > 2/3   & 
       SGM_DairyCows > 1/ 10 &
       excluding holdings in class 41
egen double SGM_= rowtotal(`vlist')


44 Grazing livestock, other
----------
local vlist ""

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
Threshold: > 2/3 & 
local vlist "`vlist'       SGM_BovineLT1"
local vlist "`vlist'       SGM_Bovine1_2M"
local vlist "`vlist'       SGM_Bovine1_2F"
local vlist "`vlist'       SGM_BovineGT2M"
local vlist "`vlist'       SGM_BovineGT2F"
local vlist "`vlist'       SGM_DairyCows"
local vlist "`vlist'       SGM_OtherCows < 2/3"
egen double SGM_= rowtotal(`vlist')


51 Pigs
----------
local vlist ""

local vlist "`vlist' SGM_PigsLT20kg"
local vlist "`vlist' SGM_PigsGT50kg"
local vlist "`vlist' SGM_PigsOther"
Threshold: > 2/3
egen double SGM_= rowtotal(`vlist')

52 Pigs and poultry, other
----------
local vlist ""

local vlist "`vlist' SGM_PigsLT20kg"
local vlist "`vlist' SGM_PigsGT50kg"
local vlist "`vlist' SGM_PigsOther"
local vlist "`vlist' SGM_PoultryBroil"
local vlist "`vlist' SGM_PoultryHens"
local vlist "`vlist' SGM_PoultryOther"
Threshold:  > 2/3 & 
local vlist "`vlist'        SGM_PigsLT20kg"
local vlist "`vlist'        SGM_PigsGT50kg  "
local vlist "`vlist'        SGM_PigsOther < 2/3"
egen double SGM_= rowtotal(`vlist')



61 Horticulture and permanent crops
----------
local vlist ""

Bipolar : 
1/3 <
local vlist "`vlist'       SGM_VegMarket"
local vlist "`vlist'       SGM_VegUnderGlass"
local vlist "`vlist'       SGM_FlowersOutdoor"
local vlist "`vlist'       SGM_FlowersGlass"
            < 2/3 &
1/3 < SGM_PastureMeadow
local vlist "`vlist'       SGM_FruitBerry"
local vlist "`vlist'       SGM_Citrus"
local vlist "`vlist'       SGM_Olive"
local vlist "`vlist'       SGM_Vineyards"
local vlist "`vlist'       SGM_Nurseries"
local vlist "`vlist'       SGM_PermGlass  < 2/3"
egen double SGM_= rowtotal(`vlist')


62 Mixed cropping, other
----------
local vlist ""

Bipolars : 
1/3 < SGM_CommonWheat
local vlist "`vlist'       SGM_Durum"
local vlist "`vlist'       SGM_Rye"
local vlist "`vlist'       SGM_Barley"
local vlist "`vlist'       SGM_Oats"
local vlist "`vlist'       SGM_GrainMaize"
local vlist "`vlist'       SGM_Rice"
local vlist "`vlist'       SGM_OtherCereals"
local vlist "`vlist'       SGM_DriedVeg"
local vlist "`vlist'       SGM_Potatoes"
local vlist "`vlist'       SGM_SugarBeet"
local vlist "`vlist'       SGM_FodderRoots"
local vlist "`vlist'       SGM_Industrial"
local vlist "`vlist'       SGM_VegOpenField"
local vlist "`vlist'       SGM_ForagePlants"
local vlist "`vlist'       SGM_Seeds"
local vlist "`vlist'       SGM_OtherCrops  < 2/3 & "
1/3 < SGM_VegMarket
local vlist "`vlist'       SGM_VegUnderGlass"
local vlist "`vlist'       SGM_FlowersOutdoor"
local vlist "`vlist'       SGM_FlowersGlass  "
                                     |  
local vlist "`vlist' SGM_PastureMeadow"
local vlist "`vlist'                SGM_FruitBerry"
local vlist "`vlist'                SGM_Citrus"
local vlist "`vlist'                SGM_Olive"
local vlist "`vlist'                SGM_Vineyards"
local vlist "`vlist'                SGM_Nurseries"
local vlist "`vlist'                SGM_PermGlass < 2/3"
Partially dominant : 
1/3 < (
local vlist "`vlist'        SGM_CommonWheat"
local vlist "`vlist'        SGM_Durum"
local vlist "`vlist'        SGM_Rye"
local vlist "`vlist'        SGM_Barley"
local vlist "`vlist'        SGM_Oats"
local vlist "`vlist'        SGM_GrainMaize"
local vlist "`vlist'        SGM_Rice"
local vlist "`vlist'        SGM_OtherCereals"
local vlist "`vlist'        SGM_DriedVeg"
local vlist "`vlist'        SGM_Potatoes"
local vlist "`vlist'        SGM_SugarBeet"
local vlist "`vlist'        SGM_FodderRoots"
local vlist "`vlist'        SGM_Industrial"
local vlist "`vlist'        SGM_VegOpenField "
local vlist "`vlist'        SGM_ForagePlants"
local vlist "`vlist'        SGM_Seeds"
local vlist "`vlist'        SGM_OtherCrops   "
|  
local vlist "`vlist'                            SGM_VegMarket"
local vlist "`vlist'                            SGM_VegUnderGlass"
local vlist "`vlist'                            SGM_FlowersOutdoor"
local vlist "`vlist'                            SGM_FlowersGlass) "
| 
local vlist "`vlist'                                                SGM_PastureMeadow"
local vlist "`vlist'                                                SGM_FruitBerry"
local vlist "`vlist'                                                SGM_Citrus"
local vlist "`vlist'                                                SGM_Olive"
local vlist "`vlist'                                                SGM_Vineyards"
local vlist "`vlist'                                                SGM_Nurseries"
local vlist "`vlist'                                                SGM_PermGlass"
  < 2/3 & 
no other pole > 1 /3
egen double SGM_= rowtotal(`vlist')


71 Partially dominant grazing livestock
----------
local vlist ""

1/3 < 
local vlist "`vlist'       SGM_PastureMeadow"
local vlist "`vlist'       SGM_Equidae"
local vlist "`vlist'       SGM_BovineLT1"
local vlist "`vlist'       SGM_Bovine1_2M"
local vlist "`vlist'       SGM_Bovine1_2F"
local vlist "`vlist'       SGM_BovineGT2M"
local vlist "`vlist'       SGM_BovineGT2F"
local vlist "`vlist'       SGM_DairyCows"
local vlist "`vlist'       SGM_OtherCows"
local vlist "`vlist'       SGM_Sheep"
local vlist "`vlist'       SGM_Goats "
                   < 2/3 & no other pole > 1/3
egen double SGM_= rowtotal(`vlist')


72 Mixed livestock, other
----------
local vlist ""

Bipolar : 
1/3 < 
local vlist "`vlist'       SGM_PastureMeadow"
local vlist "`vlist'       SGM_Equidae"
local vlist "`vlist'       SGM_BovineLT1"
local vlist "`vlist'       SGM_Bovine1_2M"
local vlist "`vlist'       SGM_Bovine1_2F"
local vlist "`vlist'       SGM_BovineGT2M"
local vlist "`vlist'       SGM_BovineGT2F"
local vlist "`vlist'       SGM_DairyCows"
local vlist "`vlist'       SGM_OtherCows"
local vlist "`vlist'       SGM_Sheep"
local vlist "`vlist'       SGM_Goats "
                     < 2/3 & 
1/3 < 
local vlist "`vlist'       SGM_PigsLT20kg"
local vlist "`vlist'       SGM_PigsGT50kg"
local vlist "`vlist'       SGM_PigsOther"
local vlist "`vlist'       SGM_PoultryBroil"
local vlist "`vlist'       SGM_PoultryHens"
local vlist "`vlist'       SGM_PoultryOther "
                      < 2/3
Partially dominant : 
1 /3 < 
       SGM_PigsLT20klocal vlist "`vlist' g"
local vlist "`vlist'        SGM_PigsGT50kg"
local vlist "`vlist'        SGM_PigsOther"
local vlist "`vlist'        SGM_PoultryBroil"
local vlist "`vlist'        SGM_PoultryHens"
local vlist "`vlist'        SGM_PoultryOther "
                       < 2/3 &
no other pole > 1/3
egen double SGM_= rowtotal(`vlist')


81 Field crops and grazing livestock
----------
local vlist ""

Bipolar : 
1/3 < 
local vlist "`vlist'       SGM_CommonWheat"
local vlist "`vlist'       SGM_Durum"
local vlist "`vlist'       SGM_Rye"
local vlist "`vlist'       SGM_Barley"
local vlist "`vlist'       SGM_Oats"
local vlist "`vlist'       SGM_GrainMaize"
local vlist "`vlist'       SGM_Rice"
local vlist "`vlist'       SGM_OtherCereals"
local vlist "`vlist'       SGM_DriedVeg"
local vlist "`vlist'       SGM_Potatoes"
local vlist "`vlist'       SGM_SugarBeet"
local vlist "`vlist'       SGM_FodderRoots"
local vlist "`vlist'       SGM_Industrial"
local vlist "`vlist'       SGM_VegOpenField"
local vlist "`vlist'       SGM_ForagePlants"
local vlist "`vlist'       SGM_Seeds"
local vlist "`vlist'       SGM_OtherCrops "
                      < 2/3 &
1 /3 < 
local vlist "`vlist'        SGM_PastureMeadow"
local vlist "`vlist'        SGM_Equidae"
local vlist "`vlist'        SGM_BovineLT1"
local vlist "`vlist'        SGM_Bovine1_2M"
local vlist "`vlist'        SGM_Bovine1_2F"
local vlist "`vlist'        SGM_BovineGT2M"
local vlist "`vlist'        SGM_BovineGT2F"
local vlist "`vlist'        SGM_DairyCows"
local vlist "`vlist'        SGM_OtherCows"
local vlist "`vlist'        SGM_Sheep"
local vlist "`vlist'        SGM_Goats "
                    < 2/3
egen double SGM_= rowtotal(`vlist')


82 Crops --- livestock, other
----------
local vlist ""
All types of holdings not covered above
egen double SGM_= rowtotal(`vlist')



* Counts by year
tab PrincipleType78 year




**Particular types**
--------------------
111 Cereals, excluding rice
----------
(SGM_CommonWheat + SGM_Durum + SGM_Rye + SGM_Barley + SGM_Oats + SGM_GrainMaize + SGM_OtherCereals) > 2/3

      
      

112 Rice
----------
SGM_Rice > 2/3


113 Cereals, including rice
----------
(SGM_CommonWheat + SGM_Durum + SGM_Rye  + SGM_Barley + SGM_Oats + SGM_GrainMaize + SGM_Rice + SGM_OtherCereals) > 2/3 ;
 SGM_CommonWheat + SGM_Durum + SGM_Rye  + SGM_Barley + SGM_Oats + SGM_GrainMaize + SGM_OtherCereals) < 2/3 ; SGM_Rice < 2/3


121 Roots
----------
(SGM_Potatoes + SGM_SugarBeet + SGM_FodderRoots) > 2/3


122 Cereals and roots
----------
Bipolar : 1 /3 < (SGM_CommonWheat + SGM_Durum + SGM_Rye  + SGM_Barley + SGM_Oats + SGM_GrainMaize + SGM_Rice +
SGM_OtherCereals) < 2/3 ; 1/3 < (SGM_Potatoes + SGM_SugarBeet + SGM_FodderRoots) < 2/3


123 Field crops, various (*)
----------
(SGM_CommonWheat + SGM_Durum + SGM_Rye  + SGM_Barley + SGM_Oats + SGM_GrainMaize + SGM_Rice + SGM_OtherCereals + SGM_DriedVeg +
SGM_Potatoes + SGM_SugarBeet + SGM_FodderRoots + SGM_Industrial + SGM_VegOpenField + SGM_ForagePlants + E/+- SGM_OtherCrops) > 2/ 3 ;
excluding in classes 11 , 121 and 122


211 Market garden vegetables, open air
----------
SGM_VegMarket > 2/3


212 Market garden vegetables , under glass
----------
SGM_VegUnderGlass > 2/3


213 Market garden vegetables, open air/under glass
----------
(SGM_VegMarket + SGM_VegUnderGlass) > 2/3 ; SGM_VegMarket < 2/3 ; SGM_VegUnderGlass < 2/3


214 Flowers, open air
----------
SGM_FlowersOutdoor > 2/3


215 Flowers, under glass
----------
SGM_FlowersGlass > 2/3


216 Flowers, open air/under glass
----------
(SGM_FlowersOutdoor + SGM_FlowersGlass) > 2/3 ; SGM_FlowersOutdoor < 2/3 ; SGM_FlowersGlass < 2/3


217 Horticulture, various (**)
----------
(SGM_VegMarket + SGM_VegUnderGlass + SGM_FlowersOutdoor + SGM_FlowersGlass) > 2/3 ; SGM_VegMarket < 2/3 ; SGM_VegUnderGlass < 2/3 ; (SGM_VegMarket
+ SGM_VegUnderGlass) < 2/3 ; SGM_FlowersOutdoor < 2/3 ; SGM_FlowersGlass < 2/3 ; (SGM_FlowersOutdoor + SGM_FlowersGlass) < 2/3


311 Quality wine (***)
----------
SGM_Olive/a > 2/3


Table wine (***)
----------
SGM_Olive/b > 2/3


313 Table grapes (***)
----------
SGM_Olive/c > 2/3


314 Vineyards, mixed (***)
----------
(SGM_Olive/a + SGM_Olive/b + SGM_Olive/c) > 2/3 ; SGM_Olive/a < 2/3 ; SGM_Olive/b < 2/3 ;
SGM_Olive/c < 2/3


321 Fruit, excluding citrus
----------
SGM_PastureMeadow > 2/3


322 Citrus
----------
SGM_FruitBerry > 2/3


323 Olives
----------
SGM_Citrus > 2/3


324 Permanent crops, various
----------
(SGM_PastureMeadow + SGM_FruitBerry + SGM_Citrus + SGM_Olive + SGM_Vineyards + SGM_Nurseries + SGM_PermGlass) > 2/3 ; SGM_PastureMeadow
< 2/3 ; SGM_FruitBerry < 2/3 ; SGM_Citrus < 2/3 ; SGM_Olive < 2/3


411 Specialized dairying
----------
SGM_DairyCows > 2/3


412 Dairying, other
----------
(SGM_BovineLT1 + SGM_Bovine1_2F + SGM_BovineGT2F + SGM_DairyCows) > 2/3 ; SGM_DairyCows < 2/3 ; SGM_DairyCows > 2/3 (SGM_BovineLT1 +
SGM_Bovine1_2F + SGM_BovineGT2F + SGM_DairyCows)


421 Cattle, rearing/fattening, suckling
----------
(SGM_BovineLT1 + SGM_Bovine1_2M + SGM_Bovine1_2F + SGM_BovineGT2M + SGM_BovineGT2F + SGM_DairyCows + SGM_OtherCows) > 2/3 ; SGM_DairyCows <
1/10 ; SGM_OtherCows > 1/3


422 Cattle, rearing/fattening, other
----------
(SGM_BovineLT1 + SGM_Bovine1_2M + SGM_Bovine1_2F + SGM_BovineGT2M + SGM_BovineGT2F + SGM_DairyCows + SGM_OtherCows) > 2/3 ; SGM_DairyCows <
1 /10 ; SGM_OtherCows < 1 /3


Dairying with cattle rearing/fattening
----------
(SGM_BovineLT1 + SGM_Bovine1_2M + SGM_Bovine1_2F + SGM_BovineGT2M + SGM_BovineGT2F + SGM_DairyCows + SGM_OtherCows) > 2/3 ; SGM_DairyCows >
1/4 ; excluding holdings in class 41


432 Cattle rearing/fattening with dairying
----------
(SGM_BovineLT1 + SGM_Bovine1_2M + SGM_Bovine1_2F + SGM_BovineGT2M + SGM_BovineGT2F + SGM_DairyCows + SGM_OtherCows) > 2/3 ; 1/10 <
SGM_DairyCows < 1 /4


441 Sheep
----------
SGM_Sheep > 2/3


442 Cattle and sheep
----------
Bipolar : 1/3 < (SGM_BovineLT1 + SGM_Bovine1_2M + SGM_Bovine1_2F + SGM_BovineGT2M + SGM_BovineGT2F + SGM_DairyCows + SGM_OtherCows)
< 2/3 ; 1/3 < SGM_Sheep < 2/3


443 Grazing livestock, various
----------
(SGM_PastureMeadow + SGM_Equidae + SGM_BovineLT1 + SGM_Bovine1_2M + SGM_Bovine1_2F + SGM_BovineGT2M -f SGM_BovineGT2F -f SGM_DairyCows + SGM_OtherCows
 + SGM_Sheep + SGM_Goats) > 2/3 ; excluding holdings in classes 41 , 42, 43, 441 and
442


511 Pigs, rearing
----------
SGM_PigsGT50kg > 2/3


512 Pigs, fattening
----------
( SGM_PigsLT20kg + SGM_PigsOther ) > 2/3


513 Pigs, mixed
----------
(SGM_PigsLT20kg + SGM_PigsGT50kg + SGM_PigsOther) > 2/3 ; SGM_PigsGT50kg < 2/3 ; (SGM_PigsLT20kg + SGM_PigsOther) < 2/3


521 Laying hens
----------
SGM_PoultryHens > 2/3


522 Table fowl
----------
SGM_PoultryBroil + SGM_PoultryOther > 2/3


523 Pigs and poultry, combined
----------
Bipolar : 1 /3 < (SGM_PigsLT20kg + SGM_PigsGT50kg + SGM_PigsOther) < 2/3 ; 1/3 < (SGM_PoultryBroil + SGM_PoultryHens + SGM_PoultryOther)
< 2/3


524 Pigs and poultry, various
----------
(SGM_PigsLT20kg + SGM_PigsGT50kg + SGM_PigsOther + SGM_PoultryBroil + SGM_PoultryHens + SGM_PoultryOther) > 2/3 ; excluding holdings
in classes 51 , 521 , 522 and 523


611 Horticulture and permanent crops
----------
Bipolar : 1 /3 < (SGM_VegMarket + SGM_VegUnderGlass + SGM_FlowersOutdoor + SGM_FlowersGlass) < 2/3 ; 1/3 < (SGM_PastureMeadow +
SGM_FruitBerry + SGM_Citrus + SGM_Olive + SGM_Vineyards + SGM_Nurseries + SGM_PermGlass) < 2/3


621 Field crops and horticulture
----------
Bipolar : 1/3 < (SGM_CommonWheat + SGM_Durum + SGM_Rye + SGM_Barley + SGM_Oats + SGM_GrainMaize + SGM_Rice -f
SGM_OtherCereals + SGM_DriedVeg + SGM_Potatoes + SGM_SugarBeet + SGM_FodderRoots + SGM_Industrial + SGM_VegOpenField.+ SGM_ForagePlants + SGM_Seeds
+ SGM_OtherCrops) < 2/3 ; 1/3 < (SGM_VegMarket + SGM_VegUnderGlass + SGM_FlowersOutdoor -f SGM_FlowersGlass) < 2/3


622 Field crops and vineyards
----------
Bipolar : 1/3 < (SGM_CommonWheat + SGM_Durum + SGM_Rye + SGM_Barley + SGM_Oats + SGM_GrainMaize + SGM_Rice +
SGM_OtherCereals + SGM_DriedVeg + SGM_Potatoes + SGM_SugarBeet + SGM_FodderRoots + SGM_Industrial + SGM_VegOpenField + SGM_ForagePlants + SGM_Seeds +
SGM_OtherCrops) < 2/3 ; 1/3 < SGM_Olive < 2/3


623 Field crops and fruit/permanent crops, other
----------
Bipolar : 1 /3 < (SGM_CommonWheat + SGM_Durum + SGM_Rye + SGM_Barley + SGM_Oats + SGM_GrainMaize + SGM_Rice +
SGM_OtherCereals + SGM_DriedVeg + SGM_Potatoes + SGM_SugarBeet + SGM_FodderRoots + SGM_Industrial + SGM_VegOpenField + SGM_ForagePlants + SGM_Seeds +
SGM_OtherCrops) < 2/3 ; 1/3 < (SGM_PastureMeadow + SGM_FruitBerry + SGM_Citrus + SGM_Olive + SGM_Vineyards + SGM_Nurseries +
SGM_PermGlass) < 2/3 ; SGM_Olive < 1 /3


624 Partially dominant held crops
----------
1/3 < (SGM_CommonWheat + SGM_Durum + SGM_Rye  + SGM_Barley -f SGM_Oats + SGM_GrainMaize -f SGM_Rice + SGM_OtherCereals +
SGM_DriedVeg + SGM_Potatoes + SGM_SugarBeet + SGM_FodderRoots + SGM_Industrial + SGM_VegOpenField + SGM_ForagePlants + SGM_Seeds + SGM_OtherCrops)
< 2/3 ; no other pole > 1/3


625 Partially dominant horticulture or permanent crops
----------
1/3 < (SGM_VegMarket + SGM_VegUnderGlass + SGM_FlowersOutdoor + SGM_FlowersGlass) or (SGM_PastureMeadow + SGM_FruitBerry + SGM_Citrus + SGM_Olive
+ SGM_Vineyards + SGM_Nurseries + SGM_PermGlass) < 2/3 ; no other pole > 1/3


711 Partially dominant dairying
----------
1/3 < (SGM_BovineLT1 + SGM_Bovine1_2F + SGM_BovineGT2F + SGM_DairyCows) < 2/3 ; SGM_DairyCows > 2/3 (SGM_BovineLT1 -f SGM_Bovine1_2F
+ SGM_BovineGT2F + SGM_DairyCows) ; (G/OJ + SGM_Equidae + SGM_BovineLT1 + SGM_Bovine1_2M + SGM_Bovine1_2F -f SGM_BovineGT2M + SGM_BovineGT2F
+ SGM_DairyCows + SGM_OtherCows + SGM_Sheep + SGM_Goats) < 2/3 ; no other pole > 1/3


712 Partially dominant grazing livestock other than dairying
----------
1/3 < (SGM_PastureMeadow + SGM_Equidae -f SGM_BovineLT1 + SGM_Bovine1_2M + SGM_Bovine1_2F + SGM_BovineGT2M + SGM_BovineGT2F + SGM_DairyCows +
SGM_OtherCows + SGM_Sheep + SGM_Goats) < 2/3 ; excluding holdings in class 711 ; no other
pole > 1/3


721 Pigs and poultry and dairying
----------
Bipolar : 1/3 < (SGM_BovineLT1 + SGM_Bovine1_2F + SGM_BovineGT2F + SGM_DairyCows) < 2/3 ; SGM_DairyCows > 2/3 (SGM_BovineLT1
+ SGM_Bovine1_2F + SGM_BovineGT2F + SGM_DairyCows); 1/3 < (SGM_PigsLT20kg + SGM_PigsGT50kg + SGM_PigsOther + SGM_PoultryBroil + SGM_PoultryHens
+ SGM_PoultryOther) < 2/3


722 Pigs and poultry and grazing livestock other than dairying
----------
Bipolar : 1/3 < (SGM_PastureMeadow + SGM_Equidae + SGM_BovineLT1 + SGM_Bovine1_2M + SGM_Bovine1_2F -f SGM_BovineGT2M + SGM_BovineGT2F +
SGM_DairyCows + SGM_OtherCows + SGM_Sheep + SGM_Goats) < 2/3 ; 1/3 < (SGM_PigsLT20kg + SGM_PigsGT50kg + SGM_PigsOther +
SGM_PoultryBroil + SGM_PoultryHens + SGM_PoultryOther) < 2/3 ; excluding holdings in class 721



723 Partially dominant pigs and poultry
----------
1/3 < (SGM_PigsLT20kg + SGM_PigsGT50kg + SGM_PigsOther + SGM_PoultryBroil + SGM_PoultryHens + SGM_PoultryOther) < 2/3 ; no other
pole > 1/3


811 Field crops with dairying
----------
Bipolar : 1 /3 < (SGM_CommonWheat + SGM_Durum + SGM_Rye + SGM_Barley + SGM_Oats + SGM_GrainMaize + SGM_Rice +
SGM_OtherCereals + SGM_DriedVeg + SGM_Potatoes + SGM_SugarBeet + SGM_FodderRoots + SGM_Industrial + SGM_VegOpenField + SGM_ForagePlants -f SGM_Seeds +
SGM_OtherCrops) < 2/3 ; 1/3 < (SGM_BovineLT1 + SGM_Bovine1_2F + SGM_BovineGT2F + SGM_DairyCows) < 2/3 ; SGM_DairyCows > 2/3
(SGM_BovineLT1 + SGM_Bovine1_2F + SGM_BovineGT2F + SGM_DairyCows) ; (SGM_CommonWheat + SGM_Durum + SGM_Rye + SGM_Barley + SGM_Oats +
SGM_GrainMaize + SGM_Rice + SGM_OtherCereals + SGM_DriedVeg + SGM_Potatoes + SGM_SugarBeet + SGM_FodderRoots + SGM_Industrial + SGM_VegOpenField +
SGM_ForagePlants + SGM_Seeds + SGM_OtherCrops) > (SGM_BovineLT1 + SGM_Bovine1_2F + SGM_BovineGT2F + SGM_DairyCows)


812 Dairying with held crops
----------
Bipolar : 1/3 < (SGM_CommonWheat + SGM_Durum + SGM_Rye + SGM_Barley + SGM_Oats + SGM_GrainMaize + SGM_Rice +
SGM_OtherCereals + SGM_DriedVeg + SGM_Potatoes + SGM_SugarBeet + SGM_FodderRoots + SGM_Industrial + SGM_VegOpenField + SGM_ForagePlants + SGM_Seeds
+ SGM_OtherCrops) < 2/3 ; 1/3 < (SGM_BovineLT1 + SGM_Bovine1_2F + SGM_BovineGT2F + SGM_DairyCows) < 2/3 ; SGM_DairyCows >
2/3 (SGM_BovineLT1 + SGM_Bovine1_2F + SGM_BovineGT2F + SGM_DairyCows); (SGM_BovineLT1 + SGM_Bovine1_2F + SGM_BovineGT2F + SGM_DairyCows) >
(SGM_CommonWheat + SGM_Durum + SGM_Rye + SGM_Barley + SGM_Oats + SGM_GrainMaize + SGM_Rice + SGM_OtherCereals + SGM_DriedVeg +
SGM_Potatoes + SGM_SugarBeet + SGM_FodderRoots + SGM_Industrial + SGM_VegOpenField + SGM_ForagePlants + SGM_Seeds + SGM_OtherCrops)


813 Field crops with grazing livestock other than dairying
----------
Bipolar : 1/3 < (SGM_CommonWheat + SGM_Durum + SGM_Rye + SGM_Barley + SGM_Oats + SGM_GrainMaize + SGM_Rice +
SGM_OtherCereals + SGM_DriedVeg + SGM_Potatoes + SGM_SugarBeet + SGM_FodderRoots + SGM_Industrial + SGM_VegOpenField + SGM_ForagePlants + SGM_Seeds +
SGM_OtherCrops) < 2/3 ; 1 /3 < (SGM_PastureMeadow + SGM_Equidae + SGM_BovineLT1 + SGM_Bovine1_2M + SGM_Bovine1_2F + SGM_BovineGT2M + SGM_BovineGT2F
+ SGM_DairyCows + SGM_OtherCows + SGM_Sheep + SGM_Goats) < 2/3 ; (SGM_CommonWheat + SGM_Durum + SGM_Rye + SGM_Barley
+ SGM_Oats + SGM_GrainMaize + SGM_Rice + SGM_OtherCereals + SGM_DriedVeg + SGM_Potatoes + SGM_SugarBeet + SGM_FodderRoots + SGM_Industrial
+ SGM_VegOpenField + SGM_ForagePlants + SGM_Seeds + SGM_OtherCrops) > (SGM_PastureMeadow + SGM_Equidae + SGM_BovineLT1 + SGM_Bovine1_2M +
SGM_Bovine1_2F + SGM_BovineGT2M + SGM_BovineGT2F + SGM_DairyCows + SGM_OtherCows + SGM_Sheep + SGM_Goats); excluding
holdings in classes 811 and 812


814 Grazing livestock other than dairying with field crops
----------
Bipolar : 1/3 < (SGM_CommonWheat + SGM_Durum + SGM_Rye + SGM_Barley + SGM_Oats + SGM_GrainMaize + SGM_Rice 
SGM_OtherCereals + SGM_DriedVeg + SGM_Potatoes + SGM_SugarBeet + SGM_FodderRoots + SGM_Industrial + SGM_VegOpenField + SGM_ForagePlants + SGM_Seeds +
SGM_OtherCrops) < 2/3 ; 1/3 < ( SGM_PastureMeadow + SGM_Equidae + SGM_BovineLT1 + SGM_Bovine1_2M + SGM_Bovine1_2F + SGM_BovineGT2M +
SGM_BovineGT2F + SGM_DairyCows + SGM_OtherCows + SGM_Sheep + SGM_Goats) < 2/3 ; (SGM_PastureMeadow + SGM_Equidae + SGM_BovineLT1 +
SGM_Bovine1_2M + SGM_Bovine1_2F + SGM_BovineGT2M + SGM_BovineGT2F + SGM_DairyCows + SGM_OtherCows + SGM_Sheep + SGM_Goats) > (SGM_CommonWheat
+ SGM_Durum + SGM_Rye + SGM_Barley + SGM_Oats + SGM_GrainMaize + SGM_Rice + SGM_OtherCereals + SGM_DriedVeg + SGM_Potatoes
+ SGM_SugarBeet + SGM_FodderRoots + SGM_Industrial + SGM_VegOpenField + SGM_ForagePlants + SGM_Seeds + SGM_OtherCrops); excluding
holdings in classes 811 and 812


821 Field crops and pigs and poultry
----------
Bipolar : 1/3 < (SGM_CommonWheat + SGM_Durum + SGM_Rye + SGM_Barley + SGM_Oats + SGM_GrainMaize + SGM_Rice +
SGM_OtherCereals + SGM_DriedVeg + SGM_Potatoes + SGM_SugarBeet + SGM_FodderRoots + SGM_Industrial + SGM_VegOpenField + SGM_ForagePlants + SGM_Seeds
+ SGM_OtherCrops) < 2/3 ; 1 /3 < (SGM_PigsLT20kg + SGM_PigsGT50kg + SGM_PigsOther + SGM_PoultryBroil + SGM_PoultryHens + SGM_PoultryOther)
< 2/3


822 Crops --- livestock, various
----------
All types of holdings not covered above



 - - - - - - - - - - - - - - - - - - - - - - - - - - - */
