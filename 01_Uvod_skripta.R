# Analize podataka u biološkim istraživanjima - praktikum 2024
# Lucija Kanjer lucija.kanjer@biol.pmf.hr

##############################################################

# 1. Uvod u R i RStudio

# Ova skripta će vas upoznati sa radom u R-u i RStudio-u.
# Uključene su sve korištenje naredbe, ALI NEKE SU NEPOTPUNE ILI SADRŽE NAMJERNE POGREŠKE:
# Dovršite naredbe i također dodajte komentare za sebe (koristite # za komentiranje)
#
# IZVRŠAVANJE NAREDBI: ctrl + Enter 
#
#############################################################

# Prva naredba: ispis teksta iz skripte u konzolu
print("Hello world!")

# Ovo je primjer komentara cijelog reda
print("Dobar dan svijete!") # ovo je komentar nakon naredbe

# Definiranje objekata (varijabli)
a <- 5
b = 3

# Različiti načina ispisa
print(a) # ispis u konzoli
a # ispis u konzoli
print(a + b) # ispis rezultata u konzoli
cat(a) # ispisu u konzoli, ali ima više mogućnosti u odnosu na print()
View(a) # ispis u novom tab- u RStudio-a

# Primjer: Definirajmo varijablu svoje visine i godine rođenja
visina  <-
godina <- 
# Ispišimo ove varijable!
print()
cat

# Osnovne operacije u R-u
# Zbroj
zbroj <- 5 + 3
print(zbroj)

# Umnožak
umnožak <- 4 * 7
print(umnožak)

# Razlika
razlika <-

# Kvocijent
kvocijent <-

# Rad s datotekama
# Provjeravanje radnog direktorija (working directory)
getwd()

# Postavljanje radnog direktorija
setwd("C:/.....")

# Traženje pomoći za naredbe i pakete:
help(setwd)
?setwd
??setwd

# Učitavanje datoteke s podacima u objekt "zivotinje"
zivotinje <- read.table("zivotinje.txt", header = TRUE)

# Kako pogledati svoje podatke?
print(zivotinje) # ispis cijele tablice u konzoli
head(zivotinje) # prikaz "glave" tablice
View(zivotinje) # prikaz u novom tabu pored skripte

# Za dodatne analize moramo instalirati dodatne R pakete
# Instalacija paketa - samo jednom
install.packages("ggplot2")

# Učitavanje paketa u radno okruženje - pri svakom pokretanju R-a
library(ggplot2)

# Primjer izrade grafa pomoću paketa ggplot2
# izrada objekta "graf_visina"
graf_visina <- ggplot(data = zivotinje, aes(x = vrsta, y = visina_cm)) +
  geom_boxplot(aes(color = skupina)) + 
  labs(title = "Visina životinja",
       x = "vrsta",
       y = "visina (cm)")
# ispis objekta "graf"
graf_visina

# Izmjenite gornji graf tako da se umjesto visine prikazuju podaci za masu!
# Pazite da izmjenitie naslov grafa i nazive osi da odgovaraju novom prikazu.

####################################################################

# Samostalni zadaci

# 1. Kreirajte 3 varijable za visine 3 različite životinje.
# 2. Izračunajte i ispišite umnožak visine životinja koje ste upisali.
# 3. Napravite novu mapu naziva "biljke" te ju postavite kao novi radni direktorij.
# 4. Instalirajte paket "RColorBrewer" i učitajte ga u radno okruženje.



