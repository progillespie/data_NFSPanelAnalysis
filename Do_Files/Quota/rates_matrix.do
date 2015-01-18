* Takes the cumulative TFP table from DAIRY_TFP_CALC.xlsx and spits out
*  the linear growth rates for the whole period and several sub-periods.
*  Type "edit" on the Stata command line, then copy and paste that table
*    to the Stata editor window (1st line should be variable names)

quietly{

capture matrix drop ZCOL
matrix define ZCOL = [  0  \  0  \  0  \  0  \  0  \  0  \  0  ]  

capture matrix drop RATES
matrix defin RATES = [ ZCOL, ZCOL, ZCOL, ZCOL ] 

capture program drop rmat
program define rmat, rclass

  args index

	
	capture matrix drop R
  matrix define   R = ZCOL
  matrix rownames R =  79-12 79-83 84-89 90-94 95-99 00-08 08-12
  matrix colnames R = `index'

  qui  reg tre_`index' year
  matrix R[1,1] =  round(_b[year] * 100, 0.01)

  qui  reg tre_`index' year if year <  1984
  matrix R[2,1] =  round(_b[year] * 100, 0.01)

  qui  reg tre_`index' year if year >= 1984 & year < 1990
  matrix R[3,1] =  round(_b[year] * 100, 0.01)

  qui  reg tre_`index' year if year >= 1990 & year < 1995
  matrix R[4,1] =  round(_b[year] * 100, 0.01)

  qui  reg tre_`index' year if year >= 1995 & year < 2000
  matrix R[5,1] =  round(_b[year] * 100, 0.01)

  qui  reg tre_`index' year if year >= 2000 & year < 2008
  matrix R[6,1] =  round(_b[year] * 100, 0.01)

  qui  reg tre_`index' year if year >= 2008
  matrix R[7,1] =  round(_b[year] * 100, 0.01) 

  return matrix R = R
	
end




rmat "tfp"
matrix define RATES = [r(R), RATES[1...,2...]]

rmat "sc"
matrix define RATES = [RATES[1...,1], r(R), RATES[1...,3...]]

rmat "tc"
matrix define RATES = [RATES[1...,1..2], r(R), RATES[1...,4]]

rmat "tec"
matrix define RATES = [RATES[1...,1..3], r(R)]

}

matrix list RATES, format(%9.2f)
