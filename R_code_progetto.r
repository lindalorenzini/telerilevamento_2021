# Mountain top mining in West Virginia

library(raster)
library(rasterVis)
setwd("C:/lab/mountaintopmining")
mining84<-brick("hobet_19840917.jpg") 
mining96<-brick("hobet_19961004.jpg")
mining04<-brick("hobet_20040706.jpg")
mining12<-brick("hobet_20120920.jpg")
#controllo le informazioni sulle singole immagini rasterbrick
mining84
mining96
mining04
mining12
# mining84: ho un raster brick in 3 bande (banda1=hobet_19840917.1, banda2= hobet_19840917.2, banda3= hobet_19840917.3)
#voglio, per esempio, plottare solo la banda 1
plot(mining84$hobet_19840917.1)
#per vedere le immagini con i colori della banda del visibile le vado a plottare in RGB
plotRGB(mining84, r=3,g=2,b=1, stretch="Lin")
plotRGB(mining96, r=3,g=2,b=1, stretch="Lin")
plotRGB(mining04, r=3,g=2,b=1, stretch="Lin")
plotRGB(mining12, r=3,g=2,b=1, stretch="Lin")
#dopo aver verificato che le immagini sono visualizzate correttamente vado a fare un multiframe 2x2
par(mfrow=c(2,2)) 
plotRGB(mining84, r=3,g=2,b=1, stretch="Lin")
plotRGB(mining96, r=3,g=2,b=1, stretch="Lin")
plotRGB(mining04, r=3,g=2,b=1, stretch="Lin")
plotRGB(mining12, r=3,g=2,b=1, stretch="Lin")
#time series
mining84<-raster("hobet_19840917.jpg") 
mining96<-raster("hobet_19961004.jpg")
mining04<-raster("hobet_20040706.jpg")
mining12<-raster("hobet_20120920.jpg")
rlist <- list.files(pattern="hobet")
rlist
import <- lapply(rlist,raster)
import
TGr <- stack(import)
plot(TGr)
levelplot(TGr)
levelplot(TGr$hobet_19840917)
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
levelplot(TGr, col.regions=cl)
levelplot(TGr,col.regions=cl, names.attr=c("1984","1996", "2004", "2012"))
levelplot(TGr,col.regions=cl, main="Hobet coal mine (West Virginia) development",names.attr=c("1984","1996", "2004", "2012"))

#land cover: differenze tra 1984 e 2012
library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)
setwd("C:/lab/mountaintopmining")

mining84<-brick("hobet_19840917.jpg") 
plotRGB(mining84, r=1, g=2, b=3, stretch="lin")
ggRGB(mining84, r=1, g=2, b=3, stretch="lin")

mining12<-brick("hobet_20120920.jpg")
plotRGB(mining12, r=1, g=2, b=3, stretch="lin")
ggRGB(mining12, r=1, g=2, b=3, stretch="lin")

par(mfrow=c(2,1)) 
plotRGB(mining84, r=1, g=2, b=3, stretch="lin")
plotRGB(mining12, r=1, g=2, b=3, stretch="lin")

picture1 <- ggRGB(mining84, r=1, g=2, b=3, stretch="lin")
picture2 <- ggRGB(mining12, r=1, g=2, b=3, stretch="lin")
grid.arrange(picture1, picture2, nrow=2)



