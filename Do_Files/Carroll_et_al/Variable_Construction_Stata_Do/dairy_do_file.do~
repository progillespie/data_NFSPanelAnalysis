set more off

use ..\..\..\OutData\DataCreatorFADN\test_data_creator_FADN.dta, clear



* AI is a general one for year 2001, not dairy specific. 
* Probably ok for specialist dairy.


***************************************************************************
*Generate Price indices.

***************************************************************************



capture drop	PTotalOutputs					
gen	PTotalOutputs	=	0			
replace	PTotalOutputs	=	70.829	if	year ==	1980
replace	PTotalOutputs	=	83.419	if	year ==	1981
replace	PTotalOutputs	=	90.379	if	year ==	1982
replace	PTotalOutputs	=	96.008	if	year ==	1983
replace	PTotalOutputs	=	98.772	if	year ==	1984
replace	PTotalOutputs	=	96.111	if	year ==	1985
replace	PTotalOutputs	=	95.599	if	year ==	1986
replace	PTotalOutputs	=	99.488	if	year ==	1987
replace	PTotalOutputs	=	109.928	if	year ==	1988
replace	PTotalOutputs	=	115.455	if	year ==	1989
replace	PTotalOutputs	=	102.354	if	year ==	1990
replace	PTotalOutputs	=	98.465	if	year ==	1991
replace	PTotalOutputs	=	100.102	if	year ==	1992
replace	PTotalOutputs	=	106.653	if	year ==	1993
replace	PTotalOutputs	=	108.291	if	year ==	1994
replace	PTotalOutputs	=	110.300	if	year ==	1995
replace	PTotalOutputs	=	105.300	if	year ==	1996
replace	PTotalOutputs	=	98.800	if	year ==	1997
replace	PTotalOutputs	=	98.000	if	year ==	1998
replace	PTotalOutputs	=	94.000	if	year ==	1999
replace	PTotalOutputs	=	100.000	if	year ==	2000
replace	PTotalOutputs	=	104.260	if	year ==	2001
replace	PTotalOutputs	=	99.950	if	year ==	2002
replace	PTotalOutputs	=	99.610	if	year ==	2003
replace	PTotalOutputs	=	101.820	if	year ==	2004
replace	PTotalOutputs	=	102.300	if	year ==	2005
replace	PTotalOutputs	=	107.430	if	year ==	2006
replace	PTotalOutputs	=	118.000	if	year ==	2007
replace	PTotalOutputs	=	122.300	if	year ==	2008
replace	PTotalOutputs	=	103.000	if	year ==	2009
replace	PTotalOutputs	=	115.300	if	year ==	2010



capture drop	PPrimeCattle					
gen	PPrimeCattle	=	0			
replace	PPrimeCattle	=	75.251	if	year ==	1980
replace	PPrimeCattle	=	92.196	if	year ==	1981
replace	PPrimeCattle	=	101.003	if	year ==	1982
replace	PPrimeCattle	=	107.804	if	year ==	1983
replace	PPrimeCattle	=	112.375	if	year ==	1984
replace	PPrimeCattle	=	109.253	if	year ==	1985
replace	PPrimeCattle	=	105.351	if	year ==	1986
replace	PPrimeCattle	=	112.932	if	year ==	1987
replace	PPrimeCattle	=	129.208	if	year ==	1988
replace	PPrimeCattle	=	124.303	if	year ==	1989
replace	PPrimeCattle	=	111.483	if	year ==	1990
replace	PPrimeCattle	=	106.577	if	year ==	1991
replace	PPrimeCattle	=	106.466	if	year ==	1992
replace	PPrimeCattle	=	115.608	if	year ==	1993
replace	PPrimeCattle	=	119.398	if	year ==	1994
replace	PPrimeCattle	=	119.400	if	year ==	1995
replace	PPrimeCattle	=	101.000	if	year ==	1996
replace	PPrimeCattle	=	95.200	if	year ==	1997
replace	PPrimeCattle	=	93.400	if	year ==	1998
replace	PPrimeCattle	=	90.900	if	year ==	1999
replace	PPrimeCattle	=	100.000	if	year ==	2000
replace	PPrimeCattle	=	92.450	if	year ==	2001
replace	PPrimeCattle	=	95.210	if	year ==	2002
replace	PPrimeCattle	=	93.330	if	year ==	2003
replace	PPrimeCattle	=	101.870	if	year ==	2004
replace	PPrimeCattle	=	105.590	if	year ==	2005
replace	PPrimeCattle	=	113.490	if	year ==	2006
replace	PPrimeCattle	=	111.200	if	year ==	2007
replace	PPrimeCattle	=	128.000	if	year ==	2008
replace	PPrimeCattle	=	115.100	if	year ==	2009
replace	PPrimeCattle	=	115.900	if	year ==	2010



capture drop	PCowSlaughter					
gen	PCowSlaughter	=	0			
replace	PCowSlaughter	=	101.346	if	year ==	1980
replace	PCowSlaughter	=	123.553	if	year ==	1981
replace	PCowSlaughter	=	133.917	if	year ==	1982
replace	PCowSlaughter	=	133.244	if	year ==	1983
replace	PCowSlaughter	=	133.917	if	year ==	1984
replace	PCowSlaughter	=	131.225	if	year ==	1985
replace	PCowSlaughter	=	126.918	if	year ==	1986
replace	PCowSlaughter	=	134.186	if	year ==	1987
replace	PCowSlaughter	=	157.604	if	year ==	1988
replace	PCowSlaughter	=	155.855	if	year ==	1989
replace	PCowSlaughter	=	134.590	if	year ==	1990
replace	PCowSlaughter	=	119.246	if	year ==	1991
replace	PCowSlaughter	=	127.187	if	year ==	1992
replace	PCowSlaughter	=	142.530	if	year ==	1993
replace	PCowSlaughter	=	146.837	if	year ==	1994
replace	PCowSlaughter	=	135.600	if	year ==	1995
replace	PCowSlaughter	=	108.700	if	year ==	1996
replace	PCowSlaughter	=	102.800	if	year ==	1997
replace	PCowSlaughter	=	98.800	if	year ==	1998
replace	PCowSlaughter	=	87.600	if	year ==	1999
replace	PCowSlaughter	=	100.000	if	year ==	2000
replace	PCowSlaughter	=	86.660	if	year ==	2001
replace	PCowSlaughter	=	83.160	if	year ==	2002
replace	PCowSlaughter	=	86.420	if	year ==	2003
replace	PCowSlaughter	=	103.210	if	year ==	2004
replace	PCowSlaughter	=	107.070	if	year ==	2005
replace	PCowSlaughter	=	118.000	if	year ==	2006
replace	PCowSlaughter	=	115.200	if	year ==	2007
replace	PCowSlaughter	=	137.400	if	year ==	2008
replace	PCowSlaughter	=	120.800	if	year ==	2009
replace	PCowSlaughter	=	124.700	if	year ==	2010



capture drop	PStoreCattle					
gen	PStoreCattle	=	0			
replace	PStoreCattle	=	70.415	if	year ==	1980
replace	PStoreCattle	=	87.882	if	year ==	1981
replace	PStoreCattle	=	97.489	if	year ==	1982
replace	PStoreCattle	=	103.821	if	year ==	1983
replace	PStoreCattle	=	109.170	if	year ==	1984
replace	PStoreCattle	=	107.642	if	year ==	1985
replace	PStoreCattle	=	100.983	if	year ==	1986
replace	PStoreCattle	=	111.135	if	year ==	1987
replace	PStoreCattle	=	132.424	if	year ==	1988
replace	PStoreCattle	=	127.293	if	year ==	1989
replace	PStoreCattle	=	109.170	if	year ==	1990
replace	PStoreCattle	=	101.856	if	year ==	1991
replace	PStoreCattle	=	102.838	if	year ==	1992
replace	PStoreCattle	=	112.664	if	year ==	1993
replace	PStoreCattle	=	118.122	if	year ==	1994
replace	PStoreCattle	=	114.700	if	year ==	1995
replace	PStoreCattle	=	99.100	if	year ==	1996
replace	PStoreCattle	=	95.900	if	year ==	1997
replace	PStoreCattle	=	89.600	if	year ==	1998
replace	PStoreCattle	=	83.000	if	year ==	1999
replace	PStoreCattle	=	100.000	if	year ==	2000
replace	PStoreCattle	=	97.220	if	year ==	2001
replace	PStoreCattle	=	100.710	if	year ==	2002
replace	PStoreCattle	=	102.790	if	year ==	2003
replace	PStoreCattle	=	112.250	if	year ==	2004
replace	PStoreCattle	=	104.520	if	year ==	2005
replace	PStoreCattle	=	107.460	if	year ==	2006
replace	PStoreCattle	=	108.700	if	year ==	2007
replace	PStoreCattle	=	119.800	if	year ==	2008
replace	PStoreCattle	=	105.900	if	year ==	2009
replace	PStoreCattle	=	109.500	if	year ==	2010



