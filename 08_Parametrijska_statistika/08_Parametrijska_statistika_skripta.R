# Analize podataka u biološkim istraživanjima - praktikum 2024
# Lucija Kanjer lucija.kanjer@biol.pmf.hr

###############################################################################

# 8. Parametrijska statistika

# Uključene su sve korištene naredbe, ALI NEKE SU NEPOTPUNE ILI SADRŽE NAMJERNE POGREŠKE:
# Dovršite naredbe gdje je potrebno i dodajte komentare za sebe (koristite # za komentiranje)
#
# IZVRŠAVANJE NAREDBI: ctrl + Enter 
#
###############################################################################

## Učitavanje paketa
library(tidyverse) # tidyr, dplyr, ggplot2
library(car)

# Učitavanje podataka

amphibians <- read.csv("amphibians.csv")

head(amphibians)

str(amphibians)

# Pretvaranje varijable Exposure u faktor
amphibians$Exposure <- as.factor(amphibians$Exposure)

# Jedan uzorak - odgovara li teoretskoj srednjoj vrijednosti?

# Distrubucija ekspresije gena za CYP1A1

# Histogram za ekspresiju
ggplot(amphibians %>% filter(Exposure == "Low"), aes(x = GeneExpression)) + 
  geom_histogram(binwidth = 7, fill = "lightgreen", color = "black") +
  theme_minimal() +
  scale_x_continuous("CYP1A1 expression (FPKM)") +
  geom_vline(xintercept = 50, size = 2, color = "darkgreen")

# Prvo želimo testirati srednju vrijednost varijable Exposure

### t-test za jedan uzorak za vodozemce s "Low" vrijednostima Exposure
# Je li statistički značajno da je srednja vrijednost našeg uzorka jednaka 50?
t.test(amphibians[amphibians$Exposure == "Low", "GeneExpression"], mu = 50)

# Dva uzorka: razlikuju li se srednje vrijednosti između "Low" i "high" izloženosti PCB-u?

### Boxplot za ekspresiju gena iz "Low" i "High" grupe

boxplot(GeneExpression ~ Exposure, data = amphibians,
        col = c("lightgreen", "red"),
        main = "Gene Expression by PCB Exposure Level",
        ylab = "CYP1A1 Expression (FPKM)", xlab = "PCB Exposure Level")

### t-test za dva uzrka 
# dvostrani
t_test_twotailed <- t.test(GeneExpression ~ Exposure, data = amphibians, var.equal = T)
print() # unesi objekt t-testa!

# jednostrani
t_test_result_one <- t.test(GeneExpression ~ Exposure, data = amphibians,  var.equal = T, 
                            alternative = "g") # opcija za jednostrani test
print() # unesi objekt t-testa!

# Kako se odnose p-vrijednost jednostranog i dvostranog testa?


### Pretpostavke za t-test:
# Normalnost distribucije podataka
# jednake varijance između uzoraka (raspršenost, st.dev)
# neovisni uzorci

# Testiranje normalnosti funkcije

# Histogram 
ggplot(amphibians %>% filter(Exposure == "Low"), aes(x = GeneExpression)) + 
  geom_histogram(binwidth = 3, fill = "lightgreen", color = "black") +
  theme_minimal() +
  scale_x_continuous("CYP1A1 expression (FPKM)") 

ggplot(amphibians %>% filter(Exposure == "High"), aes(x = GeneExpression)) + 
  geom_histogram(binwidth = 3, fill = "lightblue", color = "black") +
  theme_minimal() +
  scale_x_continuous("CYP1A1 expression (FPKM)") 

# Napravite histograme s različitim binwidth vrijednostima!

### qqplot za "Low"
qqnorm(amphibians[amphibians$Exposure == "Low", "GeneExpression"])
qqline(amphibians[amphibians$Exposure == "Low", "GeneExpression"])

# Shapiro-Wilk test za "Low"
shapiro.test(amphibians[amphibians$Exposure == "Low", "GeneExpression"])

## qqplot za "High"

# Shapiro-Wilk test za "High"

## Levene-ov test test za jednake varijance
leveneTest(GeneExpression ~ Exposure, data = amphibians)

# Što kad želimo testirati uzorke koji nemaju jednake varijance?

### Imunološki odgovor: Utjecaj PCB kemikacija na citokine
# Primjer: varijabla "cytokine_level"

