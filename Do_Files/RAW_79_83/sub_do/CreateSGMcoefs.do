* Generate Standard Gross margin or Standard Output for Farm Typology (i.e. 
*  creating a system variable)

*---------------------------------------------------------------------
* Prepare files with historical SGM coefficients 
*
*   - The coefficients are multiplied by various categories of crops
*       and livestock giving you enterprise and farm level SGM(or SO)
*
*   - These coefficients are obtainable from Eurostat 
*      (series ef_tsgm and ef_tso for SGM and SO respectively)
*
*   - SGMs from before 1986 are available in the following three
*      docs from the Official Journal of the EU: 
*       + OJ L 148 1978 - CELEX: 31978D0463 
*       + OJ L 128 1984 - CELEX: 31984D0542 
*       + OJ C 191 1986 - Google Search term "86/C 191/01" 
*
*   - The CELEX number is useful for searching on EUE-Lex.
*
*   - The SGMs from Eurostat and from the OJ have been combined into
*       consistent time series by Patrick R. Gillespie in the course 
*       of his PhD thesis. The filename was SGMs_SOs_7307.xlsx, and 
*       it was place in  Data/data_EUROSTAT/OutData/RAW_79_83.
*     NOTE: The names of the coefficients changed over time and tables
*             in the pdfs do not properly cut and paste. If the 
*             spreadsheet is lost or corrupted, you should expect
*             to lose a day or so recreating it.
*
*   - In Stata 12 and above, it is possible to read directly from an
*       Excel spreadsheet, but to maintain compatability with older 
*       Stata versions this code reads from a CSV created from that
*       file. To create the CSV correctly, filter the tables on the 
*       "Single Table" sheet by the "Associated IB Varnames" column 
*       to hide blank cells (those rows contain coefficients not used
*       in Ireland). Then copy and paste each table to a separate CSV,
*       making sure to transpose it (i.e. each column is a coefficient
*       and each row is a year).
*
*   - Name the files exactly as they are called in the insheet   
*       commands below, and you can then run this do file.
*---------------------------------------------------------------------

clear all

local startdir:pwd
local dodir "D:\Data\data_NFSPanelAnalysis\Do_Files\RAW_79_83\sub_do"
local outdatadir "D:\Data\data_EUROSTAT\OutData\RAW_79_83"
cd `outdatadir'



* Prepare Connacht-Ulster region SGM file for merging
insheet using SGM_coef_7307_connacht_ulster.csv, clear
destring, replace force
gen SGMregion = 1
sort year
save temp_SGM_coef_7307_connacht_ulster.dta, replace



* Prepare Leinster-Munster region SGM file for merging
insheet using SGM_coef_7307_leinster_munster.csv, clear
destring, replace force
gen SGMregion = 2
sort year
save temp_SGM_coef_7307_leinster_munster.dta, replace



merge 1:1 year SGMregion using temp_SGM_coef_7307_connacht_ulster
drop _merge



* Get a list of coefficient variables (i.e. all vars except year and 
*   SGMregion)
ds SGMregion year, not
local coefs "`r(varlist)'"



* At this point, missing values reflect the NFS's assesment that there
*   is no meaningful production for a given category. We can safely 
*   set these to 0.
foreach var of local coefs{

  replace `var' = 0 if missing(`var')

}

save temp_SGM_coef_7307_both, replace

clear

set obs 78 // 2 X number of years from 1973 to desired end year
gen     SGMregion = 1 if _n < 40
replace SGMregion = 2 if _n >=40
bysort SGMregion: egen year = seq() ,from(1973) to(2011)
sort year
save temp_years.dta, replace

merge 1:m year SGMregion using temp_SGM_coef_7307_both.dta
drop _merge


order year SGMregion _all
sort  year SGMregion



label define SGMregion 1 "Connacht-Ulster" 2 "Leinster-Munster"
label save SGMregion using `dodir'/_value_labels/label_SGMregion, replace
label values SGMregion SGMregion
table year SGMregion  // should be all 1's



* We've introduced entire rows of missing values by filling in the 
*   years between FSS datapoints (when SGMs are reviewed). For these
*   intervening periods, it's appropriate to simply carryforward the
*   coefficients from the most recent review (i.e. the last 
*   non-missing value for each coefficient)
*   
*  We employ the user-written package "carryforward" by David Kantor

       * findit carryforward

tsset SGMregion year //carryforward requires tsset'ing 
carryforward `coefs', replace



* We now have a nice block of data with no missing values, and with 
*   all the SGM coefs which are relevant for applying the NFS/FADN 
*  farm typology in Ireland going back as far as 1973.

save SGM_coef_7311, replace

capture erase temp_SGM_coef_7307_connacht_ulster.dta
capture erase temp_SGM_coef_7307_leinster_munster.dta
capture erase temp_SGM_coef_7307_both.dta
capture erase temp_years.dta

cd `startdir'
