


## code to prepare `oecd` dataset goes here

url_jeu_de_donnees <- "https://www.kaggle.com/datasets/jej13b/oecd-better-life-index"

ocde <- read.csv(
  "data-raw/base_OECD_avec_continent.csv",
  stringsAsFactors = FALSE,
  check.names = FALSE
)

ocde$continent <- factor(ocde$continent)

usethis::use_data(ocde, overwrite = TRUE)





