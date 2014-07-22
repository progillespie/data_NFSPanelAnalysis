# Recreating graphs for Dairy Chapter
hist.row <- read.csv("~/Data/ghg/HIST_export.csv", header=F, as.is=1)
end <- 2011

# - Figure 3-4 -- Milk Quota Volumes 
png("~/Documents/projects/phd/dairychapter/fig3_4.png", 12.7, 6.35, units="cm", res=120)
par(mar=c(3,4,1,1)+0.1)

barplot(hist$CMQUAIE[hist$YEAR>1983 & hist$YEAR<end]/1000
        , ylim = c(5, 5.8)
        , xpd=F
        , names.arg=c("84/85", " ", " ", "87/88", " ", " ", "90/91", " ", " ", "93/94", " ", " ", "96/97", " ", " ", "99/00", " ", " ", "02/03", " ", " ", "05/06", " ", " ", "08/09", " ", "10/11")
        , space=.6
        , col= colors()[214]
        , axis.lty=1
        , las = 2
        , cex.names = .8
        , main = ""
        , ylab = "million tonnes"
        , cex.lab=.8
        , cex.axis=.8
        )
text(43
     , hist$CMQUAIE[hist$YEAR==end-1]/1000 + .04
     , signif((hist$CMQUAIE[hist$YEAR==end-1]/1000)
              , digits=3)
     , cex = .6
     )
dev.off()

#  Figure 3-5 -- Farm Stocking Density (System: Dairying)
png("~/Documents/projects/phd/dairychapter/fig3_5.png", 12.7, 6.35, "cm", res=120)
par(mar=c(2,4,1,1)+0.1)
plot(hist$YEAR[hist$YEAR<2011]
     , hist$DCSDIE[hist$YEAR<2011]
     , type="l"
     , na.rm=T
     , names.arg=hist$YEAR
     , ylab = "L.U.'s per Hectare"
     , xlab=""
     , main=""
     , cex.lab=.8
     , cex.axis=.8
     )
text(2010 
     , hist$DCSDIE[hist$YEAR==2010] -.04
     , signif((hist$DCSDIE[hist$YEAR==2010])
              , digits=3)
     , cex = .6
     )
dev.off()

# Fig 4-8 -- Nominal Creamery Milk Prices (3.7% Fat Content): Ireland 1970-2010
png("~/Documents/projects/phd/dairychapter/fig4_8.png", 12.7, 6.35, "cm", res=120)
par(mar=c(3,4,1,1)+0.1)
var <- "WMPWNIE"
plot(hist$YEAR[hist$YEAR<end]
     , get(var, hist)[hist$YEAR<end]
     , type = "l"
     , na.rm = T
     , names.arg = hist$YEAR
     , ylab = "euro per 100 kg"
     , xlab = " "
     , main =""
     , sub = paste("(",var,")", sep="")
     , cex.lab=.8
     , cex.axis=.8
     )

text(x = c(2009, end-1) 
     , y = get(var, hist)[hist$YEAR==2009 | hist$YEAR==end-1] + c(-1, 1)
     , labels = signif(get(var, hist)[hist$YEAR==2009 | hist$YEAR==end-1]
              , digits=3)
     , cex = .7
     )
dev.off()

# Fig 4-9 -- Creamery Milk Deliveries (mills. litres): Ireland 1975-2010
png("~/Documents/projects/phd/dairychapter/fig4_9.png", 12.7, 6.35, "cm", res=120)
par(mar=c(3,4,1,1)+0.1)
exog$WMSMTIE[hist$YEAR==2010] <- 400
hist$WMUFNIE <- hist$WMUFAIE - exog$WMSMTIE
var <- "WMUFNIE"
plot(hist$YEAR[hist$YEAR<2011]
     , hist$WMUFNIE[hist$YEAR<2011]
     , type = "l"
     , na.rm = T
     , names.arg = hist$YEAR
     , ylab = "million litres"
     , xlab = " "
     , main = ""
     , sub = paste("(",var,")", sep="")
     , cex.lab=.8
     , cex.axis=.8
)

text(x = c(2009, 2010) + c(0, -1)
     , y = get(var, hist)[hist$YEAR==2009 | hist$YEAR==2010] + c(-200, 100)
     , labels = signif(get(var, hist)[hist$YEAR==2009 | hist$YEAR==2010]
                       , digits=3)
     , cex = .7
)
dev.off()

# Fig 4-10 -- Milk Output Per Cow: Ireland 1974-2010
png("~/Documents/projects/phd/dairychapter/fig4_10.png", 12.7, 6.35, "cm", res=120)
par(mar=c(3,4,1,1)+0.1)
var <- "CMYPCIE"
plot(hist$YEAR[hist$YEAR>1974 & hist$YEAR<2011]
          , get(var, hist)[hist$YEAR>1974 & hist$YEAR<2011]
          , type = "l"
          , ylab = "litres per cow per annum"
          , xlab = " "
          , main = ""
          , cex.lab = .8
          , cex.axis= .8
          , ylim=c(2500,5700)
          )

text(x = c(2009, 2010) + c(0, -1)
     , y = get(var, hist)[hist$YEAR==2009 | hist$YEAR==2010] + c(-150, 150)
     , labels = signif(get(var, hist)[hist$YEAR==2009 | hist$YEAR==2010]
                       , digits=3)
     , cex = .7
      )
dev.off()


