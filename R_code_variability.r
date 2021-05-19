#R_code_variability.r

#prima di tutto carichiamo le librerie che ci servono 
library(raster)
library(RStoolbox)
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
