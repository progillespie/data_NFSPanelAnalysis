* Proof of code to create farm weights. Creates some dummy data, and demonstrates how 
*   we can assign weights using matrices rather than creating whole variables and
*   more complex conditional statements.

* 


clear

set obs 100 
gen testnumber = int(runiform() * 42)
drop if testnumber == 0
drop if testnumber > 12 & testnumber < 19

* Possible values of D_SAMPLE_CELL
matrix define M_SAMPLE_CELL = (1, 2, 3, 4, 5, 6 \ 7, 8, 9, 10, 11, 12 \ 19, 20, 21, 22, 23, 24 \ 25, 26, 27, 28, 29, 30 \ 31, 32, 33, 34, 35, 36 \ 37, 38, 39, 40, 41, 42)
matrix define M_WTS_YY      = (101, 102, 103, 104, 105, 106 \ 107, 108, 109, 1010, 1011, 1012 \ 1019, 1020, 1021, 1022, 1023, 1024 \ 1025, 1026, 1027, 1028, 1029, 1030 \ 1031, 1032, 1033, 1034, 1035, 1036 \ 1037, 1038, 1039, 1040, 1041, 1042)



gen value = .
forvalues i= 1/6 {

  	forvalues j=1/6 {
	
		di "`i',`j': " M_SAMPLE_CELL[`i',`j']
		qui replace value = M_WTS_YY[`i',`j'] if testnumber == M_SAMPLE_CELL[`i',`j']
		
	}
}

br


* Table will be a diagonal line, proving that correct value was assigned.
table testnumber value 

matrix list M_SAMPLE_CELL
matrix list M_WTS_YY
