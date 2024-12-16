# Analize podataka u biološkim istraživanjima - praktikum 2024
# Lucija Kanjer lucija.kanjer@biol.pmf.hr

###############################################################################

# 7. Linearna regresija

# Uključene su sve korištene naredbe, ALI NEKE SU NEPOTPUNE ILI SADRŽE NAMJERNE POGREŠKE:
# Dovršite naredbe gdje je potrebno i dodajte komentare za sebe (koristite # za komentiranje)
#
# IZVRŠAVANJE NAREDBI: ctrl + Enter 
#
###############################################################################


# Učitajte potrebne pakete
library(ggplot2) # grafovi

# Postavljanje radnog direktorija
getwd()
setwd()

# Učitajte podatke iz CSV datoteke
# Podaci sadrže informacije o gustoći drveća, kabina i krupnom drvenom otpadu
jezera <- read.csv()

# Pogledajte prvih nekoliko redaka podataka kako biste razumjeli strukturu
head()

# Varijable:
# jezero - 16 jezera u Sjevernoj Americi
# obalno_drvece - gustoća obalnog drveća po kilometru (km−1)
# drvni_otpad - površina drvnog otpada u m2 po kilometru (m2 km−1)
# kolibe - gustoća ljudskih koliba po kilometru (no. km−1)


# Vizualizacija podataka

# Scatter plot odnosa drvnog otpada i gustoće obalnog drveća
ggplot(jezera, aes(x = kolibe, y = drvni_otpad)) +            
  geom_point() +                                      
  geom_smooth() +
  theme_minimal()

# Što prikazuje linija na scatterplotu?

# Prilagodimo scatterplot!

### Linearna regresija
# nezavisna varijabla: obalno_drvece
# zavisna varijabla: drvni_otpad

# Linearni Model: Utjecaj gustoće obalnog drveća na količinu drvnog otpada
model_drvece <- lm(drvni_otpad ~ obalno_drvece, data = jezera)

# Ispis sažetka modela za interpretaciju koeficijenata
summary(model_drvece)

# Grafička dijagnostika modela
par(mfrow = c(2, 2))
plot(model_drvece)

# Pogledajte rezidualne grafikone kako biste provjerili pretpostavke linearnog modela!

# Dodatno - ANOVA i predict

anova(model_drvece)
# Koje su vrijednosti sume kvadrata za model, a koji za pogršku?
# Koliko ima stupnjeva slobode?


predict(model_drvece, data.frame(obalno_drvece = c(1500)), interval = "confidence")

## Zadatak: Utjecaj koliba na količinu drvnog otpada

# Napravite scatterplot odnosa drvnog otpada i koliba
# Kreirajte novi model "model_kolibe" sa zavisnom varijabla: drvni_otpad i nezavisnom varijabla: kolibe
# Napravite grafičku dijagnostiku modela: kakva je normalnost reziduala? Jesu li varijance reziduala konstantne?
# Ispišite summary modela kolibe.

# Transformacija podataka

# Stvaranje novog vektora "log_kolibe"
jezera$log_kolibe <- log10(jezera$kolibe+1)

# Zašto dodajemo +1 prilikom logaritmiranja?

# Napravimo novi model s logaritmiranim podacima za kolibe!
model_log_kolibe <- lm(drvni_otpad ~ log_kolibe , data = jezera)

# Grafička dijagnostika modela!
par(mfrow = c(2, 2))
plot(model_log_kolibe)

summary(model_log_kolibe)


