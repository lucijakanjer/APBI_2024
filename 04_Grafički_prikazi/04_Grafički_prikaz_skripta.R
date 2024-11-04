# Analize podataka u biološkim istraživanjima - praktikum 2024
# Lucija Kanjer lucija.kanjer@biol.pmf.hr

##############################################################

# 4. Grafički prikaz bioloških podataka u R-u

# Uključene su sve korištenje naredbe, ALI NEKE SU NEPOTPUNE ILI SADRŽE NAMJERNE POGREŠKE:
# Dovršite naredbe i također dodajte komentare za sebe (koristite # za komentiranje)
#
# IZVRŠAVANJE NAREDBI: ctrl + Enter 
#
#############################################################

# Učitavanje paketa
library(readxl) # excel tablice
library(ggplot2) # paket za crtanje grafova
library(dplyr) # paket za manipulaciju tablicama

# Postavljanje  radnog direktorija
getwd()

setwd()

# Učitavanje seta podataka o pingvinima
penguins <- read_excel("pingvini.xlsx")

View(penguins)

###############################################################################

# Različiti načini grafičkih prikaza - base R vs. ggplot2

# Primjer 1: Histogram
# Base R histogram
hist(penguins$body_mass_g,
     main = "Distribucija mase tijela pingvina (Base R)",
     xlab = "Masa tijela (g)",
     col = "lightblue",
     border = "black")

# ggplot2 histogram
ggplot(penguins, aes(x = body_mass_g)) +
  geom_histogram(binwidth = 500, fill = "lightblue", color = "black") +
  labs(title = "Distribucija mase tijela pingvina (ggplot2)", 
       x = "Masa tijela (g)")

# Odaberite jednu numeričku varijablu i za nju napravite histogram na oba načina!

# Primjer 2: Stupičasti dijagram (bar plot)

# Prvo: Kreiranje tablice za broj pingvina po vrsti
species_count <- table(penguins$species)
print(species_count)

# Base R barplot
barplot(species_count,
        main = "Distribucija pingvina po vrsti (Base R)",
        xlab = "Vrsta",
        ylab = "Broj pingvina",
        col = "darkorange")

# Koju grešku uočavate na prikazu ovog grafa? 
# Probajte naći rješenje na iternetu kako to ispraviti!

# ggplot2 barplot
ggplot(penguins, aes(x = species)) +
  geom_bar(fill = "darkorange") +
  labs(title = "Distribucija pingvina po vrsti (ggplot2)", 
       x = "Vrsta", 
       y = "Broj pingvina")

# Napravite barplot distribucije pingvina po otocima! Odaberite drugu boju!
# Pazite da izmjenite nazive na osima! 

# Primjer 3: Točkast dijagram (scatter plot)
# Base R scatter plot
plot(penguins$bill_length_mm, penguins$bill_depth_mm,
     main = "Odnos dužine i dubine kljuna (Base R)",
     xlab = "Dužina kljuna (mm)",
     ylab = "Dubina kljuna (mm)",
     col = "darkgreen", pch = 19)

# ggplot2 scatter plot
ggplot(penguins, aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point(color = "darkgreen", size = 2) +
  labs(title = "Odnos dužine i dubine kljuna (ggplot2)", 
       x = "Dužina kljuna (mm)", 
       y = "Dubina kljuna (mm)")

# Odaberite 2 nove varijable i pokažite ih pomoću scatter plota!

###############################################################################

# ggplot2 paket - slojevi i estetika

# 1. Osnovni graf bez slojeva

ggplot() # osnovna naredba

# Osnovni grafikon - postavljamo estetiku, ali bez sloja
ggplot(data = penguins, aes(x = bill_length_mm, y = bill_depth_mm))

# 2. Dodavanje prvog geometrijskog sloja: scatter Plot
ggplot(data = penguins, aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point()

# 3. Dodavanje boje kao estetike i većih točaka
ggplot(data = penguins, aes(x = bill_length_mm, y = bill_depth_mm, color = species)) +
  geom_point(size = 3)

# 4. Dodavanje trenda sa geom_smooth()
ggplot(data = penguins, aes(x = bill_length_mm, y = bill_depth_mm, color = species)) +
  geom_point(size = 3) +
  geom_smooth(method = "lm", se = FALSE)  # linearna regresija bez prikaza greške

# 5. Dodavanje naslova i oznaka osi sa slojem labs()
ggplot(data = penguins, aes(x = bill_length_mm, y = bill_depth_mm, color = species)) +
  geom_point(size = 3) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Odnos između dužine i dubine kljuna kod pingvina",
       x = "Dužina kljuna (mm)",
       y = "Dubina kljuna (mm)")

# 6. Podešavanje tema sa slojem theme()
ggplot(data = penguins, aes(x = bill_length_mm, y = bill_depth_mm, color = species)) +
  geom_point(size = 3) +  
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Odnos između dužine i dubine kljuna kod pingvina",
       x = "Dužina kljuna (mm)",
       y = "Dubina kljuna (mm)") +
  theme_minimal()  # Minimalna tema za čist izgled

# 7. Finalno prilagođavanje: promjena skale boja

