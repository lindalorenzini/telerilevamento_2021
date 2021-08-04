# Mountain top mining in West Virginia

#immagini prese da https://earthobservatory.nasa.gov/world-of-change/Hobet

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

#  dalle info sulle immagini vedo che ho dei raster brick in 3 bande che sono evidenziate dalla voce "names"
# bande mining84: banda1=hobet_19840917.1 , banda2= hobet_19840917.2 , banda3=  hobet_19840917.3.
# bande mining96: banda1= hobet_19961004.1, banda2= hobet_19961004.2, banda3= hobet_19961004.3
# bande mining04: banda1= hobet_20040706.1 , banda2=hobet_20040706.2 , banda3= hobet_20040706.3
# bande mining12: banda1= hobet_20120920.1, banda2= hobet_20120920.2 , banda3= hobet_20120920.3

#per vedere le immagini con i colori della banda del visibile le vado a plottare in RGB
# R = red, G = green, B = blue
# associo ognuno dei 3 colori alle diverse bande della mia immagine (r=1, g=2, b=3) e scelgo il tipo di stretch (stretch= "Lin")
plotRGB(mining84, r=1,g=2,b=3, stretch="Lin")
plotRGB(mining96, r=1,g=2,b=3, stretch="Lin")
plotRGB(mining04, r=1,g=2,b=3, stretch="Lin")
plotRGB(mining12, r=1,g=2,b=3, stretch="Lin")

#dopo aver verificato che le immagini sono visualizzate correttamente vado a fare un multiframe 2x2 con la funzione par()
par(mfrow=c(2,2)) 
plotRGB(mining84, r=1,g=2,b=3, stretch="Lin")
plotRGB(mining96, r=1,g=2,b=3, stretch="Lin")
plotRGB(mining04, r=1,g=2,b=3, stretch="Lin")
plotRGB(mining12, r=1,g=2,b=3, stretch="Lin")

#salvo l'immagine ottenuta con la funzione pdf()
pdf("plotRGB.pdf")
par(mfrow=c(2,2)) 
plotRGB(mining84, r=1,g=2,b=3, stretch="Lin")
plotRGB(mining96, r=1,g=2,b=3, stretch="Lin")
plotRGB(mining04, r=1,g=2,b=3, stretch="Lin")
plotRGB(mining12, r=1,g=2,b=3, stretch="Lin")
dev.off()

#time series

# per evitare di importare singolarmente i files, creo una lista dei files di interesse e li associo ad un oggetto (rlist) per facilitare le funzioni successive 
rlist <- list.files(pattern="hobet")
rlist
#[1] "hobet_19840917.jpg" "hobet_19961004.jpg" "hobet_20040706.jpg"
#[4] "hobet_20120920.jpg"

# a questo punto importo la lista di files tramite la funzione lapply() che mi permette di applicare una funzione, nel nostro caso la funzione raster, ad una lista di files precedentemente creata, nel nostro caso rlist
import <- lapply(rlist,raster)
import

# hmd =  hobet mine development
# funzione stack permette di concatenare diversi vettori a formarne uno unico
hmd <- stack(import)
plot(hmd)

levelplot(hmd)
levelplot(hmd$hobet_19840917)

#cambio la colorRampPalette in modo da identificare meglio le zone di differenziazione 
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
# nel levelplot le parti tendenti al rosso andranno ad identificare le parti di suolo nudo rappresentati dalla miniera, l'azzurro invece identifica le zone di copertura vegetale 
levelplot(hmd,col.regions=cl, main="Hobet coal mine (West Virginia) development",names.attr=c("1984","1996", "2004", "2012"))

#salvo l'immagine risultante dalla time series come pdf 
pdf("timeseries1894_2012.pdf")
levelplot(hmd,col.regions=cl, main="Hobet coal mine (West Virginia) development",names.attr=c("1984","1996", "2004", "2012"))
dev.off()


#land cover: differenze tra 1984 e 2012
library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)
setwd("C:/lab/mountaintopmining")
mining84<-brick("hobet_19840917.jpg") 
mining96<-brick("hobet_19961004.jpg")
mining04<-brick("hobet_20040706.jpg")
mining12<-brick("hobet_20120920.jpg")

picture1 <- ggRGB(mining84, r=1, g=2, b=3, stretch="lin")
picture2 <- ggRGB(mining96, r=1, g=2, b=3, stretch="lin")
picture3 <- ggRGB(mining04, r=1, g=2, b=3, stretch="lin")
picture4 <- ggRGB(mining12, r=1, g=2, b=3, stretch="lin")
grid.arrange(picture1, picture2, picture3, picture4, nrow=2)

# funzione set.seed(): fissa i valori da attribuire ai pixel  
set.seed(1)
# funzione rnorm(): normalizza i valori dei pixel fissando la classe scelta
rnorm(1)

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

set.seed(1)
rnorm(1)
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

set.seed(1)
rnorm(1)
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

set.seed(1)
rnorm(1)
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

pdf("unsuperclass_2x2.pdf")
par(mfrow=c(2,2))
plot(m84c$map)
plot(m96c$map)
plot(m04c$map)
plot(m12c$map)
dev.off()

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
#[1,]     1  47473 miniera
#[2,]     2 298127 foresta
sum2<- 298127 + 47473
sum2
#sum2= 345600
prop2 <- freq(m96c$map) / sum2
prop2
#            value    count
#[1,] 5.787037e-06 0.137364 miniera
#[2,] 2.893519e-06 0.862636 foresta

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
#[1,] 2.893519e-06 0.09905093 miniera
#[2,] 5.787037e-06 0.90094907 foresta

