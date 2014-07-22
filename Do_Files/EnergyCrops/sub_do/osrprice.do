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
* Incorporates country-year average oilseed 
* prices from Eurostat to $dataname
********************************************************



********************************************************
insheet using ../CountryData/Eurostat/apri_ap_crpouta_1_Data.csv
*
rename time year
rename value osrprice
gen str4 country = ""
replace country = "OST"	if geo == "Austria"
replace country = "BEL"	if geo == "Belgium"
replace country = "BGR"	if geo == "Bulgaria"
replace country = "CYP"	if geo == "Cyprus"
replace country = "CZE"	if geo == "Czech Republic"
replace country = "DAN"	if geo == "Denmark"
replace country = "EST"	if geo == "Estonia"
replace country = "SUO"	if geo == "Finland"
replace country = "FRA"	if geo == "France"
replace country = "DEU"	if geo == "Germany (including  former GDR from 1991)"
replace country = "ELL"	if geo == "Greece"
replace country = "HUN"	if geo == "Hungary"
replace country = "IRE"	if geo == "Ireland"
replace country = "ITA"	if geo == "Italy"
replace country = "LVA"	if geo == "Latvia"
replace country = "LTU"	if geo == "Lithuania"
replace country = "LUX"	if geo == "Luxembourg"
replace country = "MLT"	if geo == "Malta"
replace country = "NED"	if geo == "Netherlands"
replace country = "POL"	if geo == "Poland"
replace country = "POR"	if geo == "Portugal"
replace country = "ROU"	if geo == "Romania"
replace country = "SVK"	if geo == "Slovakia"
replace country = "SVN"	if geo == "Slovenia"
replace country = "ESP"	if geo == "Spain"
replace country = "SVE"	if geo == "Sweden"
replace country = "UKI"	if geo == "United Kingdom"
*
keep country year osrprice
sort country year
*
save ../CountrySTATAFiles/Eurostat/apri_ap_crpouta_1_Data, replace
*
use ../CountrySTATAFiles/databuilds/$dataname, clear
sort country year
*
merge m:1 country year using ../CountrySTATAFiles/Eurostat/apri_ap_crpouta_1_Data
drop if _merge == 2
drop _merge
*
sort country year farmcode
save ../CountrySTATAFiles/databuilds/$dataname, replace
********************************************************