capture drop	PTotalCattle					
gen	PTotalCattle	=	0			
replace	PTotalCattle	=	77.929	if	year ==	1980
replace	PTotalCattle	=	95.563	if	year ==	1981
replace	PTotalCattle	=	104.778	if	year ==	1982
replace	PTotalCattle	=	110.353	if	year ==	1983
replace	PTotalCattle	=	114.334	if	year ==	1984
replace	PTotalCattle	=	111.490	if	year ==	1985
replace	PTotalCattle	=	107.281	if	year ==	1986
replace	PTotalCattle	=	115.131	if	year ==	1987
replace	PTotalCattle	=	132.537	if	year ==	1988
replace	PTotalCattle	=	127.986	if	year ==	1989
replace	PTotalCattle	=	113.766	if	year ==	1990
replace	PTotalCattle	=	107.736	if	year ==	1991
replace	PTotalCattle	=	108.419	if	year ==	1992
replace	PTotalCattle	=	118.316	if	year ==	1993
replace	PTotalCattle	=	122.071	if	year ==	1994
replace	PTotalCattle	=	120.700	if	year ==	1995
replace	PTotalCattle	=	101.700	if	year ==	1996
replace	PTotalCattle	=	96.300	if	year ==	1997
replace	PTotalCattle	=	93.400	if	year ==	1998
replace	PTotalCattle	=	89.100	if	year ==	1999
replace	PTotalCattle	=	100.000	if	year ==	2000
replace	PTotalCattle	=	92.260	if	year ==	2001
replace	PTotalCattle	=	94.410	if	year ==	2002
replace	PTotalCattle	=	93.640	if	year ==	2003
replace	PTotalCattle	=	103.250	if	year ==	2004
replace	PTotalCattle	=	105.580	if	year ==	2005
replace	PTotalCattle	=	113.220	if	year ==	2006
replace	PTotalCattle	=	111.000	if	year ==	2007
replace	PTotalCattle	=	127.800	if	year ==	2008
replace	PTotalCattle	=	114.400	if	year ==	2009
replace	PTotalCattle	=	115.900	if	year ==	2010



capture drop	PSheep					
gen	PSheep	=	0			
replace	PSheep	=	113.088	if	year ==	1980
replace	PSheep	=	136.395	if	year ==	1981
replace	PSheep	=	139.036	if	year ==	1982
replace	PSheep	=	146.039	if	year ==	1983
replace	PSheep	=	143.972	if	year ==	1984
replace	PSheep	=	140.069	if	year ==	1985
replace	PSheep	=	140.528	if	year ==	1986
replace	PSheep	=	147.187	if	year ==	1987
replace	PSheep	=	150.976	if	year ==	1988
replace	PSheep	=	145.350	if	year ==	1989
replace	PSheep	=	114.811	if	year ==	1990
replace	PSheep	=	109.070	if	year ==	1991
replace	PSheep	=	80.941	if	year ==	1992
replace	PSheep	=	94.374	if	year ==	1993
replace	PSheep	=	101.952	if	year ==	1994
replace	PSheep	=	89.800	if	year ==	1995
replace	PSheep	=	109.600	if	year ==	1996
replace	PSheep	=	112.400	if	year ==	1997
replace	PSheep	=	96.500	if	year ==	1998
replace	PSheep	=	88.700	if	year ==	1999
replace	PSheep	=	100.000	if	year ==	2000
replace	PSheep	=	142.850	if	year ==	2001
replace	PSheep	=	121.290	if	year ==	2002
replace	PSheep	=	119.500	if	year ==	2003
replace	PSheep	=	117.650	if	year ==	2004
replace	PSheep	=	109.560	if	year ==	2005
replace	PSheep	=	112.210	if	year ==	2006
replace	PSheep	=	114.900	if	year ==	2007
replace	PSheep	=	120.200	if	year ==	2008
replace	PSheep	=	122.100	if	year ==	2009
replace	PSheep	=	142.800	if	year ==	2010



capture drop	PMilk					
gen	PMilk	=	0			
replace	PMilk	=	53.369	if	year ==	1980
replace	PMilk	=	60.638	if	year ==	1981
replace	PMilk	=	66.312	if	year ==	1982
replace	PMilk	=	71.809	if	year ==	1983
replace	PMilk	=	72.695	if	year ==	1984
replace	PMilk	=	75.089	if	year ==	1985
replace	PMilk	=	77.305	if	year ==	1986
replace	PMilk	=	80.585	if	year ==	1987
replace	PMilk	=	89.894	if	year ==	1988
replace	PMilk	=	101.950	if	year ==	1989
replace	PMilk	=	88.652	if	year ==	1990
replace	PMilk	=	84.663	if	year ==	1991
replace	PMilk	=	91.046	if	year ==	1992
replace	PMilk	=	98.848	if	year ==	1993
replace	PMilk	=	98.493	if	year ==	1994
replace	PMilk	=	105.200	if	year ==	1995
replace	PMilk	=	105.400	if	year ==	1996
replace	PMilk	=	97.800	if	year ==	1997
replace	PMilk	=	101.100	if	year ==	1998
replace	PMilk	=	98.400	if	year ==	1999
replace	PMilk	=	100.000	if	year ==	2000
replace	PMilk	=	104.310	if	year ==	2001
replace	PMilk	=	97.090	if	year ==	2002
replace	PMilk	=	95.560	if	year ==	2003
replace	PMilk	=	95.320	if	year ==	2004
replace	PMilk	=	93.510	if	year ==	2005
replace	PMilk	=	90.160	if	year ==	2006
replace	PMilk	=	111.000	if	year ==	2007
replace	PMilk	=	112.700	if	year ==	2008
replace	PMilk	=	78.100	if	year ==	2009
replace	PMilk	=	100.200	if	year ==	2010



capture drop	PCereals					
gen	PCereals	=	0			
replace	PCereals	=	114.381	if	year ==	1980
replace	PCereals	=	122.770	if	year ==	1981
replace	PCereals	=	130.226	if	year ==	1982
replace	PCereals	=	156.991	if	year ==	1983
replace	PCereals	=	141.411	if	year ==	1984
replace	PCereals	=	131.292	if	year ==	1985
replace	PCereals	=	133.822	if	year ==	1986
replace	PCereals	=	136.618	if	year ==	1987
replace	PCereals	=	142.876	if	year ==	1988
replace	PCereals	=	141.545	if	year ==	1989
replace	PCereals	=	133.156	if	year ==	1990
replace	PCereals	=	126.498	if	year ==	1991
replace	PCereals	=	127.563	if	year ==	1992
replace	PCereals	=	126.498	if	year ==	1993
replace	PCereals	=	116.644	if	year ==	1994
replace	PCereals	=	130.600	if	year ==	1995
replace	PCereals	=	115.800	if	year ==	1996
replace	PCereals	=	94.800	if	year ==	1997
replace	PCereals	=	99.000	if	year ==	1998
replace	PCereals	=	104.800	if	year ==	1999
replace	PCereals	=	100.000	if	year ==	2000
replace	PCereals	=	104.450	if	year ==	2001
replace	PCereals	=	91.750	if	year ==	2002
replace	PCereals	=	108.970	if	year ==	2003
replace	PCereals	=	100.910	if	year ==	2004
replace	PCereals	=	96.610	if	year ==	2005
replace	PCereals	=	110.560	if	year ==	2006
replace	PCereals	=	185.400	if	year ==	2007
replace	PCereals	=	133.100	if	year ==	2008
replace	PCereals	=	94.600	if	year ==	2009
replace	PCereals	=	150.200	if	year ==	2010



capture drop	PSugarBeet					
gen	PSugarBeet	=	0			
replace	PSugarBeet	=	72.526	if	year ==	1980
replace	PSugarBeet	=	78.674	if	year ==	1981
replace	PSugarBeet	=	82.997	if	year ==	1982
replace	PSugarBeet	=	91.162	if	year ==	1983
replace	PSugarBeet	=	85.591	if	year ==	1984
replace	PSugarBeet	=	92.411	if	year ==	1985
replace	PSugarBeet	=	92.699	if	year ==	1986
replace	PSugarBeet	=	94.909	if	year ==	1987
replace	PSugarBeet	=	96.158	if	year ==	1988
replace	PSugarBeet	=	94.909	if	year ==	1989
replace	PSugarBeet	=	96.061	if	year ==	1990
replace	PSugarBeet	=	94.813	if	year ==	1991
replace	PSugarBeet	=	98.943	if	year ==	1992
replace	PSugarBeet	=	111.335	if	year ==	1993
replace	PSugarBeet	=	107.012	if	year ==	1994
replace	PSugarBeet	=	100.600	if	year ==	1995
replace	PSugarBeet	=	96.000	if	year ==	1996
replace	PSugarBeet	=	97.600	if	year ==	1997
replace	PSugarBeet	=	98.600	if	year ==	1998
replace	PSugarBeet	=	99.500	if	year ==	1999
replace	PSugarBeet	=	100.000	if	year ==	2000
replace	PSugarBeet	=	102.840	if	year ==	2001
replace	PSugarBeet	=	103.780	if	year ==	2002
replace	PSugarBeet	=	103.780	if	year ==	2003
replace	PSugarBeet	=	103.800	if	year ==	2004
replace	PSugarBeet	=	103.700	if	year ==	2005
replace	PSugarBeet	=	103.700	if	year ==	2006
replace	PSugarBeet	=	103.700	if	year ==	2007
replace	PSugarBeet	=	103.700	if	year ==	2008
replace	PSugarBeet	=	.	if	year ==	2009
replace	PSugarBeet	=	.	if	year ==	2010



