data_test <- data.frame(
  continent = factor(c("Europe", "Europe", "Asie", "Asie", "Amerique")),
  score = c(10, 20, 30, 40, 50),
  revenu = c(100, 200, 300, 400, 500),
  stringsAsFactors = TRUE
)

testthat::test_that("filtrer_modalite conserve uniquement la modalite choisie", {
  res <- filtrer_modalite(data_test, "continent", "Europe")

  testthat::expect_s3_class(res, "data.frame")
  testthat::expect_equal(nrow(res), 2)
  testthat::expect_true(all(res$continent == "Europe"))
  testthat::expect_equal(res$score, c(10, 20))
})

testthat::test_that("filtrer_modalite renvoie un data frame vide si la modalite est absente", {
  res <- filtrer_modalite(data_test, "continent", "Oceanie")

  testthat::expect_s3_class(res, "data.frame")
  testthat::expect_equal(nrow(res), 0)
  testthat::expect_equal(names(res), names(data_test))
})

testthat::test_that("filtrer_modalite renvoie une erreur si la variable qualitative est absente", {
  testthat::expect_error(
    filtrer_modalite(data_test, "pays", "Europe")
  )
})

testthat::test_that("calcul_stat_par_groupe calcule correctement la moyenne par groupe", {
  res <- calcul_stat_par_groupe(data_test, "score", "continent", "mean")

  testthat::expect_s3_class(res, "data.frame")
  testthat::expect_true(all(c("groupe", "valeur") %in% names(res)))
  testthat::expect_equal(res$valeur[res$groupe == "Europe"], 15)
  testthat::expect_equal(res$valeur[res$groupe == "Asie"], 35)
  testthat::expect_equal(res$valeur[res$groupe == "Amerique"], 50)
})

testthat::test_that("calcul_stat_par_groupe calcule correctement la mediane", {
  res <- calcul_stat_par_groupe(data_test, "score", "continent", "median")

  testthat::expect_equal(res$valeur[res$groupe == "Europe"], 15)
  testthat::expect_equal(res$valeur[res$groupe == "Asie"], 35)
  testthat::expect_equal(res$valeur[res$groupe == "Amerique"], 50)
})

testthat::test_that("calcul_stat_par_groupe calcule correctement le minimum et le maximum", {
  res_min <- calcul_stat_par_groupe(data_test, "score", "continent", "min")
  res_max <- calcul_stat_par_groupe(data_test, "score", "continent", "max")

  testthat::expect_equal(res_min$valeur[res_min$groupe == "Europe"], 10)
  testthat::expect_equal(res_max$valeur[res_max$groupe == "Europe"], 20)

  testthat::expect_equal(res_min$valeur[res_min$groupe == "Asie"], 30)
  testthat::expect_equal(res_max$valeur[res_max$groupe == "Asie"], 40)
})

testthat::test_that("calcul_stat_par_groupe renvoie une erreur si stat est invalide", {
  testthat::expect_error(
    calcul_stat_par_groupe(data_test, "score", "continent", "somme")
  )
})

testthat::test_that("calcul_stat_par_groupe renvoie une erreur si la variable quantitative n'est pas numerique", {
  testthat::expect_error(
    calcul_stat_par_groupe(data_test, "continent", "continent", "mean")
  )
})

testthat::test_that("calcul_stat_par_groupe renvoie une erreur si la variable quantitative est absente", {
  testthat::expect_error(
    calcul_stat_par_groupe(data_test, "bonheur", "continent", "mean")
  )
})

testthat::test_that("graphique_stat_par_groupe renvoie un objet ggplot", {
  p <- graphique_stat_par_groupe(data_test, "score", "continent", "mean")

  testthat::expect_s3_class(p, "ggplot")
})

testthat::test_that("graphique_stat_par_groupe utilise les bonnes valeurs calculees", {
  p <- graphique_stat_par_groupe(data_test, "score", "continent", "mean")

  testthat::expect_true(all(c("groupe", "valeur") %in% names(p$data)))
  testthat::expect_equal(p$data$valeur[p$data$groupe == "Europe"], 15)
  testthat::expect_equal(p$data$valeur[p$data$groupe == "Asie"], 35)
  testthat::expect_equal(p$data$valeur[p$data$groupe == "Amerique"], 50)
})
