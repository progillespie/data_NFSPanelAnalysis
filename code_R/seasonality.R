# Fig I.6 -- Seasonality in Volume of Monthly Milk Collections: Ireland 2011


library(pxR)


#----------------------------------------------------------------------------------------------#
#--- Pull data from CSO website. Looking for series AKM01, which is monthly milk deliveries ---#
#----------------------------------------------------------------------------------------------#
# CSO has moved their data around as part of web site management. Original URL was...
#MNMKDEL <- as.data.frame(read.px("http://cso.ie/px/pxeirestat/Database/eirestat/Agriculture%20Milk%20Production/AKM01.px"))

# Correct URL (as of 09/02/2015) is given below (it just omits Agriculture%20 from the containing directory)
MNMKDEL <- as.data.frame(read.px("http://cso.ie/px/pxeirestat/Database/eirestat/Milk%20Production/AKM01.px"))
#----------------------------------------------------------------------------------------------#

# Subset the data to give you just Creamery intake and only from domestic source
MNMKDEL <- MNMKDEL[MNMKDEL$Statistic=="Intake of Cows Milk by Creameries and Pasteurisers (Million Litres)",]
MNMKDEL <- MNMKDEL[MNMKDEL$Domestic.or.Import.Source=="Domestic",]

# Create separate vars for YEAR and Month (currently run together in a single var)
MNMKDEL$YEAR <- substr(MNMKDEL$Month, 1, 4)
MNMKDEL$Month <- substr(MNMKDEL$Month, 6, 7) 
MNMKDEL <- MNMKDEL[MNMKDEL$YEAR>2004 & MNMKDEL$YEAR<2012,]

# Save the data as a csv.
write.csv(MNMKDEL,"D:/Data/data_NFSPanelAnalysis/OutData/REDP_Book/DairyChapter/seasonality.csv")