capture drop	PPotatoes					
gen	PPotatoes	=	0			
replace	PPotatoes	=	61.568	if	year ==	1980
replace	PPotatoes	=	82.584	if	year ==	1981
replace	PPotatoes	=	107.391	if	year ==	1982
replace	PPotatoes	=	82.969	if	year ==	1983
replace	PPotatoes	=	132.969	if	year ==	1984
replace	PPotatoes	=	61.825	if	year ==	1985
replace	PPotatoes	=	93.895	if	year ==	1986
replace	PPotatoes	=	73.393	if	year ==	1987
replace	PPotatoes	=	56.877	if	year ==	1988
replace	PPotatoes	=	86.697	if	year ==	1989
replace	PPotatoes	=	64.267	if	year ==	1990
replace	PPotatoes	=	94.666	if	year ==	1991
replace	PPotatoes	=	86.375	if	year ==	1992
replace	PPotatoes	=	90.231	if	year ==	1993
replace	PPotatoes	=	114.396	if	year ==	1994
replace	PPotatoes	=	128.600	if	year ==	1995
replace	PPotatoes	=	85.200	if	year ==	1996
replace	PPotatoes	=	73.000	if	year ==	1997
replace	PPotatoes	=	146.500	if	year ==	1998
replace	PPotatoes	=	118.200	if	year ==	1999
replace	PPotatoes	=	100.000	if	year ==	2000
replace	PPotatoes	=	152.050	if	year ==	2001
replace	PPotatoes	=	148.030	if	year ==	2002
replace	PPotatoes	=	154.210	if	year ==	2003
replace	PPotatoes	=	97.620	if	year ==	2004
replace	PPotatoes	=	145.490	if	year ==	2005
replace	PPotatoes	=	236.310	if	year ==	2006
replace	PPotatoes	=	218.400	if	year ==	2007
replace	PPotatoes	=	179.100	if	year ==	2008
replace	PPotatoes	=	189.900	if	year ==	2009
replace	PPotatoes	=	197.600	if	year ==	2010



capture drop	PVeg					
gen	PVeg	=	0			
replace	PVeg	=	68.425	if	year ==	1980
replace	PVeg	=	82.747	if	year ==	1981
replace	PVeg	=	70.352	if	year ==	1982
replace	PVeg	=	87.102	if	year ==	1983
replace	PVeg	=	88.442	if	year ==	1984
replace	PVeg	=	86.265	if	year ==	1985
replace	PVeg	=	84.673	if	year ==	1986
replace	PVeg	=	78.559	if	year ==	1987
replace	PVeg	=	81.407	if	year ==	1988
replace	PVeg	=	85.846	if	year ==	1989
replace	PVeg	=	83.752	if	year ==	1990
replace	PVeg	=	88.861	if	year ==	1991
replace	PVeg	=	80.821	if	year ==	1992
replace	PVeg	=	88.442	if	year ==	1993
replace	PVeg	=	89.615	if	year ==	1994
replace	PVeg	=	92.500	if	year ==	1995
replace	PVeg	=	96.300	if	year ==	1996
replace	PVeg	=	92.100	if	year ==	1997
replace	PVeg	=	97.800	if	year ==	1998
replace	PVeg	=	97.200	if	year ==	1999
replace	PVeg	=	100.000	if	year ==	2000
replace	PVeg	=	105.390	if	year ==	2001
replace	PVeg	=	114.930	if	year ==	2002
replace	PVeg	=	110.040	if	year ==	2003
replace	PVeg	=	110.690	if	year ==	2004
replace	PVeg	=	116.110	if	year ==	2005
replace	PVeg	=	123.650	if	year ==	2006
replace	PVeg	=	138.100	if	year ==	2007
replace	PVeg	=	139.000	if	year ==	2008
replace	PVeg	=	130.900	if	year ==	2009
replace	PVeg	=	130.900	if	year ==	2010



capture drop	PTotalCrop					
gen	PTotalCrop	=	0			
replace	PTotalCrop	=	84.794	if	year ==	1980
replace	PTotalCrop	=	96.475	if	year ==	1981
replace	PTotalCrop	=	102.920	if	year ==	1982
replace	PTotalCrop	=	112.991	if	year ==	1983
replace	PTotalCrop	=	117.221	if	year ==	1984
replace	PTotalCrop	=	98.691	if	year ==	1985
replace	PTotalCrop	=	106.647	if	year ==	1986
replace	PTotalCrop	=	102.417	if	year ==	1987
replace	PTotalCrop	=	101.913	if	year ==	1988
replace	PTotalCrop	=	108.560	if	year ==	1989
replace	PTotalCrop	=	100.705	if	year ==	1990
replace	PTotalCrop	=	104.532	if	year ==	1991
replace	PTotalCrop	=	101.712	if	year ==	1992
replace	PTotalCrop	=	106.042	if	year ==	1993
replace	PTotalCrop	=	106.143	if	year ==	1994
replace	PTotalCrop	=	110.600	if	year ==	1995
replace	PTotalCrop	=	100.700	if	year ==	1996
replace	PTotalCrop	=	91.200	if	year ==	1997
replace	PTotalCrop	=	104.700	if	year ==	1998
replace	PTotalCrop	=	103.300	if	year ==	1999
replace	PTotalCrop	=	100.000	if	year ==	2000
replace	PTotalCrop	=	112.170	if	year ==	2001
replace	PTotalCrop	=	110.410	if	year ==	2002
replace	PTotalCrop	=	116.030	if	year ==	2003
replace	PTotalCrop	=	104.360	if	year ==	2004
replace	PTotalCrop	=	111.990	if	year ==	2005
replace	PTotalCrop	=	133.860	if	year ==	2006
replace	PTotalCrop	=	162.200	if	year ==	2007
replace	PTotalCrop	=	137.900	if	year ==	2008
replace	PTotalCrop	=	124.300	if	year ==	2009
replace	PTotalCrop	=	144.000	if	year ==	2010



capture drop	PTotalInputs					
gen	PTotalInputs	=	0			
replace	PTotalInputs	=	62.192	if	year ==	1980
replace	PTotalInputs	=	71.050	if	year ==	1981
replace	PTotalInputs	=	77.808	if	year ==	1982
replace	PTotalInputs	=	84.018	if	year ==	1983
replace	PTotalInputs	=	90.502	if	year ==	1984
replace	PTotalInputs	=	91.781	if	year ==	1985
replace	PTotalInputs	=	88.311	if	year ==	1986
replace	PTotalInputs	=	84.201	if	year ==	1987
replace	PTotalInputs	=	86.484	if	year ==	1988
replace	PTotalInputs	=	91.142	if	year ==	1989
replace	PTotalInputs	=	91.324	if	year ==	1990
replace	PTotalInputs	=	91.689	if	year ==	1991
replace	PTotalInputs	=	91.598	if	year ==	1992
replace	PTotalInputs	=	91.598	if	year ==	1993
replace	PTotalInputs	=	92.420	if	year ==	1994
replace	PTotalInputs	=	93.400	if	year ==	1995
replace	PTotalInputs	=	97.300	if	year ==	1996
replace	PTotalInputs	=	95.300	if	year ==	1997
replace	PTotalInputs	=	93.000	if	year ==	1998
replace	PTotalInputs	=	94.100	if	year ==	1999
replace	PTotalInputs	=	100.000	if	year ==	2000
replace	PTotalInputs	=	104.790	if	year ==	2001
replace	PTotalInputs	=	106.150	if	year ==	2002
replace	PTotalInputs	=	108.800	if	year ==	2003
replace	PTotalInputs	=	113.070	if	year ==	2004
replace	PTotalInputs	=	117.990	if	year ==	2005
replace	PTotalInputs	=	123.070	if	year ==	2006
replace	PTotalInputs	=	131.300	if	year ==	2007
replace	PTotalInputs	=	155.900	if	year ==	2008
replace	PTotalInputs	=	142.200	if	year ==	2009
replace	PTotalInputs	=	139.900	if	year ==	2010



