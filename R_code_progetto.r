# Mountain top mining in West Virginia

#richiamo le librerie precedentemente installate 
library(raster)
library(rasterVis)
library(RStoolbox)
library(ggplot2)
library(gridExtra)

# stabilisco la working directory con la funzione setwd() che varia da sistema operativo a sistema operativo
# windows
setwd("C:/lab/mountaintopmining")

# importo le immagini rasterbrick con la funzione brick() e le associo a oggetti diversi
mining84<-brick("hobet_19840917.jpg") 
mining96<-brick("hobet_19961004.jpg")
mining04<-brick("hobet_20040706.jpg")
mining12<-brick("hobet_20120920.jpg")

#controllo le informazioni sulle singole immagini rasterbrick
mining84
#class      : RasterBrick 
#dimensions : 480, 720, 345600, 3  (nrow, ncol, ncell, nlayers)
#resolution : 1, 1  (x, y)
#extent     : 0, 720, 0, 480  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : C:/lab/mountaintopmining/hobet_19840917.jpg 
#names      : hobet_19840917.1, hobet_19840917.2, hobet_19840917.3 
#min values :                0,                0,                0 
#max values :              255,              255,              255 

mining96
#class      : RasterBrick 
#dimensions : 480, 720, 345600, 3  (nrow, ncol, ncell, nlayers)
#resolution : 1, 1  (x, y)
#extent     : 0, 720, 0, 480  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : C:/lab/mountaintopmining/hobet_19961004.jpg 
#names      : hobet_19961004.1, hobet_19961004.2, hobet_19961004.3 
#min values :                0,                0,                0 
#max values :              255,              255,              255 

mining04
#class      : RasterBrick 
#dimensions : 480, 720, 345600, 3  (nrow, ncol, ncell, nlayers)
#resolution : 1, 1  (x, y)
#extent     : 0, 720, 0, 480  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : C:/lab/mountaintopmining/hobet_20040706.jpg 
#names      : hobet_20040706.1, hobet_20040706.2, hobet_20040706.3 
#min values :                0,                0,                0 
#max values :              255,              255,              255 

mining12
#class      : RasterBrick 
#dimensions : 480, 720, 345600, 3  (nrow, ncol, ncell, nlayers)
#resolution : 1, 1  (x, y)
#extent     : 0, 720, 0, 480  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : C:/lab/mountaintopmining/hobet_20120920.jpg 
#names      : hobet_20120920.1, hobet_20120920.2, hobet_20120920.3 
#min values :                0,                0,                0 
#max values :              255,              255,              255 

#  dalle info sulle immagini cedo che ho dei raster brick in 3 bande che sono evidenziate dalla voce "names"
# bande mining84: banda1=hobet_19840917.1 , banda2= hobet_19840917.2 , banda3=  hobet_19840917.3.
# bande mining96: banda1= hobet_19961004.1, banda2= hobet_19961004.2, banda3= hobet_19961004.3
# bande mining04: banda1= hobet_20040706.1 , banda2=hobet_20040706.2 , banda3= hobet_20040706.3
# bande mining12: banda1= hobet_20120920.1, banda2= hobet_20120920.2 , banda3= hobet_20120920.3

#voglio, per esempio, plottare solo una banda di una determinata immagine faccio un plot di un'immagine legata con il $ al nome della banda di interesse
#esempio plot in una sola banda:
plot(mining84$hobet_19840917.1)

#per vedere le immagini con i colori della banda del visibile le vado a plottare in RGB
plotRGB(mining84, r=3,g=2,b=1, stretch="Lin")
plotRGB(mining96, r=3,g=2,b=1, stretch="Lin")
plotRGB(mining04, r=3,g=2,b=1, stretch="Lin")
plotRGB(mining12, r=3,g=2,b=1, stretch="Lin")

#dopo aver verificato che le immagini sono visualizzate correttamente vado a fare un multiframe 2x2 con la funzione par()

par(mfrow=c(2,2)) 
plotRGB(mining84, r=3,g=2,b=1, stretch="Lin")
plotRGB(mining96, r=3,g=2,b=1, stretch="Lin")
plotRGB(mining04, r=3,g=2,b=1, stretch="Lin")
plotRGB(mining12, r=3,g=2,b=1, stretch="Lin")

#time series
# nel caso delle timeseries si utilizzano dei file raster per cui importo le immagini non con la funzione brick ma con la funzione raster e anche in questo caso le associo a oggetti diversi
mining84<-raster("hobet_19840917.jpg") 
mining96<-raster("hobet_19961004.jpg")
mining04<-raster("hobet_20040706.jpg")
mining12<-raster("hobet_20120920.jpg")

# per evitare di importare singolarmente i files, creo una lista dei files di interesse 
rlist <- list.files(pattern="hobet")
rlist

# a questo punto importo la lista di files tramite la funzione lapply() che mi permette di applicare una funzione, nel nostro caso la funzione raster, ad una lista di files precedentemente creata, nel nostro caso rlist
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
 
