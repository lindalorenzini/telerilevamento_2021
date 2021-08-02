#R code complete
#--------------------------------------

# Summary:

# 1. remote sensing first code
# 2. R code time series
# 3. R code Copernicus
# 4. R code knitr
# 5. R code multivariate analysis
# 6. R code classification
# 7. R code ggplot2
# 8. R code vegetation indices
# 9. R code land cover 
# 10. R code variability

#--------------------------------------

#1. remote sensing first code

# My first R code for remote sensing

###day1
setwd("C:/lab/") # Windows, permette di scegliere la working directory

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

###day4
#visualizzazione dati 
# prima cosa: richiamo il pacchetto raster con funzione library(raster)
library(raster)
#una volta richiamato il pacchetto raster, scelgo la cartella di lavoro con funzione setwd
setwd("C:/lab/") # Windows
#inserisco l'immagine satellitare che voglio visualizzare tramite la funzione brick
p224r63_2011<-brick("p224r63_2011_masked.grd") #la funzione brick permette di importare dati dall'esterno

# Bande Landsat
# B1: blu
# B2: verde
# B3: rosso
# B4: infrarosso vicino
# B5: infrarosso medio
# B6: infrarosso termico
# B7: infrarosso medio

#RGB 
#ogni dispositivo elettronico utilizza lo schema RGB (red,green,blue) per la visualizzazione dei colori 
#avendo questo sistema RGB possiamo visualizzare le immagini utilizzando 3 bande del satellite landsat 
#associo quindi le bande dei colori corrispondenti
#R3
#G2
#B1
#la funzione per visualizzare questo schema è plotRGB
plotRGB(p224r63_2011, r=3,g=2,b=1, stretch="Lin")
#nell'argomento della funzione devo indicare l'immagine che voglio usare, i colori e le bande corrispondenti e la funzione stretch
#la funzione stretch serve a visualizzare tutti i valori intermedi 
#l'immagine che otteniamo è un'immagine a colori naturali

#posso modificare i colori cambiando l'associazione tra RGB e bande di landsat
#R4
#G3
#B2
plotRGB(p224r63_2011, r=4,g=3,b=2, stretch="Lin") #ricordo che la vegetazione riflette tantissimo nell'infrarosso
#inverto la banda 3 con la 4
plotRGB(p224r63_2011, r=3,g=4,b=2, stretch="Lin")
#inverto ora la banda 4 e la 2
plotRGB(p224r63_2011, r=3,g=2,b=4, stretch="Lin")
#a seconda del montaggio di bande che utilizzo ottengo immagini diverse 

#esercizio: fare un multiframe 2x2 con le 4 bande utilizzate fino ad ora
par(mfrow=c(2,2)) 
plotRGB(p224r63_2011, r=3,g=2,b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4,g=3,b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3,g=4,b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3,g=2,b=4, stretch="Lin")

# funzione pdf(): mi permette di salvare l'immagine ottenuta come pdf 
pdf("il_mio_primo_pdf_con_R.pdf")
par(mfrow=c(2,2)) 
plotRGB(p224r63_2011, r=3,g=2,b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4,g=3,b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3,g=4,b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3,g=2,b=4, stretch="Lin")
dev.off()

#lo stretch può essere anche fatto in maniera non lineare con lo stretch "hist"(histogram)
plotRGB(p224r63_2011, r=3,g=4,b=2, stretch="Lin") #stretch lineare
plotRGB(p224r63_2011, r=3,g=4,b=2, stretch="hist") #stretch histogram
# con questo tipo di stretch più "violento" riesco a vedere immagini più distinte e con maggiori dettagli

# multiframe con 3 immagini: colori naturali, colori falsi e histogram stretch
par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist")
#i colori che ottengo da questo metodo RGB sono i colori reali delle immagini e di conseguenza non ho una legenda

#installare pacchetto RStoolbox
install.packages("RStoolbox")

###day5
#immagine 1988
# p224r63_1988_masked
library(raster)
setwd("C:/lab/") # Windows
p224r63_2011 <- brick("p224r63_2011_masked.grd")

