# My first R code for remote sensing

setwd("C:/lab/") # Windows

# install.packages("raster")
library(raster)

p224r63_2011<-brick("p224r63_2011_masked.grd")
p224r63_2011

plot(p224r63_2011)
