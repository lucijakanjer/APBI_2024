# Analize podataka u biološkim istraživanjima - praktikum 2024
# Lucija Kanjer lucija.kanjer@biol.pmf.hr

##############################################################

# 3. Rad s podacima i objektima

# Uključene su sve korištenje naredbe, ALI NEKE SU NEPOTPUNE ILI SADRŽE NAMJERNE POGREŠKE:
# Dovršite naredbe i također dodajte komentare za sebe (koristite # za komentiranje)
#
# IZVRŠAVANJE NAREDBI: ctrl + Enter 
#
#############################################################


# Pregled trenutnog radnog direktorija
getwd()

# Postavljanje novog radnog direktorija
setwd()

# Učitavanje potrebnog paketa za čitanje Excel tablica
library(readxl)

# Učitavanje podataka iz Excel tablice u objekt penguins
penguins <- read_excel("pingvini.xlsx")

# Pregled tablice
View(penguins) # ili klik na objekt u environmentu

# Provjera tipa i strukture objekta
str() # u zagrade upišite naziv objekta

# PITANJE: "Koja je prosječna masa pingvina vrste Adelie u kilogramima na svakom od otoka?

# Učitavanje tidyverse paketa za manipulaciju podacima
library(tidyverse)

# Korak 1: Odabir relevantnih varijabli (stupaca)
select(penguins, # podaci
       species, # varijabla 1
       island, # varijabla 2
       body_mass_g)# varijabla 3

# Gdje je objekt? Zašto nije u environmentu?

# Ponovimo korak 1, ali kreirajmo novi objekt u koji će se spremiti
penguins_selected <- select(penguins, species, island, body_mass_g)
View(penguins_selected)

# Korak 2: Filtriranje uzoraka (redaka) vrste "Adelie"
penguins_adelie <- filter(penguins_selected, # podaci
                          species == "Adelie") # uvjet filtriranja
View(penguins_adelie)

# Korak 3: Kreiranje nove varijable koja sadrži masu izraženu u kilogramima
penguins_mass_kg <- mutate(penguins_adelie, # podaci
                           body_mass_kg = body_mass_g / 1000) # kreiranje nove varijable
View(penguins_mass_kg)

# Korak 4: Zadavanje grupiranja i prikaza rezultata po otocima
penguins_grouped <- group_by(penguins_mass_kg, # podaci
                             island) # varijabla po pokoj želimo grupirati
View(penguins_grouped)

# Korak 5: Kreiranje finalne sumariziranje tablice rezultata
penguins_result <- summarise(penguins_grouped, # podaci
                             average_mass = mean(body_mass_kg)) # nova varijabla za prosjek

# Ispis konačnog rezultata
print(penguins_result)

# Kako bi mogli izračunati rezultat za otok Torgersen moramo ukloniti nedostajuće podatke
# Uklanjanje uzoraka s nedostajućim podacima
penguins_cleaned <- na.omit(penguins_mass_kg)
View(penguins_cleaned)

# Ponovimo korake 4 i 5 s novom tablicom
# Korak 4: Zadavanje grupiranja i prikaza rezultata po otocima
penguins_grouped <- group_by(penguins_cleaned, island)
View(penguins_grouped)

# Korak 5: Kreiranje finalne sumariziranje tablice rezultata
penguins_result <- summarise(penguins_grouped, average_mass = mean(body_mass_kg))

# Ispis konačnog rezultata
print(penguins_result)

### Zadatak
# Koristeći gornje funkcije za manipulaciju podacima, odgovorite na pitanje: 
# Koja je prosječna masa u kilogramima pingvina vrste Gentoo mužjaka, a koja ženki?


# Korištenje pipe operatora za smanenje količine koda
adelie_result <- penguins %>% #podaci
  select(species, island, body_mass_g) %>% #odabir relevantnih varijabli
  filter(species == "Adelie") %>% #filtriranje samo pingvina vrste Adelie
  mutate(body_mass_kg = body_mass_g/1000) %>% #kreiranje nove varijable
  na.omit() %>% #uklanjanje nedostajućih vrijednosti
  group_by(island) %>% #grupiranje po otocima
  summarise(average_mass = mean(body_mass_kg)) #sumariziraj kao prosjek

print(adelie_result)

### Zadatak
# Koristeći pipe operator, odgovorite na pitanje: 
# Koja je prosječna masa u kilogramima pingvina vrste Gentoo mužjaka, a koja ženki?
