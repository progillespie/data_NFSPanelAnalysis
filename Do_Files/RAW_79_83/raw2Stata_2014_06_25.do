args append_only

clear all
set maxvar 10000

  


local startdir: pwd // Save current working directory location
local dodir    "D:\Data/data_NFSPanelAnalysis/Do_Files/RAW_79_83"
local origdata "D:\Data/data_NFSPanelAnalysis/OrigData/RAW_79_83"
local outdata  "D:\Data/data_NFSPanelAnalysis/OutData/RAW_79_83"
capture mkdir `outdata'


cd `origdata'
capture mkdir raw_dta
capture mkdir csv
local files: dir "." files "*.xls*"



* Create renaming do files dynamically using raw2IBnamemappings.xlsx
* (will fail if the spreadsheet is open... close and run again)
*  (can be made static by turning off if do files already exist)
cd `dodir'
qui do sub_do/create_renameSheet_code.do



if "`append_only'" != "append_only" {
  *-------------------------------------------------------------
  * 1 Create one dataset per year (i.e. each workbook/.xls file)
  *-------------------------------------------------------------
  foreach spreadsheet of local files {
  
    *++++++++++++++++++++++++++++++++++++++++++++++++++++
    * Data is in origdata. Ensure that's the current dir
    *++++++++++++++++++++++++++++++++++++++++++++++++++++
    cd `origdata'


    * Get info about this workbook (year, no. sheets)
    qui import excel using `spreadsheet', describe
    local shortfilename = substr("`spreadsheet'",1,5)
    macro list _shortfilename
  
    /* Number of sheets. Store in `N_worksheets' b/c 
       `r(N_worksheet)' gets erased by the duplicates 
                    drop command in the loop somehow  */
    local N_worksheet = `r(N_worksheet)' 
    capture mkdir raw_dta/`shortfilename'
  
  
  
    *-----------------------------------------------------
    * 1.1 Save each sheet in Stata format, prepare for
    *  merging
    *-----------------------------------------------------
                
    * Loop over worksheets in workbook to import data.
    local i = 1
    while `i' <= `N_worksheet'{
      di "`i'
      import excel using `spreadsheet'          ///
        , sheet("Sheet`i'") firstrow clear


      * If a sheet has no obs then it won't save
      *  and you'll get an error. Fix this.
      count

      if `r(N)'==0 {
        set obs 1
      }  

      
      * Saving csv versions makes data more portable, both to 
      *  earlier versions of Stata, and other stats packages
      capture mkdir csv/`shortfilename'
      outsheet using csv/`shortfilename'/Sheet`i'.csv, replace comma 


      *++++++++++++++++++++++++++++++++++++++++++++
      * Do-Files are in dodir, so move there
      *++++++++++++++++++++++++++++++++++++++++++++
      cd `dodir'

      * Drop dups (in terms of all vars) and do 
      *  appropriate algorithm
      qui duplicates drop _all, force
      qui do sub_do/_convertSheet/convertSheet`i'.do

            
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
      local i = `i' + 1

    }


    *-----------------------------------------------------
    * End of subloop 1.1
    *-----------------------------------------------------
    

    
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
  
    save     raw_dta/`shortfilename'/all_sheets, replace
    
  }

  *-------------------------------------------------------------
  * End of loop 1
  *-------------------------------------------------------------

}
*--------------------------------------------------------------------
* If append_only condition closed
*--------------------------------------------------------------------


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



* Now have all variable columns, so drop all obs (they're wrong)
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

note:.Data from RAW_79_83 folder. Created using raw2Stata.do     ///
(or most recently dated version of that file).


note:.                                                            
note:.The data are historical NFS data going back as far as       ///
1979 at time of writing . The data were retrieved from            ///
magnetic tapes by Gerry Quinlan before his retirement, and        ///
stored in spreadsheets. Preparation of the data from that point   ///
on was carried out by Patrick R. Gillespie as part of his Ph.D.   ///
Questions on the data should be sent to him.

note:.                                                            
note:.The modern NFS stores the raw data in an XML                ///
database, and a programming language called XPath (or possibly    /// 
XQuery, which is an extension to XPath) is used to manipulate it  ///
before most REDP researchers ever see it as a Stata .dta file.    ///
A database will be perfectly ok with having data in               ///
different shapes, but Stata is more rigid. This data file is      ///
what the raw data looks like when forced into the usual one-      ///
column-per-variable, one-row-per-observation form that Stata      ///
-and most statistical packages- require. The data is VERY wide;   ///
there will be thousands of variables, mainly due to certain vars  ///
being repeated per crop code, bulk feed code, etc. Many vars will ///
also have a lot of 0 valued observations. For these               ///
reasons, you will most likely NOT be working with this data       ///
directly, but will use it to derive the usual variables of        ///
interest and take a subset of this for your own purposes.

note:.                                                            
note:.Most derived vars, i.e. D_VARNAME are not present in this   /// 
data. There is separate code available to do those calculations   ///
as needed. (See below)

note:.                                                            
note:.If you were expecting the 8 digit "SAS" varnames, then      ///
you'll be glad to know that THERE IS CODE to rename the           ///
appropriate vars. Many of these will be derived vars for which    ///
you'll have to run the variable's definition file first. There is ///
also code for renaming crop specific vars (will end in 4 digits). ///
Please consult Patrick R. Gillespie. 


note:.                                                            
note:.                                                            
note:.-----------------------------                                                           
note:.Example of how to derive vars
note:.-----------------------------                                                           
note:.                                                            
note:.First move to the folder containing the variable definitions.
note:.                                                          
note:.                                                            
note:.   cd D:\Data\data_NFSPanelAnalysis\Do_Files\RAW_79_83\sub_do
note:.   (Filepaths may differ from computer to computer.)
note:.                                                            
note:.                                                         
note:.Then run the file with the definition, which will be in a  ///
      filepath following this pattern:                           
note:.                                                         
note:.                                                            
note:.   IB_varname/IB_varname.do                               
note:.                                                            
note:.                                                            
note:.... where IB_varname is the IB style variable name, e.g.     
note:.                                                            
note:.                                                            
note:.   do D_FARM_GROSS_OUTPUT/D_FARM_GROSS_OUTPUT.do          
note:.                                                         
note:.                                                            
note:.IB varnames will have been shortened if they exceeded       ///
     Stata's varname character limit (32 characters). Varnames    ///
     are documented in the mapping spreadsheet, including the     ///
     shortened IB varnames and their corresponding original       ///
     versions.  
note:.                                                         
note:.Varnames were shortened systematically using the            ///
     SUBSTITUTE() function in Excel. See the D_Shortened          ///
     sheet.                




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
