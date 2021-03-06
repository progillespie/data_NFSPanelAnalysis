capture program drop cropcodekey
program define cropcodekey, rclass

args code


* Break up code into its parts
local first3digits = substr("`code'",1,3)
local lastdigit    = substr("`code'",-1,1)
   


* "if" statements decide the appropriate SAS abbreviation
* Initialise the macro cropabbrev
local cropabbrev ""
   	

* First three digits = crop 
if "`first3digits'" =="111" {
	local cropabbrev "wh"
}
   	
if "`first3digits'" =="114" {
	local cropabbrev "by"
}
   	
if "`first3digits'" =="115" {
	local cropabbrev "ot"
}
   	
if "`first3digits'" =="131" {
	local cropabbrev "pot"
}
   	
if "`first3digits'" =="132" {
	local cropabbrev "sbe"
}
   	
if "`first3digits'" =="143" {
	local cropabbrev "osr"
}
   	
if "`first3digits'" =="156" {
	local cropabbrev "lsd"
}
   	
if "`first3digits'" =="157" {
	local cropabbrev "mby"
}
   	
if "`first3digits'" =="175" {
	local cropabbrev "for"
}
   	
if "`first3digits'" =="811" {
	local cropabbrev "stw"
}
   	
if "`first3digits'" =="902" {
	local cropabbrev "msl"
}
   	
if "`first3digits'" =="903" {
	local cropabbrev "asl"
}
   	
if "`first3digits'" =="904" {
	local cropabbrev "tms"
}
   	
if "`first3digits'" =="906" {
	local cropabbrev "fbt"
}
   	
if "`first3digits'" =="922" {
	local cropabbrev "hay"
}
   	
if "`first3digits'" =="923" {
	local cropabbrev "sil"
}
   
   	
 *Last digit = description. There are SAS abbreviations for 
 * only the "spring" = 1 and "winter"=6 descriptors . Also, 
 * these are only ever applied to the crops wheat, barley, 
 * and oats. 
local descriptor ""
if "`lastdigit'"    =="1"  &        ///
  ["`first3digits'" == "111"  ///
  | "`first3digits'"== "114"  /// 
  | "`first3digits'"== "115"  ]  {
   
	local descriptor "s"
	local lastdigit ""
   		
}
   

if "`lastdigit'"    =="6"  &  ///
  ["`first3digits'" == "111"  ///
  | "`first3digits'"== "114"  /// 
  | "`first3digits'"== "115"  ]  {
   
	local descriptor "w"
	local lastdigit ""
}

return local first3digits "`first3digits'"
return local lastdigit    "`lastdigit'"
return local cropabbrev   "`cropabbrev'"
return local descriptor   "`descriptor'"

end
