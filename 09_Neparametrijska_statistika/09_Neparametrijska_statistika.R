# Analize podataka u biološkim istraživanjima - praktikum 2024
# Lucija Kanjer lucija.kanjer@biol.pmf.hr

###############################################################################

# 9. Neparametrijska statistika i statitstika kategoričkih podataka

# Dovršite naredbe gdje je potrebno i dodajte komentare za sebe (koristite # za komentiranje)
#
# IZVRŠAVANJE NAREDBI: ctrl + Enter 
#
###############################################################################

# Učitavanje paketa
library(ggplot2)

# Neparametrijska statistika

# Pokus 1: Postotak uspjeha klijanja sjemenki bez gnojiva (kontrola) i s gnojivom

# Učitavanje dataseta
biljke_pokus1 <- read.csv("biljke_pokus1.csv")

# Pogledajte tablicu!

# Vizualizacija podataka iz pokusa 1
boxplot(biljke_pokus1)

# Histogrami
par(mfrow = c(1, 2))
hist(biljke_pokus1$kontrola, main = "Histogram kontrola")
hist(biljke_pokus1$gnojivo, main = "Histogram gnojivo")
par(mfrow = c(1, 1))

# Ima li statistički značajne razlike između grupa kontrola i gnojivo?
# Podaci nisu normalno distribuirani, stoga ne možemo koristiti t-test!
# Moramo koristiti test koji ne pretpostavlja normalnu distribuciju podataka.

# Wilcoxon-Mann-Whitney test za neovisne uzorke
wilcox.test(grupa1, grupa2)

# Spremite rezultate testa u objekt "wilcoxon_test"

# Pokus 2: broj plodova prije i poslije dodatka gnojiva

# Učitajte dataset!
biljke_pokus2 <- read.csv()

# Vizualizacija
boxplot()

par(mfrow = c(1, 2))
hist()
par(mfrow = c(1, 2))

# Wilcoxonov test za uparene uzorke
wilcox.test(prije, poslije, paired = )

# Ima li statistički značajne razlike između broja plodova na biljci prije i nakon dodatka gnojiva?

# Spremite rezultate testa u objekt "wilcoxon_test_paired"

### Statistika kategoričkih podataka

# Pokus 3: Broj uspješno klijanih sjemenki pod tri različita tretmana

# Učitajte dataset!
biljke_pokus3 <- read.csv()

print()

# Vizualizacija podataka
ggplot(biljke_pokus3, aes(x = gnojiva, y = proklijano)) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_hline(aes(yintercept = ocekivano), color = "red", linetype = "dashed") +
  theme_minimal()

# hi-kvadrat test
chisq.test(promatrano, p = ocekivano / sum(ocekivano))

# Spremite test u objekt "hikvadrat_test"

# Pokus 4: Udio uspješno klijanih sjemenki pod određenim uvjetima

# Učitavanje dataseta
biljke_pokus4 <- read.csv()

print(biljke_pokus4)

# Binomialni test
binom.test(uspjesi, pokušaji, p = vjerojatnost)

# Je li postotak uspjeha značajno različit od očekivanog?


# Samostalni zadaci:
# Tema: Utjecaj različitih prehrana na težinu miševa

# Zadatak 1
# Učitajte tablicu "misevi_zadatak1.csv"
# Napravite boxplot podataka
# Napravite histograme za varijable.
# Jesu li težine miševa pod prehranom A i prehranom B značajno različite?

# Zadatak 2
# Učitajte tablicu "misevi_zadatak2.csv"
# Napravite boxplot podataka
# Napravite histograme za varijable.
# Postoji li značajna razlika između težina miševa prije i poslije promjene prehrane?

# Zadatak 3
# Učitajte tablicu "misevi_zadatak3.csv"
# Napravite barplot.
# Promatrani broj miševa s poboljšanjem težine pod tri različite prehrane:
# Postoji li značajna razlika između promatranih i očekivanih rezultata?

# Zadatak 4
# Učitajte tablicu "misevi_zadatak4.csv"
# Od 15 miševa pod određenom prehranom, njih 10 je pokazalo poboljšanje težine.
# Je li postotak poboljšanja značajno različit od očekivanih 50%?