ggplot(data = penguins, aes(x = bill_length_mm, y = bill_depth_mm, color = species)) +
  geom_point(size = 3) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Odnos između dužine i dubine kljuna kod pingvina",
       x = "Dužina kljuna (mm)",
       y = "Dubina kljuna (mm)") +
  scale_color_manual(values = c("Adelie" = "skyblue", "Chinstrap" = "darkred", "Gentoo" = "darkgreen")) +
  theme_minimal()

# Prisjetite se gradive prošle vježbe - manipulacija tablicom i napravite 3 grafa po uzoru na gornji:
# svaki graf neka pokazuje odnos duljine i dubine kljuna za 1 vrstu!

###############################################################################

# Grafički prikazi po tipu varijabli

# 1. Grafički prikazi kategoričkih varijabli
# 1.1 Tablica frekvencija za prikaz broja pingvina po vrstama.
table(penguins$species)

# Spremite ovu tablicu kao CSV dokument!

# 1.2 Barplot za prikaz distribucije pingvina po vrstama.

ggplot(penguins, aes(x = species)) + 
  geom_bar() + 
  theme_minimal()

# Kako prikazati kategorije vrste od najbrojnije do najmanje brojne?
# Moramo pretvoriti kategoričku varijablu "species" u faktor!

penguins$species <- factor(penguins$species, 
                           levels = names(sort(table(penguins$species), decreasing = TRUE)))

# Sad ponovo nacrtajte barplot!

# 1.3 Pie chart za prikaz udjela pingvina po vrstama.
species_count <- penguins %>% count(species)

pie(species_count$n, labels = species_count$species, 
    main = "Udio pingvina po vrstama", 
    col = rainbow(length(species_count$species)))

# Pokušajte na internetu naći kako nacrtati pitu u ggplotu!

# 2. Grafički prikazi numeričkih varijabli
# 2.1 Histogram za prikaz distribucije mase tijela pingvina.
ggplot(penguins, aes(x = body_mass_g)) +
  geom_histogram(binwidth = 100, color = "black", fill = "darkred") + 
  theme_minimal()

# Poigrajte se s opcijom "binwidth"!
# Što se događa s grafom? Koja vrijednost najbolje pokazuje distrubuciju?

# Napravite histogram za još jednu numeričku varijablu!
# Koja opcija binwidth je najbolja za tu varijablu?

# 2.2 Tablica deskriptive statistike za numeričku varijablu mase.
summary(penguins$body_mass_g)

# Spremite ovu tablicu kao CSV!


# 3. Prikaz odnosa između dvije kategoričke varijable
# 3.1 Bar plot
ggplot(data = penguins, aes(x = species, fill = sex)) +
  geom_bar(position = "dodge") +
  theme_minimal()

# 3.2 Stacked bar plot
ggplot(data = penguins, aes(x = species, fill = sex)) +
  geom_bar() +
  theme_minimal()

# Relativni odnos
ggplot(data = penguins, aes(x = species, fill = sex)) +
  geom_bar(position = "fill") + 
  theme_minimal()

# Prisjetite se gradiva prošle vježbe i uklonite nedostajuće vrijednosti pa ponovite grafove!

# 4. Prikaz odnosa između dvije numeričke varijable
# 4.1 Točkaskti graf (scatter plot)
ggplot(data = penguins, aes(x = bill_length_mm, y = bill_depth_mm, color = species)) +
  geom_point() +
  theme_minimal()

# 5. Prikaz odnosa između numeričke i kategoričke varijable
# 5.1 Box plot
ggplot(data = penguins, aes(x = species, y = body_mass_g, fill = species)) +
  geom_boxplot() +
  theme_minimal()

# 5.2 Violin plot
ggplot(data = penguins, aes(x = species, y = body_mass_g, fill = species)) +
  geom_violin() +
  theme_minimal()

# 5.3 Strip chart
ggplot(data = penguins, aes(x = species, y = body_mass_g, color = species)) +
  geom_jitter() +
  theme_minimal()

# Prikažite na istom grafu boxplot-ove i strip-chart kombinirajuće slojeve u ggplotu!
# Napravite isto za violin plot!

# 5.4 Višestruki histogrami
ggplot(data = penguins, aes(x = body_mass_g)) +
  geom_histogram(binwidth = 200, color = "black", fill = "lightblue") +
  facet_wrap( ~ species, ncol = 1, scales = "free_y", strip.position = "right") +
  theme_minimal()

# Napravite višestruki histogram za duljinu peraja!
# Dodajte nazive osi!

# Zadatak

# 1. Učitajte tablicu proširenog dataseta s pingvinima: palmerpengiuns_extended.
# 2. Napravite grafove za:
#    a) jednu numeričku varijablu po izboru,
#    b) jednu kategoričku varijablu po izboru,
#    c) odnos dvije numeričke varijable po izboru,
#    d) odnos dvije kategoričke varijable po izboru,
#    e) odnos kategoričke i numeričke varijable po izboru.
# Poigrajte se s temama i bojama kako bi dobili graf koji najbolje prikazuje informaciju koju želite prikazati!