********************************************************
********************************************************
* Patrick R. Gillespie				
* Research Officer				
* Teagasc, REDP					
* Athenry, Co Galway, Ireland			
* patrick.gillespie@teagasc.ie	
*											
********************************************************
* RSF Project DAF RSF 07 505 (GO1390)		
*											
* A micro level analysis of the Irish 	
* agri-food sector: lessons and 		
* recommendations from Denmark and 	
* the Netherlands				
*										
* Task 4
*
********************************************************
* Creates variables and restricts panel for the model
********************************************************



********************************************************
* Specify Panel Data - create unique pid's because
*   some farmcodes are repeated in multiple countries
********************************************************
egen pid = group(country region subregion farmcode)
destring pid, replace
tsset pid year
********************************************************



********************************************************
* Restrict panel to those farms which reported at the
*   time of the policy (this will drop 12 countries
*   from the panel because they had not yet joined the
*   EU). Also restrict to farms with a minimum of 4
*   observations (drops 1581 farms which had
*   discontinuous reporting). Finally drop 2007
*   because of a problem with Danish farms leaving the 
*   sample which was skewing the results. 
********************************************************
* Min and max years
by pid: egen year_max = max(year)
by pid: egen year_min = min(year)
keep if [year_min<=2002 & year_max>=2005]

* Min number of obs per farm is 4 years
tempvar length
by pid:gen `length' =_N
drop if `length'<4

* Drop 2007 for Danish farms (only 1 farm) 
drop if [year==2007 & country == "DAN"]
********************************************************



********************************************************
* Create a dummy variable for the energy crops scheme
*   (energycropsuaa variable was brought in with the
*   policy). Then encode country variable for 
*   interaction with time in model (can't interact
*   string variable in Stata)
********************************************************
*
gen policy = 0
replace policy = 1 if year > 2003 
* 
encode country, gen(mscode)
********************************************************



********************************************************
* Create adoption marker for each farm (to create 
*   subsets for Chow test)
********************************************************
*
by pid: egen min_ecuaa = min(energycropsuaa)
drop adopt
gen adopt = 0
replace adopt = 1 if min_ecuaa > 0
drop min_ecuaa
********************************************************



********************************************************
* TRANSFORMATIONS AND ADDITIONAL VARIABLES FOR THE
*   MODEL
********************************************************
*
gen solvency = totalliabilities/totalassets
gen ffi_tmp = familyfarmincome //Correct for negative and 0 FFI to facilitate taking log
replace ffi_tmp = 0 if familyfarmincome<0 
replace ffi_tmp = ffi_tmp + 1
gen ln_ffi = log(ffi_tmp)
gen ln_totaluaa = log(totaluaa)
gen ln_setasideuaa = log(setasideuaa)
gen ln_labour = log(labourinputhours)
gen ln_osrprice = log(osrprice)
gen specialise = totaloutputcrops/totaloutput 
gen osrape_prop = oilseedrapeuaa/totaluaa
gen intensity = machininerybuildingcurrentcosts/totalinputs
*
********************************************************
* The following measure of intensity was discarded 
*   because of differences in systems. Please see 
*   the working paper for an explanation. Recorded
*   here for transparency. DO NOT uncomment the command
*   on the following line. 
*gen intensity = (fertilisers + cropprotection)/totalinputs
********************************************************



********************************************************
*Interactions For Chow tests
********************************************************
gen pol_sizeclass = policy*sizeclass
gen pol_setasideuaa = policy*setasideuaa
gen pol_ln_labour = policy*ln_labour
gen pol_ln_ffi = policy*ln_ffi
gen pol_solvency = policy*solvency
gen pol_intensity = policy*intensity
gen pol_specialise = policy*specialise
gen pol_adop = policy*adopt
********************************************************
