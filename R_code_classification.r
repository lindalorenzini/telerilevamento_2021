#R_code_classification.r

#definisco la working directory
setwd("C:/lab/") # Windows
#definisco i pacchetti di interesse
library(raster)
library(RStoolbox)
#funzione brick prende i file e mi crea un file raster unico con più bande al suo interno
so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
#visualizzo i dati dell'immagine caricata scrivendo l'oggetto associato a brick
so
#visualizzazione l'immagine in RGB
plotRGB(so, 1, 2, 3, stretch="lin")

#Unsupervised Classification: funzione che dentro RStoolbox opera la classificazione non supervisionata
soc <- unsuperClass(so, nClasses=3)
#faccio un plott della nostra immagine classificata e la mappa, per legare immagine e mappa utilizzo il simbolo del dollaro
plot(soc$map)
#funzione set.seed() serve per avere una classificazione sempre uguale 

# esercizio: Unsupervised Classification con più classi (20)
soc20 <- unsuperClass(so, nClasses=20)
plot(soc20$map)

# Download an image from:
# https://www.esa.int/ESA_Multimedia/Missions/Solar_Orbiter/(result_type)/images
sun <- brick("sun.png")
# Unsupervised classification
sunc <- unsuperClass(sun, nClasses=3)
plot(sunc$map)