#set multitemporale
p224r63_1988 <- brick("p224r63_1988_masked.grd")
#funzione brick importa un intero set di raster
p224r63_1988
#faccio un plot per visualizzare le bande dell'immagine
plot(p224r63_1988)
# Bande Landsat
# B1: blu
# B2: verde
# B3: rosso
# B4: infrarosso vicino
# B5: infrarosso medio
# B6: infrarosso termico
# B7: infrarosso medio
#plotto ora con il sistema RGB
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")

#confronto ora le due immagini 1988 e 2011
par(mfrow=c(2,1)) 
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")

par(mfrow=c(2,2)) 
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="hist")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist")

#salvo il pdf
pdf("set multitemporale")
par(mfrow=c(2,2)) 
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="hist")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist")
dev.off()

#---------------------------------------------

# 2. R code time series

#time series analysis
#incremento della temperatura 
#dati e codice di Emanuela Cosma
  
# install.packages("raster")
library(raster)
#settiamo una nuova working directory
# setwd("/Users/name/Desktop/lab/greenland") # Mac 
# setwd("~/lab/greenland") # Linux
setwd("C:/lab/greenland") # Windows

install.packages("rasterVis") # attenzione alla maiuscola e virgolette perché usciamo da R

#la funzione raster serve a creare un oggetto con un layer raster, mi permette di caricare singoli dati invece che pacchetti di dati come fa la funzione brick
lst_2000<-raster("lst_2000.tif")
plot(lst_2000)
lst_2005 <- raster("lst_2005.tif")
plot(lst_2005) 
lst_2010 <- raster("lst_2010.tif")
lst_2015 <- raster("lst_2015.tif")
#esercizio multiframe con le quattro immagini

par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)

#funzione lapply() permette di applicare una determinata funzione ad una lista di file
#creiamo una lista di files con la funzione list.files
rlist <- list.files(pattern="lst")
rlist
#una volta creata la lista posso applicarvi una funzione tramite lapply
#applico la funzione raster sulla lista appena creata
import <- lapply(rlist,raster)
import

TGr <- stack(import)
plot(TGr)

library(raster)
library(rasterVis)
#settiamo nuovamente la working directory
# setwd("/Users/name/Desktop/lab/greenland") # Mac 
# setwd("~/lab/greenland") # Linux
setwd("C:/lab/greenland") # Windows

rlist <- list.files(pattern="lst")
rlist
 
import <- lapply(rlist,raster)
import
#creo un raster file stack con la funzione stack
TGr <- stack(import)
#a questo punto posso visualizzare il raster stack scrivendo semplicemente TGr

#passiamo ora a fare il level plot
#level plot è una funzione che permette di plottare una stack di dati 
levelplot(TGr)
levelplot(TGr$lst_2000)
#il level plot ci permette di estrarre valori statistici come per esempio valori medi

#ora voglio capire come abbellire il level plot e come "giocare" sui dati che ho, in questo caso ullo scioglimento dei ghiacci
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100) #colorRampPalette ci permette di cambiare i colori delle immagini
levelplot(TGr, col.regions=cl) 
#ll grafico grigio sopra l'immagine indica la temperatura, come media della stessa colonnna o riga della griglia di bit.
#valori bassi di temperatura, indicati da numeri interi di bit, sono rappresentati dal colore blu (sulla Gronelandia)
#possiamo cambiare i titoli delle immagini con la funzione names.attr (per nominare i singoli attributi)
#main è l'argomento, quindi nel nostro caso il titolo dellla mappa, messo tra virgolette perchè un testo
levelplot(TGr,col.regions=cl, names.attr=c("July 2000","July 2005", "July 2010", "July 2015")) #ho rinominato i layer dell'immagine
#a questo punto posso anche inserire il nome principale della mia immagine/grafico
levelplot(TGr,col.regions=cl, main="LST variation in time",names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))
 
#Melt, esercizio
MeltGreenland<-list.files(pattern="melt")
melt_import<-lapply(MeltGreenland, raster)
melt<-stack(melt_import)
melt
levelplot(melt)
#metricsalgebra applicato alle matrici per lo studio di dati temporali, facciamo la sottrazione tra primo e ultimo dato, mettiamo $ per legare uno strato all'altro
#a questo punto voglio fare la sottrazione fra i dati di due immagini 
melt_amount <- melt$X2007annual_melt - melt$X1979annual_melt
clb <- colorRampPalette(c("blue","white","red"))(100)
plot(melt_amount, col=clb)
levelplot(melt_amount, col.regions=clb)

