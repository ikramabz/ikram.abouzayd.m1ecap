#' Filtrer un jeu de donnees selon une modalite
#'
#' @description
#' Cette fonction filtre un jeu de donnees a partir d'une variable qualitative
#' et d'une modalite choisie.
#'
#' @param data Un data frame.
#' @param variable_quali Le nom de la variable qualitative.
#' @param modalite La modalite a conserver.
#'
#' @return Un data frame filtre.
#' @export
#'
#' @examples
#' filtrer_modalite(ocde, "continent", "Europe")
filtrer_modalite <- function(data, variable_quali, modalite) {
  if (!is.data.frame(data)) {
    stop("`data` doit etre un data frame.")
  }

  if (!variable_quali %in% names(data)) {
    stop("La variable qualitative n'existe pas dans `data`.")
  }

  data[data[[variable_quali]] == modalite, , drop = FALSE]
}


#' Calculer une statistique d'une variable quantitative par groupe
#'
#' @description
#' Cette fonction calcule une statistique resumee d'une variable quantitative
#' selon les modalites d'une variable qualitative.
#'
#' @param data Un data frame.
#' @param variable_quanti Le nom de la variable quantitative.
#' @param variable_quali Le nom de la variable qualitative de regroupement.
#' @param stat La statistique a calculer : `"mean"`, `"median"`, `"min"` ou `"max"`.
#'
#' @return Un data frame avec deux colonnes : `groupe` et `valeur`.
#' @export
#'
#' @examples
#' calcul_stat_par_groupe(ocde, "esperance_vie_ans", "continent", "mean")
calcul_stat_par_groupe <- function(data, variable_quanti, variable_quali, stat = "mean") {
  if (!is.data.frame(data)) {
    stop("`data` doit etre un data frame.")
  }

  if (!variable_quanti %in% names(data)) {
    stop("La variable quantitative n'existe pas dans `data`.")
  }

  if (!variable_quali %in% names(data)) {
    stop("La variable qualitative n'existe pas dans `data`.")
  }

  if (!is.numeric(data[[variable_quanti]])) {
    stop("`variable_quanti` doit correspondre a une variable numerique.")
  }

  if (!stat %in% c("mean", "median", "min", "max")) {
    stop("`stat` doit etre egal a 'mean', 'median', 'min' ou 'max'.")
  }

  fun_stat <- switch(
    stat,
    mean = function(x) mean(x, na.rm = TRUE),
    median = function(x) stats::median(x, na.rm = TRUE),
    min = function(x) min(x, na.rm = TRUE),
    max = function(x) max(x, na.rm = TRUE)
  )

  resultat <- stats::aggregate(
    x = data[[variable_quanti]],
    by = list(groupe = data[[variable_quali]]),
    FUN = fun_stat
  )

  names(resultat)[2] <- "valeur"

  resultat
}


#' Faire un graphique d'une statistique par groupe
#'
#' @description
#' Cette fonction produit un graphique en barres d'une statistique calculee
#' sur une variable quantitative selon les modalites d'une variable qualitative.
#'
#' @param data Un data frame.
#' @param variable_quanti Le nom de la variable quantitative.
#' @param variable_quali Le nom de la variable qualitative de regroupement.
#' @param stat La statistique a calculer : `"mean"`, `"median"`, `"min"` ou `"max"`.
#'
#' @return Un objet ggplot.
#' @export
#'
#' @examples
#' graphique_stat_par_groupe(ocde, "esperance_vie_ans", "continent", "mean")
graphique_stat_par_groupe <- function(data, variable_quanti, variable_quali, stat = "mean") {
  resultat <- calcul_stat_par_groupe(
    data = data,
    variable_quanti = variable_quanti,
    variable_quali = variable_quali,
    stat = stat
  )

  ggplot2::ggplot(resultat, ggplot2::aes(x = groupe, y = valeur)) +
    ggplot2::geom_col() +
    ggplot2::labs(
      title = paste("Statistique", stat, "de", variable_quanti, "par", variable_quali),
      x = variable_quali,
      y = stat
    ) +
    ggplot2::theme_minimal()
}
