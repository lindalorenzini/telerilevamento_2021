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

m84c <- unsuperClass(mining84, nClasses=2)
m84c
#unsuperClass results
#*************** Map ******************
#$map
#class      : RasterLayer 
#dimensions : 480, 720, 345600  (nrow, ncol, ncell)
#resolution : 1, 1  (x, y)
#extent     : 0, 720, 0, 480  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : memory
#names      : layer 
#values     : 1, 2  (min, max)
plot(m84c$map)

m12c <- unsuperClass(mining12, nClasses=2)
m12c
#unsuperClass results
#*************** Map ******************
#$map
#class      : RasterLayer 
#dimensions : 480, 720, 345600  (nrow, ncol, ncell)
#resolution : 1, 1  (x, y)
#extent     : 0, 720, 0, 480  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : memory
#names      : layer 
#values     : 1, 2  (min, max)
plot(m12c$map)

freq(m84c$map)
# value  count
#[1,]     1  26623 miniera
#[2,]     2 318977 foresta
sum1 <- 26623 + 318977
sum1
#sum1= [1] 345600
prop1 <- freq(m84c$map) / sum1
prop1
#        value      count
#[1,] 2.893519e-06 0.07703414 miniera 
#[2,] 5.787037e-06 0.92296586 foresta

# 1984-> 92,3% foresta, 7,7% miniera

freq(m12c$map)
# value  count
#[1,]     1  297548 foresta
#[2,]     2 48052 miniera
sum2<-297548 + 48052
sum2
#sum2= 345600
prop2 <- freq(m12c$map) / sum2
prop2
#         value    count
#[1,] 2.893519e-06 0.8609606 foresta 
#[2,] 5.787037e-06 0.1390394 miniera

#2012-> 86,1% foresta, 13,9% miniera

#inseriamo i fattori che sono variabili categoriche, nel nostro caso foresta e zone agricole, inseriamo le percentuali di entrambe le classi, otterremo una tabella a 3 colonne
cover <- c("Forest","Mine")
percent_1984 <- c(92.3, 7.7)
percent_2012 <- c(86.1, 13.9)


#generiamo il dataframe con la funzione data.frame e diamo un nome e infine lo visualizziamo

percentages <- data.frame(cover, percent_1984, percent_2012)
percentages 
#  cover percent_1984 percent_2012
#1 Forest         92.3         86.1
#2   Mine          7.7         13.9

#generiamo un grafico con ggplot, la sintassi è particolare 
ggplot(percentages, aes(x=cover, y=percent_1984, color=cover)) + geom_bar(stat="identity", fill="white")
#ripetismo l'operazione del ggplot per il 2006
ggplot(percentages, aes(x=cover, y=percent_2012, color=cover)) + geom_bar(stat="identity", fill="white")
#associamo i plot generati a un nome
graf1<- ggplot(percentages, aes(x=cover, y=percent_1984, color=cover)) + geom_bar(stat="identity", fill="white")
graf2 <- ggplot(percentages, aes(x=cover, y=percent_2012, color=cover)) + geom_bar(stat="identity", fill="white")
#utilizziamo grid.arrange per unire i ggplot ottenuti occorre avare la library gridExtra, otteniamo così i due grafici delle due annate si può così lavorare sui cambiamenti percentuali nel tempo
grid.arrange(graf1, graf2, nrow=1)