capture drop	PCalfFeed					
gen	PCalfFeed	=	0			
replace	PCalfFeed	=	85.038	if	year ==	1980
replace	PCalfFeed	=	92.788	if	year ==	1981
replace	PCalfFeed	=	99.677	if	year ==	1982
replace	PCalfFeed	=	109.365	if	year ==	1983
replace	PCalfFeed	=	117.653	if	year ==	1984
replace	PCalfFeed	=	109.150	if	year ==	1985
replace	PCalfFeed	=	107.104	if	year ==	1986
replace	PCalfFeed	=	104.090	if	year ==	1987
replace	PCalfFeed	=	104.952	if	year ==	1988
replace	PCalfFeed	=	111.195	if	year ==	1989
replace	PCalfFeed	=	107.643	if	year ==	1990
replace	PCalfFeed	=	103.660	if	year ==	1991
replace	PCalfFeed	=	103.983	if	year ==	1992
replace	PCalfFeed	=	103.660	if	year ==	1993
replace	PCalfFeed	=	104.629	if	year ==	1994
replace	PCalfFeed	=	108.300	if	year ==	1995
replace	PCalfFeed	=	111.900	if	year ==	1996
replace	PCalfFeed	=	107.700	if	year ==	1997
replace	PCalfFeed	=	100.800	if	year ==	1998
replace	PCalfFeed	=	97.900	if	year ==	1999
replace	PCalfFeed	=	100.000	if	year ==	2000
replace	PCalfFeed	=	103.860	if	year ==	2001
replace	PCalfFeed	=	105.770	if	year ==	2002
replace	PCalfFeed	=	106.840	if	year ==	2003
replace	PCalfFeed	=	110.080	if	year ==	2004
replace	PCalfFeed	=	106.390	if	year ==	2005
replace	PCalfFeed	=	107.430	if	year ==	2006
replace	PCalfFeed	=	121.900	if	year ==	2007
replace	PCalfFeed	=	140.900	if	year ==	2008
replace	PCalfFeed	=	128.200	if	year ==	2009
replace	PCalfFeed	=	123.400	if	year ==	2010



capture drop	PCattleFeed					
gen	PCattleFeed	=	0			
replace	PCattleFeed	=	86.272	if	year ==	1980
replace	PCattleFeed	=	91.975	if	year ==	1981
replace	PCattleFeed	=	99.155	if	year ==	1982
replace	PCattleFeed	=	108.448	if	year ==	1983
replace	PCattleFeed	=	117.529	if	year ==	1984
replace	PCattleFeed	=	107.392	if	year ==	1985
replace	PCattleFeed	=	104.329	if	year ==	1986
replace	PCattleFeed	=	100.845	if	year ==	1987
replace	PCattleFeed	=	102.112	if	year ==	1988
replace	PCattleFeed	=	108.237	if	year ==	1989
replace	PCattleFeed	=	105.597	if	year ==	1990
replace	PCattleFeed	=	101.478	if	year ==	1991
replace	PCattleFeed	=	102.006	if	year ==	1992
replace	PCattleFeed	=	102.851	if	year ==	1993
replace	PCattleFeed	=	104.541	if	year ==	1994
replace	PCattleFeed	=	106.000	if	year ==	1995
replace	PCattleFeed	=	110.700	if	year ==	1996
replace	PCattleFeed	=	104.400	if	year ==	1997
replace	PCattleFeed	=	98.300	if	year ==	1998
replace	PCattleFeed	=	96.500	if	year ==	1999
replace	PCattleFeed	=	100.000	if	year ==	2000
replace	PCattleFeed	=	106.410	if	year ==	2001
replace	PCattleFeed	=	107.840	if	year ==	2002
replace	PCattleFeed	=	107.740	if	year ==	2003
replace	PCattleFeed	=	111.710	if	year ==	2004
replace	PCattleFeed	=	108.850	if	year ==	2005
replace	PCattleFeed	=	111.230	if	year ==	2006
replace	PCattleFeed	=	126.700	if	year ==	2007
replace	PCattleFeed	=	147.400	if	year ==	2008
replace	PCattleFeed	=	132.000	if	year ==	2009
replace	PCattleFeed	=	122.900	if	year ==	2010



capture drop	PfertiliserNPK					
gen	PfertiliserNPK	=	0			
replace	PfertiliserNPK	=	83.871	if	year ==	1980
replace	PfertiliserNPK	=	95.421	if	year ==	1981
replace	PfertiliserNPK	=	101.977	if	year ==	1982
replace	PfertiliserNPK	=	102.601	if	year ==	1983
replace	PfertiliserNPK	=	112.695	if	year ==	1984
replace	PfertiliserNPK	=	123.309	if	year ==	1985
replace	PfertiliserNPK	=	116.025	if	year ==	1986
replace	PfertiliserNPK	=	91.779	if	year ==	1987
replace	PfertiliserNPK	=	96.878	if	year ==	1988
replace	PfertiliserNPK	=	104.058	if	year ==	1989
replace	PfertiliserNPK	=	104.058	if	year ==	1990
replace	PfertiliserNPK	=	105.723	if	year ==	1991
replace	PfertiliserNPK	=	104.162	if	year ==	1992
replace	PfertiliserNPK	=	98.959	if	year ==	1993
replace	PfertiliserNPK	=	98.959	if	year ==	1994
replace	PfertiliserNPK	=	98.300	if	year ==	1995
replace	PfertiliserNPK	=	102.500	if	year ==	1996
replace	PfertiliserNPK	=	96.400	if	year ==	1997
replace	PfertiliserNPK	=	93.400	if	year ==	1998
replace	PfertiliserNPK	=	94.500	if	year ==	1999
replace	PfertiliserNPK	=	100.000	if	year ==	2000
replace	PfertiliserNPK	=	111.580	if	year ==	2001
replace	PfertiliserNPK	=	108.360	if	year ==	2002
replace	PfertiliserNPK	=	111.460	if	year ==	2003
replace	PfertiliserNPK	=	112.200	if	year ==	2004
replace	PfertiliserNPK	=	121.190	if	year ==	2005
replace	PfertiliserNPK	=	129.190	if	year ==	2006
replace	PfertiliserNPK	=	132.300	if	year ==	2007
replace	PfertiliserNPK	=	222.700	if	year ==	2008
replace	PfertiliserNPK	=	190.400	if	year ==	2009
replace	PfertiliserNPK	=	165.800	if	year ==	2010



capture drop	PfertiliserPK					
gen	PfertiliserPK	=	0			
replace	PfertiliserPK	=	75.427	if	year ==	1980
replace	PfertiliserPK	=	87.476	if	year ==	1981
replace	PfertiliserPK	=	90.607	if	year ==	1982
replace	PfertiliserPK	=	90.892	if	year ==	1983
replace	PfertiliserPK	=	101.708	if	year ==	1984
replace	PfertiliserPK	=	109.772	if	year ==	1985
replace	PfertiliserPK	=	97.818	if	year ==	1986
replace	PfertiliserPK	=	81.879	if	year ==	1987
replace	PfertiliserPK	=	88.805	if	year ==	1988
replace	PfertiliserPK	=	95.825	if	year ==	1989
replace	PfertiliserPK	=	94.877	if	year ==	1990
replace	PfertiliserPK	=	90.133	if	year ==	1991
replace	PfertiliserPK	=	90.512	if	year ==	1992
replace	PfertiliserPK	=	84.345	if	year ==	1993
replace	PfertiliserPK	=	86.433	if	year ==	1994
replace	PfertiliserPK	=	88.500	if	year ==	1995
replace	PfertiliserPK	=	92.700	if	year ==	1996
replace	PfertiliserPK	=	88.700	if	year ==	1997
replace	PfertiliserPK	=	88.500	if	year ==	1998
replace	PfertiliserPK	=	96.300	if	year ==	1999
replace	PfertiliserPK	=	100.000	if	year ==	2000
replace	PfertiliserPK	=	104.490	if	year ==	2001
replace	PfertiliserPK	=	103.290	if	year ==	2002
replace	PfertiliserPK	=	104.980	if	year ==	2003
replace	PfertiliserPK	=	106.240	if	year ==	2004
replace	PfertiliserPK	=	110.010	if	year ==	2005
replace	PfertiliserPK	=	115.920	if	year ==	2006
replace	PfertiliserPK	=	123.500	if	year ==	2007
replace	PfertiliserPK	=	234.300	if	year ==	2008
replace	PfertiliserPK	=	254.200	if	year ==	2009
replace	PfertiliserPK	=	193.200	if	year ==	2010



capture drop	PTotalFert					
gen	PTotalFert	=	0			
replace	PTotalFert	=	81.250	if	year ==	1980
replace	PTotalFert	=	92.641	if	year ==	1981
replace	PTotalFert	=	98.488	if	year ==	1982
replace	PTotalFert	=	99.698	if	year ==	1983
replace	PTotalFert	=	109.476	if	year ==	1984
replace	PTotalFert	=	119.859	if	year ==	1985
replace	PTotalFert	=	109.677	if	year ==	1986
replace	PTotalFert	=	88.206	if	year ==	1987
replace	PTotalFert	=	94.556	if	year ==	1988
replace	PTotalFert	=	101.008	if	year ==	1989
replace	PTotalFert	=	100.806	if	year ==	1990
replace	PTotalFert	=	103.024	if	year ==	1991
replace	PTotalFert	=	101.411	if	year ==	1992
replace	PTotalFert	=	95.766	if	year ==	1993
replace	PTotalFert	=	96.270	if	year ==	1994
replace	PTotalFert	=	96.400	if	year ==	1995
replace	PTotalFert	=	101.000	if	year ==	1996
replace	PTotalFert	=	94.800	if	year ==	1997
replace	PTotalFert	=	91.300	if	year ==	1998
replace	PTotalFert	=	93.300	if	year ==	1999
replace	PTotalFert	=	100.000	if	year ==	2000
replace	PTotalFert	=	113.430	if	year ==	2001
replace	PTotalFert	=	110.510	if	year ==	2002
replace	PTotalFert	=	113.020	if	year ==	2003
replace	PTotalFert	=	115.140	if	year ==	2004
replace	PTotalFert	=	124.460	if	year ==	2005
replace	PTotalFert	=	133.100	if	year ==	2006
replace	PTotalFert	=	136.400	if	year ==	2007
replace	PTotalFert	=	220.600	if	year ==	2008
replace	PTotalFert	=	185.000	if	year ==	2009
replace	PTotalFert	=	162.200	if	year ==	2010



