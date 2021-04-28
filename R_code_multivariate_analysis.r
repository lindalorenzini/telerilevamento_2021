# R_code_multivariate_analysis.r

library(raster)
library(RStoolbox)

#setwd("~/lab/") # Linux
setwd("C:/lab/") # Windows
# setwd("/Users/name/Desktop/lab/") # Mac

#immagine: p224r63_2011_masked.grd

p224r63_2011<- brick(" p224r63_2011_masked.grd")
plot(p224r63_2011)
p224r63_2011

#adesso plottiamo i valori delle varie bande 
plot(p224r63_2011$B1_sre, p224r63_2011$B2_sre, col="red", pch=19, cex=2)

# funzione pairs: mette in correlazione a due a due tutte le variabili di un dato dataset
pairs(p224r63_2011)

#analisi multivariata: PCA 
#richiamo le due librerie utilizzate e la cartella di riferimento
library(raster)
library(RStoolbox)
setwd("C:/lab/") # Windows
#ricarico con la funzione brick l'immagine di interesse
p224r63_2011 <- brick("p224r63_2011_masked.grd")
#visualizzo le informazioni dell'immagine 
p224r63_2011
#utilizzo la funzione pairs per visualizzare tutte le bande e la loro correlazione
pairs(p224r63_2011)
#vista la dimensione dei dati, ricampionaniamo con la funzione aggregate
#funzione aggregate: aggrega più pixel in modo da ridurre la risoluzione dell'immagine
p224r63_2011res <- aggregate(p224r63_2011, fact=10) #aggreghiamo con un fattore lineare di 10, l'immagine non ha più una risoluzione di 30m ma di 300m
#vediamo ora le due immagini a confronto
par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="lin")
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="lin")

#funzione rasterPCA: prende il nostro pacchetto di dati e li compatta in un numero minore di bande
p224r63_2011res_pca <- rasterPCA(p224r63_2011res) #non contiene solo un'immagine ma anche una mappa, un modello, ecc...

#funzione summary: ci da un sommario del nostro oggetto
summary(p224r63_2011res_pca$model)
plot(p224r63_2011res_pca $ map)

p224r63_2011res_pca
dev.off()
plotRGB(p224r63_2011res_pca $ map, r=1, g=2, b=3, stretch = "lin") #immagine risultante dall'analisi delle componenti principali

