args YYYY outdatadir
* Implemented code to create farm weights. Uses matrix approach
* TODO: calc weight tables for 91 and 92. Currently just copies of 93


*-------------------------------------------------------------------
* Reduce scrolling by suppressing intermediate steps
*  Matrices will be printed at the end of the file (and save to logs)
quietly {
*-------------------------------------------------------------------


  

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
  
  


  *TODO: Stop using FARM_SYSTEM packaged with data
  capture gen int FARM_SYSTEM = .
  replace FARM_SYSTEM =1 if D_SAMPLE_CELL>0 & D_SAMPLE_CELL  <= 6
  replace FARM_SYSTEM =2 if D_SAMPLE_CELL>6 & D_SAMPLE_CELL  <= 12
  replace FARM_SYSTEM =4 if D_SAMPLE_CELL>18 & D_SAMPLE_CELL <= 24
  replace FARM_SYSTEM =5 if D_SAMPLE_CELL>24 & D_SAMPLE_CELL <= 30 
  replace FARM_SYSTEM =6 if D_SAMPLE_CELL>30 & D_SAMPLE_CELL <= 36 
  replace FARM_SYSTEM =7 if D_SAMPLE_CELL>36 & D_SAMPLE_CELL <= 42
  capture gen FARM_SYSTEM_HISTORIC = FARM_SYSTEM

  capture gen tableBcol = .
  replace tableBcol = 1 if UAA_SIZE >    0 & UAA_SIZE <  10
  replace tableBcol = 2 if UAA_SIZE >=  10 & UAA_SIZE <  20
  replace tableBcol = 3 if UAA_SIZE >=  20 & UAA_SIZE <  30
  replace tableBcol = 4 if UAA_SIZE >=  30 & UAA_SIZE <  50
  replace tableBcol = 5 if UAA_SIZE >=  50 & UAA_SIZE < 100
  replace tableBcol = 6 if UAA_SIZE >= 100



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

  
      * TODO: Stop using D_SAMPLE_CELL that came packaged with the 
      *        data 


      * Choose the appropriate cell index number
      capture drop cell_number
      *gen int cell_number = D_SAMPLE_CELL_HISTORIC
      gen int cell_number = D_SAMPLE_CELL
  }
  
  *------------------------------------------------------------------

  
  



  *------------------------------------------------------------------
  * Use matrices to assign weight variable
  *------------------------------------------------------------------

  local numrows = rowsof(M_WTS_`YYYY')
  local numcols = colsof(M_WTS_`YYYY')

  forvalues i= 1/`numrows' {
  
    forvalues j=1/`numcols' {
  	
      qui replace WTvalue = M_WTS_`YYYY'[`i',`j'] ///
        if cell_number == M_SAMPLE_CELL[`i',`j']   & ///
           year == `YYYY'
      
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
