*****************************************************
*****************************************************
* Dairy Farm Level Model
*
* (c) Thia Hennessy Cathal O’Donoghue John Lennon Teagasc.
*
* 2008
*
*
*****************************************************
*****************************************************
clear
set maxvar 20000
set mem 930m
set more off
set matsize 300
version 9.0
capture log close
cd h:
capture log close
local dodir \data\data_NFSPanelAnalysis\Do_Files\FarmLevelModel
local nfsdatadir \data\data_NFSPanelAnalysis\OutData
local outdatadir \data\data_NFSPanelAnalysis\OutData\FarmLevelModel
local Regional_outdatadir \data\data_NFSPanelAnalysis\OutData\RegionalAnalysis

cd `outdatadir'\

log using FarmLevelModel.log, replace 
di  "Job  Started  at  $S_TIME  on $S_DATE"

*****************************************************
**Simulation Parameters
*****************************************************

local data_year 2006
local first_year 2007
local first_sim_year 2008
local last_sim_year 2015


*****************************************************
* Import THia Drop Farms - Farms excluded from Thia's analysis
*****************************************************

insheet using ThiaDropFarms.txt, clear
sort farmcode
save ThiaDropFarms, replace

*****************************************************
**Import NFS Data
*****************************************************

**Create a subset of variables

use `nfsdatadir'\nfs_data.dta, clear

sort farmcode year
merge farmcode year using `Regional_outdatadir'\regional_weights.dta
drop _merge
drop if region == .

keep if year == `data_year'
replace year = `first_sim_year' - 1

*****************************************************
**Import Parameters
*****************************************************

do `dodir'\CreateParams.do
do `dodir'\CreateRegressParams.do

*****************************************************
* Subset 
* Keep only farms with dariy gross output
*****************************************************

* Farms with no milk sales

keep if fdairygo > 0 & fdairygo != .
keep if doslcmgl > 0 & doslcmgl != .

* Farms with 50% liquid milk sales

keep if dosllmgl < 0.5*dotomkgl

* No herds with less than 10 dairy cows

keep if dpopinvd > 10

sort farmcode
merge farmcode using ThiaDropFarms
drop _merge

drop if dropfarm == 1

*****************************************************
**Starting Values of variables
*****************************************************

local t = `first_year'
gen weight`t' =  wt
gen active`t' = wt
gen farm_code =  farmcode
gen system`t' = ffszsyst-int(ffszsyst/10)*10
keep if system`t' == 1 | system`t' == 2
gen uaa_ha`t' =  fsizuaa
gen forage_area`t' = fsizfrac
gen tot_lab`t' =  flabtotl
gen unpay_lab`t' =  flabunpd
gen val_frm`t' =  fainvfrm
gen val_mac`t' =  fainvmch
gen val_liv`t' =  fainvlst
gen val_bld`t' =  fainvbld
gen go`t' =  farmgo
gen dc`t' =  farmdc
gen gm`t' =  farmgm
gen oc`t' =  farmohct
gen ffi`t' =  farmffi
gen cgm`t' =  fcatlegm
gen dgm`t' =  fdairygm
gen sfp`t' = fsubchpp
gen reps`t' =  fsubreps
gen disadv`t' = fsubchen
gen total_subs`t' = sfp`t'+reps`t'+disadv`t'
gen gm2`t' = dgm`t'+cgm`t'+total_subs`t'
gen other`t' = gm`t'-gm`t'
gen dcow`t' =  dpavnohd
gen clus`t' =  fnocatlu
gen slus`t' =  fnoshplu
*gen totlus`t' = dcow`t' + clus`t' + slus`t'
gen totlus`t' = ftotallu
gen dgo`t' =  fdairygo
gen milks`t' = doslmkgl
gen gocpl`t' = dgo`t'/milks`t'
gen ddc`t' =  fdairydc
gen dccpl`t' = ddc`t'/milks`t'
gen cgo`t' =  fcatlego
gen cdc`t' =  fcatledc
gen mar`t' =  ogmarsth
gen sex`t' =  ogsexhld
gen age`t' =  ogagehld
gen lt_40`t' = (age`t' < 40)*weight`t'
gen a`t' = (age`t'<50)*weight`t'-lt_40`t'
gen fjob`t' =  oojobhld
gen b`t' =  oojobsps
gen sjob`t' =  oojobsps
gen nohld`t' =  oanohshm
gen dc_clu`t' =  cdc`t'/clus`t'
gen dc_cow`t' =  ddc`t'/dcow`t'
gen deliv_per_cow`t' =  milks`t'/dcow`t'
gen dc_litre`t' =  dc_cow`t'/deliv_per_cow`t'
gen creams`t' = doslcmgl
gen gm_litre_`t' =  dgm`t'/creams`t'
gen milkp`t' = dotomkgl
gen wmis`t' =  weight`t'*milks`t'
gen liquid`t' = creams`t'*weight`t'
gen yield`t' =  milkp`t'/dcow`t'
gen calvesold`t' =  coslcfno
gen calvesval`t' =  coslcfvl
gen weansold`t' =  coslwnno
gen weanval`t' =  coslwnvl
gen storesold`t' =  coslstno
gen storeval`t' =  coslstvl
gen finsold`t' =  coslmsno + coslfsno
gen finval`t' =  coslmsvl + coslfsvl
gen base_cpl`t' =  dc_litre`t'
gen max_cows`t' =  (((totlus`t'-dcow`t')/2)/1.2)+dcow`t'
gen max_quo`t' =  ((max_cows`t'*(deliv_per_cow`t'*1.1)))
gen capacity`t' =  max_quo`t'-milks`t'
gen current_yields`t' =  ((max_cows`t'*(deliv_per_cow*1.1))*weight`t')
gen yield_cost_per_cow`t' =  (yield`t'*1.1)*0.05
gen cost_per_litre`t' =  (dc_cow`t'+yield_cost_per_cow`t')/(deliv_per_cow`t'*1.1)
gen gmcpl`t' =  ((gocpl`t'*milk_pr_`t'/milk_pr_`data_year')-(dccpl`t'*dc_ind`t'/dc_ind`data_year'))
gen exit`t' = weight`t'*(gmcpl`t'<exit_margin_ind`t')
gen cgm1`t' = (cgo`t'*adrefpr_`t'/adrefpr_`data_year')-(cdc`t'*dc_ind`t'/dc_ind`data_year')
gen inc`t' = (((gmcpl`t'*milks`t')+total_subs`t'+cgm1`t')-(oc`t'*gdp_deflator`t'/gdp_deflator`data_year'))*weight`t'
gen active_1`t' = weight`t'-exit`t'
gen quota_re_alloc`t' = milks`t'*weight`t'*(exit`t'> 0)
sort year
by year: egen s_active`t' = sum(weight`t')
by year: egen s_inc`t' = sum(inc`t')
by year: egen s_active_1`t' = sum(active_1`t')
by year: egen s_quota_re_alloc`t' = sum(quota_re_alloc`t')
by year: egen s_exit`t' = sum(exit`t')
gen inc_active`t' = s_inc`t'/s_active`t'
gen alloc_per_active`t' = s_quota_re_alloc`t'/(s_active`t'-s_exit`t')
gen new_quota`t' = 0
gen quota`t' = 0

save `outdatadir'\tmp,replace

