#R_code_vegetation_indeces.r
#carichiamo le librerie e settiamo la working directory
library(raster)
setwd("C:/lab/") # Windows
#inserisco le mie immagini
defor1 <- brick("defor1.jpg")
defor2 <- brick("defor2.jpg")

par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

#prima cosa richiamo i pacchetti che ci servono
library(raster)
#settiamo la working directory
setwd("C:/lab/") # Windows
#inserisco le immagini che utilizziamo
defor1 <- brick("defor1.jpg")
defor2 <- brick("defor2.jpg")
# b1=NIR, b2=red, b3=green
#plotto le due immagini per vederle a confronto
par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
#andiamo ora a calcolare gli indici di vegetazione per le due immagini
defor1
#per ogni pixel prendiamo il valore nella banda red e lo sottriamo allo stesso pixel nella banda NIR
#dvi=difference vegetation index
dvi1 <- defor1$defor1.1 - defor1$defor1.2
plot(dvi1)
dev.off()
#cambio la palette di colori con colorRampPalette
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme
plot(dvi1, col=cl, main="DVI at time 1") #main serve per dare un titolo al plot
#andiamo a fare la stessa procedura per dvi2
defor2
dvi2 <- defor2$defor2.1 - defor2$defor2.2
plot(dvi2)
dev.off()
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi2, col=cl, main="DVI at time 2")
#plottiamo le due immagini insieme con la funzione par
par(mfrow=c(2,1))
plot(dvi1, col=cl, main="DVI at time 1")
plot(dvi2, col=cl, main="DVI at time 2")

#differenza tra i due dvi
difdvi<- dvi1-dvi2
#dev.off()
cld<-colorRampPalette(c('blue','white','red'))(100) 
plot(difdvi, col=cld)

#ndvi= normalized difference vegetation index
#range di ndivi sempre da -1 a 1
#(NIR-RED)/(NIR+RED)
ndvi1 <- (defor1$defor1.1 - defor1$defor1.2) / (defor1$defor1.1 + defor1$defor1.2)
plot(ndvi1,col=cl)
#in questo caso potevo scrivere anche:
#ndvi1 <- dvi1 / (defor1$defor1.1 + defor1$defor1.2)
#plot(ndvi1,col=cl)
#RStoolbox: troviamo la funzione spectralIndices

#andiamo a calcolare ndvi2 e a plottarlo
ndvi2 <- (defor2$defor2.1 - defor2$defor2.2) / (defor2$defor2.1 + defor2$defor2.2)
plot(ndvi2,col=cl)
#posso usare anche: ndvi2 <- dvi2/ (defor2$defor2.1 + defor2$defor2.2)

#andiamo a utilizzare gli indici spettrali di RStoolbox
library(RStoolbox) # for vegetation indices calculation
# RStoolbox::spectralIndices
vi1 <- spectralIndices(defor1, green = 3, red = 2, nir = 1)
plot(vi, col=cl)
vi2 <- spectralIndices(defor2, green = 3, red = 2, nir = 1)
plot(vi2, col=cl)

difndvi <- ndvi1 - ndvi2
# dev.off()
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difndvi, col=cld)


