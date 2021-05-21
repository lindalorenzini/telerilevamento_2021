#R_code_variability.r

#prima di tutto carichiamo le librerie che ci servono 
library(raster)
library(RStoolbox)
library(ggplot2) #per plottare in ggplot
library(gridExtra) #per plottare i ggplot insieme
install.packages("viridis")
library(viridis) #per colorare i ggplot

#una volta caricate le librerie,settiamo la working directory il cui comando cambia da sistema operativo a sistema operativo
setwd("C:/lab/") # Windows
 
#importiamo l'immagine con la funzione brick e la associamo ad un oggetto 
#la funzione brick differisce dalla funzione raster poicheè la funzione raster porta solo una banda mentre brick tutte le bande
sent<- brick("sentinel.png")
#ora andiamo a plottare l'immagine su tre livelli con un plotRGB
#NIR 1, RED 2,  GREEN 3
# r=1, g=2, b=3
plotRGB(sent,stretch="lin") #siccome i colori sono impostati di default non serve impostare i colori
# corrisponderebbe acplotRGB(sent,r=1, g=2, b=3,stretch="lin")
#cambiamo i colori 
plotRGB(sent, r=2, g=1, b=3, stretch="lin") 

#ora per fare il calcolo della deviazione standard posso andare ad utilizzare una sola banda e per farlo utilizzo la moving window
#prima cosa vado a vedere le bande dell'immagine 
sent
#ora vado ad associare le bande a degli oggetti in modo da essere più rapido nei passaggi successivi
nir <- sent$sentinel.1
red <- sent$sentinel.2
#calcolo l'indice di vegetazione
ndvi <- (nir-red) / (nir+red)
plot(ndvi)
# a questo punto mi sono creata la banda su cui andrò a calcolare la deviazione standard
cl <- colorRampPalette(c('black','white','red','magenta','green'))(100) # 
plot(ndvi,col=cl)

#ora vado a calcolare la variabilità della singola immagine 
#calcolo della deviazione standard
ndvisd3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
plot(ndvisd3)
#cambio la colorRampPalette
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) 
plot(ndvisd3, col=clsd)
#l'immagine fa vedere la variabilità all'interno dell'immagine 

#ora calcoliamo la media invece che la deviazione standard
ndvimean3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=mean)
plot(ndvimean3)
clmean<- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) 
plot(ndvisd3, col=clmean)

ndvisd5 <- focal(ndvi, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)  
plot(ndvisd5, col=clsd)

#ora prenciamo il nostro sistema multibanda e facciamo una pca sulla prima variabile
sentpca<- rasterPCA(sent)
plot(sentpca$map)

summary(sentpca$model)

#funzione focal ci permette di calcolare la deviazione standard/media all'interno di un quadrato 3x3 che si sposta sopra i pixel dell'immagine

pc1 <- sentpca$map$PC1
#esercizio: calcolo dev. standard di pc1 tramite la funzione focal
pc1sd5<-focal(pc1, w=matrix (1/25, nrow=5, ncol=5), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(pc1sd5, col=clsd)
#l'immagine rappresenta la diversità presente nell'immagine del ghiacciaio del similaun

#funzione source: ci permette di richiamare un pezzo di codice che abbiamo già fatto
source("source_test_lezione.r")
#a questo punto andiamo ad utilizzare la libreria nuova viridis
#richiamo il codice source_ggplot.r
dec.off()
source("source_ggplot.r")

#ora rivediamo il codice passo dopo passo
#creo una nuova finestra vuota
ggplot()+
#a questo punto aggiungo i pezzi al ggplot partendo dalla geometria
#geom_raster ci permette di creare una sorta di mappa
geom_raster(pc1sd5, mapping=aes(x=x, y=y, fill=layer))

#https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html
#pacchetto viridis: The package contains eight color scales: “viridis”, the primary choice, and five alternatives with similar properties - “magma”, “plasma”, “inferno”, “civids”, “mako”, and “rocket” -, and a rainbow color map - “turbo”.

#scale_fill_viridis : funzione che mi permette di utilizzare una delle leggende contenute in viridis
p1<-ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis()+
#aggiungo un titolo alla mappa con ggtitle
ggtitle("Standard deviation of PC1 by viridis colour scale")

#altro ggplot con dentro un'altra scala di colori (magma)
p2<-ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option="magma")+
ggtitle("Standard deviation of PC1 by magma colour scale")

#altro ggplot con dentro un'altra scala di colori (inferno)
p3<-ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option="inferno")+
ggtitle("Standard deviation of PC1 by inferno colour scale")

#altro ggplot con dentro un'altra scala di colori (plasma)
p4<-ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option="plasma")+
ggtitle("Standard deviation of PC1 by plasma colour scale")

#altro ggplot con dentro un'altra scala di colori (cividis)
p5<-ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option="cividis")+
ggtitle("Standard deviation of PC1 by cividis colour scale")

#altro ggplot con dentro un'altra scala di colori (mako)
p6<-ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option="mako")+
ggtitle("Standard deviation of PC1 by mako colour scale")

#altro ggplot con dentro un'altra scala di colori (rocket)
p7<-ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option="rocket")+
ggtitle("Standard deviation of PC1 by rocket colour scale")

#altro ggplot con dentro un'altra scala di colori (turbo)
p8<-ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option="turbo")+
ggtitle("Standard deviation of PC1 by turbo colour scale")

#ora vediamo come visualizzarle tutte insieme con grid.arrange
grid.arrange(p1,p2,p3,p4,p5,p6,p7,p8, nrow=2)