#--------------------------------------------------

# 3. R code Copernicus

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

install.packages("knitr")

#---------------------------------------------

# 4. R code knitr

#R_code_knitr.r

#prima cosa settiamo la working directory
setwd("C:/lab/") # Windows
#knitr è un pacchetto utile per creare file con diversi pdf all'interno
# knitr prende un codice all'esterno di r, lo porta all'interno di r dove genera un report nella stessa cartella del codice
library(knitr)
#funzione stitch: il primo argomento da inserire è come si chiama il nostro codice
stitch("R_code_greenland.r.docx", template=system.file("misc", "knitr-template.Rnw", package="knitr"))

#----------------------------------------------

# 5. R code multivariate analysis

# R_code_multivariate_analysis.r

library(raster)
library(RStoolbox)

#setwd("~/lab/") # Linux
setwd("C:/lab/") # Windows
# setwd("/Users/name/Desktop/lab/") # Mac

#immagine: p224r63_2011_masked.grd

p224r63_2011<- brick(" p224r63_2011_masked.grd")
plot(p224r63_2011)
p224r63_2011

#adesso plottiamo i valori delle varie bande 
plot(p224r63_2011$B1_sre, p224r63_2011$B2_sre, col="red", pch=19, cex=2)

# funzione pairs: mette in correlazione a due a due tutte le variabili di un dato dataset
pairs(p224r63_2011)

#analisi multivariata: PCA 
#richiamo le due librerie utilizzate e la cartella di riferimento
library(raster)
library(RStoolbox)
setwd("C:/lab/") # Windows
#ricarico con la funzione brick l'immagine di interesse
p224r63_2011 <- brick("p224r63_2011_masked.grd")
#visualizzo le informazioni dell'immagine 
p224r63_2011
#utilizzo la funzione pairs per visualizzare tutte le bande e la loro correlazione
pairs(p224r63_2011)
#vista la dimensione dei dati, ricampionaniamo con la funzione aggregate
#funzione aggregate: aggrega più pixel in modo da ridurre la risoluzione dell'immagine
p224r63_2011res <- aggregate(p224r63_2011, fact=10) #aggreghiamo con un fattore lineare di 10, l'immagine non ha più una risoluzione di 30m ma di 300m
#vediamo ora le due immagini a confronto
par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="lin")
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="lin")

#funzione rasterPCA: prende il nostro pacchetto di dati e li compatta in un numero minore di bande
p224r63_2011res_pca <- rasterPCA(p224r63_2011res) #non contiene solo un'immagine ma anche una mappa, un modello, ecc...

#funzione summary: ci da un sommario del nostro oggetto
summary(p224r63_2011res_pca$model)
plot(p224r63_2011res_pca $ map)

p224r63_2011res_pca
dev.off()
plotRGB(p224r63_2011res_pca $ map, r=1, g=2, b=3, stretch = "lin") #immagine risultante dall'analisi delle componenti principali

#------------------------------------

# 6. R code classification

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

# Grand Canyon
# https://landsat.visibleearth.nasa.gov/view.php?id=80948

#definisco i pacchetti di interesse
library(raster)
library(RStoolbox)
#definisco la working directory
setwd("C:/lab/") # Windows

#inserisco ora l'immagine di interesse con la funzione brick
gc<-brick("dolansprings_oli_2013088_canyon_lrg.jpg")
#plotto in RGB con stretch lineare 
plotRGB(gc, r=1, g=2, b=3, stretch="lin")
#riplotto con stretch histogram per vedere la differenza 
plotRGB(gc, r=1, g=2, b=3, stretch="hist")
#https://cran.r-project.org/web/packages/RStoolbox/RStoolbox.pdf
#eseguo la classificazione con unsuperClass(), ci permette di discriminare gli elementi della mappa 
gcc2 <- unsuperClass(gc, nClasses=2)
plot(gcc2$map)
#ricampionamento immagine nel caso sia un file troppo pesante 
#aumento il numero di classi per avere una maggiore discriminazione 
gcc4 <- unsuperClass(gc, nClasses=4)
plot(gcc4$map)