# Same series as a line plot
# barplot(get(var, hist)[hist$YEAR<end]
#         , ylim = c(2000, 6000)
#         , xpd = F
#         , names.arg=c("","","72/73","","","75/76","","","78/79","","","81/82"," "," ","84/85", " ", " ", "87/88", " ", " ", "90/91", " ", " ", "93/94", " ", " ", "96/97", " ", " ", "99/00", " ", " ", "02/03", " ", " ", "05/06", " ", " ", "08/09", " ", "10/11")
#         , space = .6
#         , col = colors()[214]
#         , axis.lty = 1
#         , las = 2
#         , cex.names = .6
#         , main = ""
#         , sub = paste("(",var,")", sep="")
#         , ylab = "litres per cow per annum"
#         , cex.lab=.8
#         , cex.axis=.8
#         )
# 
# text(65
#      , get(var, hist)[hist$YEAR==end-1] + 200
#      , signif(get(var, hist)[hist$YEAR==end-1]
#               , digits=3)
#      , cex = .6
# )
# dev.off()

# Fig 4-11 -- Number of Dairy Cows (June Enumeration): Ireland 1974-1999
png("~/Documents/projects/phd/dairychapter/fig4_11.png", 12.7, 6.35, "cm", res=120)
par(mar=c(3,4,1,1)+0.1)
var <- "DCJUIE"
barplot(get(var, hist)[hist$YEAR>1994 & hist$YEAR<end]/1000
        , ylim = c(0, 1.8)
        , xpd = F
        , names.arg=c("","","72/73","","","75/76","","","78/79","","","81/82"," "," ","84/85", " ", " ", "87/88", " ", " ", "90/91", " ", " ", "93/94", " ", " ", "96/97", " ", " ", "99/00", " ", " ", "02/03", " ", " ", "05/06", " ", " ", "08/09", " ", "10/11")
        , space = .6
        , col = colors()[214]
        , axis.lty = 1
        , las = 2
        , cex.names = .6
        , main = ""
        , sub = paste("(",var,")", sep="")
        , ylab = "million head"
        , cex.lab=.8
        , cex.axis=.8
)
text(65
     , get(var, hist)[hist$YEAR==end-1]/1000 + .075
     , signif(get(var, hist)[hist$YEAR==end-1]/1000
              , digits=3)
     , cex = .6
)
dev.off()

# Fig 4-12 -- Index of Dairy Production Costs: Ireland 1973 – 2010
png("~/Documents/projects/phd/dairychapter/fig4_12.png", 12.7, 6.35, "cm", res=120)
par(mar=c(3,4,1,1)+0.1)
var <- "WMICIUIE"
plot(hist$YEAR[hist$YEAR<end]
     , get(var, hist)[hist$YEAR<end]
     , type = "l"
     , lwd = 2
     , na.rm = T
     , names.arg = hist$YEAR
     , ylim = c(0, 2)
     , ylab = "Index 1990 = 1"
     , xlab = " "
     , main = ""
     , sub = paste("(",var,")", sep="")
     , cex.lab=.8
     , cex.axis=.8
     )

points(hist$YEAR[hist$YEAR<end]
       , exog$GDPDIE[hist$YEAR<end]
       , type="l"
       , lty=2
       )

legend(1970
       , 1.9
       , c("Index","GDP deflator")
       , lty=1:2
       , lwd=2:1
       , cex= 0.6);

dev.off()

# Fig 4-13 -- Seasonality in Volume of Monthly Milk Collections: Ireland 2011
# The following 6 lines read the latest data from www.cso.ie, then discards
# all but the year defined at the top by the variable "end" 
library(pxR)
MNMKDEL <- as.data.frame(read.px("http://cso.ie/px/pxeirestat/Database/eirestat/Agriculture%20Milk%20Production/AKM01.px"))
MNMKDEL <- MNMKDEL[MNMKDEL$Statistic=="Intake of Cows Milk by Creameries and Pasteurisers (Million Litres)",]
MNMKDEL <- MNMKDEL[MNMKDEL$Domestic.or.Import.Source=="Domestic",]
MNMKDEL$YEAR <- substr(MNMKDEL$Month, 1, 4)
MNMKDEL$Month <- substr(MNMKDEL$Month, 6, 7) 
MNMKDEL <- MNMKDEL[MNMKDEL$YEAR==end,]
# then we plot it
png("~/Documents/projects/phd/dairychapter/fig4_13.png", 12.7, 6.35, "cm", res=120)
par(mar=c(3,4,1,1)+0.1)
barplot(MNMKDEL$dat
        , names.arg= c("Jan", "Feb", "Mar", "Apr","May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
        , space = .6
        , col = colors()[214]
        , axis.lty = 1
        , las = 2
        , cex.names = .6
        , main = ""
        , ylab = "million litres"
        , cex.lab=.8
        , cex.axis=.8
)
dev.off()

# Milk trade balance
png("~/Documents/projects/phd/dairychapter/fig_mktrd.png", 12.7, 6.35, "cm", res=120)
par(mar=c(3,4,1,1)+0.1)
var <- "WMSMTIE"
plot(get(var, exog)[hist$YEAR<end]
        #, ylim = c(0, 1.8)
        #, xpd = F
        #, names.arg=c("","","72/73","","","75/76","","","78/79","","","81/82"," "," ","84/85", " ", " ", "87/88", " ", " ", "90/91", " ", " ", "93/94", " ", " ", "96/97", " ", " ", "99/00", " ", " ", "02/03", " ", " ", "05/06", " ", " ", "08/09", " ", "10/11")
        , main = ""
        , ylab = "1000 tonnes"
        , cex.lab=.8
        , cex.axis=.8
        )
# text(65
#      , get(var, hist)[hist$YEAR==end-1]/1000 + .075
#      , signif(get(var, hist)[hist$YEAR==end-1]/1000
#      , digits=3)
#      , cex = .6
#       )
dev.off()