#2004-> 90,1% foresta, 9,9% miniera

freq(m12c$map)
# value  count
#[1,]     1 48052 miniera
#[2,]     2  297548 foresta

sum4<-297548 + 48052
sum4
#sum2= 345600
prop4 <- freq(m12c$map) / sum4
prop4
#         value    count
#[1,] 5.787037e-06 0.1390394 miniera
#[2,] 2.893519e-06 0.8609606 foresta 

#2012-> 86,1% foresta, 13,9% miniera

#inseriamo i fattori che sono variabili categoriche, nel nostro caso foresta e miniera, inseriamo le percentuali di entrambe le classi, otterremo una tabella a 3 colonne
cover <- c("Forest","Mine")
percent_1984 <- c(92.3, 7.7)
percent_1996 <- c(86.3,13.7)
percent_2004 <- c (90.1, 9.9)
percent_2012 <- c(86.1, 13.9)

#generiamo il dataframe con la funzione data.frame e diamo un nome e infine lo visualizziamo
percentages <- data.frame(cover, percent_1984, percent_1996, percent_2004, percent_2012)
percentages 
#    cover        percent_1984   percent_1996   percent_2004   percent_2012
#1   Forest         92.3           86.3           90.1           86.1
#2   Mine            7.7           13.7            9.9           13.9

#generiamo i grafici con ggplot 
ggplot(percentages, aes(x=cover, y=percent_1984, fill=cover)) + geom_bar(stat="identity", color="white")
ggplot(percentages, aes(x=cover, y=percent_1996, fill=cover)) + geom_bar(stat="identity", color="white")
ggplot(percentages, aes(x=cover, y=percent_2004, fill=cover)) + geom_bar(stat="identity", color="white")
ggplot(percentages, aes(x=cover, y=percent_2012, fill=cover)) + geom_bar(stat="identity", color="white")

#associamo i plot generati a un nome
graf1<- ggplot(percentages, aes(x=cover, y=percent_1984, fill=cover)) + geom_bar(stat="identity", color="white")
graf2 <- ggplot(percentages, aes(x=cover, y=percent_1996, fill=cover)) + geom_bar(stat="identity", color="white")
graf3 <- ggplot(percentages, aes(x=cover, y=percent_2004, fill=cover)) + geom_bar(stat="identity", color="white")
graf4 <- ggplot(percentages, aes(x=cover, y=percent_2012, fill=cover)) + geom_bar(stat="identity", color="white")

#utilizziamo grid.arrange per unire i ggplot ottenuti, occorre avere la library gridExtra, otteniamo così i 4 grafici delle 4 annate per analizzare i cambiamenti percentuali nel tempo
grid.arrange(graf1, graf2, graf3, graf4, nrow=1)

pdf("graficiggplot_vers1.pdf")
grid.arrange(graf1, graf2, graf3, graf4, nrow=1)
dev.off()

graf5 <- ggplot(percentages, aes(x=cover, y=percent_1984, fill=cover))  + ggtitle("Cover percentage 1984") + geom_bar(stat="identity", color= "black") + scale_fill_manual(values=c("seagreen", "wheat"))
graf6 <- ggplot(percentages, aes(x=cover, y=percent_1996, fill=cover))+ ggtitle("Cover percentage 1996") + geom_bar(stat="identity", color= "black") + scale_fill_manual(values=c("seagreen", "wheat"))
graf7 <- ggplot(percentages, aes(x=cover, y=percent_2004, fill=cover)) + ggtitle("Cover percentage in 2004") + geom_bar(stat="identity", color= "black") + scale_fill_manual(values=c("seagreen", "wheat"))
graf8 <- ggplot(percentages, aes(x=cover, y=percent_2012, fill=cover)) + ggtitle("Cover percentage in 2012") + geom_bar(stat="identity", color= "black") + scale_fill_manual(values=c("seagreen", "wheat"))
grid.arrange(graf5, graf6, graf7, graf8, nrow=1)

pdf("graficiggplot_vers2.pdf")
grid.arrange(graf5, graf6, graf7, graf8, nrow=1)
dev.off()




ggplot(increasedpercentages, aes(x=MSHcover, y=coverpercentagein1987, fill=MSHcover)) + ggtitle("Cover percentage on the volcanic slopes of Mount Saint Helens in 1987") + theme(plot.title=element_text(face="bold")) + scale_x_discrete(limits = idealgraphicsuccession) + scale_y_continuous(limits = c(min(0),max(71))) + geom_bar(stat="identity") + theme(legend.position="bottom") + scale_fill_manual(values=c("gold", "burlywood3", "darkolivegreen4"))
ggplot(increasedpercentages, aes(x=MSHcover, y=coverpercentagein1996, fill=MSHcover)) + ggtitle("Cover percentage on the volcanic slopes of Mount Saint Helens in 1996") + theme(plot.title=element_text(face="bold")) + scale_x_discrete(limits = idealgraphicsuccession) + scale_y_continuous(limits = c(min(0),max(71))) + geom_bar(stat="identity") + theme(legend.position="bottom") + scale_fill_manual(values=c("gold", "burlywood3", "darkolivegreen4"))