*****************************************************
**Import Parameters
*****************************************************



*****************************************************
**Run Simulation
*****************************************************

local t = `first_sim_year'	
while `t'<= `last_sim_year' {	
	local t1 = `t' - 1

	gen weight`t' =  wt
	gen reg_weight`t' = rweight
	gen system`t' =  ffszsyst-int(ffszsyst/10)*10
	gen uaa_ha`t' =  fsizuaa
	gen forage_area`t' = fsizfrac
	gen tot_lab`t' =  flabtotl
	gen unpay_lab`t' =  flabunpd
	gen val_frm`t' =  fainvfrm
	gen val_mac`t' =  fainvmch
	gen val_liv`t' =  fainvlst
	gen val_bld`t' =  fainvbld
	gen go`t' =  farmgo
	gen dc`t' =  farmdc
	gen gm`t' =  farmgm
	gen oc`t' =  farmohct
	gen ffi`t' =  farmffi
	gen cgm`t' =  fcatlegm
	gen dgm`t' =  fdairygm
	gen sfp`t' = fsubchpp
	gen reps`t' =  fsubreps
	gen disadv`t' = fsubchen
	gen total_subs`t' = sfp`t'+reps`t'+disadv`t'
	gen gm2`t' = dgm`t'+cgm`t'+total_subs`t'
	gen other1`t' = gm`t'-gm2`t'
	gen dcow`t' =  dpavnohd
	gen clus`t' =  fnocatlu
	gen slus`t' =  fnoshplu
	gen totlus`t' = ftotallu
	gen dgo`t' =  fdairygo
	gen milks`t' = doslmkgl
	gen gocpl`t' = dgo`t'/milks`t'
	gen ddc`t' =  fdairydc
	gen dccpl`t' = ddc`t'/milks`t'
	gen cgo`t' =  fcatlego
	gen cdc`t' =  fcatledc
	gen mar`t' =  ogmarsth
	gen sex`t' =  ogsexhld
	gen age`t' =  ogagehld
	gen lt_40`t' = (age`t' < 40)*weight`t'
	gen a`t' = (age`t'<50)*(weight`t'-lt_40`t')
	gen fjob`t' =  oojobhld
	gen b`t' =  oojobsps
	gen sjob`t' =  oojobsps
	gen nohld`t' =  oanohshm
	gen dc_clu`t' =  cdc`t'/clus`t'
	gen dc_cow`t' =  ddc`t'/dcow`t'
	gen deliv_per_cow`t' =  milks`t'/dcow`t'
	gen dc_litre`t' =  dc_cow`t'/deliv_per_cow`t'
	gen creams`t' = doslcmgl
	gen gm_litre_`t' =  dgm`t'/creams`t'
	gen milkp`t' = dotomkgl
	gen wmis`t' =  weight`t'*milks`t'
	gen liquid`t' = creams`t'*weight`t'
	gen yield`t' =  milkp`t'/dcow`t'
	gen calvesold`t' =  coslcfno
	gen calvesval`t' =  coslcfvl
	gen weansold`t' =  coslwnno
	gen weanval`t' =  coslwnvl
	gen storesold`t' =  coslstno
	gen storeval`t' =  coslstvl
	gen finsold`t' =  coslmsno + coslfsno
	gen finval`t' =  coslmsvl + coslfsvl
	gen base_cpl`t' =  dc_litre`t'
	gen max_cows`t' =  (((totlus`t'-dcow`t')/2)/1.2)+dcow`t'
	gen max_quo`t' =  ((max_cows`t'*(deliv_per_cow`t'*1.1)))
	gen capacity`t' =  max_quo`t'-milks`t'
	gen current_yields`t' =  ((max_cows`t'*(deliv_per_cow`t'*1.1))*weight`t')
	gen yield_cost_per_cow`t' =  (yield`t'*1.1)*0.05
	gen cost_per_litre`t' =  (dc_cow`t'+yield_cost_per_cow`t')/(deliv_per_cow`t'*1.1)
	gen gmcpl`t' =  ((gocpl`t'*milk_pr_`t'/milk_pr_`data_year')-(dccpl`t'*dc_ind`t'/dc_ind`data_year'))
	gen exit`t' = weight`t'*(gmcpl`t'<exit_margin_ind`t')
	gen housing_index`t' = housing_ind`t'/housing_ind`data_year'
	gen bulktank_index`t' = bulktank_ind`t'/bulktank_ind`data_year'
	gen labour_index`t' = 23*labour_ind`t'
	gen inv_costs_perlitre`t' = (housing_ind`t'+bulktank_ind`t'+23*labour_ind`t')/(deliv_per_cow`t'*1.1)
	gen milk_pr`t' = milk_pr_`t'/milk_pr_`data_year'
	gen quota_index`t' = (quota_ind`t'*1.24)/7
	gen gm_on_10`t' = (gocpl`t'*milk_pr`t')-(quota_index`t' + 0.05)
	gen new_dc`t' = (((ddc`t'+((milks`t'*0.1)*0.05)) ) *dc_ind`t'/dc_ind`data_year')/(milks`t'*1.1)
	gen dc_index`t'= dc_ind`t'
	gen old_dc`t' = (ddc`t'*dc_ind`t')/(milks`t')
	gen demand_10`t' = (gm_on_10`t'>0.00001)*(milks`t'*0.1)
	gen gm_other`t' = (gocpl`t'*milk_pr`t')-(old_dc`t'+inv_costs_perlitre`t'+quota_index`t')
	gen dc_other`t' = old_dc`t'+inv_costs_perlitre`t'
	gen free_quota`t' = (active`t1'>0)*(new_quota`t1'*0.0269)
	gen check`t' = free_quota`t'*weight`t'
	gen year`t' = `t'
	gen other_demand`t' = (gm_other`t'>0.00001)*(capacity`t'-demand_10`t') if(year`t' == `first_sim_year')
	replace other_demand`t' = (gm_other`t'>0.00001)*(capacity`t') + (gm_other`t'<=0.00001)*(demand_10`t') if(year`t' != `first_sim_year')
	gen total_demand`t' = max((quota_re_alloc`t1'==0)*(other_demand`t'+ demand_10`t' - free_quota`t'),0)
	gen rem_demand`t' = (active_1`t1'>0)*(other_demand`t'-((new_quota`t1'-milks`t')+free_quota`t'))
	gen rem_demand1`t' = max(rem_demand`t',0)

	gen allocated`t' = (alloc_per_active`t1'*weight`t') if ((total_demand`t'*(year`t'==`first_sim_year') + rem_demand1`t'*(year`t'!=`first_sim_year'))>alloc_per_active`t1')
	replace allocated`t' = ((total_demand`t'*(year`t'==`first_sim_year') + rem_demand1`t'*(year`t'!=`first_sim_year'))*weight`t') if ((total_demand`t'*(year`t'==`first_sim_year') + rem_demand1`t'*(year`t'!=`first_sim_year')) <= alloc_per_active`t1')
	gen allocated1`t' = (alloc_per_active`t1') if ((total_demand`t'*(year`t'==`first_sim_year') + rem_demand1`t'*(year`t'!=`first_sim_year'))>alloc_per_active`t1')
	replace allocated1`t' = ((total_demand`t'*(year`t'==`first_sim_year') + rem_demand1`t'*(year`t'!=`first_sim_year'))) if ((total_demand`t'*(year`t'==`first_sim_year') + rem_demand1`t'*(year`t'!=`first_sim_year')) <= alloc_per_active`t1')
	gen still_demand`t' = ((total_demand`t'*(year`t'==`first_sim_year') + rem_demand1`t'*(year`t'!=`first_sim_year')) > alloc_per_active`t1')*weight`t'
	sort year
	by year: egen s_still_demand`t' = sum(still_demand`t')
	by year: egen s_allocated`t' = sum(allocated`t')
	gen diff_quota`t' = s_quota_re_alloc`t1'*1.03 - s_allocated`t'
	gen ratio_diff_alloc_demand`t' = diff_quota`t' /s_still_demand`t' 
	gen total_allocated`t' = (still_demand`t'>0)*(allocated1`t'+ ratio_diff_alloc_demand`t')+(still_demand`t'<=0)*allocated1`t'
	gen new_quota`t' = (year`t' != `first_sim_year')*(active_1`t1'>0)*(total_allocated`t'+new_quota`t1'+free_quota`t')
	replace new_quota`t' = (quota_re_alloc`t1'==0)*((total_allocated`t'+milks`t')*1.03) if(year`t' == `first_sim_year')
	gen q_inc`t' = (new_quota`t'>0)*(year`t' != `first_sim_year')*(new_quota`t'-milks`t') + (year`t' == `first_sim_year')*(new_quota`t'-milks`t')
	gen _10_quota`t' = (q_inc`t'>demand_10`t')*demand_10`t'+(q_inc`t'<=demand_10`t')*q_inc`t'
	gen other`t' = q_inc`t'-_10_quota`t'
	gen check1`t' = (new_quota`t'!=0)*((milks`t'+_10_quota`t'+other`t')-new_quota`t')
	gen active`t' = (new_quota`t'>0)*weight`t'
	gen check2`t' = new_quota`t'*weight`t'
	gen go1`t' = new_quota`t'*(gocpl`t'*milk_pr_`t'/milk_pr_`data_year')
	gen dc_old`t' = (milks`t'*old_dc`t')+(_10_quota`t'*0.05)+(other`t'*new_dc`t') if(year`t' != `first_sim_year')
	replace dc_old`t' = (milks`t'*old_dc`t')+(_10_quota`t'*0.05) if(year`t' == `first_sim_year')
	gen dc_10`t' = other`t'*inv_costs_perlitre`t' + (year`t' == `first_sim_year')*(other`t'*old_dc`t')
	gen dother`t' = 0
	gen quota`t' = (total_allocated`t'*(quota_ind`t'*1.24)/7)+quota`t1'*(year`t' != `first_sim_year')
	gen dgm1`t' = (new_quota`t'>0)*(go1`t'-(dc_old`t'+dc_10`t'+dother`t'+quota`t'))
	gen gm_per_litre`t' = (new_quota`t'>0)*(dgm1`t'/new_quota`t')
	replace gm_per_litre`t' = 0 if gm_per_litre`t' == .
	gen exiting`t' = (gm_per_litre`t'<exit_margin_ind`t')*weight`t'
	*todo exiting1 - ask thia for data file
	gen exiting1`t' = exiting`t'
	gen cgm1`t' = (clus`t'>0)*(((cgo`t'*adrefpr_`t'/adrefpr_`data_year')-(cdc`t'*dc_ind`t'/dc_ind`data_year'))/clus`t')*(clus`t'-(total_allocated`t'/(deliv_per_cow`t'*1.1)))
	replace cgm1`t' =0 if cgm1`t' == .
	gen inc`t' = (new_quota`t'>0`t')*(((dgm1`t'+cgm1`t'+total_subs`t')-(oc`t'*gdp_deflator`t'/gdp_deflator`data_year'))*weight`t')
	gen active_1`t' = (exiting1`t'==0 &(new_quota`t')>0.9)*weight`t'
	gen quota_re_alloc`t' = (exiting1`t'>0)*(new_quota`t'*weight`t')
	sort year
	by year: egen s_active`t' = sum(active`t')
	by year: egen s_inc`t' = sum(inc`t')
	by year: egen s_active_1`t' = sum(active_1`t')
	by year: egen s_quota_re_alloc`t' = sum(quota_re_alloc`t')
	by year: egen s_exit`t' = sum(exit`t')
	gen inc_active`t' = s_inc`t'/s_active`t'
	gen alloc_per_active`t' = s_quota_re_alloc`t'*1.03/s_active_1`t'

	local t =`t'+1
}	
