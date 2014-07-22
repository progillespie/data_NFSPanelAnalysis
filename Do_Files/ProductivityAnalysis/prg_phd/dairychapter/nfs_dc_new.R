sink("test.Rout")
# All graphs pertain to Specialist Dairy
# Per ha = "var"1
# Per LU = "var"2
# Per lt = "var"3

#Set parameters for graphics
library("Hmisc")

# Read in the data and generate variables.
nfs <- read.csv("~/Data/nfs_yr2010.csv", header=T)

nfs$doslcmvl <- nfs$doslcmgl*nfs$p_doslcm
#nfs$othergm <- nfs$fdairygm - nfs$doslcmvl - nfs$dosllmvl - nfs$domkfdvl
nfs$doslcmvl_ha <- nfs$doslcmgl_ha*nfs$p_doslcm
nfs$dosllmvl_ha <- nfs$dosllmgl_ha*nfs$p_dosllm
nfs$domkfdvl_ha <- nfs$domkfdgl_ha*nfs$p_domkfd
nfs$docftfvl <- nfs$docftfno*nfs$p_docftfvl
nfs$docftfvl_ha <- nfs$docftfvl/nfs$daforare
nfs$docfslvl <- nfs$docfslno*nfs$p_docfslvl
nfs$docfslvl_ha <- nfs$docfslvl/nfs$daforare
nfs$doschbvl_ha <- nfs$doschbvl/nfs$daforare
nfs$dotochbvl <- nfs$dotochbn*nfs$p_dotochbv
nfs$dotochbvl_ha <- nfs$dotochbvl/nfs$daforare
nfs$dovlcnod_ha <- nfs$dovlcnod/nfs$daforare
nfs$othergm_ha <- nfs$fdairygm_ha - nfs$doslcmvl_ha - nfs$dosllmvl_ha - nfs$domkfdvl_ha
gmhacomp <- data.frame(cbind(nfs$doslcmvl_ha, nfs$dosllmvl_ha, nfs$domkfdvl_ha, nfs$othergm_ha))

#---------------------------------------------------------------------------------------#
#Yields and Stocking density -----------------------------------------------------------#
ps.options(family="serif", width=5, height=2.55, pointsize=12 )
pdf.options(family="serif", width=5, height=2.55, pointsize=12 )

cairo_pdf("~/Documents/projects/phd/dairychapter/fig/dpnolu_ha.pdf", family="serif", width=5, height=2.55, pointsize=12)
par(mar=c(3,4,1,1)+0.1+0.1)
plot(dpnolu/daforare ~ year, nfs
     , type="l"
     , lwd=1.5
     , xlab=""
     , ylab="Avg no. LU per ha"
     , cex.lab = .8
     , cex.axis = .6
     , bty="l"
     , las=1
)
minor.tick(nx=5, tick.ratio=.6)
dev.off()

cairo_ps("~/Documents/projects/phd/dairychapter/fig/dpnolu_ha_c.eps", family="serif", width=5, height=2.55, pointsize=12)
par(mar=c(3,4,1,1)+0.1)
plot(dpnolu/daforare ~ year, nfs
     , type="l"
     , lwd=1.5
     , xlab=""
     , ylab="Avg no. LU per ha"
     , cex.lab = .8
     , cex.axis = .6
     , bty="l"
)
minor.tick(nx=5, tick.ratio=.6)
dev.off()


# pdf("~/Documents/projects/phd/dairychapter/fig/dpnolu_ha.pdf", family="serif", width=5, height=2.55, paper="a4", pointsize=12 )
par(mar=c(3,4,1,1)+0.1)
plot(dpnolu/daforare ~ year, nfs
     , type="l"
     , lwd=1.5
     , xlab=""
     , ylab="Avg no. LU per ha"
     , cex.lab = .8
     , cex.axis = .8
     , bty ="l" 
)
minor.tick(nx=5, tick.ratio=.6)
dev.off()

#cairo_pdf("~/Documents/projects/phd/dairychapter/fig/dpnolu_ha_c.pdf", family="serif", width=5, height=2.55, pointsize=12 )
par(mar=c(3,4,1,1)+0.1)
plot(dpnolu/daforare ~ year, nfs
     , type="l"
     , lwd=1.5
     , xlab=""
     , ylab="Avg no. LU per ha"
     , cex.lab = .8
     , cex.axis = .8
     , bty="l"
)
minor.tick(nx=5, tick.ratio=.6)
dev.off()

cairo_ps("~/Documents/projects/phd/dairychapter/fig/dpnolu_ha.eps", family="serif", width=5, height=2.55,  pointsize=12 )
par(mar=c(3,4,1,1)+0.1)
plot(dpnolu/daforare ~ year, nfs
     , type="l"
     , lwd=1.5
     , xlab=""
     , ylab="Avg no. LU per ha"
     , cex.lab = .8
     , cex.axis = .8
     , bty="l"
)
minor.tick(nx=5, tick.ratio=.6)
dev.off()

