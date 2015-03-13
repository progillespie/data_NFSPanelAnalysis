* As a temporary fix, I used code I developed myself to create two variables
*   so active code was dependent on deprecated code (and data). 
*   This file details checks I ran to make sure the updated code was completing 
*   correctly.

* record current location
local startdir "`cwd'"

* currcodedata = Directory where intermediate data from active code are stored
* oldcodedata  = Directory where intermediate data from deprecated code are stored
local currcodedata "D:\Data\data_NFSPanelAnalysis\OutData\Quota"
local oldcodedata "D:\Data_real\data_NFSPanelAnalysis\OutData\"


*   I first ran a comparison of two important compenents (hay and silage alloc
*   to the dairy herd). They turn out to have identical yearly means for 79-83.

use `currcodedata'/bulkfeed_merge_data.dta, clear
tabstat  *ALLOC*DAIRY*92* if YE_AR < 1984, by(YE_AR)

use `oldcodedata'/nfs_7983, clear
tabstat  *ALLOC*DAIRY*92*, by(year)



*Next I check the final calculated variables. Note that uppercase vars
*  ARE NOT SYSTEM GENERATED variables in this dataset. The calculated versions
*  , i.e. the lowercase versions have been renamed by this point, so 
*  these vars are in fact the results of the code.  
use `oldcodedata'/nfs_7983, clear
cd "D:\Data\data_NFSPanelAnalysis\Do_Files\RAW_79_83\sub_do"
capture macro drop required_vars zero_vlist
qui do D_FORAGE_AREA_HA\D_FORAGE_AREA_HA  
qui do D_FEED_AREA_EQUIV_HA\D_FEED_AREA_EQUIV_HA

rename D_FEED_AREA_EQUIV_HA  PG_FEED_AREA_EQUIV_HA
rename D_FORAGE_AREA_HA      PG_FORAGE_AREA_HA
rename farmcode FARM_CODE
rename year YE_AR

keep FARM_CODE YE_AR PG_FEED_AREA_EQUIV_HA PG_FORAGE_AREA_HA
sort FARM_CODE YE_AR
save `currcodedata'/PG_version_vars, replace


use `currcodedata'/data_for_dairydofile.dta, clear
mvencode D_FEED_AREA_EQUIV_HA D_FORAGE_AREA_HA, mv(0) override
keep if YE_AR < 1984
merge 1:1 FARM_CODE YE_AR using `currcodedata'/PG_version_vars, nogen

summ PG_FEED_AREA_EQUIV_HA D_FORAGE_AREA_HA PG_FORAGE_AREA_HA, detail

* PG versions are higher for both, substantially so for the feed var
*  I'm not going to rectify this before my viva. Will have to live with
*  using nfs_7983 and the deprecated code for now.

cd `startdir'
