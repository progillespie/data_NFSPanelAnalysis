rm(list=ls())
library(foreign)
#*****************************************************
# Directory filepaths
#*****************************************************
paneldir <- "~/Data/data_NFSPanelAnalysis/"
#paneldir <- "/media/MyPassport/Data/data_NFSPanelAnalysis/"
  dodir <- paste(paneldir, "Do_Files/REDP_Book", sep='') 
  outdatadir <- paste(paneldir, "OutData", sep='')
  #outdatadir <- paste(paneldir, "OutData/REDP_Book/DairyChapter", sep='')
  regional.outdatadir <- paste(paneldir, "OutData/RegionalAnalysis", sep='') 
  nfsdatadir <- paste(paneldir, "OutData/nfs_data.dta", sep='')
  origdatadir <- paste(paneldir, "OrigData", sep='') 


intdata <- paste(outdatadir, "/nfs_9508.R", sep='') 
intdata2 <- paste(outdatadir, "/cm_9508.R", sep='') 
intdata3 <- paste(outdatadir, "/cm_9508_ctgrps.R", sep='') 

#*****************************************************
# 2* Set working directory and start logs
#*****************************************************
setwd(dodir)
#log using `outdatadir'/master.log, replace 
#di  "Job  Started  at  $S_TIME  on $S_DATE"

nfs <- read.dta(nfsdatadir)