#-----------------------------------------------

# 7. R code ggplot2

library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)

setwd("C:/lab/")

p224r63 <- brick("p224r63_2011_masked.grd")

ggRGB(p224r63,3,2,1, stretch="lin")
ggRGB(p224r63,4,3,2, stretch="lin")

p1 <- ggRGB(p224r63,3,2,1, stretch="lin")
p2 <- ggRGB(p224r63,4,3,2, stretch="lin")

grid.arrange(p1, p2, nrow = 2) # this needs gridExtra

#----------------------------------------------------

# 8. R code vegetation indices

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

#worldwide NDVI
install.packages("rasterdiv") #for worldwide NDVI
library(rasterdiv)
plot(copNDVI)
#ora voglio togliere dall'immagine tutta la parte che riguarda l'acqua
#utilizzo la funzione cbiind per cambiare i valori dei pixel che mi interessano
#pixels con valori 253,254,255 (acqua) devono essere settati come NA
copNDVI <- reclassify(copNDVI, cbind(253:255, NA))
plot(copNDVI)
#ora facciamo il levelplot per vedere la media dei valori dei pixel
#richiamo il pacchetto rasterVis per utilizzare il levelplot
library(rasterVis)
levelplot(copNDVI) #l'immagine mostra i luoghi con maggiore biomassa vegetale 

#----------------------------

# 9. R code land cover 

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
#classe 2 foresta amzzonica e classe 1 con campi coltivati e fiume
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
#[1,] 2.930042e-06 0.09963902 , campi
#[2,] 5.860085e-06 0.90036098 ,foresta

s2 <- 342726
prop2 <- freq(d2c$map) / s2
prop2
#value     count
#[1,] 2.917783e-06 0.5231905 ,foresta
#[2,] 5.835565e-06 0.4768095, campi

#ora creiamo un dataset
cover<-c("Forest", "Agriculture")
percent_1992<-c(90.03, 09.96)
percent_2006<-c(52.31, 47.68)
#funzione date.frame() mi permette di creare una tabella/dataset
percentages<-data.frame(cover,percent_1992,percent_2006)
percentages
#ora facciamo un grafico utilizzando ggplot
p1<-ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
p2<-ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")

#grid.arrange()  funzione che permette di aggregare più grafici nella stessa pagins
grid.arrange(p1, p2, nrow=1)

#in questo modo abbiamo analizzato un'immagine satellitare e abbiamo trasformato l'immagine in dati utilizzabili per analizzare la copertura 

#---------------------------------------

# 10. R code variability

#R_code_variability.r

#prima di tutto carichiamo le librerie che ci servono 
library(raster)
library(RStoolbox)
library(ggplot2) #per plottare in ggplot
library(gridExtra) #per plottare i ggplot insieme
install.packages("viridis")
library(viridis) #per colorare i ggplot

#una volta caricate le librerie,settiamo la working directory il cui comando cambia da sistema operativo a sistema operativo
setwd("C:/lab/") # Windows
 
#importiamo l'immagine con la funzione brick e la associamo ad un oggetto 
#la funzione brick differisce dalla funzione raster poicheè la funzione raster porta solo una banda mentre brick tutte le bande
sent<- brick("sentinel.png")
#ora andiamo a plottare l'immagine su tre livelli con un plotRGB
#NIR 1, RED 2,  GREEN 3
# r=1, g=2, b=3
plotRGB(sent,stretch="lin") #siccome i colori sono impostati di default non serve impostare i colori
# corrisponderebbe acplotRGB(sent,r=1, g=2, b=3,stretch="lin")
#cambiamo i colori 
plotRGB(sent, r=2, g=1, b=3, stretch="lin") 