cairo_ps("~/Documents/projects/phd/dairychapter/fig/dpnolu_ha.eps", family="serif",width=5, height=2.55,  pointsize=12 )
par(mar=c(3,4,1,1)+0.1)
plot(dpnolu/daforare ~ year, nfs
     , type="l"
     , lwd=1.5
     , xlab=""
     , ylab="Avg no. LU per ha"
     , cex.lab = .8
     , cex.axis = .8
     , bty="l"
     )
minor.tick(nx=5, tick.ratio=.6)
dev.off()

cairo_ps("~/Documents/projects/phd/dairychapter/fig/lt_lu.eps", family="serif",width=5, height=2.55,  pointsize=12 )
par(mar=c(3,4,1,1)+0.1)
plot(doslcmgl/dpnolu ~ year, nfs
     , type="l"
     , lwd=1.5
     , xlab=""
     , ylab="Avg litres per LU"
     , cex.lab = .8
     , cex.axis = .8
     , bty="l"
)
minor.tick(nx=5, tick.ratio=.6)
dev.off()

#---------------------------------------------------------------------------------------#
# Gross output -------------------------------------------------------------------------#

# Per Farm
cairo_ps("~/Documents/projects/phd/dairychapter/fig/fdairygo.eps", family="serif",width=5, height=2.55,  pointsize=12 )
par(mar=c(3,4,1,1)+0.1)
plot(fdairygo ~ year, nfs
     , type="l"
     , lwd=1.5
     , xlab=""
     , ylab="Euro per farm"
     , ylim=c(20000,85000)
     , cex.lab = .8
     , cex.axis = .8
     , bty="l"
)
points(doslcmvl ~ year, nfs
        , type="l"
        , lwd = 1.5
        , lty = 2
)
legend(1995, 80000
       ,legend=c("Gross Output", "Value of Creamery Milk Deliveries")
       , lty = c(1,2)
       , cex=.75
)
minor.tick(nx=5, tick.ratio=.6)
dev.off()



# Per hectare
cairo_ps("~/Documents/projects/phd/dairychapter/fig/fdairygo_ha.eps", family="serif",width=5, height=2.55,  pointsize=12 )
par(mar=c(3,4,1,1)+0.1)
plot(fdairygo_ha ~ year, nfs
     , type="l"
     , lwd=1.5
     , xlab=""
     , ylab="Euro per hectare"
     , ylim=c(0,3500)
     , cex.lab = .8
     , cex.axis = .8
     , bty="l"
)
points(doslcmvl/daforare ~ year, nfs
       , type="l"
       , lwd = 1.5
       , lty = 2
)
legend(2000, 1500
      ,legend=c("Gross Output", "Value of Creamery Milk Deliveries")
      , lty = c(1,2)
      , cex=.7
)
minor.tick(nx=5, tick.ratio=.6)
dev.off()



# Per livestock unit
cairo_ps("~/Documents/projects/phd/dairychapter/fig/fdairygo_lu.eps", family="serif",width=5, height=2.55,  pointsize=12 )
par(mar=c(3,4,1,1)+0.1)
plot(fdairygo_lu ~ year, nfs
     , type="l"
     , lwd=1.5
     , xlab=""
     , ylab="Euro per LU"
     , ylim=c(0, 2000)
     , cex.lab = .8
     , cex.axis = .8
     , bty="l"
)
points(doslcmvl/dpnolu ~ year, nfs
       , type="l"
       , lwd = 1.5
       , lty = 2
)
legend(2000, 600
       ,legend=c("Gross Output", "Value of Creamery Milk Deliveries")
       , lty = c(1,2)
       , cex=.7
       )
minor.tick(nx=5, tick.ratio=.6)
dev.off()



# Per litre
cairo_ps("~/Documents/projects/phd/dairychapter/fig/fdairygo_lt.eps", family="serif",width=5, height=2.55,  pointsize=12 )
par(mar=c(3,4,1,1)+0.1)
plot(fdairygo_lt ~ year, nfs
     , type="l"
     , lwd=1.5
     , xlab=""
     , ylab="Euro per litre"
     , ylim=c(0.2, 0.4)
     , cex.lab = .8
     , cex.axis = .8
     , bty="l"
)
points(doslcmvl/doslcmgl ~ year, nfs
       , type="l"
       , lwd = 1.5
       , lty = 2
)
legend(1998, 0.25
      ,legend=c("Gross Output", "Value of Creamery Milk Deliveries")
      , lty = c(1,2)
      , cex=.7
       )
minor.tick(nx=5, tick.ratio=.6)
dev.off()

# Gross Margin and Direct Costs

