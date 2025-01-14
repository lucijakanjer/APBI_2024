# Multivarijantna statistika u R
# Analize korelacije, kovarijance, PCA, MDS, MANOVA, diskriminantne analize, hijerarhijsko grupiranje i K-means

# 1. Instalacija i učitavanje potrebnih paketa
if (!require("tidyverse")) install.packages("tidyverse")
if (!require("vegan")) install.packages("vegan")
if (!require("MASS")) install.packages("MASS")
if (!require("psych")) install.packages("psych")
if (!require("cluster")) install.packages("cluster")
library(tidyverse)
library(vegan)
library(MASS)
library(psych)
library(cluster)

# 2. Učitavanje Iris podataka

data <- iris
colnames(data) <- c("SepalLength", "SepalWidth", "PetalLength", "PetalWidth", "Species")

# 3. Korelacijske analize
cor_matrix <- cor(data %>% select(SepalLength:PetalWidth))
print(cor_matrix)

# Vizualizacija korelacija
pairs(data %>% select(SepalLength:PetalWidth), main = "Scatterplot matrica", pch = 21, bg = c("red", "green", "blue")[as.numeric(data$Species)])

# 4. Analiza kovarijance (MANOVA)
manova_res <- manova(cbind(SepalLength, SepalWidth, PetalLength, PetalWidth) ~ Species, data = data)
summary(manova_res)
summary.aov(manova_res) # Pojedinačni ANOVA testovi

# 5. Principal Component Analysis (PCA)
pca_res <- prcomp(data %>% select(SepalLength:PetalWidth), scale. = TRUE)
summary(pca_res)

# Vizualizacija PCA
biplot(pca_res, main = "PCA Biplot", col = c("red", "green", "blue")[as.numeric(data$Species)])

# 6. Multidimensional Scaling (MDS)
mds_res <- metaMDS(data %>% select(SepalLength:PetalWidth), distance = "euclidean", k = 2)
print(mds_res)
plot(mds_res, type = "t", main = "MDS - Iris podaci")

# 7. Diskriminantna analiza
lda_res <- lda(Species ~ SepalLength + SepalWidth + PetalLength + PetalWidth, data = data)
lda_pred <- predict(lda_res)
lda_res

# Vizualizacija LDA
data$LDA1 <- lda_pred$x[,1]
data$LDA2 <- lda_pred$x[,2]
ggplot(data, aes(x = LDA1, y = LDA2, color = Species)) +
  geom_point(size = 3) +
  labs(title = "LDA Scatterplot", x = "LDA1", y = "LDA2") +
  theme_minimal()

# 8. Hijerarhijsko grupiranje
hclust_res <- hclust(dist(data %>% select(SepalLength:PetalWidth)), method = "ward.D2")
plot(hclust_res, labels = data$Species, main = "Hijerarhijsko grupiranje", sub = "", xlab = "", ylab = "Udaljenost")

# 9. K-means klasteriranje
set.seed(123)
kmeans_res <- kmeans(data %>% select(SepalLength:PetalWidth), centers = 3)
print("K-means rezultati:")
print(kmeans_res)

data$Cluster <- as.factor(kmeans_res$cluster)
ggplot(data, aes(x = SepalLength, y = SepalWidth, color = Cluster)) +
  geom_point(size = 3) +
  labs(title = "K-means grupiranje", x = "SepalLength", y = "SepalWidth") +
  theme_minimal()


