# Generiranje dataseta "ribe" za Vježbu 5"
# Postavljanje random seed-a za reproduktivnost
set.seed(737)

# Generiranje podataka
uzorak <- c(1:30)
duljina_cm <- rnorm(30, mean = 30, sd = 5) # Normalno distribuirana duzina ribe
masa_g <- rlnorm(30, meanlog = 4, sdlog = 0.5) # Log-normalno distribuirana tezina ribe
brzina_plivanja <- rnorm(30, mean = 2, sd = 0.5)  # normalna distribucija
starost_riba <- rexp(30, rate = 0.1)  # eksponencijalna distribucija
broj_jaja <- rpois(30, lambda = 100) # Poissonova distribucija za broj jaja
broj_parazita <- rpois(30, lambda = 5)  # Poissonova distribucija
temperatura_vode <- rnorm(30, mean = 15, sd = 2)  # normalna distribucija
jezero <- sample(c("Jarun", "Bundek", "Maksimir"), 30, replace = TRUE) # Kategorička varijabla

velicina_ribe <- ifelse(duljina_cm < 25, "juvenilna",
                             ifelse(duljina_cm <= 35, "subadultna", "adultna"))

# Kombinacija svih varijabli u jednu tablicu
ribe <- data.frame(
  duljina_cm = duljina_cm,
  velicina_ribe = velicina_ribe,
  masa_g = masa_g,
  brzina_plivanja = brzina_plivanja,
  starost_riba = starost_riba,
  broj_jaja = broj_jaja, 
  broj_parazita = broj_parazita,
  temperatura_vode = temperatura_vode,
  jezero = jezero
)

ribe[ , sapply(ribe, is.numeric)] <- round(ribe[ , sapply(ribe, is.numeric)], 2)

write.csv(ribe, file = "ribe.csv",  row.names = FALSE, quote = FALSE)