mining96<-brick("hobet_19961004.jpg")
plotRGB(mining96, r=1, g=2, b=3, stretch="lin")
ggRGB(mining96, r=1, g=2, b=3, stretch="lin")
 
mining04<-brick("hobet_20040706.jpg")
plotRGB(mining04, r=1, g=2, b=3, stretch="lin")
ggRGB(mining04, r=1, g=2, b=3, stretch="lin")
 
mining12<-brick("hobet_20120920.jpg")
plotRGB(mining12, r=1, g=2, b=3, stretch="lin")
ggRGB(mining12, r=1, g=2, b=3, stretch="lin")

par(mfrow=c(2,2)) 
plotRGB(mining84, r=1, g=2, b=3, stretch="lin")
plotRGB(mining96, r=1, g=2, b=3, stretch="lin")
plotRGB(mining04, r=1, g=2, b=3, stretch="lin")
plotRGB(mining12, r=1, g=2, b=3, stretch="lin")

picture1 <- ggRGB(mining84, r=1, g=2, b=3, stretch="lin")
picture2 <- ggRGB(mining96, r=1, g=2, b=3, stretch="lin")
picture3 <- ggRGB(mining04, r=1, g=2, b=3, stretch="lin")
picture4 <- ggRGB(mining12, r=1, g=2, b=3, stretch="lin")
grid.arrange(picture1, picture2, picture3, picture4, nrow=2)

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

m96c <- unsuperClass(mining96, nClasses=2)
m96c
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
plot(m96c$map)

m04c <- unsuperClass(mining04, nClasses=2)
m04c
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
plot(m04c$map)

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

freq(m96c$map)
#  value  count
#[1,]     1 298127 foresta
#[2,]     2  47473 miniera
sum2<- 298127 + 47473
sum2
#sum2= 345600
prop2 <- freq(m96c$map) / sum2
prop2
#            value    count
#[1,] 2.893519e-06 0.862636
#[2,] 5.787037e-06 0.137364

# 1996-> 86,3% foresta, 13,7% miniera

freq(m04c$map)
#     value  count
#[1,]     1  34232 miniera
#[2,]     2 311368 foresta

sum3<- 311368+ 34232
sum3
#sum2= 345600
prop3 <- freq(m04c$map) / sum3
prop3
#            value      count
#[1,] 2.893519e-06 0.09905093
#[2,] 5.787037e-06 0.90094907

#2004-> 90,1% foresta, 9,9% miniera

freq(m12c$map)
# value  count
#[1,]     1  297548 foresta
#[2,]     2 48052 miniera
sum4<-297548 + 48052
sum4
#sum2= 345600
prop4 <- freq(m12c$map) / sum4
prop4
#         value    count
#[1,] 2.893519e-06 0.8609606 foresta 
#[2,] 5.787037e-06 0.1390394 miniera

#2012-> 86,1% foresta, 13,9% miniera

#inseriamo i fattori che sono variabili categoriche, nel nostro caso foresta e zone agricole, inseriamo le percentuali di entrambe le classi, otterremo una tabella a 3 colonne
cover <- c("Forest","Mine")
percent_1984 <- c(92.3, 7.7)
percent_1996 <- c(86.3,13.7)
percent_2004 <- c (90.1, 9.9)
percent_2012 <- c(86.1, 13.9)


#generiamo il dataframe con la funzione data.frame e diamo un nome e infine lo visualizziamo

percentages <- data.frame(cover, percent_1984, percent_1996, percent_2004, percent_2012)
percentages 
#        cover percent_1984   percent_1996   percent_2004   percent_2012
#1 Forest         92.3           86.3           90.1           86.1
#2   Mine          7.7           13.7            9.9           13.9

#generiamo i grafici con ggplot, la sintassi è particolare 
ggplot(percentages, aes(x=cover, y=percent_1984, fill=cover)) + geom_bar(stat="identity", color="white")
ggplot(percentages, aes(x=cover, y=percent_1996, fill=cover)) + geom_bar(stat="identity", color="white")
ggplot(percentages, aes(x=cover, y=percent_2004, fill=cover)) + geom_bar(stat="identity", color="white")
ggplot(percentages, aes(x=cover, y=percent_2012, fill=cover)) + geom_bar(stat="identity", color="white")
#associamo i plot generati a un nome
graf1<- ggplot(percentages, aes(x=cover, y=percent_1984, fill=cover)) + geom_bar(stat="identity", color="white")
graf2 <- ggplot(percentages, aes(x=cover, y=percent_1996, fill=cover)) + geom_bar(stat="identity", color="white")
graf3 <- ggplot(percentages, aes(x=cover, y=percent_2004, fill=cover)) + geom_bar(stat="identity", color="white")
graf4 <- ggplot(percentages, aes(x=cover, y=percent_2012, fill=cover)) + geom_bar(stat="identity", color="white")
#utilizziamo grid.arrange per unire i ggplot ottenuti occorre avare la library gridExtra, otteniamo così i due grafici delle due annate si può così lavorare sui cambiamenti percentuali nel tempo
grid.arrange(graf1, graf2, graf3, graf4, nrow=1)





