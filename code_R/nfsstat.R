# All graphs pertain to Specialist Dairy
nfs <- read.csv("~/Data/nfsstat7609.csv")
View(names(nfs))

# Gross output per ha (unadjusted)
png("~/Documents/projects/phd/dairychapter/gogmdc_ha.png", 12.7, 10 , units = "cm", res=120)
par(mar=c(3,4,1,1))
plot(farmgo/fsizunha ~ year, nfs
     , type="l"
     , xlab=""
     , ylab="Euro per hectare"
     , cex.lab = .8
     , cex.axis = .8
     )

points(farmgm/fsizunha ~ year, nfs
     , type="l"
     , lty=2
     )

points(farmffi/fsizunha ~ year, nfs
       , type = "l"
       , lty = 1
       , lwd = 2
       )

legend(1976, 1100
        , legend=c("Gross Output", "Gross Margin", "Fam. Farm Inc.")
        , lty = c(1,2,1)
        , lwd = c(1,1,2)
        , cex = .7
        )
dev.off()

rm(list=ls())
nfs <- data.frame(read.csv("~/Data/data_NFSPanelAnalysis/OutData/9609v2.csv"), row.names=NULL)

# Per hectare GO and GM for Dairy operations on Dairy Farms 
nfs$dgoha <- nfs$farmgo/nfs$fsizunha
nfs$dgmha <- nfs$fdairygm/nfs$fsizunha

# Convert gallons to litres
nfs$dotomkli <- nfs$dotomkgl*4.54609

# CPL Dairy GO,GM and whole farm costs (Direct and Overhead) for Dairy Farms
nfs$dgoli <- (nfs$fdairygo/nfs$dotomkli)*100
nfs$dgmli <- (nfs$fdairygm/nfs$dotomkli)*100
nfs$fdcli <- (nfs$farmdc/nfs$dotomkli)*100
nfs$fohli <- (nfs$farmohct/nfs$dotomkli)*100
nfs$totalct <- nfs$farmdc + nfs$farmohct
nfs$ftoli <- (nfs$totalct/nfs$dotomkli)*100


# daforare = Forage area (acs)
# There are 0.404686 ha per acre
nfs$daforare <- nfs$daforare*0.404686
mn.daforare <- tapply(nfs$daforare
                      , nfs$year
                      , function(i, x=nfs$daforare, w=nfs$w) weighted.mean(x[i],w[i])
                      )

png("~/Documents/projects/phd/dairychapter/fig_daforare.png", 12.7, 6.35, units="cm", res=120)
par(mar=c(3,4,1,1))
plot(mn.daforare
     , type="l"
     , xlab=""
     , ylab="hectares"
     , cex = .8
     , xaxt = "n"
     )

axis(1, at = 1:14, labels=row.names(mn.daforare))
dev.off()
