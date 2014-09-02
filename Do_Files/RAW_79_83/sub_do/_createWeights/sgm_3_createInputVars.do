* This file calls the variable definition files for all of the
*   derived vars required to calculate NFS farm types according to 
*   the NFS/FADN farm typology. 


qui do D_HORSES_FOR_SGMS_AVGNO/D_HORSES_FOR_SGMS_AVGNO
do D_LT1YR_FOR_SO_AVGNO/D_LT1YR_FOR_SO_AVGNO
qui do D_HERD_SIZE_AVG_NO/D_HERD_SIZE_AVG_NO // have this from 84
qui do D_COWS_AVG_NO/D_COWS_AVG_NO           // have this from 84
qui do D_TOTAL_SHEEP_AVG_NO/D_TOTAL_SHEEP_AVG_NO
qui do D_EWES_AVG_NO/D_EWES_AVG_NO
qui do D_SHEEP_FOR_SGMS_AVGNO/D_SHEEP_FOR_SGMS_AVGNO

* We may have the pig variables in the data already. If not, then
*   rederive. Definitions will also check if components are in the 
*   data already too.
foreach var in ///
  D_WEANERS_AVG_NO             ///
  D_FEMALE_PIGS_FOR_SGMS_AVGNO ///
  D_BOARS_PIGSGT20KG_SGMS_AVGNO {
    capture confirm variable `var'
    if _rc!=0{
      qui do `var'/`var'
    }
}

qui do D_FEMALE_PIGS_FOR_SGMS_AVGNO/D_FEMALE_PIGS_FOR_SGMS_AVGNO
qui do D_BOARS_PIGSGT20KG_SGMS_AVGNO/D_BOARS_PIGSGT20KG_SGMS_AVGNO

qui do D_POULTRY1_FOR_SGMS_AVGNO/D_POULTRY1_FOR_SGMS_AVGNO
qui do D_POULTRY2_FOR_SGMS_AVGNO/D_POULTRY2_FOR_SGMS_AVGNO
qui do D_POULTRY3_FOR_SGMS_AVGNO/D_POULTRY3_FOR_SGMS_AVGNO


* Next two lines extrace the dataset filename from the whole path
*  which is stored in the global macro $S_FN
local match = regexm("$S_FN", "^.*OutData/(.*.dta)")
capture local FN = regexs(1)


* Use the filename to change behaviour of the do file concerning 
*   some vars which do not exist in nfs_7983.dta 
if "`FN'"=="nfs_7983.dta"{
    di "Condition works"
  qui do D_TOTAL_CATTLE_1_2YRS_AVG_NO/D_TOTAL_CATTLE_1_2YRS_AVG_NO
  qui do D_TOTALGT2YRS_FOR_SGMS_AVGNO/D_TOTALGT2YRS_FOR_SGMS_AVGNO
}

else {
  * I already have these in the dataset, and I don't have all the
  *  parts to recreate them myself. Formulae are complete however.
  qui do D_MALE_CATTLE_1_2YRS_AVG_NO/D_MALE_CATTLE_1_2YRS_AVG_NO
  qui do D_FEMALE_CATTLE_1_2YRS_AVG_NO/D_FEMALE_CATTLE_1_2YRS_AVG_NO
  qui do D_MALEGT2YRS_FOR_SGMS_AVGNO/D_MALEGT2YRS_FOR_SGMS_AVGNO
  qui do D_FEMALEGT2YRS_FOR_SGMS_AVGNO/D_FEMALEGT2YRS_FOR_SGMS_AVGNO
}
