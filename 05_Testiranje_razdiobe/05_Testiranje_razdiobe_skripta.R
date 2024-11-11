# Analize podataka u biološkim istraživanjima - praktikum 2024
# Lucija Kanjer lucija.kanjer@biol.pmf.hr

###############################################################################

# 5. Testiranje razdiobe bioloških podataka u R-u

# Uključene su sve korištene naredbe, ALI NEKE SU NEPOTPUNE ILI SADRŽE NAMJERNE POGREŠKE:
# Dovršite naredbe gdje je potrebno i dodajte komentare za sebe (koristite # za komentiranje)
#
# IZVRŠAVANJE NAREDBI: ctrl + Enter 
#
###############################################################################

# Instalacija novih paketa
install.packages() # popunite za pakete koje nemate, pazite navodnike!

# Učitavanje potrebnih paketa
library(dplyr) # za manipulaciju tablicama
library(ggplot2) # za crtanje grafova
library(fitdistrplus) # za fit-atanje ditribucije

# Postavljanje radnog direktorija
getwd()
setwd()

# Učitavanje seta podataka o ribama u jezerima grada Zagreba
ribe <- read.csv("ribe.csv", header = TRUE)

# Pregledajte set podataka!
str(ribe)
print(ribe)

###############################################################################

### Faktori u R-u - organizacija kategoričkih varijabli
# Koje kategoričke varijable nalazimo u setu podataka o ribama?
# Koja varijabla je nomimalna, a koja ordinalna?

### Nominalna kategorička varijabla - broj riba po jezerima
ggplot(ribe, aes(x = jezero)) + 
  geom_bar(aes(fill = jezero)) + 
  theme_minimal()

# Koji je problem? R crta kategorije abecednim redom!
# Provjerite tip varijable jezero!
class()
str()

# Koristimo naredbu factor() da postavimo padajući poredak varijable jezero
ribe$jezero <- 
  factor(ribe$jezero, 
         levels = names(sort(table(ribe$jezero), decreasing = TRUE)))

# Ponovo provjerite tip varijable i nacrtajte barplot! Što se promjenilo?


### Ordinalna kategorička varijabla - broj riba po veličinskoj kategoriji
graf_velicina <- ggplot(ribe, aes(x = velicina_ribe)) + 
  geom_bar(aes(fill = velicina_ribe)) + 
  theme_minimal() +
  labs(x = "Veličina ribe", y = "Broj riba")

print(graf_velicina)

# Provjerite tip varijable velicina_riba!
class()
str()

# Koristimo naredbu factor() da ručno uredimo poredak ove ordinalne kategoričke varijable
ribe$velicina_ribe <- 
  factor(ribe$velicina_ribe, 
         levels = c("juvenilna", "subadultna", "adultna"), ordered = TRUE)

# Ponovo provjerite tip varijable i nacrtajte barplot! Što se promjenilo?


### Eksportiranje ggplot grafa kao slike ili PDF dokumenta

ggsave(filename = "graf_velicina.jpg", # naziv JPG slike
       plot = graf_velicina, # koji objekt želimo eksportirati
       width = 8, height = 6, # dimenzije u inčima
       dpi = 300) # dots per inch

ggsave(filename = "graf_velicina.pdf", # naziv JPG slike 
       width = 8, height = 6, # dimenzije u inčima
       device = cairo_pdf) # naziv metode eksporta za PDF

# Je li ova veličina grafa dobra za A4 dokument?
# Izmjenite dimenzije tako da se font i podaci jasno vide!

###############################################################################

# Ispitivanje normalnosti distribucije

# 1. Histogram
hist(ribe$duljina_cm, 
     main = "Histogram duljine ribe (cm)", 
     xlab = "Duljina (cm)", ylab = "Broj riba",
     col = "lightblue", border = "black")

hist(ribe$starost_riba, 
     main = "Histogram starosti ribe (godine)", 
     xlab = "Starost (godina)", 
     col = "lightgreen", 
     border = "black")

# Koju razliku primjećujete u izgledima histogram?

# 2. Q-Q plot
qqnorm(ribe$duljina_cm, main = "Q-Q plot za duljinu ribe")
qqline(ribe$duljina_cm, col = "red")

qqnorm(ribe$starost_riba, main = "Q-Q plot za starost ribe")
qqline(ribe$starost_riba, col = "red")

# Koju razliku primjećujete u izgledima Q-Q plota?


# 3. Shapiro-Wilk test
shapiro.test(ribe$duljina_cm)

shapiro.test(ribe$starost_riba)

# Za koju varijablu je Shapiro-Wilk test značajan? Što to znači?


# 4. Cullen and Fray graf
descdist(ribe$duljina_cm, boot = 500)

descdist(ribe$starost_riba, boot = 500)

# Eksportiranje grafova u base R-u

# Otvorite uređaj za PNG format
png("graf.png", width = 2000, height = 1500, res = 300)  # 'res' je parametar za dpi

# Nacrtajte graf
hist(ribe$duljina_cm, main = "Histogram duljine riba", xlab = "Duljina (cm)", 
     col = "skyblue", border = "black")

# Zatvorite uređaj za izvođenje i spremite sliku
dev.off()


##############################################################################

# Zadaci
# 1.a Eksportirajajte napravljenje grafove, zalijepite ih u Word dokument.
# 1.b Objasnite svaki od korištenih grafova i testova.

# 2.a Napravite ispitivanje normalnosti za varijablu "brzina_plivanja".
# 2.b Je li varijabla normalno distribuirana? Napravite dokument izvještaja.

# 2.a Napravite ispitivanje normalnosti za varijablu "sbroj_jaja".
# 2.b Je li varijabla normalno distribuirana? Napravite dokument izvještaja.
