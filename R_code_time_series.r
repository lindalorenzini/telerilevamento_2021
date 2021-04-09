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

library(raster)
library(rasterVis)
#settiamo nuovamente la working directory
# setwd("/Users/name/Desktop/lab/greenland") # Mac 
# setwd("~/lab/greenland") # Linux
setwd("C:/lab/greenland") # Windows

rlist <- list.files(pattern="lst")
rlist
 
import <- lapply(rlist,raster)
import
#creo un raster file stack con la funzione stack
TGr <- stack(import)
#a questo punto posso visualizzare il raster stack scrivendo semplicemente TGr

#passiamo ora a fare il level plot
#level plot è una funzione che permette di plottare una stack di dati 
levelplot(TGr)
levelplot(TGr$lst_2000)
#il level plot ci permette di estrarre valori statistici come per esempio valori medi

#ora voglio capire come abbellire il level plot e come "giocare" sui dati che ho, in questo caso ullo scioglimento dei ghiacci
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100) #colorRampPalette ci permette di cambiare i colori delle immagini
levelplot(TGr, col.regions=cl) #nel caso del level plot l'argomento è col.regions e non solo col
#names.attr argomento della funzione levelplot per nominare gli attributi
levelplot(TGr,col.regions=cl, names.attr=c("July 2000","July 2005", "July 2010", "July 2015")) #ho rinominato i layer dell'immagine
#a questo punto posso anche inserire il nome principale della mia immagine/grafico
levelplot(TGr,col.regions=cl, main="LST variation in time",names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))
 
#Melt, esercizio
MeltGreenland<-list.files(pattern="melt")
melt_import<-lapply(MeltGreenland, raster)
melt<-stack(melt_import)
melt
levelplot(melt)

#a questo punto voglio fare la sottrazione fra i dati di due immagini 
melt_amount <- melt$X2007annual_melt - melt$X1979annual_melt
clb <- colorRampPalette(c("blue","white","red"))(100)
plot(melt_amount, col=clb)
levelplot(melt_amount, col.regions=clb)






