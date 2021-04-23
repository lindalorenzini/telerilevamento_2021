# R_code_multivariate_analysis.r

library(raster)
library(RStoolbox)

setwd("~/lab/") # Linux
# setwd("C:/lab/") # Windows
# setwd("/Users/name/Desktop/lab/") # Mac

#immagine: p224r63_2011_masked.grd

p224r63_2011<- brick(" p224r63_2011_masked.grd")
plot(p224r63_2011)
p224r63_2011

#adesso plottiamo i valori delle varie bande 
plot(p224r63_2011$B1_sre, p224r63_2011$B2_sre, col="red", pch=19, cex=2)

# funzione pairs: mette in correlazione a due a due tutte le variabili di un dato dataset
pairs(p224r63_2011)