# Per farm
cairo_ps("~/Documents/projects/phd/dairychapter/fig/fdairygm.eps", family="serif",width=5, height=2.55,  pointsize=12 )
par(mar=c(3,4,1,1)+0.1)
plot(fdairygm ~ year, nfs
     , type="l"
     , lwd=1.5
     , xlab=""
     , ylab="Euro per farm"
     , ylim=c(0, 55000)
     , cex.lab = .8
     , cex.axis = .8
     , bty="l"
)
points(fdairydc ~ year, nfs
       , type="l"
       , lwd = 1.5
       , lty = 2
)
legend(1995, 52000
       ,legend=c("Gross Margin", "Direct Costs")
       , lty = c(1,2)
       , cex=.7
       )
minor.tick(nx=5, tick.ratio=.6)
dev.off()

# Per hectare
cairo_ps("~/Documents/projects/phd/dairychapter/fig/fdairygm_ha.eps", family="serif",width=5, height=2.55,  pointsize=12 )
par(mar=c(3,4,1,1)+0.1)
plot(fdairygm_ha ~ year, nfs
     , type="l"
     , lwd=1.5
     , xlab=""
     , ylab="Euro per hectare"
     , ylim=c(0, 2200)
     , cex.lab = .8
     , cex.axis = .8
     , bty="l"
)
points(fdairydc_ha ~ year, nfs
       , type="l"
       , lwd = 1.5
       , lty = 2
)
legend(1995, 600
       ,legend=c("Gross Margin", "Direct Costs")
       , lty = c(1,2)
       , cex=.7
       )
minor.tick(nx=5, tick.ratio=.6)
dev.off()



# Per livestock unit
cairo_ps("~/Documents/projects/phd/dairychapter/fig/fdairygm_lu.eps", family="serif",width=5, height=2.55,  pointsize=12 )
par(mar=c(3,4,1,1)+0.1)
plot(fdairygm_lu ~ year, nfs
     , type="l"
     , lwd=1.5
     , xlab=""
     , ylab="Euro per LU"
     , ylim=c(0, 1200)
     , cex.lab = .8
     , cex.axis = .8
     , bty="l"
)
points(fdairydc_lu ~ year, nfs
       , type="l"
       , lwd = 1.5
       , lty = 2
)
legend(1995, 300
       ,legend=c("Gross Margin", "Direct Costs")
       , lty = c(1,2)
       , cex=.7
       )
minor.tick(nx=5, tick.ratio=.6)
dev.off()

# Per litre
cairo_ps("~/Documents/projects/phd/dairychapter/fig/fdairygm_lt.eps", family="serif",width=5, height=2.55,  pointsize=12 )
par(mar=c(3,4,1,1)+0.1)
plot(fdairygm_lt ~ year, nfs
     , type="l"
     , lwd=1.5
     , xlab=""
     , ylab="Euro per litre"
     , ylim=c(0, 0.4)
     , cex.lab = .8
     , cex.axis = .8
     , bty="l"
)
points(fdairydc_lt ~ year, nfs
       , type="l"
       , lwd = 1.5
       , lty = 2
)
legend(1995, 0.37
       ,legend=c("Gross Margin", "Direct Costs")
       , lty = c(1,2)
       , cex=.7
       )
minor.tick(nx=5, tick.ratio=.6)
dev.off()



# #---------------------------------------------------------------------------------------#
# # Costs --------------------------------------------------------------------------------#
# cairo_ps("~/Documents/projects/phd/dairychapter/GO_ha.png",width=5, 10 , units = "cm", pointsize=12 )
# par(mar=c(3,4,1,1)+0.1)
# plot(GO_ha ~ year, nfs
#      , type="l"
#      , lwd=1.5
#      , xlab=""
#      , ylab="Euro per hectare"
#      , cex.lab = .8
#      , cex.axis = .8
# )
# minor.tick(nx=5, tick.ratio=.6)
# dev.off()
# 
# cairo_ps("~/Documents/projects/phd/dairychapter/GO_lu.png",width=5, 10 , units = "cm", pointsize=12 )
# par(mar=c(3,4,1,1)+0.1)
# plot(GO_lu ~ year, nfs
#      , type="l"
#      , lwd=1.5
#      , xlab=""
#      , ylab="Euro per LU"
#      , cex.lab = .8
#      , cex.axis = .8
# )
#minor.tick(nx=5, tick.ratio=.6)
# dev.off()
# 
# 
# #--Decomp of Costs --#
# 
# 
# 
# 
# 
# #---------------------------------------------------------------------------------------#
# # Gross Margin -------------------------------------------------------------------------#
# 
# cairo_ps("~/Documents/projects/phd/dairychapter/GO_lt.eps",width=5, 10 , units = "cm", pointsize=12 )
# par(mar=c(3,4,1,1)+0.1)
# plot(GO_lt ~ year, nfs
#      , type="l"
#      , lwd=1.5
#      , xlab=""
#      , ylab="Euro per litre"
#      , cex.lab = .8
#      , cex.axis = .8
# )
#minor.tick(nx=5, tick.ratio=.6)
# dev.off()
sink()
