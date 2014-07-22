sink("test.txt", type=c("output", "message"))
print("Here we go...")
# This script will pull in NFS data and generate descriptive stats for 
# the dairy chapter

rm(list=ls())
# 8409v0.dta is a Stata dataset I've been working with. Using it 
# because it goes back to 84, and I know it has most (all?) of 
# what I'll need for this. Will have to grab the latest year of
# data though. 
#
# library(foreign)
# nfs <- read.dta("~/Data/data_NFSPanelAnalysis/OutData/8409v0.dta")
# library(plm)
# nfs <- pdata.frame(nfs[nfs$farmsys==1,], index = c("cffrmcod", "year"), row.names=T)

# Actually need to move quicker, so I reverted to some data manipulation in Stata

gogm <- data.frame(read.csv("F:/Data/gogm9609.csv"))
summary(gogm)

# Average GO and GM series for dairying on a cpl basis
png("F:/Documents/projects/phd/dairychapter/gogm_nfs.png", 12.7, 9, units="cm", res=120)
par(mar=c(3,4,1,1)+0.1)
plot(dgoli ~ year, data=gogm, type="l", ylim = c(3, 7), xlab="", ylab="cent per litre" )
points(dgmli ~ year, data=gogm, type="l", lty=2)
legend(1996, 3.9,legend=c("Gross Output", "Gross Margin"), lty = c(1,2), cex=.75)
dev.off()

# Variable definitions
# year = year
# fdairygo = dairy gross output per farm in euro
# dgoha = dairy gross output per hecatare in euro
# dgoli = dairy gross outpur per litre in cent
# fdairygm = dairy gross margin per farm in euro
# dgmha = dairy gross margin per hectare in euro
# dgmli = dairy gross margin per litre in cent
# fsizuaa = farm size (Utilisable Agricultural Area) in hectares
# dotomkgl = milk production in gallons
# dotomkli = milk production in litres
print("A little text to prove a point")
sink() 
