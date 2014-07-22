gen D_LABOUR_UNITS_PAID           = ///
     D_LABOUR_UNITS_PAID_EXCL_CAS + ///
     D_LABOUR_UNITS_PAID_CAS 


gen D_TOTAL_CASUAL_LABOUR_EU         = ///
     CASUAL_WAGES_PAID_EU            - ///
     CASUAL_LABOUR_NON_ALLOCABLE_EU


rename D_HERD_SIZE_AVG_NO       dpavnohd
rename D_DAIRY_LU_INCL_BULLS    dpnolu
rename D_TOTAL_CATTLE_NO        cptotcno
rename D_LABOUR_UNITS_UNPAID    flabunpd
rename D_LABOUR_UNITS_PAID      flabpaid
rename D_TOTAL_CASUAL_LABOUR_EU fdcaslab

