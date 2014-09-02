* This file assigns farms to Principal Types according to the 
*   NFS/FADN Typology. Necessary SGMs are calculated on each farm. 
*   See 78/443/EEC and subsequent amendments. 


qui mvencode _all, mv(0) override

label var YE_AR  "Year"
label var YE_AR "Year"

*-------------------------------------------------------------------- 
* Reference material
*-------------------------------------------------------------------- 
* CELEX-31985D0377




*-------------------------------------------------------------------- 
* Assignment of General Types
*-------------------------------------------------------------------- 
* Create empty variable for General Type codes. 
capture drop GeneralType
gen int GeneralType = .
label var GeneralType ///
  "General Type per CELEX-31985D0377"


* ... and Threshold variables
capture drop Threshol*
gen double Threshold = .
gen double Threshold2= . 
label var Threshold ///
  "Threshold for farm types. Delete if found in data."
label var Threshold2 ///
  "Threshold for farm types. Delete if found in data."


* - - - - - - - - - - - - - - - - - - - - - - - - - -
local title "Spec. field crops"
local code  = 1
* - - - - - - - - - - - - - - - - - - - - - - - - - -
  * Relevant threshold(s) 
  replace Threshold = (2/3) * SGM_Farm
  
  * Update farm type variable
  replace GeneralType = `code' ///
    if P`code' > Threshold

  label define GeneralType `code' "`title'", modify
  label values GeneralType GeneralType 


* - - - - - - - - - - - - - - - - - - - - - - - - - -
local title "Spec. horticulture"
local code  = 2
* - - - - - - - - - - - - - - - - - - - - - - - - - -
  * Relevant threshold(s) 
  replace Threshold = (2/3) * SGM_Farm
  
  * Update farm type variable
  replace GeneralType = `code' ///
    if P`code' > Threshold

  label define GeneralType `code' "`title'", modify
  label values GeneralType GeneralType 


* - - - - - - - - - - - - - - - - - - - - - - - - - -
local title "Spec. permanent crops"
local code  = 3
* - - - - - - - - - - - - - - - - - - - - - - - - - -
  * Relevant threshold(s) 
  replace Threshold = (2/3) * SGM_Farm
  
  * Update farm type variable
  replace GeneralType = `code' ///
    if P`code' > Threshold

  label define GeneralType `code' "`title'", modify
  label values GeneralType GeneralType 


* - - - - - - - - - - - - - - - - - - - - - - - - - -
local title "Spec. grazing livestock"
local code  = 4
* - - - - - - - - - - - - - - - - - - - - - - - - - -
  * Relevant threshold(s) 
  replace Threshold = (2/3) * SGM_Farm
  
  * Update farm type variable
  replace GeneralType = `code' ///
    if P`code' > Threshold

  label define GeneralType `code' "`title'", modify
  label values GeneralType GeneralType 


* - - - - - - - - - - - - - - - - - - - - - - - - - -
local title "Spec. granivores"
local code  = 5
* - - - - - - - - - - - - - - - - - - - - - - - - - -
  * Relevant threshold(s) 
  replace Threshold = (2/3) * SGM_Farm
  
  * Update farm type variable
  replace GeneralType = `code' ///
    if P`code' > Threshold

  label define GeneralType `code' "`title'", modify
  label values GeneralType GeneralType 


* - - - - - - - - - - - - - - - - - - - - - - - - - -
local title "Mixed cropping"
local code  = 6
* - - - - - - - - - - - - - - - - - - - - - - - - - -
  * Relevant threshold(s) 
  replace Threshold = (2/3) * SGM_Farm
  
  * Update farm type variable
  replace GeneralType = `code'    ///
    if (P1 + P2 + P3) >  Threshold & ///
        P1            <= Threshold & ///
        P2            <= Threshold & ///
        P3            <= Threshold

  label define GeneralType `code' "`title'", modify
  label values GeneralType GeneralType 


* - - - - - - - - - - - - - - - - - - - - - - - - - -
local title "Mixed livestock holdings"
local code  = 7
* - - - - - - - - - - - - - - - - - - - - - - - - - -
  * Relevant threshold(s) 
  replace Threshold = (2/3) * SGM_Farm
  
  * Update farm type variable
  replace GeneralType = `code' ///
    if (P4 + P5)      >  Threshold & ///
        P4            <= Threshold & ///
        P5            <= Threshold

  label define GeneralType `code' "`title'", modify
  label values GeneralType GeneralType 


* - - - - - - - - - - - - - - - - - - - - - - - - - -
local title "Mixed crops -livestock"
local code  = 8
* - - - - - - - - - - - - - - - - - - - - - - - - - -
  * Relevant threshold(s) 
  replace Threshold = (1/3) * SGM_Farm
  
  * Update farm type variable. Do after classes 1 - 7!
  replace GeneralType = `code' ///
    if  P1            >  Threshold & ///
        P4            >  Threshold & ///
        missing(GeneralType) // only from missing, excludes 1-7.

  label define GeneralType `code' "`title'", modify
  label values GeneralType GeneralType 