capture drop	PSeeds					
gen	PSeeds	=	0			
replace	PSeeds	=	53.292	if	year ==	1980
replace	PSeeds	=	55.926	if	year ==	1981
replace	PSeeds	=	61.658	if	year ==	1982
replace	PSeeds	=	65.763	if	year ==	1983
replace	PSeeds	=	74.206	if	year ==	1984
replace	PSeeds	=	72.424	if	year ==	1985
replace	PSeeds	=	77.459	if	year ==	1986
replace	PSeeds	=	78.311	if	year ==	1987
replace	PSeeds	=	75.600	if	year ==	1988
replace	PSeeds	=	75.600	if	year ==	1989
replace	PSeeds	=	77.459	if	year ==	1990
replace	PSeeds	=	78.466	if	year ==	1991
replace	PSeeds	=	83.579	if	year ==	1992
replace	PSeeds	=	84.198	if	year ==	1993
replace	PSeeds	=	89.620	if	year ==	1994
replace	PSeeds	=	98.000	if	year ==	1995
replace	PSeeds	=	103.400	if	year ==	1996
replace	PSeeds	=	100.500	if	year ==	1997
replace	PSeeds	=	102.000	if	year ==	1998
replace	PSeeds	=	102.100	if	year ==	1999
replace	PSeeds	=	100.000	if	year ==	2000
replace	PSeeds	=	103.680	if	year ==	2001
replace	PSeeds	=	107.350	if	year ==	2002
replace	PSeeds	=	115.150	if	year ==	2003
replace	PSeeds	=	116.140	if	year ==	2004
replace	PSeeds	=	115.660	if	year ==	2005
replace	PSeeds	=	120.110	if	year ==	2006
replace	PSeeds	=	130.800	if	year ==	2007
replace	PSeeds	=	141.900	if	year ==	2008
replace	PSeeds	=	131.600	if	year ==	2009
replace	PSeeds	=	122.100	if	year ==	2010



capture drop	PMotorFuels					
gen	PMotorFuels	=	0			
replace	PMotorFuels	=	40.710	if	year ==	1980
replace	PMotorFuels	=	55.741	if	year ==	1981
replace	PMotorFuels	=	64.092	if	year ==	1982
replace	PMotorFuels	=	72.164	if	year ==	1983
replace	PMotorFuels	=	75.713	if	year ==	1984
replace	PMotorFuels	=	78.706	if	year ==	1985
replace	PMotorFuels	=	61.656	if	year ==	1986
replace	PMotorFuels	=	62.143	if	year ==	1987
replace	PMotorFuels	=	60.612	if	year ==	1988
replace	PMotorFuels	=	66.040	if	year ==	1989
replace	PMotorFuels	=	69.589	if	year ==	1990
replace	PMotorFuels	=	71.260	if	year ==	1991
replace	PMotorFuels	=	65.623	if	year ==	1992
replace	PMotorFuels	=	67.711	if	year ==	1993
replace	PMotorFuels	=	65.553	if	year ==	1994
replace	PMotorFuels	=	66.000	if	year ==	1995
replace	PMotorFuels	=	71.800	if	year ==	1996
replace	PMotorFuels	=	73.500	if	year ==	1997
replace	PMotorFuels	=	70.500	if	year ==	1998
replace	PMotorFuels	=	75.600	if	year ==	1999
replace	PMotorFuels	=	100.000	if	year ==	2000
replace	PMotorFuels	=	95.780	if	year ==	2001
replace	PMotorFuels	=	94.730	if	year ==	2002
replace	PMotorFuels	=	99.060	if	year ==	2003
replace	PMotorFuels	=	110.170	if	year ==	2004
replace	PMotorFuels	=	131.720	if	year ==	2005
replace	PMotorFuels	=	144.080	if	year ==	2006
replace	PMotorFuels	=	147.300	if	year ==	2007
replace	PMotorFuels	=	173.600	if	year ==	2008
replace	PMotorFuels	=	143.500	if	year ==	2009
replace	PMotorFuels	=	168.600	if	year ==	2010



capture drop	PElectricity					
gen	PElectricity	=	0			
replace	PElectricity	=	61.979	if	year ==	1980
replace	PElectricity	=	77.886	if	year ==	1981
replace	PElectricity	=	92.532	if	year ==	1982
replace	PElectricity	=	98.739	if	year ==	1983
replace	PElectricity	=	104.656	if	year ==	1984
replace	PElectricity	=	110.863	if	year ==	1985
replace	PElectricity	=	113.773	if	year ==	1986
replace	PElectricity	=	106.014	if	year ==	1987
replace	PElectricity	=	101.843	if	year ==	1988
replace	PElectricity	=	100.873	if	year ==	1989
replace	PElectricity	=	96.993	if	year ==	1990
replace	PElectricity	=	96.023	if	year ==	1991
replace	PElectricity	=	96.023	if	year ==	1992
replace	PElectricity	=	96.023	if	year ==	1993
replace	PElectricity	=	96.023	if	year ==	1994
replace	PElectricity	=	96.000	if	year ==	1995
replace	PElectricity	=	97.500	if	year ==	1996
replace	PElectricity	=	99.400	if	year ==	1997
replace	PElectricity	=	100.000	if	year ==	1998
replace	PElectricity	=	100.000	if	year ==	1999
replace	PElectricity	=	100.000	if	year ==	2000
replace	PElectricity	=	101.480	if	year ==	2001
replace	PElectricity	=	105.930	if	year ==	2002
replace	PElectricity	=	119.570	if	year ==	2003
replace	PElectricity	=	125.690	if	year ==	2004
replace	PElectricity	=	135.710	if	year ==	2005
replace	PElectricity	=	141.610	if	year ==	2006
replace	PElectricity	=	157.600	if	year ==	2007
replace	PElectricity	=	159.900	if	year ==	2008
replace	PElectricity	=	167.400	if	year ==	2009
replace	PElectricity	=	156.900	if	year ==	2010




capture drop	PTotalEnergy					
gen	PTotalEnergy	=	0			
replace	PTotalEnergy	=	44.321	if	year ==	1980
replace	PTotalEnergy	=	59.762	if	year ==	1981
replace	PTotalEnergy	=	68.671	if	year ==	1982
replace	PTotalEnergy	=	76.540	if	year ==	1983
replace	PTotalEnergy	=	80.624	if	year ==	1984
replace	PTotalEnergy	=	84.261	if	year ==	1985
replace	PTotalEnergy	=	70.304	if	year ==	1986
replace	PTotalEnergy	=	69.488	if	year ==	1987
replace	PTotalEnergy	=	67.558	if	year ==	1988
replace	PTotalEnergy	=	71.863	if	year ==	1989
replace	PTotalEnergy	=	74.239	if	year ==	1990
replace	PTotalEnergy	=	75.575	if	year ==	1991
replace	PTotalEnergy	=	71.195	if	year ==	1992
replace	PTotalEnergy	=	72.977	if	year ==	1993
replace	PTotalEnergy	=	71.344	if	year ==	1994
replace	PTotalEnergy	=	71.700	if	year ==	1995
replace	PTotalEnergy	=	76.600	if	year ==	1996
replace	PTotalEnergy	=	78.200	if	year ==	1997
replace	PTotalEnergy	=	75.900	if	year ==	1998
replace	PTotalEnergy	=	80.200	if	year ==	1999
replace	PTotalEnergy	=	100.000	if	year ==	2000
replace	PTotalEnergy	=	97.080	if	year ==	2001
replace	PTotalEnergy	=	97.140	if	year ==	2002
replace	PTotalEnergy	=	102.920	if	year ==	2003
replace	PTotalEnergy	=	112.580	if	year ==	2004
replace	PTotalEnergy	=	131.700	if	year ==	2005
replace	PTotalEnergy	=	143.120	if	year ==	2006
replace	PTotalEnergy	=	148.100	if	year ==	2007
replace	PTotalEnergy	=	168.900	if	year ==	2008
replace	PTotalEnergy	=	146.100	if	year ==	2009
replace	PTotalEnergy	=	164.700	if	year ==	2010




