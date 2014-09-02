* This file assigns farms to Principal Types according to the 
*   NFS/FADN Typology. Necessary SGMs are calculated on each farm. 
*   See 78/443/EEC and subsequent amendments. 


qui mvencode _all, mv(0) override

label var YE_AR  "Year"
label var YE_AR "Year"

*-------------------------------------------------------------------- 
* Reference material
*-------------------------------------------------------------------- 
* CELEX-32008R1242




*-------------------------------------------------------------------- 
* Assignment of General Types
*-------------------------------------------------------------------- 
* Create empty variable for General Type codes. 
capture drop GeneralType
gen int GeneralType = .
label var GeneralType ///
  "General Type per CELEX-32008R1242"


* ... and Threshold variables
capture drop Threshol*
gen double Threshold = .
gen double Threshold2= . 
label var Threshold ///
  "Threshold for farm types. Delete if found in data."
label var Threshold2 ///
  "Threshold for farm types. Delete if found in data."


* - - - - - - - - - - - - - - - - - - - - - - - - - -
local title "Specialist field crops"
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
local title "Specialist horticulture"
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
local title "Specialist permanent crops"
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
local title "Specialist grazing livestock"
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
local title "Specialist granivores"
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
  "Principal Type per CELEX-32008R1242"


* - - - - - - - - - - - - - - - - - - - - - - - - - -
local title "Specialist COP"
local code  = 15
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  * Relevant threshold(s) 
  replace Threshold = (2/3) * SGM_Farm
  
  * Update farm type variable
  replace PrincipalType = `code'           ///
    if  (P15 + P16 + SGM_Peas) >  Threshold & ///
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
local title "General field crop"
local code  = 16
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  * Relevant threshold(s) 
  replace Threshold = (2/3) * SGM_Farm
  
  * Update farm type variable
  replace PrincipalType = `code'           ///
    if  (P15 + P16 + SGM_Peas) <= Threshold & ///
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
local title "Specialist Hort (indoor)"
local code  = 21
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  * Relevant threshold(s) 
  replace Threshold = (2/3) * SGM_Farm
  
  * Update farm type variable
  replace PrincipalType = `code'                          ///
    if  (SGM_VegUnderGlass + SGM_FlowersGlass) > Threshold & ///
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
local title "Specialist Hort (outdoor)"
local code  = 22
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  * Relevant threshold(s) 
  replace Threshold = (2/3) * SGM_Farm
  
  * Update farm type variable
  replace PrincipalType = `code'                       ///
    if  (SGM_VegMarket +SGM_FlowersOutdoor) > Threshold & ///
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
local title "Other horticulture"
local code  = 23
* - - - - - - - - - - - - - - - - - - - - - - - - - -
quietly {
  * Relevant threshold(s) 
  replace Threshold = (2/3) * SGM_Farm
  
  * Update farm type variable
  replace PrincipalType = `code'                             ///
    if  (SGM_VegUnderGlass + SGM_FlowersGlass)   <= Threshold & ///
        (SGM_VegMarket     + SGM_FlowersOutdoor) <= Threshold & ///
        GeneralType == real(substr("`code'", 1, 1))


  label define PrincipalType `code' "`title'", modify
  label values PrincipalType PrincipalType
}
* - - - - - - - - - - - - - - - - - - - - - - - - - -
* - - - - - - - - - - - - - - - - - - - - - - - - - -
tab PrincipalType YE_AR, missing
* - - - - - - - - - - - - - - - - - - - - - - - - - -
* - - - - - - - - - - - - - - - - - - - - - - - - - -




drop Threshol*
