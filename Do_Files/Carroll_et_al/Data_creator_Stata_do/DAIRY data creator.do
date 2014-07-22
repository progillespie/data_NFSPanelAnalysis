gen t=0

rename foadvfee advisefee

*rename ffszsyst sys *Commented out for use with 84 to 09 data set
rename farmsys sys

*rename ffarmcod fc
rename cffrmcod fc

rename ffsolcod sclass
rename fsizunad size3
rename flabtotl labunits
rename flabsmds mandays
rename fainvfrm farmvaluee
rename fainvmch machinee
rename fainvbld buildingse
rename fainvlim landimpe
rename fvalflab labfame
rename fdcaslab labcase
rename forntcon conacree
rename fohirlab hiredlabe
rename fointpay intereste
rename fomacopt opexmachinery
rename fobldmnt opexbuildings
rename foupkpld upkeepe
rename foexlime limee
rename foannuit annuitiese
rename forates  ratee

*rename foinsure insurancee

rename fofuellu fuellubse
rename foelecfs esbe
rename fophonfs phonee
rename fortfmer rentretirefame
rename fortnfer rentretirenonfame
rename fomiscel miscoverheade
rename fdairygo dairyinggrossoutput
rename fcatlego cattlegrossoutput
rename fsheepgo sheepgrossoutput
rename fcropsgo cropsgrossoutput

*rename fcplivgo cropandlivegrossoutput

rename fgrntsub othergrantsandsubs
rename iaisfdy  aidairy
rename iaisfcat aicattle
rename iaisfshp aisheep
rename ogmarsth maritalstat
rename ogsexhld hohsex
rename ogagehld age
rename oojobhld offjobtype
rename ooinchld offjobinc
rename oanolt5y childunder5
rename oano515y childunder15
rename oano1619 childunder19
rename fbelclbl loan

rename fsubhors   sub1	
rename fsubtbco   sub2

*rename fsubforh   sub3	

rename fsubesag	sub4
rename fsubyfig	sub5
rename fsubreps	sub6

*rename fsubscno	sub7
*rename fsubscen	sub8
*rename fsubsccp	sub9
*rename fsubscpp	sub10

rename fsubsctp	sub11

*rename fsub10no	sub12
*rename fsub10en	sub13
*rename fsub10cp	sub14
*rename fsub10pp	sub15
*rename fsub10tp	sub16
*rename fsub22no	sub17
*rename fsub22en	sub18
*rename fsub22cp	sub19
*rename fsub22pp	sub20
*rename fsub22tp	sub21
*rename fsubspno	sub22
*rename fsubspen	sub23
*rename fsubspcp	sub24
*rename fsubsppp	sub25
*rename fsubsptp	sub26
*rename fsubexno	sub27
*rename fsubexen	sub28
*rename fsubexcp	sub29
*rename fsubexpp	sub30
*rename fsubextp	sub31
*rename fsubchno	sub32

rename fsubchen	sub33

*rename fsubchcp	sub34

rename fsubchpp	sub35

*rename fsubchtp	sub36
*rename fsubepno	sub37
*rename fsubepen	sub38
*rename fsubepcp	sub39
*rename fsubeppp	sub40
*rename fsubeptp	sub41
*rename fsubshno	sub42
*rename fsubshen	sub43
*rename fsubshcp	sub44
*rename fsubshpp	sub45
*rename fsubshtp	sub46
*rename fsubgpcm	sub47
*rename fsubtups	sub48
*rename fsubasac	sub49
*rename fsubaspd	sub50
*rename fsubascp	sub51
*rename fsubaspp	sub52

rename fsubastp	sub53

*rename fsubcaac	sub54
*rename fsubcapd	sub55
*rename fsubcacp	sub56
*rename fsubcapp	sub57

rename fsubcatp	sub58

*rename fsubrpac	sub59
*rename fsubrppd	sub60
*rename fsubrpcp	sub61
*rename fsubrppp	sub62

rename fsubrptp	sub63

*rename fsubpbac	sub64
*rename fsubpbpd	sub65
*rename fsubpbcp	sub66
*rename fsubpbpp	sub67

rename fsubpbtp	sub68

*rename fsubliac	sub69
*rename fsublipd	sub70
*rename fsublicp	sub71
*rename fsublipp	sub72

rename fsublitp	sub73

*rename fsubmzac	sub74
*rename fsubmzpd	sub75
*rename fsubmzcp	sub76
*rename fsubmzpp	sub77

rename fsubmztp	sub78
rename fsubvstp   sub79

*rename dpavnohd DYave
*rename dpavnobl DYbullave
*rename dpclinvd DYcloseinv
*rename dotomkgl DYmilkgal
*rename dotomkvl DYmilke

rename dosubsvl DYsubs

*rename ddconval DYconcentrates
*rename ddpastur DYpasture
*rename ddwinfor DYwinfor
*rename ddmiscdc DYmisccosts
*rename dqownqty DYownquota
*rename dqrentgl DYleasedquota
*rename dqletgal DYletquota
*rename dqcuryer DYquota
*rename dabotfat DYfat
*rename daproten DYprotein
*rename daforare DYforagearea
*rename dafedare DYfeedarea

keep t w fc sclass size3 labunits mandays farmvaluee machinee advisefee buildingse landimpe labfame labcase conacree hiredlabe intereste opexmachinery opexbuildings upkeepe limee annuitiese ratee insurancee fuellubse esbe phonee rentretirefame rentretirenonfame miscoverheade dairyinggrossoutput cattlegrossoutput sheepgrossoutput cropsgrossoutput cropandlivegrossoutput othergrantsandsubs aidairy aicattle aisheep maritalstat hohsex age offjobtype offjobinc childunder5 childunder15 childunder19 loan sub1 sub2 sub3 sub4 sub5 sub6 sub7 sub8 sub9 sub10 sub11 sub12 sub13 sub14 sub15 sub16 sub17 sub18 sub19 sub20 sub21 sub22 sub23 sub24 sub25 sub26 sub27 sub28 sub29 sub30 sub31 sub32 sub33 sub34 sub35 sub36 sub37 sub38 sub39 sub40 sub41 sub42 sub43 sub44 sub45 sub46 sub47 sub48 sub49 sub50 sub51 sub52 sub53 sub54 sub55 sub56 sub57 sub58 sub59 sub60 sub61 sub62 sub63 sub64 sub65 sub66 sub67 sub68 sub69 sub70 sub71 sub72 sub73 sub74 sub75 sub76 sub77 sub78 sub79 DYave DYbullave DYcloseinv DYmilkgal DYmilke DYsubs DYconcentrates DYpasture DYwinfor DYmisccosts DYownquota DYleasedquota DYletquota DYquota DYfat DYprotein DYforagearea DYfeedarea


