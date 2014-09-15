* svy_crops_fertilizer should be in long form, i.e. a single CROP_CODE 
*   and QUANTITY_ALLOCATED_50KGBAGS instead of 4 separate vars each


capture drop CROP_CODE

* Each row is currently a particular mix of fertilizer. Create a var
* numbering each mix (it's not a code, just a sequential numbering, so
* 1 on some farm may not be the same mix as 1 on another, or even the
* same farm in another year). 
bysort FARM_CODE YE_AR: egen FertilserNumber = seq()


* Convert to long structure. Creates CropPrecedence, which just 
*   records first through fourth crop reported. 
reshape long Quantity alloccropcode ///
  , i(FARM_CODE YE_AR FertilserNumber) j(CropPrecedence)
label var CropPrecedence "Which of farm's top 4 crops"

* Rename the vars and make sure they are kept
rename Quantity      QUANTITY_ALLOCATED_50KGBAGS
rename alloccropcode CROP_CODE


drop if CROP_CODE == 0
