* Reads Excel spreadsheet to create code for naming raw variables.
*  from default varnames (after importing from excel to Stata) 
*  to IB style. 

* DOES NOT do the renaming itself... it writes the code file which
*  does that. 

* There will be a separate renaming file for each Sheet
*  of the raw data spreadsheet, and this will be called by the 
*  convertSheet file (also specific to each sheet of the 
*  spreadsheet).


import excel using "D:\Data\data_NFSPanelAnalysis\Support_Docs\raw2SASnamemapping\varnamemappings.xlsx", firstrow sheet("AllVarsMapping") allstring clear


drop if DefaultStatavarname==":"


capture drop Mappedcode 
gen     Mappedcode = LennonCode 
replace Mappedcode = PRGCode    if LennonCode == ":"

drop if Mappedcode == ":"            
drop if Mappedcode == "split by sex"
drop if missing(Mappedcode)


* Ensure matsize is big enough (1100 should do it)
capture set matsize 1100

* Stata only allows numeric matrices in its standard matrix lang. 
*   so make our string variable svy_table numeric 
encode svy_table, gen(svy_coded)


local i = 1
while `i' < 71 {

	di "Generating renaming code for Sheet `i'"

	* Stata thinks the code is a dataset, so write 
        *  a do file which Stata will read back in later.
        *  By selecting the variables "rename" "Default.."
        *  etc. we've isolated the columns with code in them
        *  and the "if Sheet ==" part gets just the renaming
        *  commands that are relevant for a particular sheet.
     
	outfile rename DefaultStatavarname Mappedcode  ///
	   using sub_do/_renameSheet/renameSheetLennon`i'.do ///
	   if Sheet == "Sheet `i'"  ///
	   , noq wide replace


        * Records variables' membership in various svy_tables via
        *   matrices. 

        * Get a list of all the table names cited for this Sheet 
        *   and store in a macro
        levelsof svy_table                ///
	  if Sheet == "Sheet `i'"          & ///
               svy_table != "various"      & ///
               svy_table != "unknown"      & ///
               svy_table != "split by sex"   ///
          , local(tables)


        * Create a matrix for each set of variables from this Sheet 
        *   belonging to each table. The matrix name will be, e.g.
        *   S1_1 for the first table from Sheet 1 and S1_2 for the
        *   second table from this sheet, etc. Most sheets are close
        *   to a 1:1 correspondence with some svy_table, but some are
        *   not, hence all the effort here.
        local j = 1
        foreach table of local tables {

          capture matrix drop S`i'_`table'

          * Create the matrix from the relevant subset of the data 
          *  Elements of the matrix must be numeric, so use svy_coded 
          mkmat svy_coded          ///
	    if Sheet == "Sheet `i'" & ///
               svy_table == "`table'" ///
            , matrix(S`i'_`j')        ///
              rownames(Mappedcode)    

              * Use column name to store the table's name
              matrix colnames S`i'_`j' = "`table'"

          local j = `j' + 1
        
        }
	local i = `i' + 1
}


* Make one more master matrix with the svy_table as the rowname. 
*   This will be used to create a list of tables to initialise as 
*   blank datasets. This step is important, because it means I can 
*   accomodate variables being assigned to a table from any number of
*   sheets, and in any order. This is handy, because I don't know this
*   information in advance. 
mkmat svy_coded                 ///
  if !missing(svy_table)         & ///
     svy_table != "various"      & ///
     svy_table != "unknown"      & ///
     svy_table != "split by sex"   ///
, matrix(SVY_CODES) rownames(svy_table)