### Vizualizacija jednolikosti varijanci (raspršenosti)

# Boxplot
boxplot(CytokineLevel ~ Exposure, data = amphibians,
        col = c("lightgreen", "orange"),
        main = "IL-6 Levels by PCB Exposure Level",
        ylab = "IL-6 Level (pg/mL)", xlab = "PCB Exposure Level")

### Levene-ov test

leveneTest(CytokineLevel ~ Exposure, data = amphibians)

### t-test za dva uzorka - nejednake varijance (Welchov test)

t_test_cytokine <- t.test(CytokineLevel ~ Exposure, data = amphibians, 
                          var.equal = F) #uvjet za nejednake varijance
print(t_test_cytokine)

### Što kad želimo testirati uzorke koji nisu neovisni?

# Učitavanje uparenih podataka o pokusu na vodozemcima

amphibians_experiment <- read.csv("amphibians_experiment.csv")

#Pogledajmo podatke!
head()
str()

# Pretvaranje varijable Exposure u faktor
amphibians_experiment$Exposure <- as.factor(amphibians_experiment$Exposure)

### Cytokine visualization - paired data

# Visualization
boxplot(CytokineLevel ~ Exposure, data = amphibians_experiment,
        col = c("lightgreen", "gold"),
        #main = "IL-6 Levels by PCB Exposure Level",
        ylab = "IL-6 Level (pg/mL)", xlab = "Time")

### t-test 
t_test_cytokine <- t.test(CytokineLevel ~ Exposure, data = amphibians_experiment, var.equal = F)
print(t_test_cytokine)

# pretvaranje tablice iz dugackog (long) u siroki (wide) format

cytokine_wide <- amphibians_experiment %>%
  pivot_wider(names_from = Exposure, values_from = CytokineLevel, id_cols = AmphibianID)

### t-test za uparene uzorke
t_test_cytokine <- t.test(cytokine_wide$"0_weeks", cytokine_wide$"2_weeks", 
                          paired = TRUE)
print(t_test_cytokine)

### ANOVA - Analiza varijance - t-test za više grupa

# Učitajmo novi dataset "fotosinteza.xlsx"
library(readxl)   # For reading Excel files
fotosinteza

# Pogledajmo dataset!
View()
str()

# Dataset: utjecaj toplinskog šoka na klijance Arabidopsis thaliana
# grupa: wt_k - kontrola, wt_37 - klijanci s predtretmanom na 37C, wt_42 - klijanci bez toplinskog predtretmana
# temp: temperatura tretmana klijanaca za vrijeme pokusa
# aklimatizacija_37: DA, NE ili N/A
# pi_Abs: prvi parametar za fotosintetsku učinkovitost
# FvFm: drugi parametar za fotosintetsku učinkovitost
# DREB2A: ekspresija gena DREB2A povezanog s toplinskom aklimatizacijom
# HSFA3: ekspresija gena HSFA3 povezanog s toplinskom aklimatizacijom


# Pretvorimo varijablu "grupa" u faktor"
as.factor()

# Vizualizirajmo odnos varijable "Pi_Abs" između grupa

ggplot(fotosinteza, aes(x = grupa, y = Pi_Abs)) +
  geom_boxplot() +
  theme_minimal()

# Isprobajte i ostale prikaza: boxplot i violin plot!

ggplot(fotosinteza, aes(x = grupa, y = Pi_Abs)) +
  geom_point() +
  stat_summary(fun.data = 'mean_se', geom = 'errorbar', width = 0.2) +
  stat_summary(fun.data = 'mean_se', geom = 'pointrange') +
  theme_minimal()

# Napravimo ANOVA analizu
# Pitanje: postoji li razlika u srednjim vrijednostima fotosintetske aktivnosti
# između grupa kontrole i različitih tretmana biljaka?
aov(Pi_Abs ~ grupa, data = fotosinteza)

# Spremite rezultate ANOVA teszta u objekt "anova_Pi_Abs"

# Pregled rezultata ANOVA-e
summary()

# Post-hoc analiza ukoliko je ANOVA značajna

# Tukey's Honest Significant Difference Test
posthoc_Pi_Abs <- TukeyHSD(anova_Pi_Abs)
print(posthoc_Pi_Abs)

# Napravite ANOVA analizu za drugi paramatar fotosintetske učinkovitosti i ekspreije oba gena!


