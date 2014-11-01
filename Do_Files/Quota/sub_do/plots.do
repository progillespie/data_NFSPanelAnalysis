args outdatadir

local plotout "`outdatadir'/plots"
capture mkdir `plotout'

set scheme lean2

* Variables in the model
yrbox Y2                    if ALLOC > 0.6, ///
  title("Dairy gross output per farm") ytitle("constant euro")  noout
graph export `plotout'/box_Y2.emf,  replace

yrbox H                     if ALLOC > 0.6, ///
  title("Dairy herd size per farm") ytitle("dairy cows")  noout
graph export `plotout'/box_H.emf,  replace

yrbox C                     if ALLOC > 0.6, ///
  title("Capital stock allocated to dairy enterprise per farm") ytitle("replacement value in constant euro")  noout
graph export `plotout'/box_C.emf,  replace

yrbox DC                     if ALLOC > 0.6, ///
  title("Variable costs per farm") ytitle("constant euro")  noout
graph export `plotout'/box_D.emf,  replace

yrbox L3 if ALLOC > 0.6, ///
  title("Labour per farm") ytitle("standard man days")  noout
graph export `plotout'/box_L3.emf,  replace

yrbox LANDFAGE              if ALLOC > 0.6, ///
  title("Dairy forage area per farm") ytitle("hectares")  noout
graph export `plotout'/box_A.emf,  replace



* Other variables of interest
yrbox D_MILK_YIELD          if ALLOC > 0.6, ///
  title("Milk yield") ytitle("litres per dairy cow")  noout
graph export `plotout'/box_yield.emf,  replace

yrbox D_DAIRY_STOCKING_RATE if ALLOC > 0.6, ///
  title("Dairy cows per hectare") ytitle("")  noout
graph export `plotout'/box_stkrt.emf,  replace

yrbox D_LABOUR_INTENSITY_HA if ALLOC > 0.6, ///
  title("Total labour per hectare") ytitle("Annual work units")  noout
graph export `plotout'/box_laha.emf,  replace

yrbox D_LABOUR_INTENSITY_LU if ALLOC > 0.6, ///
  title("Total labour per livestock unit") ytitle("Annual work units")  noout
graph export `plotout'/box_lalu.emf,  replace

yrbox ecalfpct          if ALLOC > 0.6, ///
  title("Milk yield") ytitle("litres per dairy cow")  noout
graph export `plotout'/box_yield.emf,  replace


* Bar graph show differences in the sample size distribution 
graph bar (count) FC if year==1983 | year==1984,  ///
   over(SZCLASS) over(year) asyvar scheme(lean2)  ///
   title("Effect of methodological changes on sample distributions", span) ///
   ytitle("sampled farms")
graph export `plotout'/bar_diffsamples.emf,  replace


graph drop _all