capture drop	PPlantProtection					
gen	PPlantProtection	=	0			
replace	PPlantProtection	=	57.192	if	year ==	1980
replace	PPlantProtection	=	65.547	if	year ==	1981
replace	PPlantProtection	=	71.404	if	year ==	1982
replace	PPlantProtection	=	73.299	if	year ==	1983
replace	PPlantProtection	=	77.950	if	year ==	1984
replace	PPlantProtection	=	80.017	if	year ==	1985
replace	PPlantProtection	=	80.362	if	year ==	1986
replace	PPlantProtection	=	80.276	if	year ==	1987
replace	PPlantProtection	=	82.257	if	year ==	1988
replace	PPlantProtection	=	83.376	if	year ==	1989
replace	PPlantProtection	=	86.133	if	year ==	1990
replace	PPlantProtection	=	88.803	if	year ==	1991
replace	PPlantProtection	=	89.664	if	year ==	1992
replace	PPlantProtection	=	91.731	if	year ==	1993
replace	PPlantProtection	=	95.004	if	year ==	1994
replace	PPlantProtection	=	97.500	if	year ==	1995
replace	PPlantProtection	=	100.800	if	year ==	1996
replace	PPlantProtection	=	100.400	if	year ==	1997
replace	PPlantProtection	=	100.800	if	year ==	1998
replace	PPlantProtection	=	100.600	if	year ==	1999
replace	PPlantProtection	=	100.000	if	year ==	2000
replace	PPlantProtection	=	100.830	if	year ==	2001
replace	PPlantProtection	=	101.640	if	year ==	2002
replace	PPlantProtection	=	101.610	if	year ==	2003
replace	PPlantProtection	=	103.220	if	year ==	2004
replace	PPlantProtection	=	102.690	if	year ==	2005
replace	PPlantProtection	=	101.720	if	year ==	2006
replace	PPlantProtection	=	101.700	if	year ==	2007
replace	PPlantProtection	=	103.200	if	year ==	2008
replace	PPlantProtection	=	105.100	if	year ==	2009
replace	PPlantProtection	=	105.200	if	year ==	2010




capture drop	PVetExp					
gen	PVetExp	=	0			
replace	PVetExp	=	35.751	if	year ==	1980
replace	PVetExp	=	40.044	if	year ==	1981
replace	PVetExp	=	46.336	if	year ==	1982
replace	PVetExp	=	50.629	if	year ==	1983
replace	PVetExp	=	57.513	if	year ==	1984
replace	PVetExp	=	64.545	if	year ==	1985
replace	PVetExp	=	66.765	if	year ==	1986
replace	PVetExp	=	66.395	if	year ==	1987
replace	PVetExp	=	68.616	if	year ==	1988
replace	PVetExp	=	71.355	if	year ==	1989
replace	PVetExp	=	74.019	if	year ==	1990
replace	PVetExp	=	77.054	if	year ==	1991
replace	PVetExp	=	79.571	if	year ==	1992
replace	PVetExp	=	81.569	if	year ==	1993
replace	PVetExp	=	83.050	if	year ==	1994
replace	PVetExp	=	85.800	if	year ==	1995
replace	PVetExp	=	89.300	if	year ==	1996
replace	PVetExp	=	92.300	if	year ==	1997
replace	PVetExp	=	94.700	if	year ==	1998
replace	PVetExp	=	95.900	if	year ==	1999
replace	PVetExp	=	100.000	if	year ==	2000
replace	PVetExp	=	104.660	if	year ==	2001
replace	PVetExp	=	109.360	if	year ==	2002
replace	PVetExp	=	114.670	if	year ==	2003
replace	PVetExp	=	115.780	if	year ==	2004
replace	PVetExp	=	117.620	if	year ==	2005
replace	PVetExp	=	122.430	if	year ==	2006
replace	PVetExp	=	126.200	if	year ==	2007
replace	PVetExp	=	128.900	if	year ==	2008
replace	PVetExp	=	130.900	if	year ==	2009
replace	PVetExp	=	131.100	if	year ==	2010




capture drop	POtherInputs					
gen	POtherInputs	=	0			
replace	POtherInputs	=	42.155	if	year ==	1980
replace	POtherInputs	=	50.079	if	year ==	1981
replace	POtherInputs	=	56.894	if	year ==	1982
replace	POtherInputs	=	61.648	if	year ==	1983
replace	POtherInputs	=	66.403	if	year ==	1984
replace	POtherInputs	=	69.968	if	year ==	1985
replace	POtherInputs	=	71.712	if	year ==	1986
replace	POtherInputs	=	73.613	if	year ==	1987
replace	POtherInputs	=	76.070	if	year ==	1988
replace	POtherInputs	=	77.655	if	year ==	1989
replace	POtherInputs	=	79.239	if	year ==	1990
replace	POtherInputs	=	81.933	if	year ==	1991
replace	POtherInputs	=	84.152	if	year ==	1992
replace	POtherInputs	=	85.658	if	year ==	1993
replace	POtherInputs	=	87.480	if	year ==	1994
replace	POtherInputs	=	90.300	if	year ==	1995
replace	POtherInputs	=	91.200	if	year ==	1996
replace	POtherInputs	=	92.700	if	year ==	1997
replace	POtherInputs	=	93.600	if	year ==	1998
replace	POtherInputs	=	95.900	if	year ==	1999
replace	POtherInputs	=	100.000	if	year ==	2000
replace	POtherInputs	=	105.920	if	year ==	2001
replace	POtherInputs	=	110.350	if	year ==	2002
replace	POtherInputs	=	114.090	if	year ==	2003
replace	POtherInputs	=	116.910	if	year ==	2004
replace	POtherInputs	=	121.000	if	year ==	2005
replace	POtherInputs	=	124.040	if	year ==	2006
replace	POtherInputs	=	128.900	if	year ==	2007
replace	POtherInputs	=	136.800	if	year ==	2008
replace	POtherInputs	=	139.200	if	year ==	2009
replace	POtherInputs	=	137.300	if	year ==	2010



	
capture drop	CPI					
gen	CPI	=	0			
replace	CPI	=	33.199	if	year ==	1980
replace	CPI	=	39.241	if	year ==	1981
replace	CPI	=	47.246	if	year ==	1982
replace	CPI	=	55.326	if	year ==	1983
replace	CPI	=	61.079	if	year ==	1984
replace	CPI	=	66.332	if	year ==	1985
replace	CPI	=	69.914	if	year ==	1986
replace	CPI	=	72.641	if	year ==	1987
replace	CPI	=	74.965	if	year ==	1988
replace	CPI	=	76.540	if	year ==	1989
replace	CPI	=	79.601	if	year ==	1990
replace	CPI	=	82.308	if	year ==	1991
replace	CPI	=	84.941	if	year ==	1992
replace	CPI	=	87.490	if	year ==	1993
replace	CPI	=	88.802	if	year ==	1994
replace	CPI	=	90.933	if	year ==	1995
replace	CPI	=	93.207	if	year ==	1996
replace	CPI	=	94.698	if	year ==	1997
replace	CPI	=	96.118	if	year ==	1998
replace	CPI	=	98.425	if	year ==	1999
replace	CPI	=	100.000	if	year ==	2000
replace	CPI	=	104.900	if	year ==	2001
replace	CPI	=	109.725	if	year ==	2002
replace	CPI	=	113.566	if	year ==	2003
replace	CPI	=	116.064	if	year ==	2004
replace	CPI	=	118.966	if	year ==	2005
replace	CPI	=	123.724	if	year ==	2006
replace	CPI	=	129.787	if	year ==	2007
replace	CPI	=	135.108	if	year ==	2008
replace	CPI	=	128.299	if	year ==	2009
replace	CPI	=	130.028	if	year ==	2010



capture drop	PTransportcap					
gen	PTransportcap	=	0			
replace	PTransportcap	=	30.651	if	year ==	1980
replace	PTransportcap	=	36.229	if	year ==	1981
replace	PTransportcap	=	43.620	if	year ==	1982
replace	PTransportcap	=	51.079	if	year ==	1983
replace	PTransportcap	=	56.391	if	year ==	1984
replace	PTransportcap	=	61.241	if	year ==	1985
replace	PTransportcap	=	64.548	if	year ==	1986
replace	PTransportcap	=	67.065	if	year ==	1987
replace	PTransportcap	=	69.211	if	year ==	1988
replace	PTransportcap	=	70.665	if	year ==	1989
replace	PTransportcap	=	73.491	if	year ==	1990
replace	PTransportcap	=	75.990	if	year ==	1991
replace	PTransportcap	=	78.422	if	year ==	1992
replace	PTransportcap	=	80.775	if	year ==	1993
replace	PTransportcap	=	81.986	if	year ==	1994
replace	PTransportcap	=	83.954	if	year ==	1995
replace	PTransportcap	=	86.053	if	year ==	1996
replace	PTransportcap	=	88.509	if	year ==	1997
replace	PTransportcap	=	89.825	if	year ==	1998
replace	PTransportcap	=	92.368	if	year ==	1999
replace	PTransportcap	=	100.000	if	year ==	2000
replace	PTransportcap	=	101.316	if	year ==	2001
replace	PTransportcap	=	104.051	if	year ==	2002
replace	PTransportcap	=	108.307	if	year ==	2003
replace	PTransportcap	=	109.624	if	year ==	2004
replace	PTransportcap	=	109.624	if	year ==	2005
replace	PTransportcap	=	111.042	if	year ==	2006
replace	PTransportcap	=	116.483	if	year ==	2007
replace	PTransportcap	=	121.259	if	year ==	2008
replace	PTransportcap	=	0.000	if	year ==	2009
replace	PTransportcap	=	0.000	if	year ==	2010



