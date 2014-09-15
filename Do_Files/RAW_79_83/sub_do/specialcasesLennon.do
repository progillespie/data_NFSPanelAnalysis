* Address once-off issues for particular sheets in the conversion
*  process
		        
* Macros passed in from master file
args shortfilename i



*-------------*
* 1981        *
*-------------*

* MAJOR ISSUE: Sheet 6's farmcodes are invalid. Drop all obs
if "`shortfilename'" == "raw81" & "`i'"=="6" {

	drop if _n > 0

}	



*-------------*
* 1983        *
*-------------*

* MAJOR ISSUE: Sheet 40's farmcodes are invalid. Drop all obs
*  Looks as if may be recoverable (with a lot of work from following
*  sheet because it's an obvious copy & paste error... data block
*  from C2 was pasted when A2 was selected).  
if "`shortfilename'" == "raw83" & "`i'"=="40" {

	drop if _n > 0

}	

