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

