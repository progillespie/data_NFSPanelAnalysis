*--------------------------------------------------------------------
* Creates overlaid kernel densities for NI, BMW, and SE
*	- year 2008 only
*	- Net margins per litre from -0.10 to 0.30 only
*--------------------------------------------------------------------

* Get varname to plot from command line.
args area code yyyy

* Default values 

if "`yyyy'"=="" {

	local yyyy "==2008"

}

local fortitle "Components of Net Margin (€) (`area' `code', year `yyyy')"

* Bounds on graph
local limvar "fdairynm_lt" // 
local UL "0.5"
local LL "-0.1"

*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
* Graphing command
*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
kdensity fdairygo_lt if                     /// ===== Command ========
           `area' == `code'               & ///
	   year `yyyy'                    & /// First plot (GO)
           fdairygo_lt    < `UL'          & ///
           fdairygo_lt   > `LL'             ///
    , addplot(kdensity fdairydc_lt if       /// =======Options========
                      `area' == `code'    & ///
                      year `yyyy'         & /// 
                      fdairydc_lt < `UL'  & /// Second plot (DC)
                      fdairydc_lt > `LL'    ///
              ||                            /// 
              kdensity fdairyoh_lt if       /// ----------------------
                      `area' == `code'    & ///
                      year `yyyy'         & ///
                      fdairyoh_lt < `UL'  & /// Third plot (OH)
                      fdairyoh_lt > `LL'    ///
              ||                            /// 
              kdensity fdairynm_lt if       /// ---------------------- 
                      `area' == `code'    & ///
                      year `yyyy'         & /// Fourth plot (NM)
                      fdairynm_lt < `UL'  & /// 
                      fdairynm_lt > `LL'  ) /// ---------------------- 
      scheme(s2mono)                        /// Start from s2mono 
      legend(bplacement(neast) ring(0)      /// Legend in plot area    
             label(1 "GO")                  /// ----------------------
             label(2 "DC")                  /// Legend labels
             label(3 "OH")                  ///   & suppress
             label(4 "NM")                  ///   legend outline
             region(lcolor(white))   )      /// ----------------------
       plotregion(style(none))              /// no plotregion border
       graphregion(                         /// ----------------------
                   lcolor(white)            /// graphregion border 
                   fcolor(white)            ///  color set to white
                  )                         /// ----------------------
       xscale(range(`LL' (0.05) `UL'))      /// range at least LL-UL
       xlabel(`LL' (0.1) `UL')             /// force x labelling
       xtitle("")                           /// suppress x axis title
       yscale(range(0 (5) 25))      /// range at least LL-UL
       ylabel(0 (5) 25 ,nogrid)                      /// suppress y gridlines
      note ("")                             /// suppress notes
      title("`fortitle'")                  


*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
* End of graphing command
*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -





* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
/* Prototype for a fourth plot...  



              ||                             ///  
              kdensity `var' if              ///----------------------
                         cntry == 1       &  ///
                         `yyyy' == 2008   &  /// 
                         `limvar'  < `UL' &  /// Fourth plot (IE)
                         `limvar'  > `LL'    ///

AND

             label(4 "IE") )    

Don't forget to remove the last ")" in second to last label! */
* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

