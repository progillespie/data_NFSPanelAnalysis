* Place  "`OrigData'" and "`OutData'" at the end of the "do" command 
*  calling this file (allows passing of macros to this file)
args OrigData OutData


capture log close



*--------------------------------------------------------------------
* Create farm weights via published data (see App_B_84_13.xlsx)
*--------------------------------------------------------------------

/*
 We don't have the actual weights applied in the microdata, so it
   is necessary to "back out" these weights on the basis of two 
   tables in the annual published reports. These tables give the 
   two critical bits of information relative to each "sample cell":

     1) the estimated proportions of the population, and
     2) the number of sampled farms.

 NOTE:  the info for the "two tables" is actually scattered across 
         the reports for most years, only recently appearing whole
         in the appendices. Further details in the spreadsheet. 

 When combined with the total number of farms represented by the 
   sample (sometimes available in the reports, sometimes needing to 
   be deduced from other information in the reports), we can get the
   approximate weight of each cell. This is carried out on the 
   Excel spreadsheet cited above.  

 The following code takes those weight tables (or rather CSVs copies
   of them created from the spreadsheet) and brings them into Stata. 
   It then assigns the weights to a variable called "WTvalue" for each
   farm. Once validation of the generated weight is complete, the  
   variable can be renamed/reassigned.

 Finally, to verify that the weights were correctly assigned (i.e.
   farms identified within a particular sample cell obtain the
   calculated weight for that cell in that year) the do-file prints
   several matrices/tables for comparison. Check the log file. It's 
   important to note that this check will not identify problems with
   the calculation of the weights, but only the consistency with which
   the weights were assigned to the data. The former requires 
   comparison with published results. This will be carried out 
   elsewhere.
*/ 
*--------------------------------------------------------------------






*--------------------------------------------------------------------
* Paremeters and directories to set if running standalone
*--------------------------------------------------------------------
* If we don't have OutData set, then assume running standalone
if "`OutData'" == "" {


  *******************************
  * Run Parameters
  *******************************
  * Type of Simulation
  scalar sc_simulation = 1


  *******************************
  * Directories
  *******************************

  *Do-Files
  local dodir = "D:\data\Data_NFSPanelANalysis\Do_Files\FarmPriceVolMSM"
  global dodir1 = "`dodir'"

  * Original Data
  local OrigData = "D:\DATA\Data_NFSPanelANalysis\OrigData\FarmPriceVolMSM"

  * Output Data
  local s = sc_simulation
  local OutDataO = "D:\data\Data_NFSPanelANalysis\OutData\FarmPriceVolMSM\\`s'"
  local OutData = "D:\data\Data_NFSPanelANalysis\OutData\FarmPriceVolMSM"


}

*--------------------------------------------------------------------



* Either way, tell Stata where weight table csv's are
local wtdata "D:\Data\data_NFSPanelAnalysis\OutData\MakeWeights"



* Ensure no problems with the log file
capture mkdir `OutData'/Logs
capture erase `OutData'/Logs/assignWeights.txt






*--------------------------------------------------------------------
* Loading and preliminary data manipulation
*--------------------------------------------------------------------

* Load the existing weight data (goes back as far as 1995)
use "`OrigData'/svy_weights.dta", clear

* Make a list of the vars in this dataset
qui ds 
local svy_weights_vlist "`r(varlist)'"

* Get general farm characteristics
merge 1:1 FARM_CODE YE_AR using `OrigData'/svy_farm , nogen



* Some code uses year, and some uses YE_AR (same var, diff. name only)
*  Just make sure both exist in the data to ensure no error from it.
capture gen int year = . 
capture replace year = YE_AR



* The farm typology changed over time. Code allows for this by 
*  using a separate variable for farm system code, and then for 
*  resulting sample cell code for both time periods (pre and post 93).
*  Not currently using this as the typology calculation is still 
*  causing problems. Not an issue for dairy (it didn't change).
capture gen int FARM_SYSTEM_HISTORIC = .
capture replace FARM_SYSTEM_HISTORIC = FARM_SYSTEM



* Sample cells id the relevant weight to apply to the farm, but 
*   must be derived from FARM_SYSTEM and UAA_SIZE.
do Cr_d_sample_cell.do

*--------------------------------------------------------------------



* Initialise the calculated weight variable (i.e. don't overwrite
*   UAA_WEIGHT yet)
capture drop WTvalue
gen WTvalue = .



* Get list of years to apply weights to (only applies from 1984 on)
levelsof year if year > 1983, local(datayears) 
foreach YYYY of local datayears {

    macro list _YYYY
    * Assign weights, passing in YYYY and OutData macros
    do _createWeights/assignWeights.do `YYYY' `OutData'

}	



capture tw sc WTvalue UAA_WEIGHT       ///
  if UAA_WEIGHT > 0 & FARM_SYSTEM==1   ///
  , title("Stata calc. weights vs. UAA_WEIGHT (Spec. Dairy only)")
capture graph export `OutData'/dy_weight_check.pdf, replace


replace UAA_WEIGHT = WTvalue if YE_AR <  1995



* Matrices left in memory. Check the dimensions are as expected.
matrix dir

*--------------------------------------------------------------------




keep `svy_weights_vlist'
note: Extended UAA_WEIGHT back to 1984 (first year weights were used) via App_B_84_13.xlsx. 
note: Farm typology changed in 1993. Dairy unaffected, but other weights will be incorrect.
note: Completed as part of P. R. Gillespie's thesis. Contact him for details/queries.
save `OutData'/svy_weights_84.dta, replace

