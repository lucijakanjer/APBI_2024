# Analize podataka u biološkim istraživanjima - praktikum 2024/25

# Lucija Kanjer, lucija.kanjer@biol.pmf.hr

###############################################################################

# 11. Multivarijantna statistika: morfologija dijatomeja

###############################################################################

# Instalacija i učitavanje potrebnih paketa
library(Hmisc) # napredna obrada podataka, korelacija sa p-vrednostima
library(vegan) # paket za ekološke analize (brojnosti vrsta), PCA
library(MASS) # diskriminantna analiza
library(psych) # paket za analize koje se često koriste u psihologiji
library(cluster) # klaster analize
library(ggplot2) # grafovi
library(ggfortify) # za vizualizaciju rezultata statističkih analiza
library(tidyverse) # iz nekog razloga bitno je ovo učitati zadnje u ovoj vježbi

# Učitavanje podataka o dijatomejama
diatoms 


# 1. Vizualna eksploracija varijabli po grupama dijatomeja

# Histogram
ggplot(diatoms, aes(x = length_um)) +
  geom_histogram( color = "black", fill = "lightgreen") + 
  labs(title = "Length") +
  facet_wrap(~ group, nrow = 3) +
  theme_minimal()

# Boxplot
ggplot(diatoms, aes(x = group, y = length_um)) +
  geom_boxplot(aes(fill = group)) + 
  theme_minimal()

# Odaberite što vam je informativnije, histogram ili boxplot te napravite taj graf za ostatak varijabli!

# Kako se ponašaju varijable? Ima li varijabli čiji grafovi jako odstupanju od drugih?
# Ima li grupa koje su vizualno "sličnije"?


# 2. Korelacijske analize

# naredba "rcorr" iz paketa Hmisc prikazuje nam korelacije i značajnost tih istih korelacija (p-vrijednosti)
korelacije <- rcorr(as.matrix(ddata[1:12]))
korelacije

# Scatterplot svih varijabli
pairs(
  data %>% select(where(is.numeric)),  # odabir samo numerićkih varijabli
  main = "Scatterplot matrica",
  pch = 19,
  col = c("pink", "lightgreen", "lightblue")[as.numeric(factor(data$group))]
)

# 3. Analiza glavnih komponenti (PCA - Principal Component Analysis)
# Statistička tehnika za reduciranje dimenzionalnosti podataka.
# Pronalaženje linearnih kombinacija originalnih varijabli koje maksimiziraju varijancu.
# Koristi se za vizualizaciju i prepoznavanje skrivenih obrazaca u podacima.

# prcomp s opcijom scale. = TRUE standardizira podatke kako bi sve varijable imale jednak doprinos
pca <- prcomp(data %>% select(variable1:variable2), scale. = TRUE)
print()
# rezultat su "loadings" - korelacije izvornih varijabli sa princ. komponentama (PC1, PC2...)

# ovdje se vidi ukupno objasnjena varijanca svake PC osi
summary()

# scree plot - prikazuje doprinos svake komponente ukupnoj varijanci
plot()

# Vizualizacija PCA
# PCA scatterplot obojen prema grupama dijatomeja, s prikazom "loadings" vektora
autoplot(pca, data = your_data, colour = 'group',
         loadings = TRUE, loadings.label = TRUE, loadings.colour ="gray", loadings.label.size = 3) +
  theme_classic()


# 4. Diskriminantna analiza (LDA - Linear discriminant analysis)
# LDA je metoda klasifikacije koja maksimizira razlike između grupa
# Metoda za klasifikaciju podataka u unaprijed definirane grupe.

# izračunavanje linearne diskriminantne funkcije za separaciju grupa dijatomeja
lda <- lda(group ~ variable1 + variable2 + variable3 , data = your_data)
print()
# Koeficijenti: Pokazuju doprinos svake varijable u razdvajanju grupa.

# test "sortiranja" - primjenimo dobivenu diskrim. funkciju ponovo na citav dataset
lda_predict <- predict()

# Posteriorne vjerojatnosti: Pokazuju pouzdanost klasifikacije.
head(lda_predict$posterior)

# koliko ih je tocno sortirao (80%)
mean(lda_predict$class==data$group)

# tablica tocne vs. predviđene grupe
table(pred = lda_predict$class, true = diatoms$group)

# Vizualizacija LDA
diatoms$LDA1 <- lda_predict$x[,1]
diatoms$LDA2 <- 
diatoms$predicted <-

head(diatoms)

ggplot(data, aes()) +
  geom_point() +
  theme_minimal()

# Napredno prilagođavanje oblika i boja
ggplot(diatoms, aes(x = LDA1, y = LDA2, color = group, shape = predicted)) +
  geom_point(size = 3) +
  scale_shape_manual(values = c(15, 17, 18)) +
  scale_color_manual(values = c("#00AFBB", "#E7B800", "#FC4E07"))+
  labs(title = "LDA Scatterplot", x = "LDA1", y = "LDA2") +
  theme_minimal()