capture drop	POthercap					
gen	POthercap	=	0			
replace	POthercap	=	42.155	if	year ==	1980
replace	POthercap	=	50.079	if	year ==	1981
replace	POthercap	=	56.894	if	year ==	1982
replace	POthercap	=	61.648	if	year ==	1983
replace	POthercap	=	66.403	if	year ==	1984
replace	POthercap	=	69.968	if	year ==	1985
replace	POthercap	=	71.712	if	year ==	1986
replace	POthercap	=	73.613	if	year ==	1987
replace	POthercap	=	76.070	if	year ==	1988
replace	POthercap	=	77.655	if	year ==	1989
replace	POthercap	=	79.239	if	year ==	1990
replace	POthercap	=	81.933	if	year ==	1991
replace	POthercap	=	84.152	if	year ==	1992
replace	POthercap	=	85.658	if	year ==	1993
replace	POthercap	=	87.480	if	year ==	1994
replace	POthercap	=	90.300	if	year ==	1995
replace	POthercap	=	91.200	if	year ==	1996
replace	POthercap	=	92.700	if	year ==	1997
replace	POthercap	=	93.600	if	year ==	1998
replace	POthercap	=	95.900	if	year ==	1999
replace	POthercap	=	100.000	if	year ==	2000
replace	POthercap	=	105.920	if	year ==	2001
replace	POthercap	=	110.350	if	year ==	2002
replace	POthercap	=	114.090	if	year ==	2003
replace	POthercap	=	116.910	if	year ==	2004
replace	POthercap	=	121.000	if	year ==	2005
replace	POthercap	=	124.040	if	year ==	2006
replace	POthercap	=	128.900	if	year ==	2007
replace	POthercap	=	136.800	if	year ==	2008
replace	POthercap	=	139.200	if	year ==	2009
replace	POthercap	=	137.300	if	year ==	2010




/*
***************************************************************************
* Convert punts to Euro

***************************************************************************

replace farmvaluee=farmvaluee/.787564 if t<=3 

replace machinee=machinee /.787564 if t<=3

replace buildingse=buildingse /.787564 if t<=3

*replace landimpe=landimpe /.787564 if t<=3

replace labfame=labfame /.787564 if t<=3

replace labcase= labcase/.787564 if t<=3

replace hiredlabe= hiredlabe/.787564 if t<=3

replace intereste= intereste/.787564 if t<=3

replace opexmachinery= opexmachinery/.787564 if t<=3

replace opexbuildings= opexbuildings/.787564 if t<=3

replace upkeepe=upkeepe /.787564 if t<=3

*replace limee=limee /.787564 if t<=3

replace annuitiese= annuitiese/.787564 if t<=3

replace ratee=ratee /.787564 if t<=3

*replace insurancee= insurancee/.787564 if t<=3

replace fuellubse =fuellubse /.787564 if t<=3

*replace esbe =esbe /.787564 if t<=3


*replace phonee =phonee /.787564 if t<=3

*replace rentretirefame =rentretirefame /.787564 if t<=3

*replace rentretirenonfame =rentretirenonfame /.787564 if t<=3

replace miscoverheade =miscoverheade /.787564 if t<=3

replace dairyinggrossoutput =dairyinggrossoutput /.787564 if t<=3

replace cropsgrossoutput =cropsgrossoutput /.787564 if t<=3

replace cropandlivegrossoutput =cropandlivegrossoutput /.787564 if t<=3

replace othergrantsandsubs =othergrantsandsubs /.787564 if t<=3

replace aidairy =aidairy /.787564 if t<=3

replace aicattle =aicattle /.787564 if t<=3

replace aisheep =aisheep /.787564 if t<=3

replace loan =loan /.787564 if t<=3

replace sub1 =sub1 /.787564 if t<=3

replace sub2 =sub2 /.787564 if t<=3

replace sub3 =sub3 /.787564 if t<=3

replace sub4 =sub4 /.787564 if t<=3

replace sub5 =sub5 /.787564 if t<=3

replace sub6 =sub6 /.787564 if t<=3

*replace sub7 =sub7 /.787564 if t<=3

*replace sub8 =sub8 /.787564 if t<=3

*replace sub9 =sub9 /.787564 if t<=3

*replace sub10 =sub10 /.787564 if t<=3

*replace sub11 =sub11 /.787564 if t<=3

*replace sub12 =sub12 /.787564 if t<=3

*replace sub13 =sub13 /.787564 if t<=3

*replace sub14 =sub14 /.787564 if t<=3

*replace sub15 =sub15 /.787564 if t<=3

*replace sub16 =sub16 /.787564 if t<=3

*replace sub17 =sub17 /.787564 if t<=3

*replace sub18 =sub18 /.787564 if t<=3

*replace sub19 =sub19 /.787564 if t<=3

*replace sub20 =sub20 /.787564 if t<=3

*replace sub21 =sub21 /.787564 if t<=3

*replace sub22 =sub22 /.787564 if t<=3

*replace sub23 =sub23 /.787564 if t<=3

*replace sub24 =sub24 /.787564 if t<=3

*replace sub25 =sub25 /.787564 if t<=3

*replace sub26 =sub26 /.787564 if t<=3

*replace sub27 =sub27 /.787564 if t<=3

*replace sub28 =sub28 /.787564 if t<=3

*replace sub29= sub29/.787564 if t<=3

*replace sub30 =sub30 /.787564 if t<=3

*replace sub31 =sub31 /.787564 if t<=3

*replace sub32 =sub32 /.787564 if t<=3

replace sub33 =sub33 /.787564 if t<=3

*replace sub34 =sub34 /.787564 if t<=3

*replace sub35= sub35/.787564 if t<=3

*replace sub36 =sub36 /.787564 if t<=3

*replace sub37 =sub37 /.787564 if t<=3

*replace sub38 =sub38 /.787564 if t<=3

*replace sub39=sub39 /.787564 if t<=3

*replace sub40= sub40/.787564 if t<=3

*replace sub41 =sub41 /.787564 if t<=3

*replace sub42=sub42 /.787564 if t<=3

*replace sub43 =sub43/.787564 if t<=3 

*replace sub44 =sub44/.787564 if t<=3

*replace sub45 =sub45 /.787564 if t<=3

*replace sub46 =sub46 /.787564 if t<=3

*replace sub47 =sub47 /.787564 if t<=3

*replace sub48 =sub48 /.787564 if t<=3

*replace sub49 =sub49 /.787564 if t<=3

*replace sub50 =sub50 /.787564 if t<=3

*replace sub51 =sub51 /.787564 if t<=3

*replace sub52=sub52 /.787564 if t<=3

*replace sub53= sub53/.787564 if t<=3

*replace sub54=sub54 /.787564 if t<=3

*replace sub55=sub55 /.787564 if t<=3

*replace sub56=sub56/.787564 if t<=3

*replace sub57= sub57/.787564 if t<=3

*replace sub58=sub58 /.787564 if t<=3

*replace sub59= sub59/.787564 if t<=3

*replace sub60=sub60 /.787564 if t<=3

*replace sub61=sub61 /.787564 if t<=3

*replace sub62=sub62 /.787564 if t<=3

replace sub63=sub63 /.787564 if t<=3

*replace sub64= sub64/.787564 if t<=3

*replace sub65=sub65 /.787564 if t<=3

*replace sub66=sub66 /.787564 if t<=3

*replace sub67=sub67 /.787564 if t<=3

replace sub68= sub68/.787564 if t<=3

*replace sub69=sub69 /.787564 if t<=3

*replace sub70 =sub70/.787564 if t<=3

*replace sub71 =sub71/.787564 if t<=3

*replace sub72 =sub72/.787564 if t<=3

replace sub73=sub73 /.787564 if t<=3

*replace sub74=sub74 /.787564 if t<=3

*replace sub75=sub75 /.787564 if t<=3

*replace sub76=sub76 /.787564 if t<=3

*replace sub77= sub77/.787564 if t<=3

replace sub78=sub78 /.787564 if t<=3

replace sub79 =sub79/.787564 if t<=3

*replace DYcloseinv= DYcloseinv/.787564 if t<=3

replace DYmilke =DYmilke/.787564 if t<=3

replace DYsubs =DYsubs/.787564 if t<=3

replace DYconcentrates=DYconcentrates /.787564 if t<=3

replace DYpasture=DYpasture /.787564 if t<=3

replace DYwinfor= DYwinfor/.787564 if t<=3

replace DYmisccosts=DYmisccosts /.787564 if t<=3

replace advisefee=advisefee/.787564 if t<=3
*/



