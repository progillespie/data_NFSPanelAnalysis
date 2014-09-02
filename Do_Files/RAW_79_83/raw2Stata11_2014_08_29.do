args append_only

clear all
set maxvar 10000

  
local stata_version = 12
local lennon = 1


local startdir: pwd // Save current working directory location
local dodir    "D:\Data/data_NFSPanelAnalysis/Do_Files/RAW_79_83"
local origdata "D:\Data/data_NFSPanelAnalysis/OrigData/RAW_79_83"
local outdata  "D:\Data/data_NFSPanelAnalysis/OutData/RAW_79_83"
capture mkdir `outdata'


cd `origdata'
capture mkdir raw_dta
capture mkdir csv
local files: dir "." files "*.xls*"



if `stata_version' >= 12 {

  * Create renaming do files dynamically using raw2IBnamemappings.xlsx
  * (will fail if the spreadsheet is open... close and run again)
  *  (can be made static by turning off if do files already exist)
  cd `dodir'
  

  if `lennon' == 1 {

    qui do sub_do/create_renameSheet_lennon_code.do

    * Previous do file left in memory a matrix storing the 
    *   svy_tables we need. Initialise these as blank datasets to 
    *   which we merge variables from the various sheets without prior
    *   knowledge of which vars come from which sheet or which to 
    *   table they belong.
    local tables: rownames(SVY_CODES)
    local tables: list uniq tables


    capture mkdir `outdata'/svy_tables_7983
    qui foreach filename of local tables {

      clear
      set obs 1
      gen int FARM_CODE = .
      gen int YE_AR     = . 
      gen int Row       = . 
      drop if _n > 0
      save `outdata'/svy_tables_7983/`filename', replace

    }

    * You now have blank dataset for each svy_table, with 0 obs and
    * just the key variables for the merge (FARM_CODE and YE_AR also
    * with 0 obs). They are located here...
    macro list _outdata

    * ... and here's all the contents of that directory (the files)
    dir `outdata'/svy_tables_7983/


  } 



  if `lennon' != 1 {

    * Rename variables s.t. PRG's original code will run. 
    qui do sub_do/create_renameSheet_code.do

  }

}




* This section reads the raw data from an Excel spreadsheet or csv
*   and prepares Stata datasets. If append_only was specified on the 
*   Stata command line when calling this file then this 
*   section is skipped, running instead from previously saved .dta's

