# My first R code for remote sensing

setwd("C:/lab/") # Windows, permette di scegliere la set working directory

# install.packages("raster"), seleziono il pacchetto da cui prendo gli oggetti, in questo caso immagini
library(raster)

p224r63_2011<-brick("p224r63_2011_masked.grd")
# scrivendo l'argomento di brick ottengo le informazioni sull'immagine
p224r63_2011 

# funzione plot ci permette di visualizzare le immagini
plot(p224r63_2011) #permette di visualizzare le immagini

#colorRampPalette è una funzione che ci permette di scegliere la banda di colori in cui visualizzare l'immagine
cl <- colorRampPalette(c("black","grey","light grey"))(100)
plot(p224r63_2011, col =cl)

#nuova palette di colori 
cl <- colorRampPalette(c("blue","red","yellow"))(100)
plot(p224r63_2011, col =cl)
