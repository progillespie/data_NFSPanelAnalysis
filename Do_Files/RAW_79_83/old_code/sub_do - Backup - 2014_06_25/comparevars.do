local nfs_7983 "D:\Data\data_NFSPanelAnalysis\OutData\nfs_7983.dta"
local nfs_8409 ///
  "D:\Data\data_NFSPanelAnalysis\OrigData\RAW_84_09\cod8409.csv"

use `nfs_7983', clear
qui ds
local vlist_7983 "`r(varlist)'"



insheet using `nfs_8409', clear



foreach var of local vlist_7983 {
    
    capture confirm variable `var'
    if _rc!=0 {
        local novar "`novar' `var'" 
    }

}


clear



macro list _novar
