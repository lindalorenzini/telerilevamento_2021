# Mountain top mining in West Virginia

library(raster)
setwd("C:/lab/mountaintopmining")
mining84<-brick("hobet_19840917.jpg") 
mining96<-brick("hobet_19961004.jpg")
mining04<-brick("hobet_20040706.jpg")
mining12<-brick("hobet_20120920.jpg")
mining84
# ho un raster brick in 3 bande: banda1=hobet_19840917.1, banda2= hobet_19840917.2, banda3= hobet_19840917.3
#voglio, per esempio, plottare solo la banda 1
plot(mining84$hobet_19840917.1)
