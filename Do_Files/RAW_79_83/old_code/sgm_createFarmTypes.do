* This file uses calculated SGMs to create a system variable for NFS farm data using the NFS/FADN farm typology.

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



* - - - - - - - - - - - - - - - - - - - - - - - - - - -
* - - - - - - - - - - - - - - - - - - - - - - - - - - -


* From A-Z of FADN methodology p. 26
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

* From Commission Decision 78/463/EEC
* Composition and thresholds
/* - - - - - - - - - - - - - - - - - - - - - - - - - - -

**Principal types**
--------------------

11 Cereals
----------
E/01
E/02
E/03
E/04
E/05
E/06
E/07
E/08
Threshold:  > 2/3


12 Field Crops, other
----------
E/01
E/02
E/03
E/04
E/05
E/06
E/07
E/08
E/09
E/10
E/11
E/12
E/13
E/14a
E/18
E/19
E/20
Threshold: > 2/3 & Cereals threshold not met


21 Horticulture12 Field Crops, other
----------
E/ 14b
E/ 15
E/ 16
E/17
Threshold:  > 2/3


31 Vineyards
----------
H/04
Threshold:  > 2/3


32 Fruit/permanent crops, other
----------
H/01
H/02
H/03
H/04
H/05
H/06
H/07
Threshold: > 2/3 & Vineyards threshold not met


41 Cattle, dairying 
----------
K/02
K/04
K/06
K/07
Threshold:  > 2/3 & 
       K/07 > 2/3 K/02
                  K/04
                  K/06
                  K/07


42 Cattle, rearing/fattening
----------
K/02
K/03
K/04
K/05
K/06
K/07
K/08
Threshold:  > 2/3 & 
       K/07 < 1/10

43 Cattle, mixed
----------
K/02
K/03
K/04
K/05
K/06
K/07
K/08 
Threshold:  > 2/3   & 
       K/07 > 1/ 10 &
       excluding holdings in class 41


44 Grazing livestock, other
----------
G/01
K/01
K/02
K/03
K/04
K/05
K/06
K/07
K/08
K/09
K/10
Threshold: > 2/3 & 
      K/02
      K/03
      K/04
      K/05
      K/06
      K/07
      K/08 < 2/3


51 Pigs
----------
K/ll
K/12
K/13
Threshold: > 2/3

52 Pigs and poultry, other
----------
K/11
K/12
K/13
K/14
K/15
K/16
Threshold:  > 2/3 & 
       K/11
       K/12  
       K/13 < 2/3



61 Horticulture and permanent crops
----------
Bipolar : 
1/3 <
      E/14b
      E/15
      E/16
      E/17
            < 2/3 &
1/3 < H/01
      H/02
      H/03
      H/04
      H/05
      H/06
      H/07  < 2/3


62 Mixed cropping, other
----------
Bipolars : 
1/3 < E/01
      E/02
      E/03
      E/04
      E/05
      E/06
      E/07
      E/08
      E/09
      E/10
      E/ 11
      E/12
      E/13
      E/14a
      E/18
      E/19
      E/20  < 2/3 & 
1/3 < E/14b
      E/15
      E/16
      E/17  |  H/01
               H/02
               H/03
               H/04
               H/05
               H/06
               H/07 < 2/3
Partially dominant : 
1/3 < (E/01
       E/02
       E/03
       E/04
       E/05
       E/06
       E/07
       E/08
       E/09
       E/10
       E/11
       E/12
       E/13
       E/14a 
       E/18
       E/19
       E/20   |  E/14b
                 E/15
                 E/16
                 E/17) | H/01
                         H/02
                         H/03
                         H/04
                         H/05
                         H/06
                         H/07  < 2/3 & 
no other pole > 1 /3


71 Partially dominant grazing livestock
----------
1/3 < G/01
      K/01
      K/02
      K/03
      K/04
      K/05
      K/06
      K/07
      K/08
      K/09
      K/10 < 2/3 & no other pole > 1/3


72 Mixed livestock, other
----------
Bipolar : 
1/3 < G/01
      K/01
      K/02
      K/03
      K/04
      K/05
      K/06
      K/07
      K/08
      K/09
      K/ 10 < 2/3 & 
1/3 < K/11
      K/12
      K/13
      K/14
      K/15
      K/16 < 2/3
Partially dominant : 
1 /3 < K/11
       K/12
       K/13
       K/14
       K/15
       K/16 < 2/3 &
no other pole > 1/3


81 Field crops and grazing livestock
----------
Bipolar : 
1/3 < E/01
      E/02
      E/03
      E/04
      E/05
      E/06
      E/07
      E/08
      E/09
      E/10
      E/11
      E/12
      E/13
      E/14a
      E/18
      E/19
      E/20 < 2/3 &
1 /3 < G/01
       K/01
       K/02
       K/03
       K/04
       K/05
       K/06
       K/07
       K/08
       K/09
       K/10 < 2/3


82 Crops --- livestock, other
----------
All types of holdings not covered above





**Particular types**
--------------------
111 Cereals, excluding rice
----------
(E/01 + E/02 + E/03 + E/04 + E/05 + E/06 + E/08) > 2/3


112 Rice
----------
E/07 > 2/3


113 Cereals, including rice
----------
(E/01 + E/02 + E/03 + E/04 + E/05 + E/06 + E/07 + E/08) > 2/3 ;
 E/01 + E/02 + E/03 + E/04 + E/05 + E/06 + E/08) < 2/3 ; E/07 < 2/3


121 Roots
----------
(E/10 + E/ll + E/12) > 2/3


122 Cereals and roots
----------
Bipolar : 1 /3 < (E/01 + E/02 + E/03 + E/04 + E/05 + E/06 + E/07 +
E/08) < 2/3 ; 1/3 < (E/ 10 + E/11 + E/12) < 2/3


123 Field crops, various (*)
----------
(E/01 -h E/02 + E/03 + E/04 + E/05 + E/06 + E/07 + E/08 + E/09 +
E/ 10 + E/ 11 + E/ 12 + E/13 + E/ 14a + E/18 + E/+- E/20) > 2/ 3 ;
excluding in classes 11 , 121 and 122


211 Market garden vegetables, open air
----------
E/ 14b > 2/3


212 Market garden vegetables , under glass
----------
E/15 > 2/3


213 Market garden vegetables, open air/under glass
----------
(E/14b + E/15) > 2/3 ; E/14b < 2/3 ; E/15 < 2/3


214 Flowers, open air
----------
E/ 16 > 2/3


215 Flowers, under glass
----------
E/ 17 > 2/3


216 Flowers, open air/under glass
----------
(E/ 16 + E/17) > 2/3 ; E/16 < 2/3 ; E/17 < 2/3


217 Horticulture, various (**)
----------
(E/ 14b + E/ 15 + E/ 16 + E/ 17) > 2/3 ; E/ 14b < 2/3 ; E/ 15 < 2/3 ; (E/14b
+ E/15) < 2/3 ; E/ 16 < 2/3 ; E/ 17 < 2/3 ; (E/ 16 + E/ 17) < 2/3


311 Quality wine (***)
----------
H/04/a > 2/3


Table wine (***)
----------
H/04/b > 2/3


313 Table grapes (***)
----------
H/04/c > 2/3


314 Vineyards, mixed (***)
----------
(H/04/a + H/04/b + H/04/c) > 2/3 ; H/04/a < 2/3 ; H/04/b < 2/3 ;
H/04/c < 2/3


321 Fruit, excluding citrus
----------
H/01 > 2/3


322 Citrus
----------
H/02 > 2/3


323 Olives
----------
H/03 > 2/3


324 Permanent crops, various
----------
(H/01 + H/02 + H/03 + H/04 + H/05 + H/06 + H/07) > 2/3 ; H/01
< 2/3 ; H/02 < 2/3 ; H/03 < 2/3 ; H/04 < 2/3


411 Specialized dairying
----------
K/07 > 2/3


412 Dairying, other
----------
(K/02 + K/04 + K/06 + K/07) > 2/3 ; K/07 < 2/3 ; K/07 > 2/3 (K/02 +
K/04 + K/06 + K/07)


421 Cattle, rearing/fattening, suckling
----------
(K/02 + K/03 + K/04 + K/05 + K/06 + K/07 + K/08) > 2/3 ; K/07 <
1/10 ; K/08 > 1/3


422 Cattle, rearing/fattening, other
----------
(K/02 + K/03 + K/04 + K/05 + K/06 + K/07 + K/08) > 2/3 ; K/07 <
1 /10 ; K/08 < 1 /3


Dairying with cattle rearing/fattening
----------
(K/02 + K/03 + K/04 + K/05 + K/06 + K/07 + K/08) > 2/3 ; K/07 >
1/4 ; excluding holdings in class 41


432 Cattle rearing/fattening with dairying
----------
(K/02 + K/03 + K/04 + K/05 + K/06 + K/07 + K/08) > 2/3 ; 1/10 <
K/07 < 1 /4


441 Sheep
----------
K/09 > 2/3


442 Cattle and sheep
----------
Bipolar : 1/3 < (K/02 + K/03 + K/04 + K/05 + K/06 + K/07 + K/08)
< 2/3 ; 1/3 < K/09 < 2/3


443 Grazing livestock, various
----------
(G/01 + K/01 + K/02 + K/03 + K/04 + K/05 -f K/06 -f K/07 + K/08
 + K/09 + K/ 10) > 2/3 ; excluding holdings in classes 41 , 42, 43, 441 and
442


511 Pigs, rearing
----------
K/ 12 > 2/3


512 Pigs, fattening
----------
( K/ ll + K/ 13 ) > 2/3


513 Pigs, mixed
----------
(K/ll + K/ 12 + K/13) > 2/3 ; K/12 < 2/3 ; (K/ ll + K/ 13) < 2/3


521 Laying hens
----------
K/ 15 > 2/3


522 Table fowl
----------
K/14 + K/ 16 > 2/3


523 Pigs and poultry, combined
----------
Bipolar : 1 /3 < (K/ ll + K/12 + K/13) < 2/3 ; 1/3 < (K/ 14 + K/ 15 + K/ 16)
< 2/3


524 Pigs and poultry, various
----------
(K/ll + K/12 + K/13 + K/14 + K/15 + K/ 16) > 2/3 ; excluding holdings
in classes 51 , 521 , 522 and 523


611 Horticulture and permanent crops
----------
Bipolar : 1 /3 < (E/14b + E/15 + E/16 + E/17) < 2/3 ; 1/3 < (H/01 +
H/02 + H/03 + H/04 + H/05 + H/06 + H/07) < 2/3


621 Field crops and horticulture
----------
Bipolar : 1/3 < (E/01 + E/02 + E/03 + E/04 + E/05 + E/06 + E/07 -f
E/08 + E/09 + E/10 + E/ ll + E/12 + E/13 + E/14a.+ E/18 + E/19
+ E/20) < 2/3 ; 1/3 < (E/14b + E/15 + E/16 -f E/17) < 2/3


622 Field crops and vineyards
----------
Bipolar : 1/3 < (E/01 + E/02 + E/03 + E/04 + E/05 + E/06 + E/07 +
E/08 + E/09 + E/ 10 + E/ll + E/12 + E/13 + E/14a + E/18 + E/19 +
E/20) < 2/3 ; 1/3 < H/04 < 2/3


623 Field crops and fruit/permanent crops, other
----------
Bipolar : 1 /3 < (E/01 + E/02 + E/03 + E/04 + E/05 + E/06 + E/07 +
E/08 + E/09 + E/10 + E/11 + E/12 + E/13 + E/14a + E/18 + E/19 +
E/20) < 2/3 ; 1/3 < (H/01 + H/02 + H/03 + H/04 + H/05 + H/06 +
H/07) < 2/3 ; H/04 < 1 /3


624 Partially dominant held crops
----------
1/3 < (E/01 + E/02 + E/03 + E/04 -f E/05 + E/06 -f E/07 + E/08 +
E/09 + E/10 + E/ 11 + E/12 + E/13 + E/14a + E/18 + E/19 + E/20)
< 2/3 ; no other pole > 1/3


625 Partially dominant horticulture or permanent crops
----------
1/3 < (E/14b + E/15 + E/16 + E/17) or (H/01 + H/02 + H/03 + H/04
+ H/05 + H/06 + H/07) < 2/3 ; no other pole > 1/3


711 Partially dominant dairying
----------
1/3 < (K/02 + K/04 + K/06 + K/07) < 2/3 ; K/07 > 2/3 (K/02 -f K/04
+ K/06 + K/07) ; (G/OJ + K/01 + K/02 + K/03 + K/04 -f K/05 + K/06
+ K/07 + K/08 + K/09 + K/10) < 2/3 ; no other pole > 1/3


712 Partially dominant grazing livestock other than dairying
----------
1/3 < (G/01 + K/01 -f K/02 + K/03 + K/04 + K/05 + K/06 + K/07 +
K/08 + K/09 + K/10) < 2/3 ; excluding holdings in class 711 ; no other
pole > 1/3


721 Pigs and poultry and dairying
----------
Bipolar : 1/3 < (K/02 + K/04 + K/06 + K/07) < 2/3 ; K/07 > 2/3 (K/02
+ K/04 + K/06 + K/07); 1/3 < (K/11 + K/12 + K/13 + K/14 + K/15
+ K/16) < 2/3


722 Pigs and poultry and grazing livestock other than dairying
----------
Bipolar : 1/3 < (G/01 + K/01 + K/02 + K/03 + K/04 -f K/05 + K/06 +
K/07 + K/08 + K/09 + K/10) < 2/3 ; 1/3 < (K/11 + K/12 + K/13 +
K/14 + K/15 + K/16) < 2/3 ; excluding holdings in class 721



723 Partially dominant pigs and poultry
----------
1/3 < (K/11 + K/12 + K/13 + K/14 + K/15 + K/16) < 2/3 ; no other
pole > 1/3


811 Field crops with dairying
----------
Bipolar : 1 /3 < (E/01 + E/02 + E/03 + E/04 + E/05 + E/06 + E/07 +
E/08 + E/09 + E/ 10 + E/ 11 + E/ 12 + E/ 13 + E/ 14a + E/ 18 -f E/ 19 +
E/20) < 2/3 ; 1/3 < (K/02 + K/04 + K/06 + K/07) < 2/3 ; K/07 > 2/3
(K/02 + K/04 + K/06 + K/07) ; (E/01 + E/02 + E/03 + E/04 + E/05 +
E/06 + E/07 + E/08 + E/09 + E/10 + E/ 11 + E/12 + E/ 13 + E/14a +
E/18 + E/ 19 + E/20) > (K/02 + K/04 + K/06 + K/07)


812 Dairying with held crops
----------
Bipolar : 1/3 < (E/01 + E/02 + E/03 + E/04 + E/05 + E/06 + E/07 +
E/08 + E/09 + E/ 10 + E/ 11 + E/ 12 + E/ 13 + E/ 14a + E/ 18 + E/19
+ E/20) < 2/3 ; 1/3 < (K/02 + K/04 + K/06 + K/07) < 2/3 ; K/07 >
2/3 (K/02 + K/04 + K/06 + K/07); (K/02 + K/04 + K/06 + K/07) >
(E/01 + E/02 + E/03 + E/04 + E/05 + E/06 + E/07 + E/08 + E/09 +
E/10 + E/11 + E/12 + E/13 + E/14a + E/18 + E/19 + E/20)


813 Field crops with grazing livestock other than dairying
----------
Bipolar : 1/3 < (E/01 + E/02 + E/03 + E/04 + E/05 + E/06 + E/07 +
E/08 + E/09 + E/ 10 + E/ 11 + E/ 12 + E/ 13 + E/ 14a + E/ 18 + E/19 +
E/20) < 2/3 ; 1 /3 < (G/01 + K/01 + K/02 + K/03 + K/04 + K/05 + K/06
+ K/07 + K/08 + K/09 + K/10) < 2/3 ; (E/01 + E/02 + E/03 + E/04
+ E/05 + E/06 + E/07 + E/08 + E/09 + E/ 10 + E/11 + E/ 12 + E/13
+ E/14a + E/18 + E/19 + E/20) > (G/01 + K/01 + K/02 + K/03 +
K/04 + K/05 + K/06 + K/07 + K/08 + K/09 + K/10); excluding
holdings in classes 811 and 812


814 Grazing livestock other than dairying with field crops
----------
Bipolar : 1/3 < (E/01 + E/02 + E/03 + E/04 + E/05 + E/06 + E/07 +
E/08 + E/09 + E/ 10 + E/11 + E/12 + E/ 13 + E/ 14a + E/ 18 + E/ 19 +
E/20) < 2/3 ; 1/3 < ( G/01 + K/01 + K/02 + K/03 + K/04 + K/05 +
K/06 + K/07 + K/08 + K/09 + K/10) < 2/3 ; (G/01 + K/01 + K/02 +
K/03 + K/04 + K/05 + K/06 + K/07 + K/08 + K/09 + K/10) > (E/01
+ E/02 + E/03 + E/04 + E/05 + E/06 + E/07 + E/08 + E/09 + E/10
+ E/11 + E/12 + E/ 13 + E/14a + E/18 + E/19 + E/20); excluding
holdings in classes 811 and 812


821 Field crops and pigs and poultry
----------
Bipolar : 1/3 < (E/01 + E/02 + E/03 + E/04 + E/05 + E/06 + E/07 +
E/08 + E/09 + E/ 10 + E/ 11 + E/ 12 + E/13 + E/ 14a + E/18 + E/19
+ E/20) < 2/3 ; 1 /3 < (K/11 + K/12 + K/13 + K/14 + K/15 + K/16)
< 2/3


822 Crops --- livestock, various
----------
All types of holdings not covered above


----------
----------
----------
----------
----------
----------
----------
----------
----------
----------
Bipolar : 1 /3 < (E/01 + E/02 + E/03 + E/04 + E/05 + E/06 + E/07 +
Bipolar : 1 /3 < (E/01 + E/02 + E/03 + E/04 + E/05 + E/06 + E/07 +
Bipolar : 1 /3 < (E/01 + E/02 + E/03 + E/04 + E/05 + E/06 + E/07 +
Bipolar : 1 /3 < (E/01 + E/02 + E/03 + E/04 + E/05 + E/06 + E/07 +
Bipolar : 1 /3 < (E/01 + E/02 + E/03 + E/04 + E/05 + E/06 + E/07 +
Bipolar : 1 /3 < (E/01 + E/02 + E/03 + E/04 + E/05 + E/06 + E/07 +
Bipolar : 1 /3 < (E/01 + E/02 + E/03 + E/04 + E/05 + E/06 + E/07 +
Bipolar : 1 /3 < (E/01 + E/02 + E/03 + E/04 + E/05 + E/06 + E/07 +
Bipolar : 1 /3 < (E/01 + E/02 + E/03 + E/04 + E/05 + E/06 + E/07 +
Bipolar : 1 /3 < (E/01 + E/02 + E/03 + E/04 + E/05 + E/06 + E/07 +
Bipolar : 1 /3 < (E/01 + E/02 + E/03 + E/04 + E/05 + E/06 + E/07 +
Bipolar : 1 /3 < (E/01 + E/02 + E/03 + E/04 + E/05 + E/06 + E/07 +
Bipolar : 1 /3 < (E/01 + E/02 + E/03 + E/04 + E/05 + E/06 + E/07 +
Bipolar : 1 /3 < (E/01 + E/02 + E/03 + E/04 + E/05 + E/06 + E/07 +
Bipolar : 1 /3 < (E/01 + E/02 + E/03 + E/04 + E/05 + E/06 + E/07 +
 - - - - - - - - - - - - - - - - - - - - - - - - - - - */
