args append_only
capture mkdir raw_dta
local files: dir "." files "*.xls*"

if "`append_only'" != "append_only"{
	*-------------------------------------------------------------
	* 1 Create one dataset per year (i.e. each workbook/.xls file)
	*-------------------------------------------------------------
	foreach spreadsheet of local files{
	
		qui import excel using `spreadsheet', describe
		
		local shortfilename = substr("`spreadsheet'",1,5)
		macro list _shortfilename
	
	
		/* Number of sheets. Store in `N_worksheets' b/c 
		    `r(N_worksheet)' gets erased by the duplicates drop 
	             command in the loop somehow*/
		local N_worksheet = `r(N_worksheet)' 
		capture mkdir raw_dta/`shortfilename'
	
	
	
		*-----------------------------------------------------
		* 1.1 Save each sheet in Stata format, prepare for
		*  merging
		*-----------------------------------------------------
		local i = 1
		while `i' <= `N_worksheet'{
			di "`i'
			import excel using `spreadsheet'          ///
			       , sheet("Sheet`i'") firstrow clear
	
			
			/* Drop the variable card (it's just the Sheet 
			   number). Necessary to facilitate merging later 
			   on.          */
			drop car?
	
			qui do sub_do/convertSheet`i'.do
	
			sort farm
			save raw_dta/`shortfilename'/Sheet`i', replace
			local i = `i' + 1
		}

			STOP!!
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
			  qui merge 1:1 farm                       ///
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
* 2 Append all years together for a single data file
*--------------------------------------------------------------------
foreach spreadsheet of local files {

	local shortfilename = substr("`spreadsheet'",1,5)
	macro list _shortfilename
	
	if "`shortfilename'" == "raw79"{
	   use raw_dta/`shortfilename'/all_sheets, clear
	   capture qui destring Quantityclosinginventory, replace
	}
	else{
	   append using raw_dta/`shortfilename'/all_sheets
	}
}
*--------------------------------------------------------------------
* End of loop 2
*----------------------------a----------------------------------------


order farm year

label var DED "District Electoral Division"

note: Data from RAW_79_83 folder (sent to PRG from COD on 25th Apr. ///
2014). All sheets within each workbook were first merged together   ///
(duplicates were dropped), then years were appended together. Some  ///
thought must be put into whether or not it was appropriate to drop  ///
duplicates, so this is only a provisional dataset.
 
save raw_dta/raw_79_83.dta, replace

notes


quietly {

	preserve

	describe, replace clear
	outsheet using raw_dta/raw7983varlist.csv, comma replace

	restore
}


do rename_raw79_83.do



/* NOTE: Some sheets have a typo (carf instead of card), hence the single 
         wildcard character ("?") in the drop command. 
			 			 
   ALSO: If "drop car?" causes an error, then check to see that the 
         variables are named (not just labelled) using the first row 
         of the sheet. Sheet12 has repeated column headings ("alloc 
         crop code" and "Quantity") which confuses Stata, so it 
         reverts to using the column letters instead (hence there are
         no 4 letter variables, let alone any beginning with "car"). 
         I handled this by adding the numbers 1 - 4 to the end of 
         those column headings (e.g. alloc crop code 1, Quantity 1, 
         alloc crop code 2, etc.). Stata was then able to use the 
         first row as varnames again, and the code executed. This 
         needs to be done for all years' workbooks.      */



* Do this before merging sheets within any given year (so near top of file)
* Code for collapsing all the crop codes

	*local i = substr("`var'", -1, 1)
	*macro list _i
	*egen crop`i' = concat(farm `var'),  punct(_)

