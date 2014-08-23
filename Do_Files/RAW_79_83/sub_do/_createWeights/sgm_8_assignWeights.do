* Implemented code to create farm weights. Uses matrix approach
* TODO: calc weight tables for 91 and 92. Currently just copies of 93


*-------------------------------------------------------------------
* Reduce scrolling by suppressing intermediate steps
*  Matrices will be printed at the end of the file (and save to logs)
quietly {
*-------------------------------------------------------------------

  args YYYY outdatadir

  

  *------------------------------------------------------------------
  * Import weight table, save as matrix
  *------------------------------------------------------------------

  preserve // Remember data in memory without saving a dta
  
  * Read in the weight table and store it as a matrix
  insheet using ///
    "`outdatadir'/weight_table`YYYY'.csv", clear

  mkmat _all, matrix(M_WTS_`YYYY')
  matrix list M_WTS_`YYYY'
  
  restore // Bring back data. Weight matrix persists.
  
  *------------------------------------------------------------------
  
  




  *------------------------------------------------------------------
  * Create cell index matrix (modern and historic)
  *------------------------------------------------------------------

  * Modern sample cells

  if `YYYY' >= 1993{
      
      * 36 cells (13 - 18 skipped, last cell is 42), 
      *   6 rows(systems) by 6 columns (size classes)
      matrix define M_SAMPLE_CELL = ( 1,  2,  3,  4,  5,  6) ///
                                  \ ( 7,  8,  9, 10, 11, 12) ///
                                  \ (19, 20, 21, 22, 23, 24) ///
                                  \ (25, 26, 27, 28, 29, 30) /// 
                                  \ (31, 32, 33, 34, 35, 36) ///
                                  \ (37, 38, 39, 40, 41, 42)

      local rownames ""
      local rownames "`rownames' Dairy"
      local rownames "`rownames' DYOther" 
      local rownames "`rownames' CARear"                     
      local rownames "`rownames' CAOther"
      local rownames "`rownames' Sheep"
      local rownames "`rownames' Tillage"

      matrix rownames M_SAMPLE_CELL = `rownames'
      matrix rownames M_WTS_`YYYY'  = `rownames'

      * Choose the appropriate cell index number
      capture drop cell_number
      gen int cell_number = D_SAMPLE_CELL
  
    
  }
  


  * Historic sample cells

  else {
  
      * 48 cells (no skipping) 
      *   8 rows(systems) by 6 columns (size classes)
      matrix define M_SAMPLE_CELL = ( 1,  2,  3,  4,  5,  6) ///
                                  \ ( 7,  8,  9, 10, 11, 12) ///
                                  \ (13, 14, 15, 16, 17, 18) ///
                                  \ (19, 20, 21, 22, 23, 24) ///
                                  \ (25, 26, 27, 28, 29, 30) ///
                                  \ (31, 32, 33, 34, 35, 36) ///
                                  \ (37, 38, 39, 40, 41, 42) ///
                                  \ (43, 44, 45, 46, 47, 48)

      local rownames ""
      local rownames "`rownames' Dairy"
      local rownames "`rownames' Cattle" 
      local rownames "`rownames' DYCA"                     
      local rownames "`rownames' Sheep"
      local rownames "`rownames' DYTill"
      local rownames "`rownames' DryTill"
      local rownames "`rownames' Field"
      local rownames "`rownames' Other"

      matrix rownames M_SAMPLE_CELL = `rownames'
      matrix rownames M_WTS_`YYYY'  = `rownames'

  
      * Choose the appropriate cell index number
      capture drop cell_number
      gen int cell_number = D_SAMPLE_CELL_HISTORIC
  }
  
  *------------------------------------------------------------------

  
  



  *------------------------------------------------------------------
  * Use matrices to assign weight variable
  *------------------------------------------------------------------

  capture drop WTvalue
  gen WTvalue = .
  forvalues i= 1/6 {
  
    forvalues j=1/6 {
  	
      qui replace WTvalue = M_WTS_`YYYY'[`i',`j'] ///
        if cell_number == M_SAMPLE_CELL[`i',`j']
      
      * Uncomment the following to get a message detailing the 
      *   assignment of each cell for this year 
      *di "Cell " M_SAMPLE_CELL[`i',`j'] " : " M_WTS_`YYYY'[`i',`j']
  		
    }
  
  }

  *------------------------------------------------------------------


*-------------------------------------------------------------------
* End of quietly {}. Output window resumes as this point.
}
*-------------------------------------------------------------------



label variable WTvalue "Calculated weight, rename after validating."






*-------------------------------------------------------------------
* Append each year's tables to a log for validagtion. 
*  (delete last run's log in the file that calls this one)
*-------------------------------------------------------------------
log using `outdatadir'/Logs/sgm_8_assignWeights.txt, text append



* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
*Matrices and tabstats for
di _col(17) "`YYYY'"
      * 1) Cell Numbering
      * 2) Weight table applied
      * 3) Table of mean weights within year (should match 2)
      * 4) Table of mean weights across years 
           *(should not match 2 where > 1 year has weights assigned)
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

matrix list M_SAMPLE_CELL
matrix list M_WTS_`YYYY'
log off

if `YYYY' >= 1993 {

  log on
  * Use modern system definitions
  table FARM_SYSTEM tableBcol              ///
    if !missing(cell_number) & year==`YYYY' ///
    , contents(mean WTvalue)

  table FARM_SYSTEM tableBcol              ///
    if !missing(cell_number)                ///
    , contents(mean WTvalue)

}


else {

  log on
  * Use historic system definitions
  table FARM_SYSTEM_HISTORIC tableBcol      ///
     if !missing(cell_number) & year==`YYYY' ///
     , contents(mean WTvalue)

  table FARM_SYSTEM_HISTORIC tableBcol      ///
     if !missing(cell_number)                ///
     , contents(mean WTvalue)

}



log close
capture drop cell_number
*-------------------------------------------------------------------






*-------------------------------------------------------------------
* Save the weights and some related vars in a dataset
*-------------------------------------------------------------------

  preserve

  keep FARM_CODE   ///
       YE_AR       ///
       WTvalue     ///
       FARM_SYST*  /// 
       D_SAMPL*

* Quietly add some notes to the data
quietly {
  note: Weights calculated on the basis of published reports as 
  note:   detailed in App_B_84_13.xlsx and associated do-files.
  note:   The weights are in variable WTvalue. Once the weights
  note:   have been validated, they should be renamed to signify
  note:   this. If you see WTvalue in the data, then be aware
  note:   that the weights may need further validation.
  
}
  save `outdatadir'/weights.dta, replace

  restore
*-------------------------------------------------------------------
