* Reads Excel spreadsheet TO CREATE CODE for naming raw variables.
*  from IB style to SAS style varnames.

* DOES NOT do the renaming itself... it writes the code file which
*  does that.



capture preserve // Preserve the data in memory temporarily

import excel using ///
 "D:\Data\data_NFSPanelAnalysis\Support_Docs\raw2SASnamemapping\raw2IBnamemappings.xlsx" ///
  , firstrow sheet("AllVarsMapping") allstring clear



/*  Drop if there was no default varname for a variable (it's not in
     the raw data).     */
drop if DefaultStatavarname==":"



/* Stata thinks the code is a dataset, so write 
  a do file which Stata will read back in later.

  By selecting the variables "rename" "Default.."
  etc. we've isolated the columns with code in them
  and the "if Sheet ==" part gets just the renaming
  commands that are relevant for a particular sheet. */


* First remove any spaces in the varnames
replace Mappedcode = regexr(Mappedcode," ", "")
replace SAScode    = regexr(SAScode   ," ", "")

* Now write the do file
outfile rename Mappedcode SAScode ///
   using renameIB2SAS.do ///
   if SAScode != ":"            & ///
      SAScode != "default"      & ///
      length(SAScode)> 5       ///
   , noq wide replace



capture restore  // Renaming file updated, bring back preserved data