* - - - - - - - - - - - - - - - - - - - - - - - - - -
local title "Non-classified holdings"
local code  = 9
* - - - - - - - - - - - - - - - - - - - - - - - - - -
  * Relevant threshold(s) - none
  
  * Update farm type variable
  replace GeneralType = `code' ///
    if SGM_Farm == 0

  label define GeneralType `code' "`title'", modify
  label values GeneralType GeneralType 


table GeneralType YE_AR, missing


*-------------------------------------------------------------------- 
* Assignment of Principal Types
*-------------------------------------------------------------------- 

* Create empty variable for Principal Type codes. 
capture drop PrincipalType
gen int PrincipalType = .
label var PrincipalType ///
  "Principal Type per CELEX-31985D0377"


* - - - - - - - - - - - - - - - - - - - - - - - - - -
local title "Cereals"
local code  = 11
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  * Relevant threshold(s) 
  replace Threshold = (2/3) * SGM_Farm
  
  * Update farm type variable
  replace PrincipalType = `code'           ///
    if  P`code'             >  Threshold & ///
        GeneralType == real(substr("`code'", 1, 1))


  label define PrincipalType `code' "`title'", modify
  label values PrincipalType PrincipalType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab PrincipalType YE_AR, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -
* - - - - - - - - - - - - - - - - - - - - - - - - - -


* - - - - - - - - - - - - - - - - - - - - - - - - - -
local title "Gen. field cropping"
local code  = 12
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  * Relevant threshold(s) 
  replace Threshold = (2/3) * SGM_Farm
  
  * Update farm type variable
  replace PrincipalType = `code'           ///
    if  P11                 <= Threshold & ///
        GeneralType == real(substr("`code'", 1, 1))


  label define PrincipalType `code' "`title'", modify
  label values PrincipalType PrincipalType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab PrincipalType YE_AR, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -
* - - - - - - - - - - - - - - - - - - - - - - - - - -


* - - - - - - - - - - - - - - - - - - - - - - - - - -
local title "Spec. Horticulture"
local code  = 20
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  * Relevant threshold(s) - None
  
  * Update farm type variable
  replace PrincipalType = `code'                          ///
    if  GeneralType == real(substr("`code'", 1, 1))
        


  label define PrincipalType `code' "`title'", modify
  label values PrincipalType PrincipalType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab PrincipalType YE_AR, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -
* - - - - - - - - - - - - - - - - - - - - - - - - - -


* - - - - - - - - - - - - - - - - - - - - - - - - - -
local title "Spec. Vineyards"
local code  = 31
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  * Relevant threshold(s) 
  replace Threshold = (2/3) * SGM_Farm
  
  * Update farm type variable
  replace PrincipalType = `code'                          ///
    if  SGM_Vineyards                      >  Threshold & ///
        GeneralType == real(substr("`code'", 1, 1))
        


  label define PrincipalType `code' "`title'", modify
  label values PrincipalType PrincipalType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab PrincipalType YE_AR, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -
* - - - - - - - - - - - - - - - - - - - - - - - - - -


* - - - - - - - - - - - - - - - - - - - - - - - - - -
local title "Spec. Fruit"
local code  = 32
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  * Relevant threshold(s) 
  replace Threshold = (2/3) * SGM_Farm
  
  * Update farm type variable
  replace PrincipalType = `code'                          ///
    if  (SGM_FruitBerry + SGM_Citrus)      >  Threshold & ///
        GeneralType == real(substr("`code'", 1, 1))
        


  label define PrincipalType `code' "`title'", modify
  label values PrincipalType PrincipalType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab PrincipalType YE_AR, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -
* - - - - - - - - - - - - - - - - - - - - - - - - - -


* - - - - - - - - - - - - - - - - - - - - - - - - - -
local title "Spec. Olives"
local code  = 33
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  * Relevant threshold(s) 
  replace Threshold = (2/3) * SGM_Farm
  
  * Update farm type variable
  replace PrincipalType = `code'                          ///
    if  SGM_Olive                          >  Threshold & ///
        GeneralType == real(substr("`code'", 1, 1))
        


  label define PrincipalType `code' "`title'", modify
  label values PrincipalType PrincipalType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab PrincipalType YE_AR, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -
* - - - - - - - - - - - - - - - - - - - - - - - - - -


* - - - - - - - - - - - - - - - - - - - - - - - - - -
local title "Various permanent crops"
local code  = 34
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  * Relevant threshold(s) 
  replace Threshold = (2/3) * SGM_Farm
  
  * Update farm type variable
  replace PrincipalType = `code'                          ///
    if  missing(PrincipalType)             >  Threshold & ///
        GeneralType == real(substr("`code'", 1, 1))
        


  label define PrincipalType `code' "`title'", modify
  label values PrincipalType PrincipalType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab PrincipalType YE_AR, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -
