# a short Rscript to compare results of SFA estimation using 
# frontier package in R.
rm(list=ls())

datadir <- "/media/MyPassport/Data/projects/phd/softwaretest/"
setwd(datadir)

# before running, ensure that you've saved the xtfrontier1 dataset as a
# csv or dta and saved in this directory
dir()
# if it's not there then use Stata to go get it

# import the data, declare it a panel using plm.data (after loading
# the plm package), and store it in a data table (a faster type of 
# data frame... must load data table package to use) 
library("plm") # <- for panel data
library("data.table")
xt <- data.table(read.csv("xtfrontier1.csv"))
xt <- plm.data(xt, c("id","t"))

# once satisfied that import went ok, load frontier package
library("frontier") # <- for SFA commands

# estimate the models and save the results
# this syntax is analagous to xtfrontier varlist, ti in Stata 12
xt.model.ti <- sfa(lnwidgets ~ lnmachines + lnworkers, xt, truncNorm=T)
# this syntax is analagous to xtfrontier varlist, tvd in Stata 12
xt.model.tvd <- sfa(lnwidgets ~ lnmachines + lnworkers, xt, truncNorm=T, timeEffect=T)
# this syntax gives you Coelli's (1995) method of estimating parameters of an efficiency equation
xt.model.tvd.eef <- sfa(lnwidgets ~ lnmachines + lnworkers| lnmachines, xt, timeEffect=T)

# output is obtained by running summary() on the model objects stored
# above. Can store the summary itself as an object and then write it
# as a file for saving.
xt.summary.ti <- summary(xt.model.ti)
xt.summary.tvd <- summary(xt.model.tvd)
xt.summary.tvd.eef <- summary(xt.model.tvd.eef)
write.csv(xt.summary.ti["mleParam"], "sfa_ti_out_R.csv")
write.csv(xt.summary.tvd["mleParam"], "sfa_tvd_out_R.csv")
write.csv(xt.summary.tvd.eef["mleParam"], "sfa_tvd_eef_out_R.csv")

dir()
xt.summary.ti
xt.summary.tvd
xt.summary.tvd.eef
# inspection of these estimates will show that they are very close to 
# those calculated by Stata for the same specification using this dataset;
# this is the expected behaviour, given that both programs are presumably 
# built on Coelli's Frontier 4.1. 