if "`append_only'" != "append_only" {
  *-------------------------------------------------------------
  * 1 Create one dataset per year (i.e. each workbook/.xls file)
  *-------------------------------------------------------------
  foreach spreadsheet of local files {
  
    *++++++++++++++++++++++++++++++++++++++++++++++++++++
    * Data is in origdata. Ensure that's the current dir
    *++++++++++++++++++++++++++++++++++++++++++++++++++++
    cd `origdata'


    local shortfilename = substr("`spreadsheet'",1,5)
    capture mkdir raw_dta/`shortfilename'
    capture mkdir csv/`shortfilename'


    if `stata_version' >= 12 {

      * Get info about this workbook (year, no. sheets)
      qui import excel using `spreadsheet', describe
      macro list _shortfilename
    
      /* Number of sheets. Store in `N_worksheet' b/c 
         `r(N_worksheet)' gets erased by the 
            "duplicates drop" command in the loop somehow  */
      local N_worksheet = `r(N_worksheet)' 
  
    }
  
    else {

      * Get list of csv worksheets for this year to loop over
      local csv_files: dir "csv/`shortfilename'" ///
        files "Sheet*.csv", respectcase
      local csv_files: list sort csv_files
      macro list _csv_files
    
   
      * Count the number of files, which will then be
      *   N_worksheet
      local N_worksheet = 0
      foreach file of local csv_files { 
        
        local N_worksheet = `N_worksheet' + 1

      }
    }
    
    macro list _N_worksheet 
    
    
    *-----------------------------------------------------
    * 1.1 Save each sheet in Stata format, prepare for
    *  merging
    *-----------------------------------------------------
    


    * Loop over worksheets in workbook to import data.
    local i = 1
    while `i' <= `N_worksheet'{

      di "`i'"

      *---------------------------------
      * Branch for Stata12+ versions
      *---------------------------------
      if `stata_version' >= 12 {
  
        import excel using `spreadsheet'          ///
          , sheet("Sheet`i'") firstrow clear
  
      }
      *---------------------------------
      * End of Stata12+ branch
      *---------------------------------



      *---------------------------------
      * Branch for pre-Stata12 versions
      *---------------------------------
      else {
  
        insheet using csv/`shortfilename'/Sheet`i'.csv ///
          , comma case clear

      }
      *---------------------------------
      * Endo of pre-Stata12 branch
      *---------------------------------

 
  
      *---------------------------------------
      * Rest of loop (after import or insheet
      *---------------------------------------

      * If a sheet has no obs then it won't save
      *  and you'll get an error. Fix this.
      count

      if `r(N)'==0 {
        set obs 1
      }  

      
      * Saving csv versions makes data more portable, both to 
      *  earlier versions of Stata, and other stats packages
      *outsheet using csv/`shortfilename'/Sheet`i'.csv, replace comma 


      *++++++++++++++++++++++++++++++++++++++++++++
      * Do-Files are in dodir, so move there
      *++++++++++++++++++++++++++++++++++++++++++++
      cd `dodir'

      * Drop dups (in terms of all vars) and do 
      *  appropriate algorithm
      qui duplicates drop _all, force

      if `lennon' == 1 {

        
        local YYYY = substr("`shortfilename'", 4,2)
        
        qui do sub_do/Sheet2Tables.do `i' `YYYY' `outdata'
        * This far
        continue

      }

      else {
        qui do                                   ///
         sub_do/_convertSheet/convertSheet`i'.do ///
         `shortfilename' `origdata'

            
        * Note which sheets still have surplus obs
        qui duplicates report farmcode
        if "`r(unique_value)'" != "`r(N)'" {

          local `i'`shortfilename'_surplus = ///
            `r(N)' - `r(unique_value)'

        }  

      
        * The odd sheet has once-off issues to fix
        *   (note that `i' is a macro passed into the dofile, not
        *    a part of the do file's name)
        qui do sub_do/specialcases.do `shortfilename' `i'



        *++++++++++++++++++++++++++++++++++++++++++++
        * Data should remain in origdata so move back
        *++++++++++++++++++++++++++++++++++++++++++++
        cd `origdata'

        sort farmcode
        save     raw_dta/`shortfilename'/Sheet`i', replace

      }

      cd `origdata'
      local i = `i' + 1

    }


    if `lennon' == 1 {

      continue,break
    
    }  
  

    *-----------------------------------------------------
    * End of subloop 1.1
    *-----------------------------------------------------
    

    
    * NO DIFFERENCE IN VERSION FOR REMAINING CODE
    *-----------------------------------------------------
    * 1.2 Merge sheets together for single Stata dataset 
    *  per year
    *-----------------------------------------------------
    local i = 1
    while `i' <= `N_worksheet'{
      
      if `i'==1{
         use raw_dta/`shortfilename'/Sheet`i', clear
      }

      else {
        qui merge 1:1 farmcode                   ///
         using raw_dta/`shortfilename'/Sheet`i'  ///
         , nogen
      }
      
      local i = `i' + 1  

    }

    *-----------------------------------------------------
    * End of subloop 1.2
    *-----------------------------------------------------
  

    gen year = substr("`shortfilename'", 4,2)
    destring year, replace
    replace year = year + 1900
 
    save raw_dta/`shortfilename'/all_sheets, replace
    
  }

  *-------------------------------------------------------------
  * End of loop 1
  *-------------------------------------------------------------
}

*--------------------------------------------------------------------
* If append_only condition closed
*--------------------------------------------------------------------

STOP!!

*++++++++++++++++++++++++++++++++++++++++++++++++++++
* Data is in origdata. Ensure that's the current dir
*++++++++++++++++++++++++++++++++++++++++++++++++++++
cd `origdata'


*--------------------------------------------------------------------
* 2 Append all years together for a single data file
*--------------------------------------------------------------------
foreach spreadsheet of local files {

  local shortfilename = substr("`spreadsheet'",1,5)
  macro list _shortfilename
  

  if "`shortfilename'" == "raw79"{
     use raw_dta/`shortfilename'/all_sheets, clear
     capture qui destring Quantityclosinginventory, replace
     capture qui destring CONC_ALLOC_DAIRY_HERD_50KG_EU, replace
  }

  else if "`shortfilename'" == "raw80"{
     save `outdata'/nfs_temp.dta, replace
     use raw_dta/`shortfilename'/all_sheets, clear
     capture qui destring CONC_ALLOC_DAIRY_HERD_50KG_EU, replace
     qui merge 1:1 farmcode                      ///
       using `outdata'/nfs_temp                  ///
       , nogen
  }

  
  else {
     qui merge 1:1 farmcode                      ///
       using raw_dta/`shortfilename'/all_sheets  ///
       , nogen
  }
}



* Now you have all variable columns, so drop all obs (they're wrong)
drop if _n > 0 
save `outdata'/nfs_temp.dta, replace



foreach spreadsheet of local files {

  local shortfilename = substr("`spreadsheet'",1,5)
  macro list _shortfilename
  
  if "`shortfilename'" == "raw79"{
     use raw_dta/`shortfilename'/all_sheets, clear
     capture qui destring Quantityclosinginventory, replace
     save `outdata'/nfs_temp`shortfilename'.dta, replace
     use `outdata'/nfs_temp.dta
     append using `outdata'/nfs_temp`shortfilename'.dta
     erase `outdata'/nfs_temp`shortfilename'.dta
  }

  else if "`shortfilename'" == "raw80"{
     save `outdata'/nfs_temp.dta, replace
     use raw_dta/`shortfilename'/all_sheets, clear
     capture qui destring CONC_ALLOC_DAIRY_HERD_50KG_EU, replace
     save `outdata'/nfs_temp`shortfilename'.dta, replace
     use `outdata'/nfs_temp.dta
     append using `outdata'/nfs_temp`shortfilename'.dta
     erase `outdata'/nfs_temp`shortfilename'.dta
  }

  else{
     append using raw_dta/`shortfilename'/all_sheets
  }

}
*--------------------------------------------------------------------
* End of loop 2
*----------------------------a----------------------------------------


order farmcode year

label var DED  "District Electoral Division"
label var year "YearW



* Notes to attach to the dataset for future users
qui do `dodir'/sub_do/notes.do




save `outdata'/nfs_7983.dta, replace
erase `outdata'/nfs_temp.dta




* Create a spreadsheet describing the data (varnames, datatypes, etc)
quietly {

  preserve
  
  * Creates csv listing vars in dataset
  describe, replace clear
  outsheet using `outdata'/nfs_7983varlist.csv, comma replace

  restore

   /* 
   Some sheets have a typo (carf instead of card), hence the single 
     wildcard character ("?") in the drop command. 
              
   Also, if "drop car?" causes an error, then check to see that the 
     variables are named (not just labelled) using the first row 
     of the sheet. Sheet12 has repeated column headings ("alloc 
     crop code" and "Quantity") which confuses Stata, so it 
     reverts to using the column letters instead (hence there are
     no 4 letter variables, let alone any beginning with "car"). 
     I handled this by adding the numbers 1 - 4 to the end of 
     those column headings (e.g. alloc crop code 1, Quantity 1, 
     alloc crop code 2, etc.). Stata was then able to use the 
     first row as varnames again, and the code executed. This 
     needs to be done for all years' workbooks.      
    */
}



tabstat farmcode, stats(N) by(year)
notes  // show notes attached to data



cd `startdir' // return Stata to previous directory
