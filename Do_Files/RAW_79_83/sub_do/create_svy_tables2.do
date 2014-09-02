* Make 79 - 83 data compatible with John Lennon's ConvertIBDataSet
*  code. 

* Read each of the svy_tables in FarmPriceVolMSM and generate lists
*   of varnames in them

local startdir: pwd
local dodir  "D:/Data/data_NFSPanelAnalysis/Do_Files/RAW_79_83/sub_do"
local outdatadir "D:/Data/data_NFSPanelAnalysis/OutData/RAW_79_83"
local svydir "D:\Data\data_NFSPanelAnalysis\OrigData\FarmPriceVolMSM\"
*local svydir "D:/Data/data_NFSPanelAnalysis/OrigData/ConvertIBDataSet"

capture mkdir `outdatadir'/svy_tables_7983


* Get lists of vars in each table dataset
cd `svydir'

* There's a lot of intermediate data in the FarmPriceVolMSM directory
*  quickest way to see what we actually need is to get the
*  intersection set of .dta file in this directory with files from the
*  related directory ConvertIBDataSet 
local svy_tables_1: dir                                     ///
  "D:\Data\data_NFSPanelAnalysis\OrigData\FarmPriceVolMSM\" ///
  files "*.dta"

local svy_tables_2: dir                                      ///
  "D:\Data\data_NFSPanelAnalysis\OrigData\ConvertIBDataSet\" ///
  files "*.dta"


local svy_tables: list svy_tables_1 & svy_tables_2


quietly{
  foreach table of local svy_tables {
  
      noisily macro list _table

      use `table', clear
      capture drop d_*
      capture drop i_*
      
      
      qui describe, replace clear
      local filename = substr("`table'", 1, length("`table'")-4)
      outsheet position name varlab                           ///
        using `outdatadir'/svy_tables_7983/vars_`filename'.csv ///
        , comma replace
 
  }
}



cd `startdir'
