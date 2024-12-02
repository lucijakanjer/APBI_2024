# Analize podataka u biološkim istraživanjima - praktikum 2024
# Lucija Kanjer lucija.kanjer@biol.pmf.hr

###############################################################################

# 6. Deskriptivna statistka

# Uključene su sve korištene naredbe, ALI NEKE SU NEPOTPUNE ILI SADRŽE NAMJERNE POGREŠKE:
# Dovršite naredbe gdje je potrebno i dodajte komentare za sebe (koristite # za komentiranje)
#
# IZVRŠAVANJE NAREDBI: ctrl + Enter 
#
###############################################################################

# Instalacija i učitavanje potrebnih paketa
install.packages("") # nadopuni za nove pakete!

library(dplyr) # manipulacija tablicama
library(ggplot2) # crtanje grafova
library(patchwork) # spajanje više grafova u jedan plot
library(data.table) # statistika po postajama

# Postavljanje radnog direktorija
getwd()
setwd()

# Učitavanje seta podataka o rakovima u na postaji istok i zapad
rakovi <- read.csv("rakovi.csv", header = TRUE)

# Pregledajte set podataka!
str(rakovi)
head(rakovi)

# Histogrami - pregled distribucije kontinuiranih numeričkih varijabli
# Prvo cemo kreirati objekte, a onda ih ispisati sve na jednom plotu

histogram_duljina <- ggplot(rakovi, aes(x = duljina)) +
  geom_histogram(binwidth = 1, color = "black", fill = "lightgreen") + 
  labs(title = "Histogram duljine rakova", subtitle = "opis: ") +
  theme_minimal()

histogram_masa <- ggplot(rakovi, aes(x = masa)) +
  geom_histogram(binwidth = 50, color = "black", fill = "lightblue") + 
  labs(title = "Histogram mase rakova", subtitle = "opis: ") +
  theme_minimal()

histogram_temperatura <- ggplot(rakovi, aes(x = temperatura)) +
  geom_histogram(binwidth = 3, color = "black", fill = "pink") + 
  labs(title = "Histogram temperature vode", subtitle = "opis: ") +
  theme_minimal()

histogram_patogeni <- ggplot(rakovi, aes(x = patogeni)) +
  geom_histogram(binwidth = 2, color = "black", fill = "lightyellow") + 
  labs(title = "Histogram patogena na rakovima", subtitle = "opis: ") +
  theme_minimal()

# Spajanje 4 grafa u 1 pomoću paketa patchwork
(histogram_duljina + histogram_masa) / (histogram_temperatura + histogram_patogeni)

# Zadatak: Opisati izgled distrubucije - simetričnost, nagnutost - u subtitle!
# Spremite ovaj graf kao JPEG sliku!

histogrami <- (histogram_duljina + histogram_masa) / (histogram_temperatura + histogram_patogeni)

ggsave(filename = "rakovi_histogrami.jpg", # naziv JPG slike
       plot = histogrami, # koji objekt želimo eksportirati
       width = 8, height = 6, # dimenzije u inčima
       dpi = 300) # dots per inch

# Usporedba distribucije varijabli po postajama istok i zapad

# Crtamo isti histogram kao i ranije, ali koristimo facet_wrap za odvajanje po postajama
histogram_duljina_postaje <- ggplot(rakovi, aes(x = duljina)) +
  geom_histogram(binwidth = 1, color = "black", fill = "lightgreen") + 
  labs(title = "Histogram duljine rakova", subtitle = "opis: ") +
  facet_wrap(~ postaja, nrow = 2) + #odvaja histograme po grupirajucoj varijabli postaja
  theme_minimal()

print(histogram_duljina_postaje)

# Kako sad izgleda distrubucija? Opišite u subtitle!

# Napravite histograme usporedbe po postajama i za varijable masa, temperatura i patogeni!
# Opišite nove izgled distribucije u subtitle!

histogram_masa_postaje

histogram_temperatura_postaje

histogram_patogeni_postaje

# Deskriptina statistika

# Naredba summary() - pregled kvartila, medijana i aritmetičke sredine
summary(rakovi) # cijeli dataset
summary(rakovi$duljina) #samo jedna varijabla

# Simetrične i normalne distribucije
# Aritmetička sredina za duljinu
mean(rakovi$duljina)

# SD - Standardna devijacija za duljinu
sd(rakovi$duljina)

# SE - Standardna pogreška za duljinu (Standard Error)
sd(rakovi$duljina) / sqrt(length(rakovi$duljina))

