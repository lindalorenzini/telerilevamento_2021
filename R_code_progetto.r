# Mountain top mining in West Virginia

library(raster)
setwd("C:/lab/mountaintop")
mining84<-brick("hobet_19840917.jpg") 
mining96<-brick("hobet_19961004.jpg")
mining04<-brick("hobet_20040706.jpg")
mining12<-brick("hobet_20120920.jpg")
#controllo le informazioni sulle singole immagini rasterbrick
mining84
mining96
mining04
mining12
# ho un raster brick in 3 bande: banda1=hobet_19840917.1, banda2= hobet_19840917.2, banda3= hobet_19840917.3
#voglio, per esempio, plottare solo la banda 1
plot(mining84$hobet_19840917.1)
#per vedere le immagini con i colori della banda del visibile le vado a plottare in RGB
plotRGB(mining84, r=3,g=2,b=1, stretch="Lin")
plotRGB(mining96, r=3,g=2,b=1, stretch="Lin")
plotRGB(mining04, r=3,g=2,b=1, stretch="Lin")
plotRGB(mining12, r=3,g=2,b=1, stretch="Lin")
#dopo aver verificato che le immagini sono visualizzate vado a fare un multiframe 2x2
par(mfrow=c(4,1)) 
plotRGB(mining84, r=3,g=2,b=1, stretch="Lin")
plotRGB(mining96, r=3,g=2,b=1, stretch="Lin")
plotRGB(mining04, r=3,g=2,b=1, stretch="Lin")
plotRGB(mining12, r=3,g=2,b=1, stretch="Lin")


library(raster)
setwd("C:/lab/alluvioni")
giugno<-brick("weuropeflooding_oli_2021167.jpg")
giugno
plotRGB(giugno, r=3,g=2,b=1, stretch="Lin")
