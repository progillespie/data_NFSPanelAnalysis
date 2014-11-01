capture program drop yrbox
program define yrbox, rclass

version 12 
syntax varlist [if] [in] [,ytitle(string) title(string) NOOUTsides]


graph box `varlist' `if' `in', ///
  over(year, relabel (1 " "   2 "1980"   3 " "   4 " "   5 " "   6 "1984"   7 " "   8 " "   9 " "   10 "1988"   11 " "   12 " "   13 " "   14 "1992"   15 " "   16 " "   17 " "   18 "1996"   19 " "    20 " "   21 " "   22 "2000"   23 " "   24 " "   25 " "   26 "2004"   27 " "   28 " "   29 " "   30 "2008"   31 " "   32 " "   33 " "   34 "2012") )     ///
  `nooutsides'        ///
  ytitle(`"`ytitle'"')    ///
  title("`title'")

end
