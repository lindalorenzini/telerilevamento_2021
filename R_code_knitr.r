#R_code_knitr.r

#prima cosa settiamo la working directory
setwd("C:/lab/") # Windows
#knitr è un pacchetto utile per creare file con diversi pdf all'interno
# knitr prende un codice all'esterno di r, lo porta all'interno di r dove genera un report nella stessa cartella del codice
library(knitr)
#funzione stitch: il primo argomento da inserire è come si chiama il nostro codice
stitch("R_code_greenland.r.docx", template=system.file("misc", "knitr-template.Rnw", package="knitr"))
