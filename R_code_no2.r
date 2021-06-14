#R_code_no2.r

#1. settare la working directory EN
setwd("C:/lab/EN") #Windows
library(raster)

# 2. importazione della prima immagine (singola banda)

EN01<-raster("EN_0001.png")

#3. plottare la prima immagine importata con la colorramppalette che si preferisce

cl <- colorRampPalette(c("red","pink","orange","yellow"))(100)
plot(EN01, col=cl)

#4. importare l'ultima immagine e plottarla con la precedente color palette

EN13<-raster("EN_0013.png")
cl <- colorRampPalette(c("red","pink","orange","yellow"))(100)
plot(EN13, col=cl)

#5. fare la differenza delle due immagine e plot della differenza

ENdif<- EN01-EN13
plot(ENdif, col=cl)

#6. plot delle 3 immagini insieme

par(mfrow=c(3,1)) #3 righe e 1 colonna 
plot(EN01, col=cl,main="NO2 gennaio")
plot(EN13, col=cl,main="NO2 marzo")
plot(ENdif, col=cl, main="NO2 gennaio-marzo")

