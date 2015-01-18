* ====================================================================
*  fform - Program to make functional forms
* ====================================================================

capture program drop fform
program define fform, rclass

args symbol vlist numeraire norm homog


* Let's the loops choose the correct version of each
*   variable (e.g. mean normalised, homogenous) for 
*    creating the the terms
if    `norm' == 1 local suffix "_norm"
else              local suffix ""

* --------------------------------------------------------------------
* Create normalisations, logs, and Cobb-Douglas
* --------------------------------------------------------------------
foreach var of local vlist {
  
  *  Switch for mean normalisation
  if `norm' == 1 {
    qui summ `var'
    capture drop `var'`suffix'
    gen double `var'`suffix' = `var'/`r(mean)'
  }
  
  if `homog' == 1 {
    * Suffix may be "" or _norm at this point
    *  The _hom suffix will be set further down, 
    *   so it must be hardcoded for this part.
    capture drop `var'_hom
    gen double `var'_hom = `var'`suffix'/`numeraire'`suffix'
  }
  
  capture drop ln`var'
  
  * Choose appropriate version of input to log
  if `homog'==1 gen double ln`var' = ln(`var'_hom)
  else          gen double ln`var' = ln(`var'`suffix')
  
  capture drop ln`var'
  gen double ln`var' = ln(`var')
  
  
  * Cobb-Douglas production function (exlcude numerarire from list)
  if "`var'" != "`numeraire'"  local cd "`cd' ln`var'"

 }

 * If homogenised, make _hom the suffix (whether normalised or not)
 *   otherwise will be either "" or _norm
 if  `homog' == 1 local suffix "_hom"

 
* In any case, suffix is now appropriate for translog loop 
 
 
 

* --------------------------------------------------------------------
* Create interactions, logs, and translog varlist
* --------------------------------------------------------------------


* List which excludes variables already interacted
*  e.g. after  x11, x12, skip x21 (start from x22). 
*  This list starts out as a copy of x, and shrinks
*  as the loop progresses. Numeraire is removed from
*  the initial list
local vlist : list vlist - numeraire
local J_vars "`vlist'"

* Record the number associated with the numeraire input
local numeraire_index = subinstr("`numeraire'", "`symbol'", "", 1)

* Initialise an index 
local i = 0  


* Loop gives you ln(x_i^ 2) and ln(x_i x_j )
*  These are the square and interaction terms of 
*   all the vars in the varlist. 
foreach I_var of local vlist {
  
  
  local i = `i' + 1
  
  * Increment outer loop index number again if its the
  *  numeraire's index (we've removed it from the list!)
  if "`i'" == "`numeraire_index'" local i = `i' + 1



  * Initisalise another index for inner loop
  local j = `i'
  foreach J_var of local J_vars {
    
	di "`I_var'`suffix'  X  `J_var'`suffix' = `symbol'`i'`j'"
	
	capture drop `symbol'`i'`j' 
	gen double `symbol'`i'`j'  = ///
	  `I_var'`suffix' * `J_var'`suffix'
	
	capture drop ln`symbol'`i'`j' 
	gen double ln`symbol'`i'`j' = ln(`symbol'`i'`j')
	
	* Translog	production function terms
	local tl "`tl' ln`symbol'`i'`j'"
	
	local j = `j' + 1
  }
  
  local J_vars: list J_vars - I_var
}
* --------------------------------------------------------------------

 
return local cd     "`cd'"
return local tl     "`tl'"
return local vlist  "`vlist'"
return local norm   "`norm'"
return local homog  "`homog'"
return local suffix "`suffix'"

end
* ====================================================================
*  End of fform definition
* ====================================================================