#ora per fare il calcolo della deviazione standard posso andare ad utilizzare una sola banda e per farlo utilizzo la moving window
#prima cosa vado a vedere le bande dell'immagine 
sent
#ora vado ad associare le bande a degli oggetti in modo da essere più rapido nei passaggi successivi
nir <- sent$sentinel.1
red <- sent$sentinel.2
#calcolo l'indice di vegetazione
ndvi <- (nir-red) / (nir+red)
plot(ndvi)
# a questo punto mi sono creata la banda su cui andrò a calcolare la deviazione standard
cl <- colorRampPalette(c('black','white','red','magenta','green'))(100) # 
plot(ndvi,col=cl)

#ora vado a calcolare la variabilità della singola immagine 
#calcolo della deviazione standard
ndvisd3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
plot(ndvisd3)
#cambio la colorRampPalette
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) 
plot(ndvisd3, col=clsd)
#l'immagine fa vedere la variabilità all'interno dell'immagine 

#ora calcoliamo la media invece che la deviazione standard
ndvimean3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=mean)
plot(ndvimean3)
clmean<- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) 
plot(ndvisd3, col=clmean)

ndvisd5 <- focal(ndvi, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)  
plot(ndvisd5, col=clsd)

#ora prenciamo il nostro sistema multibanda e facciamo una pca sulla prima variabile
sentpca<- rasterPCA(sent)
plot(sentpca$map)

summary(sentpca$model)

#funzione focal ci permette di calcolare la deviazione standard/media all'interno di un quadrato 3x3 che si sposta sopra i pixel dell'immagine

pc1 <- sentpca$map$PC1
#esercizio: calcolo dev. standard di pc1 tramite la funzione focal
pc1sd5<-focal(pc1, w=matrix (1/25, nrow=5, ncol=5), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(pc1sd5, col=clsd)
#l'immagine rappresenta la diversità presente nell'immagine del ghiacciaio del similaun

#funzione source: ci permette di richiamare un pezzo di codice che abbiamo già fatto
source("source_test_lezione.r")
#a questo punto andiamo ad utilizzare la libreria nuova viridis
#richiamo il codice source_ggplot.r
dec.off()
source("source_ggplot.r")

#ora rivediamo il codice passo dopo passo
#creo una nuova finestra vuota
ggplot()+
#a questo punto aggiungo i pezzi al ggplot partendo dalla geometria
#geom_raster ci permette di creare una sorta di mappa
geom_raster(pc1sd5, mapping=aes(x=x, y=y, fill=layer))

#https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html
#pacchetto viridis: The package contains eight color scales: “viridis”, the primary choice, and five alternatives with similar properties - “magma”, “plasma”, “inferno”, “civids”, “mako”, and “rocket” -, and a rainbow color map - “turbo”.

#scale_fill_viridis : funzione che mi permette di utilizzare una delle leggende contenute in viridis
p1<-ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis()+
#aggiungo un titolo alla mappa con ggtitle
ggtitle("Standard deviation of PC1 by viridis colour scale")

#altro ggplot con dentro un'altra scala di colori (magma)
p2<-ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option="magma")+
ggtitle("Standard deviation of PC1 by magma colour scale")

#altro ggplot con dentro un'altra scala di colori (inferno)
p3<-ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option="inferno")+
ggtitle("Standard deviation of PC1 by inferno colour scale")

#altro ggplot con dentro un'altra scala di colori (plasma)
p4<-ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option="plasma")+
ggtitle("Standard deviation of PC1 by plasma colour scale")

#altro ggplot con dentro un'altra scala di colori (cividis)
p5<-ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option="cividis")+
ggtitle("Standard deviation of PC1 by cividis colour scale")

#altro ggplot con dentro un'altra scala di colori (mako)
p6<-ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option="mako")+
ggtitle("Standard deviation of PC1 by mako colour scale")

#altro ggplot con dentro un'altra scala di colori (rocket)
p7<-ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option="rocket")+
ggtitle("Standard deviation of PC1 by rocket colour scale")

#altro ggplot con dentro un'altra scala di colori (turbo)
p8<-ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option="turbo")+
ggtitle("Standard deviation of PC1 by turbo colour scale")

#ora vediamo come visualizzarle tutte insieme con grid.arrange
grid.arrange(p1,p2,p3,p4,p5,p6,p7,p8, nrow=2)

#---------------------------------











