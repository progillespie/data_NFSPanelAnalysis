* Address once-off issues for particular sheets in the conversion
*  process
		        
* Macros passed in from master file
args shortfilename i


*-------------*
* 1979        *
*-------------*

* Small amount of duplicated obs... OK to drop
if "`shortfilename'" == "raw79" & ///
"`i'" == "21" {

	duplicates drop farm, force

}	




*-------------*
* 1980        *
*-------------*

* Small amount of duplicated obs... OK to drop
if "`shortfilename'" == "raw80" & ["`i'"=="9" | "`i'"=="10"] {

	duplicates drop farm, force

}	




*-------------*
* 1981        *
*-------------*

* MAJOR ISSUE: Sheet 6's farmcodes are invalid. Drop all obs
if "`shortfilename'" == "raw81" & "`i'"=="6" {

	drop if _n > 0

}	


* Small amount of duplicated obs... OK to drop
if "`shortfilename'" == "raw81" & ///
   ["`i'"=="7" | "`i'"=="32" | "`i'"=="42" ] {

	duplicates drop farm, force

}	



*-------------*
* 1982        *
*-------------*

* Small amount of duplicated obs... OK to drop
if "`shortfilename'" == "raw82" & "`i'"=="7"  {

	duplicates drop farm, force

}	



*-------------*
* 1983        *
*-------------*

* Small amount of duplicated obs... OK to drop
if "`shortfilename'" == "raw83" &  ///
    ["`i'"=="7"| "`i'"=="13"] {

	duplicates drop farm, force

}	

