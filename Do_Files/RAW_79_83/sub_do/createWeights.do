capture log close


*--------------------------------------------------------------------
* Directories
*--------------------------------------------------------------------
local weight_dodir  "./_createWeights"
local estat_outdatadir "D:/Data/data_EUROSTAT/OutData/RAW_79_83"
local outdatadir "D:/Data/data_NFSPanelAnalysis/OutData/MakeWeights"
*--------------------------------------------------------------------

*TODO: Fix directories s.t. everything comes from FarmPriceVolMSM or
*       a subdirectory of it. Want to create a packet that has 
*       everything it needs. 
  
*TODO: Change all variable definitions to John's Cr_ style ones.

*TODO: Define historical systems and sample cell , 
*      assign farms to them, 
*      get farm counts for weight generation in spreadsheet, 
*      create new weight tables for 91 & 92 (I think... double check), 
*      complete a new run (after restructuring... or maybe not), 
*      add new mean GO series to FarmGO spreadsheet.



*--------------------------------------------------------------------
* Build panel and merge in SGM coefficients
*--------------------------------------------------------------------

qui do `weight_dodir'/sgm_1_createCoefs.do // gen SGM coef to merge
qui ds year SGMregion, not
local coefs "`r(varlist)'" // list of all the coefs to check

qui do `weight_dodir'/sgm_2_builddata.do // get raw vars from svy 

*--------------------------------------------------------------------





*--------------------------------------------------------------------
* Merge and drop years in which we have ONLY coefficients
*--------------------------------------------------------------------

sort year SGMregion
merge m:1 year SGMregion using ///
  "`estat_outdatadir'/SGM_coef_7311.dta", nogen
drop if year < 1979 // have no data before 1979
drop if year > 2012 // have no data after 2012


capture mkdir `outdatadir'/Logs
log using `outdatadir'/Logs/sgm_1and2.txt, text replace
* This log checks that the SGM coefs are correctly applied to the 
*   data. 

*  These are means of the coef's associated with each farm, they 
*  should match the csv's you imported because the mean of a constant
*  value is just the constant itself. 

* * * * * * * * * * * * * * * * * * * * * * * 
* Connacht-Ulster region SGM coefficients
* * * * * * * * * * * * * * * * * * * * * * * 
tabstat `coefs' if SGMregion==1 , by(YE_AR)


* * * * * * * * * * * * * * * * * * * * * * * 
* Leinster-Munster region SGM coefficients
* * * * * * * * * * * * * * * * * * * * * * * 
tabstat `coefs' if SGMregion==2 , by(YE_AR)

*  Pay particular attention to mushrooms (i02...) because it's
*  based on 100 m2 rather than hectares, but the first reported SGM
*  was in per hectare terms (100 larger than the rest of the series).
*  This should be fixed by this point.
log close
view `outdatadir'/Logs/sgm_1and2.txt
*--------------------------------------------------------------------



*--------------------------------------------------------------------
* Calculate SGMs and assign farms to EC farm types
*--------------------------------------------------------------------

* Derive necessary variables, calculate SGMs, and assign farms
*  according to EC typology
qui do `weight_dodir'/sgm_3_createInputVars.do
qui do `weight_dodir'/sgm_4_calcSGMs.do
qui do `weight_dodir'/sgm_5_createPrincipalTypes.do
qui do `weight_dodir'/sgm_6_createParticularTypes.do

*--------------------------------------------------------------------





*--------------------------------------------------------------------
* Define NFS systems on basis of EC farm types
*--------------------------------------------------------------------

* The final step is translating the principal and particular types
*   to NFS systems. NFS just regroups the types, although the actual
*   regroupings changed in 1993 to the modern groups, whilst there 
*   was a different grouping in the years prior. Hence, this file
*   will create FARM_SYSTEM and D_SAMPLE_CELL, as well as HISTORIC 
*   versions of both.
qui do `weight_dodir'/sgm_7_createNFSsystems.do



log using `outdatadir'/Logs/sgm_5to7.txt, text replace

* This log reports farmcounts by NFS system (modern and historic)
*   and by EEC farm types (Principal and Particular types). 
*   The system definitions are in finer detail as you progress
*   from one table to the next.

* * * * * * * * * * * * * * * * * * * * * * * 
* NFS systems (modern)
* * * * * * * * * * * * * * * * * * * * * * * 

table FARM_SYSTEM YE_AR


* * * * * * * * * * * * * * * * * * * * * * * 
* NFS systems (historic)
* * * * * * * * * * * * * * * * * * * * * * * 

table FARM_SYSTEM_HISTORIC YE_AR



* * * * * * * * * * * * * * * * * * * * * * * 
* EEC Typology - Principal types 
* * * * * * * * * * * * * * * * * * * * * * * 

table PrincipalType YE_AR


* * * * * * * * * * * * * * * * * * * * * * * 
* EEC Typology - Particular types
* * * * * * * * * * * * * * * * * * * * * * * 

table ParticularType YE_AR



log close
view `outdatadir'/Logs/sgm_5to7.txt

*--------------------------------------------------------------------




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
   It then assigns the weights to a variable called "value" for each
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

capture mkdir `outdatadir'/Logs
capture erase `outdatadir'/Logs/sgm_8_assignWeights.txt

* Get list of years to apply weights to (only applies from 1984 on)
levelsof year if year > 1983, local(datayears) 
foreach YYYY of local datayears {

    * Assign weights, passing in YYYY and outdatadir macros
    do `weight_dodir'/sgm_8_assignWeights.do `YYYY' `outdatadir'

}	


* Matrices left in memory. Check the dimensions are as expected.
matrix dir

*--------------------------------------------------------------------

di "Assignment done. Opening log."
view `outdatadir'/Logs/sgm_8_assignWeights.txt
