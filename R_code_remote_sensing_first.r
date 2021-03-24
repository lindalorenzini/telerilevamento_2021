# My first R code for remote sensing

###day1
setwd("C:/lab/") # Windows, permette di scegliere la set working directory

# install.packages("raster"), seleziono il pacchetto da cui prendo gli oggetti, in questo caso immagini
library(raster)

p224r63_2011<-brick("p224r63_2011_masked.grd") #funzione brick per importare le informazioni
# scrivendo l'argomento di brick ottengo le informazioni sull'immagine
p224r63_2011 

# funzione plot ci permette di visualizzare le immagini
plot(p224r63_2011) 

###day2
#colorRampPalette è una funzione che ci permette di scegliere la banda di colori in cui visualizzare l'immagine
cl <- colorRampPalette(c("black","grey","light grey"))(100)
plot(p224r63_2011, col =cl)

#nuova palette di colori 
cl <- colorRampPalette(c("blue","red","yellow"))(100)
plot(p224r63_2011, col =cl)

###day3
# prima cosa: richiamo il pacchetto raster con funzione library(raster)
 library(raster)
#una volta richiamato il pacchetto raster, scelgo la cartella di lavoro con funzione setwd
setwd("C:/lab/") # Windows
#inserisco l'immagine satellitare che voglio visualizzare tramite la funzione brick
p224r63_2011<-brick("p224r63_2011_masked.grd")
#a questo punto voglio plottare la mia immagine con la palette di colori utilizzati in precedenza
cls <- colorRampPalette(c("red","pink","orange","purple")) (200)
plot(p224r63_2011, col=cls)
#possiamo ottenere le informazioni sull'immagine e sulle bande che la compongono con l'oggetto del brick
p224r63_2011

#a questo punto posso spiegare al mio software a quali colori corrispondono le bande (B) che in questa immagine sono 7
# Bande Landsat
# B1: blu
# B2: verde
# B3: rosso
# B4: infrarosso vicino
# B5: infrarosso medio
# B6: infrarosso termico
# B7: infrarosso medio

#se voglio plottare una sola banda, prima cosa voglio pulire la finestra grafica corrente con dev.off()
dev.off()

#il simbolo $ viene sempre utilizzato per legare due pezzi, in questo caso vogliamo legare un'immagine a una sola banda
#voglio plottare una sola banda,utilizzo sempre la funzione Plot
plot(p224r63_2011$B1_sre)

#esercizio di plot con altre bande di colori
cl <- colorRampPalette(c("blue","red","yellow"))(100)
#se voglio visualizzare la banda uno ma con i nuovi colori posso utilizzare
plot(p224r63_2011$B1_sre,col=cl)

#ripulisco nuovamente la parte grafica con dev.off
dev.off()

#par serve per decidere come voglio mettere le immagini all'interno del plot, mi permette di fare multiframe  
par(mfrow=c(1,2)) 
#dove mf sta per MultiFrame 
#1 e 2 sono numero di righe e colonne in cui vogliamo visualizzare le bande  
#c è un vettore che ci permette di avere più di un argomento al suo interno 
#di seguito scrivo il plot delle bande che voglio visualizzare
plot(p224r63_2011$B1_sre,col=cl)
plot(p224r63_2011$B2_sre,col=cl)

#due righe e una colonna
par(mfrow=c(2,1)) #c è un vettore che ci permette di avere più di un argomento al suo interno
plot(p224r63_2011$B1_sre,col=cl)
plot(p224r63_2011$B2_sre,col=cl)

#una riga e due colonne
par(mfrow=c(1,2))
plot(p224r63_2011$B1_sre,col=cl)
plot(p224r63_2011$B2_sre,col=cl)

# plot delle prime 4 bande di landsat:
par(mfrow=c(4,1)) #quattro righe e una colonna
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

par(mfrow=c(2,2)) #quadrato 2x2, visualizzo 4 immagini su due righe e due colonne
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

#multiframe con 4 immagini di diverse palette di colori (blu,verde,rosso,infrarosso)
#imposta il 2x2 per il multiframe
par(mfrow=c(2,2)) 
#immagine 1 in alto a sinistra plot con blu
clb <- colorRampPalette(c("dark blue","blue","light blue")) (100)
plot(p224r63_2011$B1_sre, col=clb) 
#immagine 2 in alto a destra plot con verde
clg <- colorRampPalette(c("dark green","green","light green")) (100)
plot(p224r63_2011$B2_sre, col=clg)
#immagine 3 in basso a sinistra plot con rosso
clr <- colorRampPalette(c("dark red","red","pink")) (100)
plot(p224r63_2011$B3_sre, col=clr)
#immagine 4 in basso a destra plot con infrarosso(colori inventati)
clnir <- colorRampPalette(c("red","orange","yellow")) (100)
plot(p224r63_2011$B4_sre, col=clnir)




     
