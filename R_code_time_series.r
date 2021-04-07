#time series analysis
#incremento della temperatura 
#dati e codice di Emanuela Cosma
  
# install.packages("raster")
library(raster)
#settiamo una nuova working directory
# setwd("/Users/name/Desktop/lab/greenland") # Mac 
# setwd("~/lab/greenland") # Linux
setwd("C:/lab/greenland") # Windows

install.packages("rasterVis") # attenzione alla maiuscola e virgolette perché usciamo da R

#la funzione raster serve a creare un oggetto con un layer raster, mi permette di caricare singoli dati invece che pacchetti di dati come fa la funzione brick
lst_2000<-raster("lst_2000.tif")
plot(lst_2000)
lst_2005 <- raster("lst_2005.tif")
plot(lst_2005) 
lst_2010 <- raster("lst_2010.tif")
lst_2015 <- raster("lst_2015.tif")
#esercizio multiframe con le quattro immagini

par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)

#funzione lapply() permette di applicare una determinata funzione ad una lista di file
#creiamo una lista di files con la funzione list.files
rlist <- list.files(pattern="lst")
rlist
#una volta creata la lista posso applicarvi una funzione tramite lapply
#applico la funzione raster sulla lista appena creata
import <- lapply(rlist,raster)
import

TGr <- stack(import)
plot(TGr)
