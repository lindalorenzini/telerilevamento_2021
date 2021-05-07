#R_code_land_cover.r

library(raster)
library(RStoolbox)
install.packages("ggplot2")
library(ggplot2)

#setwd("~/lab/") # Linux
setwd("C:/lab/") # Windows
# setwd("/Users/name/Desktop/lab/") # Mac

#https://ggplot2-book.org/

defor1 <- brick("defor1.jpg")
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
ggRGB(defor1, r=1, g=2, b=3, stretch="lin")

defor2 <- brick("defor2.jpg")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
ggRGB(defor2, r=1, g=2, b=3, stretch="lin")

par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

#multiframe con ggplot2 e gridextra

library(raster)
library(RStoolbox) # classification
# install.packages("ggplot2")
library(ggplot2)
install.packages("gridExtra")
library(gridExtra)
#setwd("~/lab/") # Linux
setwd("C:/lab/") # Windows
# setwd("/Users/name/Desktop/lab/") # Mac
defor1 <- brick("defor1.jpg")
defor2 <- brick("defor2.jpg")
#facciamo un ggplot in RGB
ggRGB(defor1, r=1, g=2, b=3, stretch="lin")
#https://earthobservatory.nasa.gov/images/35891/deforestation-in-mato-grosso-brazil

#unsupervised classification
d1c <- unsuperClass(defor1, nClasses=2)
d1c
plot(d1c$map)
#classe 1 foresta amzzonica e classe 2 con campi coltivati e fiume
#set.seed() permetterebbe di standardizzare i risultati

d2c <- unsuperClass(defor2, nClasses=2)
d2c
plot(d2c$map)
#classe 1 come foresta amazzonica e classe 2 con campi coltivati
#proviamo a fare classificazione con 3 classi per vedere se riusciamo a identificare il fiumr 
d2c3<- unsuperClass(defor2, nClasses=3)
plot(d2c3$map)
freq(d1c$map) #ci permette di vedere quanti pixel formano le varie classi
# value  count
#[1,]     1  34006
#[2,]     2 307286

#somma
s1<-34006+307286
#risultato=341292

#faccio la proporzione tra i valori
prop1<-freq(d1c$map)/s1
prop1
# value      count
#[1,] 2.930042e-06 0.09963902
#[2,] 5.860085e-06 0.90036098

s2 <- 342726
prop2 <- freq(d2c$map) / s2
prop2
#value     count
#[1,] 2.917783e-06 0.5231905
#[2,] 5.835565e-06 0.4768095