* - - - - - - - - - - - - - - - - - - - - - - - - - -


* - - - - - - - - - - - - - - - - - - - - - - - - - -
local title "Dairying"
local code  = 41
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  * Relevant threshold(s) 
  replace Threshold  =  (2/3) * SGM_Farm
  replace Threshold2 =  (2/3) * P41
  
  * Update farm type variable
  replace PrincipalType = `code'                        ///
    if  P41                                >  Threshold  & ///
        SGM_DairyCows                      >  Threshold2 & ///
        GeneralType == real(substr("`code'", 1, 1))
        


  label define PrincipalType `code' "`title'", modify
  label values PrincipalType PrincipalType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab PrincipalType YE_AR, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -
* - - - - - - - - - - - - - - - - - - - - - - - - - -


* - - - - - - - - - - - - - - - - - - - - - - - - - -
local title "Cattle Rearing"
local code  = 42
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  * Relevant threshold(s) 
  replace Threshold  = (2/3)  * SGM_Farm
  replace Threshold2 = (1/10) * SGM_Farm
  
  * Update farm type variable
  replace PrincipalType = `code'                          ///
    if  P42                                >  Threshold  & ///
        SGM_DairyCows                      <= Threshold2 & ///
        GeneralType == real(substr("`code'", 1, 1))
        


  label define PrincipalType `code' "`title'", modify
  label values PrincipalType PrincipalType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab PrincipalType YE_AR, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -
* - - - - - - - - - - - - - - - - - - - - - - - - - -


* - - - - - - - - - - - - - - - - - - - - - - - - - -
local title "Dairy/Cattle"
local code  = 43 
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  * Relevant threshold(s) 
  replace Threshold  = (2/3)  * SGM_Farm
  replace Threshold2 = (1/10) * SGM_Farm
  
  * Update farm type variable
  replace PrincipalType = `code'                          ///
    if  P42                                >  Threshold  & ///
        SGM_DairyCows                      >  Threshold2 & ///
        PrincipalType                      != 41         & ///
        GeneralType == real(substr("`code'", 1, 1))
        


  label define PrincipalType `code' "`title'", modify
  label values PrincipalType PrincipalType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab PrincipalType YE_AR, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -
* - - - - - - - - - - - - - - - - - - - - - - - - - -


* - - - - - - - - - - - - - - - - - - - - - - - - - -
local title "Sheep, goats, other"
local code  = 44
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  * Relevant threshold(s) 
  replace Threshold = (2/3) * SGM_Farm
  
  * Update farm type variable
  replace PrincipalType = `code'                          ///
    if  P42                               <=  Threshold & ///
        GeneralType == real(substr("`code'", 1, 1))
        


  label define PrincipalType `code' "`title'", modify
  label values PrincipalType PrincipalType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab PrincipalType YE_AR, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -
* - - - - - - - - - - - - - - - - - - - - - - - - - -


* - - - - - - - - - - - - - - - - - - - - - - - - - -
local title "Spec. granivores"
local code  = 50
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  * Relevant threshold(s) 
  replace Threshold = (2/3) * SGM_Farm
  
  * Update farm type variable
  replace PrincipalType = `code'                          ///
    if GeneralType == real(substr("`code'", 1, 1))
        
        


  label define PrincipalType `code' "`title'", modify
  label values PrincipalType PrincipalType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab PrincipalType YE_AR, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -
* - - - - - - - - - - - - - - - - - - - - - - - - - -

/*
* - - - - - - - - - - - - - - - - - - - - - - - - - -
local title "Mixed cropping"
local code  = 60 
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  * Relevant threshold(s) 
  replace Threshold = (2/3) * SGM_Farm
  
  * Update farm type variable
  replace PrincipalType = `code'                          ///
    if  missing(PrincipalType)             >  Threshold & ///
        GeneralType == real(substr("`code'", 1, 1))
        


  label define PrincipalType `code' "`title'", modify
  label values PrincipalType PrincipalType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab PrincipalType YE_AR, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -
* - - - - - - - - - - - - - - - - - - - - - - - - - -


* - - - - - - - - - - - - - - - - - - - - - - - - - -
local title ""
local code  = 
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  * Relevant threshold(s) 
  replace Threshold = (2/3) * SGM_Farm
  
  * Update farm type variable
  replace PrincipalType = `code'                          ///
    if  missing(PrincipalType)             >  Threshold & ///
        GeneralType == real(substr("`code'", 1, 1))
        


  label define PrincipalType `code' "`title'", modify
  label values PrincipalType PrincipalType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab PrincipalType YE_AR, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -
* - - - - - - - - - - - - - - - - - - - - - - - - - -
*/

drop Threshol*
