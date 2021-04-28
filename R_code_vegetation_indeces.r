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
