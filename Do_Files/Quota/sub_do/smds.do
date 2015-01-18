capture drop CerealsCYHA 
gen double CerealsCYHA = 0
label var CerealsCYHA "CY_HECTARES_HA for all cereal crops."
foreach code of local crop_codes {

	if [regexm("`code'", "11[0-9][0-9]") | ///
	    regexm("`code'", "157[0-9]")     ] {

	  replace CerealsCYHA = ///
	     CerealsCYHA + CY_HECTARES_HA`code'

	}

}


* Initialise at 0
capture drop d_standard_man_days
gen double d_standard_man_days = 0



* Start with Dairy Cows
* CHANGE-main: Formula calls for DAIRY_COWS, but that's far too low
*   us same 12 month total type var as for other livestock 
replace d_standard_man_days = (MTH12_TOTAL_DAIRY_COWS_NO / 12) * DAIRY_COWS 


* Add in other cattle
replace d_standard_man_days  =              ///
  d_standard_man_days                          ///
                +                              /// 
  (                                            ///
    (                                          /// 
       ((MTH12_TOTAL_OTHER_COWS_NO        *    ///
	 SUCKLING) * .9)                       /// 
		+                              ///
       ((MTH12_TOTAL_CALVES_LT6MTHS_NO    *    ///
        CATTLE_LT1YR) * .2)                    ///
		+                              ///
       ((MTH12_TOTAL_CALVES_6_12MTHS_NO   *    ///
         CATTLE_LT1YR) * .4)                   ///
		+                              ///
       ((MTH12_TOT_CATTLE_FL_1_2YRS_NO    *    ///
          CATTLE_1_2YRS) * .7)                 ///
		+                              ///
       ((MTH12_TOT_CATTLE_FL_GT2YRS_NO    *    ///
          CATTLE_2_3YRS) * 1)                  /// 
		+                              ///
         ((MTH12_TOTAL_IN_CALF_HEIFERS_NO *    ///
           CATTLE_2_3YRS) * .7)                ///  
    ) / 12                                     ///
  )                                         // END





* Add in sheep
replace d_standard_man_days  =  ///
  d_standard_man_days              ///
                +                  /// 
    (                              ///
      (                            ///
       EWE_LAMBS_TAKING_RAM_NO  +  ///
       EWES_NOT_LET_TO_RAM_NO   +  ///
       EWE_LAMBS_TAKING_RAM_NO     /// 
      ) * SHEEP_EWES               /// 
    )                              ///
                +                  ///  
    (                              ///
      (                            ///
       FAT_HOGGETS_SALES_NO      + ///
       BREEDING_HOGGETS_SALES_NO   ///
      ) * SHEEP_HOGGETS            ///
    )                           // END 



* Add in pigs
replace d_standard_man_days  =                              ///
  d_standard_man_days                                          ///
                +                                              /// 
  (                                                            ///             
    (                                                          /// 
      (MTH12_TOTAL_SOWS_NO * PIGS_SOWS)                        ///
 		+                                              ///
      (MTH12_TOTAL_FATTENERS_NO * PIGS_FATTENERS)              ///
		+                                              ///
      (MTH12_TOTAL_LAYING_BIRDS_NO * POULTRY_HENS_LAYERS)      ///
 		+                                              ///
      (MTH12_TOTAL_TABLE_FOWL_NO * POULTRY_TABLE_FOWL)         ///
 		+                                              ///
      (MTH12_TOTAL_CHICKS_PULLETS_NO * POULTRY_PULLETS)        ///
 		+                                              ///
      (MTH12_TOTAL_OTHER_FOWL_NO * POULTRY_OTHER_FOWL_TURKEYS) ///
    ) / 12                                                     /// 
  )                                                         // END 



* Add in horses. 
replace d_standard_man_days  =             ///
  d_standard_man_days                      ///
                +                          /// 
  (                                        /// 
    (                                      /// 
      (MTH12_TOTAL_HORSES_DRAUGHT_NO * 10) ///
 		+                          ///
      (MTH12_TOTAL_HORSES_LT2YR_NO * 8)    /// 
		+                          ///     
      (MTH12_TOTAL_HORSES_GT2YR_NO * 10)   ///  
		+                          ///
      (MTH12_TOTAL_PONIES_NO * 10)         /// 
		+                          ///
      (MTH12_TOTAL_MULES_JENNETS_NO * 10)  ///
		+                          ///
      (MTH12_TOTAL_ASSES_NO * 10)          /// 
    ) / 12                                 /// 
  )                                     // END 



* You may not have this var, so capture this bit of formula
capture replace d_standard_man_days  =                   ///
  d_standard_man_days                                    ///
                +                                        ///    
  (OTHER_LVSTCK_ALLOW_INCL_HOUSE_EU * HORSES_DRAUGHT) // END



* Add in crops (this should not be captured)
replace d_standard_man_days  =               ///
  d_standard_man_days                           ///
                +                               ///
  (CerealsCYHA * CEREALS)                       ///
                +                               ///
  (CY_HECTARES_HA1321 * SUGAR_BEET)             ///
                +                               ///
  (CY_HECTARES_HA1311 * POTATOES_WARE)          ///
                +                               ///
  (CY_HECTARES_HA1311 * POTATOES_PROCESSING) // END              



* Add in silage if SILAGE_CODE is length 1 (it's in the IB code, but why???)
replace d_standard_man_days  =      ///
  d_standard_man_days                  ///
                +                      ///
  (SIL_TOTAL_YIELD_TONNES * .05)       ///
  if length(string(SILAGE_CODE))==1 // END              



tabstat d_sta* D_STA* if FARM_SYSTEM == 1 & D_SOIL_GROUP < 3 [weight = UAA_WEIGHT], by(YE_AR)
gen double d_standard_man_days_noreplace = d_standard_man_days


* Formula works well in most year, and looks sane for 79 - 83. 
*   We have a system generated var, which we'll use for 84 - 12
*   because there are a few oddball years (e.g. 85 - 87)
replace d_standard_man_days = D_STANDARD_MAN_DAYS if YE_AR > 1983
tabstat d_sta* D_STA* if FARM_SYSTEM == 1 & D_SOIL_GROUP < 3 [weight = UAA_WEIGHT], by(YE_AR)
