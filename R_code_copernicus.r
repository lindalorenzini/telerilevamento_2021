#R_code_copernicus.r
#visualizzazione copernicus

install.packages("ncdf4") #serve per leggere il formato di dati NC

# prima cosa richiamiamo tutte le librerie necessarie 
install.packages("ncdf4")
library(raster)
library(ncdf4)

#definisco la working directory
setwd("C:/lab/") # Windows
#ora scelgo un nome per il dataset
albedo <- raster("c_gls_ALBH_202006130000_GLOBE_PROBAV_V1.5.1.nc")
albedo #visualizzo le info sul rasterlayer 

cl <- colorRampPalette(c('light blue','green','red','yellow'))(100)  
plot(albedo, col=cl)

# resampling: possiamo ricampionare i dati con una minore risoluzione (pixel più grandi)
#utilizziamo la funzione aggregate per aggregare i pixel dell'immagine
#ricampionamento bilineare: prende i pixel di una riga e di un'altra riga e li aggrega
albedores <- aggregate(albedo, fact=100)
plot(albedores, col=cl)

