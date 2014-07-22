# Fig I.6 -- Seasonality in Volume of Monthly Milk Collections: Ireland 2011
# The following 6 lines read the latest data from www.cso.ie, selects only domestic deliveries to creameries, and spits out a csv for graph generation in Excel.
# all but the year defined at the top by the variable "end" 
library(pxR)
MNMKDEL <- as.data.frame(read.px("http://cso.ie/px/pxeirestat/Database/eirestat/Agriculture%20Milk%20Production/AKM01.px"))
MNMKDEL <- MNMKDEL[MNMKDEL$Statistic=="Intake of Cows Milk by Creameries and Pasteurisers (Million Litres)",]
MNMKDEL <- MNMKDEL[MNMKDEL$Domestic.or.Import.Source=="Domestic",]
MNMKDEL$YEAR <- substr(MNMKDEL$Month, 1, 4)
MNMKDEL$Month <- substr(MNMKDEL$Month, 6, 7) 
MNMKDEL <- MNMKDEL[MNMKDEL$YEAR>2004 & MNMKDEL$YEAR<2012,]
write.csv(MNMKDEL,"G:/Data/data_NFSPanelAnalysis/OutData/REDP_Book/DairyChapter/seasonality.csv")