# Asimetrične distribucije
# Medijan za masu
median(rakovi$masa)

# Interkvartilni range (IQR) za masu
IQR(rakovi$masa)

# Raspon (Range) za temperaturu
range(rakovi$masa)

# Deskriptivna statistika po grupirajućoj varijabli "postaja"

# Paket "data.table" - daje lijep tablični prikaz deskritipne statistike
# setDT() naredba preoblikuje dataset da ga mozemo koristiti s paketom data.table
setDT(rakovi)

# Kategoricku grupirajucu varijablu "postaja" moramo pretvoriti u faktor naredbom as.factor()
rakovi$postaja <- as.factor(rakovi$postaja)
str(rakovi$postaja)

# Summary - pregled kvartila, medijana i aritmetičke sredine
# za varijablu "duljina"
rakovi[, as.list(summary(duljina)), by = list(postaja)]

# Izmjenite gornju naredbu da umjesto summary prikazuje vrijednosti standarne devijacije!

# Sličnu tablicu možemo generirati pomoću "dplyr" objekta
# Podsjetimo se pipe operatora i vježbe "Rad s podacima"!
summary_duljina_postaje <- rakovi %>%
  group_by(postaja) %>%
  summarise(
    minimum = min(duljina),
    Q1 = quantile(duljina, 0.25),
    medijan = median(duljina),
    prosjek = mean(duljina),
    Q3 = quantile(duljina, 0.75),
    maximun = max(duljina),
    stdev = sd(duljina) 
  )

print(summary_duljina_postaje)

# Izvoz u tablicu
write.csv(summary_duljina_postaje, # naziv R objekta
          "summary_duljina_postaje.csv", # naziv nove CSV datoteke 
          row.names = FALSE, quote = FALSE) # postavke

# Grafički prikazi deskriptivne statistike

# Stupičasti dijagram: duljina (aritmetička sredina i standardna devijacija)
barplot_duljina <- ggplot(summary_duljina_postaje, aes(x = postaja, y = prosjek)) +
  geom_bar(stat = "identity", fill = "skyblue", color = "black") +
  geom_errorbar(aes(ymin = prosjek - stdev, ymax = prosjek + stdev), width = 0.2) +
  labs(x = "", y = "prosječna duljina (cm)") +
  theme_minimal()

print(barplot_duljina)

# Boxplot usporedbe: masa, temperatura i patogeni između postaja zapad i istok
boxplot_masa <- ggplot(rakovi, aes(x = postaja, y = masa, fill = postaja)) +
  geom_boxplot() +
  theme_minimal() +
  labs(x = "", y = "Masa (g)")

boxplot_temperatura <- ggplot(rakovi, aes(x = postaja, y = temperatura, fill = postaja)) +
  geom_boxplot() +
  theme_minimal() +
  labs(x = "", y = "Temperatura (°C)")

boxplot_patogeni <- ggplot(rakovi, aes(x = postaja, y = patogeni, fill = postaja)) +
  geom_boxplot() +
  theme_minimal() +
  labs(x = "", y = "Patogeni")

# Prikaz svih plotova na jednom plotu
(barplot_duljina + boxplot_masa) / (boxplot_temperatura + boxplot_patogeni)

# Zadatak

# U setu podataka o pingvinima ("pingvini.xlsx") napravite usporedbu mase pingvina po vrstama!

# Napravite novu mapu naziva "samostalni_zadatak" i postavite ju kao radni direktorij.
# Učitajte tablicu u radno okruženje.
# Napravite tablicu da sadrži samo podatke o vrsti i masi pingvina.
# Grafički prikažite broj pingvina svake vrste. Koristite odgovarjući graf za kategoričku varijable.
# Napravite histogram za masu pingvina svake vrste.
# Opišite kako izgleda distribucija podataka o masi s obzirom na simetričnost i nagnutost.
# Ispitajte je li distribucija normalna koristeći Q-Q plot i Shapiro-Wilk test.
# Izračunajte deskriptivnu statistiku (summary) za masu svake vrste pingvina.
# Izračunajte aritmetičku standardnu devijaciju i standardnu pogrešku.
# S obzirom izgled distribucije, je li bolje kosristiti aritmetičku sredinu ili medijan za prikaz centralne tendencije?
# Grafički usporedite mase između vrsta (npr. boxplot).
# Komentirajte usporedbu deskriptive statistike mase između vrsta.






