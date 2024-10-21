# Analize podataka u biološkim istraživanjima - praktikum 2024
# Lucija Kanjer lucija.kanjer@biol.pmf.hr

##############################################################

# 2. Unos podataka u programsko okruženje R i struktura objekata

# Neke naredbe su nepotpune ili sadrža namjerene pogrške!
# Dovršite naredbe i  dodajte komentare za sebe (koristite # za komentiranje)
#
# IZVRŠAVANJE NAREDBI: ctrl + Enter 
#
#############################################################

### Kreiranje objekata u R-u - ručni unos
# 1. Varijable
x <- 3.14         # brojčana vrijednost
y <- "DNA"        # tekst (mora ići u navodnike)
z <- TRUE         # logička vrijednost (TRUE/FALSE)

# Provjera tipa podataka
class(x) # prikazuje samo tip varijable
str(x) # struktura: prikazuje tip varijable i što ona sadrži

# Provjerite tip podataka varijabli y i z!

# 2. Vektori
geni <- c("BRCA1", "TP53", "MYC")  # tekstualni vektor gena
print(geni)
duljine <- c(1863, 1179, 1584)     # numerički vektor duljina gena u parovima baza (bp)
print(duljine)

# Učitajte vektor numeričkih vrijednosti od 1 do 1000!

# 3. Matrice - skup vektora istog tipa
# Definiranje matrice
matrix_mikrobi <- matrix(c(85, 47, 37, 10, 65, 50, 28, 8), 
                         nrow = 4, # postavljanje broja redaka u matrici
                         byrow = TRUE) # definiranje popunjavanja matrice po retcima

# Dodavanje naziva redaka i stupaca
rownames(matrix_mikrobi) <- c("Bakterija1", "Bakterija2", "Gljivica1", "Gljivica2")
colnames(matrix_mikrobi) <- c("CFU_kuhinja", "CFU_kupaonica")

print(matrix_mikrobi)
View(matrix_mikrobi)

# Na temelju gornjeg primjera kreirajte vlastit matrix 
# s brojnostima vrsta organizama i lokacijama po vlastitom izboru!

# 4. Podatkovni okvir (data frame) - skup vektora različitih tipova
df_mikrobi <- data.frame(
  CFU = c(85, 47, 37, 10, 65, 50, 28, 8), # numerički vektor
  mikrorganizam = c("Bakterija", "Bakterija", "Gljivica", "Gljivica"),  # tekstualni vektor 
  lokacija = c("kuhinja", "kupaonica", "kuhinja", "kupaonica") # tekstualni vektor
  )

# Uvid u data frame
print(df_mikrobi) # ispis u konzoli
View(df_mikrobi) # vizualizacija tablice u novom listu


### Učitavanje datoteka
# Podsjetimo se naredbi za provjeru i postavljanje radnog direktorija!
getwd()
setwd("C:/Users/lucij/Documents/APUBI") #izmjeniti za vaše računalo!

# Učitavanje tekstualnih datoteka:
# Prisjetimo se prošle vježbe i učitajte tablicu zivotinje.txt!


# Otvorite datoteku "biljke.csv" u Notepadu. Što primjećujete?
# Pokušajte otvoriti CSV tablicu u Excelu!

# Učitavanje CSV tablica
biljke <- read.csv("biljke.csv", header = TRUE)
View(biljke) # ili klik na objekt u environmentu

# Učitavanje Excel tablica
# Za Excel prvo moramo ucitati paket readxl
install.packages("readxl") # instalacija paketa readxl
library(readxl) # učitavanje paketa

# Učitavanje Excel tablice pingvini
pingvini <- read_excel("pingvini.xlsx")
View(pingvini) # ili klik na objekt u environmentu

# Pregled prvih redaka podataka
head(zivotinje)

# Pregled zadnjih redaka podataka
tail(zivotinje)

# Tipovi podataka - provjera strukture
str(zivotinje)

# Izvlačenje pojedinačnih stupaca i redaka iz data frame-a

# Stupac predstavlja varijable
vrsta_zivotinja <- zivotinje$vrsta  #data.frame$stupac
print(vrsta_zivotinja)

# Redak predstavlja uzorke
zivotinja_1 <- zivotinje[1, ] # data.frame[redak, stupac]
print(zivotinja_1)

# Pokušajte na isti način izdvojiti 1. stupac!
# Pokušajte na isti način izdvojiti vrijednost iz 1. stupca i 3. retka!

# Izvoz R objekata u datoteke
write.table(df_mikrobi, # definiramo koji objekt želimo eksportati
            file = "mikrobi.csv", # definiramo naziv datoteke
            sep = ",", # definiramo separatore stupaca
            row.names = FALSE) # definiramo da R ne zapiše broj redaka u zasebni stupac

## Zadaci

# 1. Kreirajte 2 varijable, u jednu spremite ime vrste po vašem izboru, a u drugu broj jedinki te vrste.
# 2. Ispištie tip objekta za novokreirane varijable.
# 3. Kreirajte 2 vektora, u jednom pohranite tekstove, a u drugom brojeve.
# 4. Kreirajte data frame s biološkim podacima po vašem izboru, mora sadržavati 2 numeričke i 2 kategoričke varijable.
# 5. Ispištie strukturu novokreiranog data frame-a.
# 6. Iz vašeg kreiranog data frame-a izolirajte jedan stupac i spremite ga u novi vektor.





