***************************************************
************ STATA MODELS *************************
***************************************************
use "/media/MyPassport/pg/productivity/Limdep Data (xls)/DAIRY XLS", clear
rename DC D


drop if Y2<=0
drop if LANDFAGE<=0
drop if LANDFEED<=0
drop if L3<=0
drop if C<=0
drop if D<=0
drop if H<=0 

***** set for panel analysis *****
tsset FC T


***** mean adjust and convert to logs ***** 

egen mY=mean(Y2)
egen mH=mean(H)
egen mC=mean(C)
egen mL=mean(L3)
egen mD=mean(D)
egen mA=mean(LANDFAGE)

gen lnY2=log(Y2/mY)
gen lnH=log(H/mH)
gen lnC=log(C/mC)
gen lnL=log(L3/mL)
gen lnD=log(D/mD)
gen lnA=log(LANDFAGE/mA)

****************************************************
********** Production Functions ********************
****************************************************

***** cobb-douglas *****
regress lnY lnH lnC lnL lnD lnA


***** add technical change *****
regress lnY lnH lnC lnL lnD lnA T

gen TT=T*T
regress lnY lnH lnC lnL lnD lnA T TT

gen TTT=TT*T
regress lnY lnH lnC lnL lnD lnA T TT TTT

regress lnY lnH lnC lnL lnD lnA T2 T3 T4 T5 T6 T7 T8 T9 T10 


***** translog functional form *****
gen lnHH=lnH*lnH
gen lnHC=lnH*lnC
gen lnHL=lnH*lnL
gen lnHD=lnH*lnD
gen lnHA=lnH*lnA
gen lnCC=lnC*lnC
gen lnCL=lnC*lnL
gen lnCD=lnC*lnD
gen lnCA=lnC*lnA
gen lnLL=lnL*lnL
gen lnLD=lnL*lnD
gen lnLA=lnL*lnA
gen lnDD=lnD*lnD
gen lnDA=lnD*lnA
gen lnAA=lnA*lnA

gen lnHT=lnH*T
gen lnCT=lnC*T
gen lnLT=lnL*T
gen lnDT=lnD*T
gen lnAT=lnA*T

***** translog with time dummies ***** 
regress lnY lnH lnC lnL lnD lnA lnHH lnHC lnHL lnHD lnHA lnCC lnCL lnCD lnCA lnLL lnLD lnLA lnDD lnDA lnAA T2 T3 T4 T5 T6 T7 T8 T9 T10 

***** translog with time trend - non-neutral technical change *****
regress lnY lnH lnC lnL lnD lnA lnHH lnHC lnHL lnHD lnHA lnCC lnCL lnCD lnCA lnLL lnLD lnLA lnDD lnDA lnAA T TT lnHT lnCT lnLT lnDT lnAT  


*********************************************
******** panel frontier functions ***********
*********************************************

*********** pooled model - no specification on Uit ****************
frontier lnY lnH lnC lnL lnD lnA lnHH lnHC lnHL lnHD lnHA lnCC lnCL lnCD lnCA lnLL lnLD lnLA lnDD lnDA lnAA T2 T3 T4 T5 T6 T7 T8 T9 T10

predict uPOOL, u


******* Pit and Lee, 1981 ********
xtfrontier lnY lnH lnC lnL lnD lnA lnHH lnHC lnHL lnHD lnHA lnCC lnCL lnCD lnCA lnLL lnLD lnLA lnDD lnDA lnAA T2 T3 T4 T5 T6 T7 T8 T9 T10, ti

predict uPL, u


******* Battese and Coelli, 1992 *****
xtfrontier lnY lnH lnC lnL lnD lnA lnHH lnHC lnHL lnHD lnHA lnCC lnCL lnCD lnCA lnLL lnLD lnLA lnDD lnDA lnAA T2 T3 T4 T5 T6 T7 T8 T9 T10, tvd

predict uBC, u

/*
**************************************************************************
********** cross-sectional models (NB - redo mean correction) ************
**************************************************************************

drop if T<10
drop mY-lnAA

egen mY=mean(Y1)
egen mH=mean(H)
egen mC=mean(C)
egen mL=mean(L3)
egen mD=mean(D)
egen mA=mean(A2)
gen lnY=log(Y1/mY)
gen lnH=log(H/mH)
gen lnC=log(C/mC)
gen lnL=log(L3/mL)
gen lnD=log(D/mD)
gen lnA=log(A2/mA)
gen lnHH=lnH*lnH
gen lnHC=lnH*lnC
gen lnHL=lnH*lnL
gen lnHD=lnH*lnD
gen lnHA=lnH*lnA
gen lnCC=lnC*lnC
gen lnCL=lnC*lnL
gen lnCD=lnC*lnD
gen lnCA=lnC*lnA
gen lnLL=lnL*lnL
gen lnLD=lnL*lnD
gen lnLA=lnL*lnA
gen lnDD=lnD*lnD
gen lnDA=lnD*lnA
gen lnAA=lnA*lnA

frontier lnY lnH lnC lnL lnD lnA 
frontier lnY lnH lnC lnL lnD lnA lnHH lnHC lnHL lnHD lnHA lnCC lnCL lnCD lnCA lnLL lnLD lnLA lnDD lnDA lnAA

****** change distribution of Ui ******

frontier lnY lnH lnC lnL lnD lnA lnHH lnHC lnHL lnHD lnHA lnCC lnCL lnCD lnCA lnLL lnLD lnLA lnDD lnDA lnAA, distribution(tnormal) 
frontier lnY lnH lnC lnL lnD lnA lnHH lnHC lnHL lnHD lnHA lnCC lnCL lnCD lnCA lnLL lnLD lnLA lnDD lnDA lnAA, distribution(exponential) 

****** add inefficiency inputs - only available in cross-sectional ******
frontier lnY lnH lnC lnL lnD lnA lnHH lnHC lnHL lnHD lnHA lnCC lnCL lnCD lnCA lnLL lnLD lnLA lnDD lnDA lnAA, distribution(tnormal) cm(SOIL2 SOIL3 SIZE2 SIZE3 SIZE4 SIZE5) 
/
