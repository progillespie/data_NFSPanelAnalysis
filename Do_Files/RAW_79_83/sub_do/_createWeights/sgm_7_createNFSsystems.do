* This file assigns farms to NFS systems on the basis of their
*   FADN/EU farm types (i.e. Principal and Particular types)


/*-------------------------------------------------------------------
* Reference Material
*--------------------------------------------------------------------

* Read from SoilCode tab of new_DataDictionary.xls 
1 Dairying
2 Dairying and Other
4 Cattle Rearing
5 Cattle Other
6 Mainly Sheep
7 Tillage

** From Appendix of NFS Annual Report 2005

* Dairying
*------------------
Particular type 411(specialist milk production)


* Dairying + Other 
*------------------
Particular types: 
   * 412 (specialist milk production with cattle rearing),
   * 431 (dairying with rearing and fattening cattle), 
   * 432 (cattle rearing and fattening with dairying), 
   * 444 (various grazing livestock), 
   * 711 (mixed livestock -mainly dairying), 
   * 811 (field crops combined with dairying), and
   * 812 (dairying combined with field crops)


* Cattle Rearing
*------------------
Particular types: 
   * 421 (specialist cattle -mainly rearing)


* Cattle Other 
*------------------
Particular types:
   * 422 (specialist cattle-mainly fattening), and 
   * 712 (mixed livestock)


* Mainly Sheep
*------------------
Particular types: 
   * 441 (specialist sheep), and 
   * 442 (sheep and cattle combined)


* Tillage
*------------------
Principal types: 
   * 13 (specialist cereals, oilseeds and protein crops), and 
   * 14 (general field cropping) 
plus particular types: 
   * 813 (field crops /grazing livestock), 
   * 814 (grazing livestock/field crops), and 
   * 822 (grazing livestock/permanent crops) 


**NOT INCLUDED** IN THE NFS SAMPLE are:
Principal types:
   * 50 (specialist granivores);
   * 72 (mixed livestock, mainly granivores);
   * 20 (specialist horticulture); 
   * 60 (market gardening);
plus particular types: 
   * 821 (field crops and granivores);
   * 823 (various mixed crops and livestock);
   * and non classified farms 
.

*/
*--------------------------------------------------------------------





*--------------------------------------------------------------------
* Assign modern NFS farm systems
*--------------------------------------------------------------------


* If the IB FARM_SYSTEM variable is already in the data, rename it
capture rename FARM_SYSTEM FARM_SYSTEM_IBmade
capture label var FARM_SYSTEM_IBmade /// 
  "NFS farm system, made by IB. Kept for validating."


* Initialise a system variable
gen int FARM_SYSTEM = . 



replace FARM_SYSTEM = 1 ///
  if ParticularType == 411
label define FARM_SYSTEM 1 "Dairying", modify



replace FARM_SYSTEM = 2       ///
  if ParticularType == 412 | ///
     ParticularType == 431 | ///
     ParticularType == 432 | ///
     ParticularType == 444 | ///
     ParticularType == 711 | ///
     ParticularType == 811 | ///
     ParticularType == 812
label define FARM_SYSTEM 2 "Dairy/Other", modify



replace FARM_SYSTEM = 4 ///
  if ParticularType == 421
label define FARM_SYSTEM 4 "Cattle Rearing", modify



replace FARM_SYSTEM = 5        ///
  if ParticularType == 422 | ///
     ParticularType == 712
label define FARM_SYSTEM 5 "Cattle Other", modify



replace FARM_SYSTEM = 6 ///
  if ParticularType == 441 | ///
     ParticularType == 442
label define FARM_SYSTEM 6 "Mainly Sheep", modify



replace FARM_SYSTEM = 7 ///
  if PrincipalType == 11  | ///
     PrincipalType == 12  | ///
     ParticularType == 813 | ///
     ParticularType == 814 | ///
     ParticularType == 822
label define FARM_SYSTEM 7 "Tillage", modify


* This is a catch all category, so it must be assigned last
replace FARM_SYSTEM = 0 if missing(FARM_SYSTEM)
label define FARM_SYSTEM 0 "Not in reports", modify
label values FARM_SYSTEM FARM_SYSTEM 


label var FARM_SYSTEM        ///
  "NFS farm system as calculated by Stata code."


table ParticularType FARM_SYSTEM, missing






*--------------------------------------------------------------------
* Assign historic NFS farm systems
*--------------------------------------------------------------------


* Initialise a system variable
capture drop FARM_SYSTEM_HISTORIC 
gen int FARM_SYSTEM_HISTORIC = . 



* Assign systems

replace FARM_SYSTEM_HISTORIC = 1 ///
  if ParticularType == 411
label define FARM_SYSTEM_HISTORIC 1 "Dairying", modify



replace FARM_SYSTEM_HISTORIC = 2       ///
  if ParticularType == 421 | /// 421 + 422 = 42
     ParticularType == 422 | ///
     ParticularType == 443 | ///  * had missed this
     ParticularType == 712
label define FARM_SYSTEM_HISTORIC 2 "Cattle", modify



replace FARM_SYSTEM_HISTORIC = 3 ///
   if ParticularType == 412 | ///
      ParticularType == 431 | /// 431 + 432 = 43
      ParticularType == 432 | ///
      ParticularType == 711
label define FARM_SYSTEM_HISTORIC 3 "Dairying/Cattle", modify



replace FARM_SYSTEM_HISTORIC = 4 ///
  if ParticularType == 441 | ///
     ParticularType == 442
label define FARM_SYSTEM_HISTORIC 4 "Mainly Sheep", modify



replace FARM_SYSTEM_HISTORIC = 5 ///
  if ParticularType == 811  | ///
     ParticularType == 812 
label define FARM_SYSTEM_HISTORIC 5 "Dairying/Tillage", modify



replace FARM_SYSTEM_HISTORIC = 6 ///
  if ParticularType == 813 | ///
     ParticularType == 814 | ///
     ParticularType == 822 //  * had missed this
label define FARM_SYSTEM_HISTORIC 6 "Drystock/Tillage", modify



replace FARM_SYSTEM_HISTORIC = 7 ///
  if PrincipalType == 11  | ///
     PrincipalType == 12
label define FARM_SYSTEM_HISTORIC 7 "Field Crops", modify



replace FARM_SYSTEM_HISTORIC = 8     ///
  if  PrincipalType == 51  | ///
      PrincipalType == 52  | ///
      PrincipalType == 72  | ///
      ParticularType == 821
label define FARM_SYSTEM_HISTORIC 8 "Other Systems", modify



* This is a catch all category, so it must be assigned last
replace FARM_SYSTEM_HISTORIC = 0 if missing(FARM_SYSTEM_HISTORIC)
label define FARM_SYSTEM_HISTORIC 0 "Not in reports", modify
label values FARM_SYSTEM_HISTORIC FARM_SYSTEM_HISTORIC 



label var FARM_SYSTEM_HISTORIC        ///
  "NFS farm system, defined in 1984 NFS Annual Report."



table ParticularType FARM_SYSTEM_HISTORIC, missing

* Finally create sample cell variables
qui do Cr_d_sample_cell.do
