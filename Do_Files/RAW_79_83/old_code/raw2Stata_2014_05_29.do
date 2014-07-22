args append_only

clear all
set maxvar 10000

capture mkdir raw_dta
cd "D:\Data/data_NFSPanelAnalysis/OrigData/RAW_79_83"
	


local startdir: pwd // Save current working directory location



local outdata "D:\Data/data_NFSPanelAnalysis/OutData"
local files: dir "." files "*.xls*"



* Create renaming do files dynamically using raw2IBnamemappings.xlsx
*  (Can be made static by turning off if do files already exist)
qui do sub_do/create_renameSheet_code.do



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


			* If a sheet has no obs then it won't save
			*  and you'll get an error. Fix this.
			count
			if `r(N)'==0 {
			   set obs 1
			}	


		        * Drop dups (in terms of all vars) and do 
			*  appropriate algorithm
			qui duplicates drop _all, force
			qui do sub_do/_convertSheet/convertSheet`i'.do
		        qui duplicates report farmcode

		        
		        * Note which sheets still have surplus obs
		        if "`r(unique_value)'" != "`r(N)'" {

		            local `i'`shortfilename'_surplus = ///
		               `r(N)' - `r(unique_value)'

		        }	

			
		        * The odd sheet has once-off issues to fix
		      qui do sub_do/specialcases.do `shortfilename' `i'


			sort farmcode
			save raw_dta/`shortfilename'/Sheet`i', replace
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
	   capture qui destring CONC_ALLOC_DAIRY_HERD_50KG_EU, replace
	}

	else if "`shortfilename'" == "raw80"{
	   save `outdata'/nfs_temp.dta, replace
	   use raw_dta/`shortfilename'/all_sheets, clear
	   capture qui destring CONC_ALLOC_DAIRY_HERD_50KG_EU, replace
	   qui merge 1:1 farmcode                      ///
	      using `outdata'/nfs_temp                 ///
	      , nogen
	}

	
	else {
	   qui merge 1:1 farmcode                      ///
	      using raw_dta/`shortfilename'/all_sheets ///
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

note: Data from RAW_79_83 folder (sent to PRG from COD on 25th Apr. ///
2014). All sheets within each workbook were first edited using the  ///
convertSheet do files.  After each conversion is  done, the sheets  ///
are saved as separate dta's before merging. Early versions of this  ///
dataset had simply dropped duplicated entries for  each farmcode,   ///
but this was not appropriate. Resolving these rows is handled by    ///
the conversion files . The algorithm used to get the  data in shape ///
varies by sheet (see README for details).
 
save `outdata'/nfs_7983.dta, replace
erase `outdata'/nfs_temp.dta

tabstat farmcode, stats(N) by(year)

notes


quietly {

	preserve
	
	* Creates csv listing vars in dataset
	describe, replace clear
	outsheet using `outdata'/nfs_7983varlist.csv, comma replace

	restore

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
}



* TODO move the following to the bottom of the file (after testing done)
* Create IB-style derived variables
*do sub_do/IBderivedvars.do

cd sub_do
do D_FARM_GROSS_OUTPUT/D_FARM_GROSS_OUTPUT.do


*cd "D:\Data\data_NFSPanelAnalysis\OrigData\RAW_79_83\sub_do\D_FARM_GROSS_OUTPUT"
*do D_TOTAL_LIVESTOCK_GROSS_OUTPUT/D_TOTAL_LIVESTOCK_GROSS_OUTPUT

cd `startdir' // return Stata to previous directory
