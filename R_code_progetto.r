# Mountain top mining in Virginia

library(raster)
setwd("C:/lab/mountaintopmining")
mining84<-brick("hobet_19840917.jpg") 
mining88<-brick("hobet_19880827.jpg")
mining92<-brick("hobet_19920806.jpg")
mining96<-brick("hobet_19961004.jpg")
mining00<-brick("hobet_20001015.jpg")
mining04<-brick("hobet_20040706.jpg")
mining08<-brick("hobet_20080818.jpg")
mining12<-brick("hobet_20120920.jpg")
mining84
# ho un raster brick in 3 bande: banda1=hobet_19840917.1, banda2= hobet_19840917.2, banda3= hobet_19840917.3
#voglio, per esempio, plottare solo la banda 1
plot(mining84$hobet_19840917.1)
