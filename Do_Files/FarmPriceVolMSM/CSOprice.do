local var1 = "$var1"
local var2 = "$var2"

qui replace dp`var1' = sc_`var2'_1985/sc_`var2'_1984 if sc_pricechange == 2 & YE_AR == 1984
qui replace dp`var1' = sc_`var2'_1986/sc_`var2'_1985 if sc_pricechange == 2 & YE_AR == 1985
qui replace dp`var1' = sc_`var2'_1987/sc_`var2'_1986 if sc_pricechange == 2 & YE_AR == 1986
qui replace dp`var1' = sc_`var2'_1988/sc_`var2'_1987 if sc_pricechange == 2 & YE_AR == 1987
qui replace dp`var1' = sc_`var2'_1989/sc_`var2'_1988 if sc_pricechange == 2 & YE_AR == 1988
qui replace dp`var1' = sc_`var2'_1990/sc_`var2'_1989 if sc_pricechange == 2 & YE_AR == 1989
qui replace dp`var1' = sc_`var2'_1991/sc_`var2'_1990 if sc_pricechange == 2 & YE_AR == 1990
qui replace dp`var1' = sc_`var2'_1992/sc_`var2'_1991 if sc_pricechange == 2 & YE_AR == 1991
qui replace dp`var1' = sc_`var2'_1993/sc_`var2'_1992 if sc_pricechange == 2 & YE_AR == 1992
qui replace dp`var1' = sc_`var2'_1994/sc_`var2'_1993 if sc_pricechange == 2 & YE_AR == 1993
qui replace dp`var1' = sc_`var2'_1995/sc_`var2'_1994 if sc_pricechange == 2 & YE_AR == 1994
qui replace dp`var1' = sc_`var2'_1996/sc_`var2'_1995 if sc_pricechange == 2 & YE_AR == 1995
qui replace dp`var1' = sc_`var2'_1997/sc_`var2'_1996 if sc_pricechange == 2 & YE_AR == 1996
qui replace dp`var1' = sc_`var2'_1998/sc_`var2'_1997 if sc_pricechange == 2 & YE_AR == 1997
qui replace dp`var1' = sc_`var2'_1999/sc_`var2'_1998 if sc_pricechange == 2 & YE_AR == 1998
qui replace dp`var1' = sc_`var2'_2000/sc_`var2'_1999 if sc_pricechange == 2 & YE_AR == 1999
qui replace dp`var1' = sc_`var2'_2001/sc_`var2'_2000 if sc_pricechange == 2 & YE_AR == 2000
qui replace dp`var1' = sc_`var2'_2002/sc_`var2'_2001 if sc_pricechange == 2 & YE_AR == 2001
qui replace dp`var1' = sc_`var2'_2003/sc_`var2'_2002 if sc_pricechange == 2 & YE_AR == 2002
qui replace dp`var1' = sc_`var2'_2004/sc_`var2'_2003 if sc_pricechange == 2 & YE_AR == 2003
qui replace dp`var1' = sc_`var2'_2005/sc_`var2'_2004 if sc_pricechange == 2 & YE_AR == 2004
qui replace dp`var1' = sc_`var2'_2006/sc_`var2'_2005 if sc_pricechange == 2 & YE_AR == 2005
qui replace dp`var1' = sc_`var2'_2007/sc_`var2'_2006 if sc_pricechange == 2 & YE_AR == 2006
qui replace dp`var1' = sc_`var2'_2008/sc_`var2'_2007 if sc_pricechange == 2 & YE_AR == 2007
qui replace dp`var1' = sc_`var2'_2009/sc_`var2'_2008 if sc_pricechange == 2 & YE_AR == 2008
qui replace dp`var1' = sc_`var2'_2010/sc_`var2'_2009 if sc_pricechange == 2 & YE_AR == 2009
qui replace dp`var1' = sc_`var2'_2011/sc_`var2'_2010 if sc_pricechange == 2 & YE_AR == 2010
qui replace dp`var1' = sc_`var2'_2012/sc_`var2'_2011 if sc_pricechange == 2 & YE_AR == 2011
*qui replace dp`var1' = sc_`var2'_2013/sc_`var2'_2012 if sc_pricechange == 2 & YE_AR == 2012


