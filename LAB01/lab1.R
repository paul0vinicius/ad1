install.packages("dplyr")
install.packages("tidyr")
install.packages("magrittr")
install.packages("ggplot2")

library(readr)
library(dplyr)
library(magrittr)
library(ggplot2)
series_from_imdb <- read_csv("https://raw.githubusercontent.com/nazareno/imdb-series/master/data/series_from_imdb.csv")

dataSeries<- series_from_imdb %>% filter(series_name %in% c("How to Get Away with Murder", "13 Reasons Why", "Friends","Modern Family", "Black Mirror"))

ggplot(dataSeries, aes(x=series_name, y = UserRating)) + geom_boxplot()

# Segundo a analise utilizando mediana, o valor que melhor representa os dados, pois os dados estão variando dms...
# How To Get Away With Murder é a série mais bem avaliada do conjunto de dados.