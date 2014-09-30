*******************************************
* Create svy_horses_other_1
*******************************************


*rename d_horse_pasture_eu D_HORSE_PASTURE_EU

* d_horses_livestock_units = 

gen d_horses_livestock_units = ((MTH12_TOTAL_HORSES_DRAUGHT_NO * 1.5) + (MTH12_TOTAL_HORSES_LT2YR_NO * 1) + (MTH12_TOTAL_HORSES_GT2YR_NO * 1) + (MTH12_TOTAL_PONIES_NO * 1) + (MTH12_TOTAL_MULES_JENNETS_NO * 1) + (MTH12_TOTAL_ASSES_NO * 1)) / 12
replace d_horses_livestock_units =0 if d_horses_livestock_units == .

