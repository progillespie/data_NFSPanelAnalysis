# clear all objects from the workspace
rm(list=ls())

# load the required libraries (R packages... sets of commands you can use)
library(foreign) # used here for the ability to read .dta files
library(data.table) # very useful for big datasets (makes manipulation quicker & easier)

#------------------------------------------------------------#
# Set up
#------------------------------------------------------------#
# Directory Structure -- Set up file paths

# first and foremost, specify the project's 'root directory'
paneldir <- "/media/MyPassport/Data/data_FADNPanelAnalysis/"
#paneldir <- "~/Data/data_NFSPanelAnalysis/"

source(paste(paneldir, "code_R/dirstruct.R", sep='') 

# Now that dirstruct.R has created the rest of the filepaths in the directory structure
# change directory to where all the R code is
setwd(Rdir) # set working directory - see what it is with getwd()

# read the Stata dataset into an object (it will be a data frame class of object)...
nfs <- read.dta(paste(nfsdatadir, "nfs_data.dta", sep=''))
       # NOTE: read.dta() needs a filepath, but I've opted not to hardcode it (i.e. just type it in), but I instead
       #  store parts of the filepath as ojects themselves and then paste() on the last bit as appropriate. We've
       #  used macros in Stata to accomplish the same thing, and the effect is you only have to specify the correct
       #  'project root' once. All other filepaths are relative to paneldir
       
       
# reclassify the object as data.table (a new type of data.frame object which is easier to use)
nfs <- data.table(nfs)
setkey(nfs, farmcode, year)
       
       # if you wanted to, you can save/load in R data format using the following
       #save(nfs, file=paste(outdatadir, "nfs_data.R", sep=''))
       #load(paste(outdatadir, "nfs_data.R", sep=''))
       
       # but it's probably just as handy to save in Stata formatted files using
       #write.dta()

# Project specific files with complete filepaths specified. You can simply give these objects to the 
# save/write.dta command. Second argument of paste() is the filename you save the file as. 
intdata <- paste(outdatadir, "test", sep='') 
#intdata2 <- paste(outdatadir, "", sep='') 
#intdata3 <- paste(outdatadir, "", sep='') 
# etc....

# so for example, if i create some data
test <- data.frame(x=c(1:10), y=c(10:1), row.names=NULL)
# this saves that object as a .dta in your outdatadir with the filename you chose
write.dta(test, intdata)
# which you can then read back in...
read.dta(intdata)
# but note that it's just screen output until I store it in an object...

       
#------------------------------------------------------------#
#------------------------------------------------------------#

#*****************************************************
#* 3* Merge in weights
#*****************************************************
regional.weights <- read.dta(paste(regional.outdatadir, "regional_weights.dta", sep=''))
   
# there is a merge() command in R, 
#nfs <- merge(nfs, regional.weights, by=c("farmcode", "year"))
       
# but the data.tables package provides the := operator which is quicker
nfs[, rweight:=regional.weights$rweight, by=list(farmcode, year)]
       
# for the sake of computing efficiency, you should remove objects you don't need anymore using rm()...
rm(regional.weights)
       
       
# because we have a data.table we can use this object class' improved subsetting capabilities
# to create the R equivalent of Stata's <tabstat wt region, by(year)> with
nfs[, list(mean(wt), mean(region)), by=year]
# and it's just as easy with any function or expression in the middle term, e.g. weighted mean
nfs[, list(weighted.mean(wt, wt), weighted.mean(region, wt)), by=year]
# ... although that makes no sense here.
       
       
# This is admittedly a few more keystrokes than <tabstat wt region, by(year)>, but this is an example
# of doing things "the Stata way" inside of R (bad idea). Do it the R way instead, i.e. create a new object which is
# the collapsed dataset. Again, using the <data.table> package...
       
nfs.yr <- nfs[,lapply(.SD, mean), by=year]
viewData(nfs.yr)
       # NOTE: .SD is a symbol meaning Subset of Data Table. It's a shortcut for 
       # avoiding long lists of column names for that second term (j term in the package's terminology)
       
       
# You now have both the collapsed, and the uncollapsed data in memory simultaneously! In Stata you can only hold
# one dataset in memory at a time, which means a lot of loading and saving. In R, you just reference the object
# you want.
       
       
# That collapsed table is very handy for generating descriptives! We can even save keystrokes by 'attaching' 
# the collapsed data.
       
attach(nfs.yr) # When attached, we don't have to write nfs.yr$ before varnames
plot(year, fsizuaa
     , type="l"
     , lwd=2
     , ylim=c(0,75)
     , ylab="mean hectares per farm")
       
# ... it's  easy to overlay another series on the graph...
points(year, daforare
       , type="l"
       , lwd=1 )
detach(nfs.yr) # Can only attach one object at a time, so detach() when done
       
       ## attach() and detach() just alter R's "focus". All objects remain in memory the whole time, 
       ## and you can still manipulate any object by specifying its name before varname, e.g. nfs$year