***************************************************************************
* drop all non dairy

***************************************************************************

drop if sys==2
drop if sys==3
drop if sys==4
drop if sys==5
drop if sys==6
drop if sys==7
drop if sys==8
drop if sys==.





***************************************************************************
* create input allocation variable according to gross output

***************************************************************************

gen alloc=dairyinggrossoutput/cropandlivegrossoutput

replace alloc=1 if alloc>1
replace alloc=0 if alloc<0





***************************************************************************
* Create Capital Input (end of year book values)= machinery+buildings 

***************************************************************************

gen C= alloc*(((machinee/PTransportcap)*100)+((buildingse/POthercap)*100))





***************************************************************************
* Create Labour Inputs

*************************************************************************** 
gen L1=(alloc*(labfame + labcase + hiredlabe))/CPI*100
gen L2=alloc*labunits
gen L3=alloc*mandays





***************************************************************************
* Create Herd size variable (average number)

***************************************************************************

gen H=DYave






***************************************************************************
* convert early years to LITRES! and deflate
* todo -  DO I NEED TO DO THIS WITH FADN DATA?
***************************************************************************

*replace DYmilkgal=DYmilkgal*4.546092 if t==1
*replace DYmilkgal=DYmilkgal*4.546092 if t==2
*replace DYmilkgal=DYmilkgal*4.546092 if t==3
*replace DYmilkgal=DYmilkgal*4.546092 if t==4
*replace DYmilkgal=DYmilkgal*4.546092 if t==5
*replace DYmilkgal=DYmilkgal*4.546092 if t==6

replace DYmilkgal=DYmilkgal*4.546092 if year<=2001
rename DYmilkgal Y1  



* Deflate Milk values

gen Y2=(DYmilke/PMilk)*100





***************************************************************************
*Direct Costs 

***************************************************************************
*gen DC= (DYconcentrates/PCattleFeed*100)+ (DYpasture/PTotalFert*100)+ (DYwinfor/PTotalFert*100) +(alloc*opexmachinery/PTotalInputs*100)+(alloc*limee/PTotalFert*100)+ (alloc*fuellubse/PMotorFuels*100)



* the following line will only work if you keep feedforgrazinglivestock and feedforgrazinglivestockhomegrown from the FADN data in the dataset in the Data Creator's keep statement. 

gen DC= (alloc*feedforgrazinglivestock/PCattleFeed*100) + (alloc*feedforgrazinglivestockhomegrown + PTotalFert*100) + (alloc*opexmachinery/PTotalInputs*100)+(alloc*fdferfil/PTotalFert*100)+ (alloc*fuellubse/PMotorFuels*100)





***************************************************************************
* CREATE TIME DUMMIES
***************************************************************************

tab t, gen(T)





***************************************************************************
* CREATE EFFICIENCY VARIABLES  
***************************************************************************

* divide age into dummies

rename age AGE

gen AGE1=0 
replace AGE1=1 if AGE<=30


gen AGE2=0 
replace AGE2=1 if AGE<=40
replace AGE2=0 if AGE<=31


gen AGE3=0 
replace AGE3=1 if AGE<=50
replace AGE3=0 if AGE<=41


gen AGE4=0 
replace AGE4=1 if AGE<=60
replace AGE4=0 if AGE<=51


gen AGE5=0
replace AGE5=1 if AGE<=70
replace AGE5=0 if AGE<=61


gen AGE6=0 
replace AGE6=1 if AGE<=80
replace AGE6=0 if AGE<=71


gen AGE7=0 
replace AGE7=1 if AGE<=90
replace AGE7=0 if AGE<=81





***************************************************************************
* create soil class dummies (1 is best, followed by 2 and 3)  
***************************************************************************

*gen SOIL1=0
*(replace SOIL1=1 if sclass<300


*gen SOIL2=0
*replace SOIL2=1 if sclass<500
*replace SOIL2=0 if sclass<300


*gen SOIL3=0
*replace SOIL3=1 if sclass<700
*replace SOIL3=0 if sclass<500





***************************************************************************
* create AI dummy (equal to 1 if farm spends any amount)  
***************************************************************************

replace aidairy=aidairy/PVetExp*100
gen AID=0
replace AID=1 if aidairy>0




***************************************************************************
* create Bull Dummy equal to one if farm has atleast one Bull  
***************************************************************************

*gen BULL=0
*replace BULL=1 if DYbullave>0





***************************************************************************
* create indebtedness variable (value of loans divided by end of year value of farm)
***************************************************************************

gen DEBTRAT=((loan/CPI*100)/(farmvaluee/CPI*100)*100)





***************************************************************************
* create subsidies ratios (value of subsidies/value of milk sales)  
***************************************************************************

gen SUBS1=sub5+sub6+sub2+sub4 //"sub26 +" cut out (don't have it or just not coded)
gen SUBRAT1=SUBS1/DYmilke
gen SUBS2=DYsubs
gen SUBRAT2=SUBS2/DYmilke





***************************************************************************
* create ratio of dairy land (feed area) to total land (unadjusted farm size)  
***************************************************************************

gen LANDRAT=DYfeedarea/size3





***************************************************************************
* create value per acre variable  
***************************************************************************

gen ACREVAL=((farmvaluee/CPI*100)*100)/size3





***************************************************************************
* create children dummy  
***************************************************************************

gen CHILD=0
replace CHILD=1 if childunder5>0
replace CHILD=1 if childunder15>0
replace CHILD=1 if childunder19>0





***************************************************************************
* create married dummy  
***************************************************************************

*gen MARRIED=0
*replace MARRIED=1 if maritalstat==1

* don't have marital status, but could imply it from Reg-unpaid Spouse vars 
* (C06XXX in request sheet) if we get it (don't have it now).





***************************************************************************
* create off-farm job dummy 1(holder)  
***************************************************************************

*gen OFFFARM=0
*replace OFFFARM=1 if offjobtype==1
*replace OFFFARM=1 if offjobtype==2

* don't have off-farm info, and I don't see any FADN vars that fit





***************************************************************************
* create average cow value variable (closing inventory of dairy herd divided 
*  by average number of cows)
***************************************************************************

*gen COWVAL=DYcloseinv/DYave





***************************************************************************
* gen extension variable (value and dummy)
***************************************************************************

*gen EXTEN=advisefee
gen EXTEN=teagasc // <- replaced with var created in renameFADN.do

gen EXTEND=0
*replace EXTEND=1 if advisefee>0
replace EXTEND=1 if teagasc>0 // <- replaced with var created in renameFADN.do





***************************************************************************
* GENERATE SIZE DUMMIES
***************************************************************************

gen SIZE1=0
gen SIZE2=0
gen SIZE3=0
gen SIZE4=0
gen SIZE5=0

replace SIZE1=1 if size3<=75

replace SIZE2=1 if size3<=100
replace SIZE2=0 if size3<75

replace SIZE3=1 if size3<=125
replace SIZE3=0 if size3<100

replace SIZE4=1 if size3<=175
replace SIZE4=0 if size3<125

replace SIZE5=1 if size3>175





***************************************************************************
* Drop, rename, replace
***************************************************************************

drop DYsubs
rename alloc ALLOC

rename sys SYS

rename t T

rename wt W

rename fc FC

*rename offjobtype JOBTYPE

*rename sclass SCLASS

*rename hohsex SEX

rename aidairy AI

rename size3 FSIZE

rename farmvaluee FVALUE

rename childunder5 CHILD5

rename childunder15 CHILD15

rename childunder19 CHILD19

rename loan LOAN

*rename DYownquota QTOWN

*rename DYleasedquota QTLEASE

*rename DYletquota QTLET

*rename DYquota QT

*rename DYfat FAT

*rename DYprotein PROTEIN

rename DYforagearea LANDFAGE

rename DYfeedarea LANDFEED

replace LANDFAGE=LANDFAGE*2.47105 if T==11

replace LANDFEED=LANDFEED*2.47105 if T==11

replace FSIZE=FSIZE*2.47105 if T==11





***************************************************************************
* create intensification variable (COW per acre)

***************************************************************************

gen INTENSE=DYave/LANDFAGE





***************************************************************************
* create decoupling variable

***************************************************************************

gen DECOUP=0
replace DECOUP=1 if T==10
replace DECOUP=1 if T==11





***************************************************************************
* drop unecessary variables

**************************************************************************

* Original keep statement

*keep INTENSE DECOUP AI SYS T W FC SCLASS FSIZE FVALUE SEX AGE CHILD5 CHILD15 CHILD19 JOBTYPE CHILD5 CHILD15 CHILD19 LOAN Y1 QTOWN QTLEASE QTLET QT FAT PROTEIN LANDFAGE LANDFEED ALLOC- SIZE5



* Edited keep statement necessary to get file to complete run.

*keep INTENSE DECOUP AI SYS T W FC FSIZE FVALUE AGE CHILD5 CHILD15 CHILD19 CHILD5 CHILD15 CHILD19 LOAN Y1 Y2 LANDFAGE LANDFEED ALLOC- SIZE5
