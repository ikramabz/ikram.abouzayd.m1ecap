#' Jeu de donnees OCDE
#'
#' @description
#' Le jeu de donnees porte sur 38 pays membres ou partenaires de l'OCDE,
#' pour l'annee 2017, issu de l'Indice de vie meilleure.
#'
#' @details
#' La base comprend 23 indicateurs quantitatifs et un indicateur qualitatif,
#' couvrant les principales dimensions du bien-etre.
#'
#' Les variables decrivent notamment les conditions materielles
#' (revenu disponible, patrimoine, logement), le marche du travail
#' (taux d'emploi, insecurite, chomage, revenus), l'education
#' (niveau d'etudes, duree de scolarite, competences), ainsi que la sante,
#' la satisfaction dans la vie, l'environnement, la securite
#' et la participation citoyenne.
#'
#' Une premiere verification montre que l'ensemble des variables est exploitable,
#' sans valeurs manquantes, ce qui permet de mener l'analyse directement.
#'
#' @format Un data frame de 38 lignes et 24 variables :
#' \describe{
#'   \item{Pays}{Nom du pays.}
#'   \item{depenses_logement_pct}{Part des depenses de logement.}
#'   \item{revenu_disponible_menages}{Revenu disponible des menages.}
#'   \item{insecurite_marche_travail_pct}{Part d'insecurite sur le marche du travail.}
#'   \item{chomage_long_terme_pct}{Taux de chomage de longue duree.}
#'   \item{soutien_social_pct}{Part de soutien social.}
#'   \item{competences_eleves_score}{Score de competences des eleves.}
#'   \item{pollution_air_pm25}{Niveau de pollution de l'air PM2.5.}
#'   \item{engagement_parties_prenantes_score}{Score d'engagement des parties prenantes.}
#'   \item{esperance_vie_ans}{Esperance de vie.}
#'   \item{satisfaction_vie_score}{Score de satisfaction dans la vie.}
#'   \item{taux_homicide}{Taux d'homicide.}
#'   \item{logements_sans_equipements_pct}{Part de logements sans equipements de base.}
#'   \item{pieces_par_personne}{Nombre moyen de pieces par personne.}
#'   \item{patrimoine_financier_menages}{Patrimoine financier des menages.}
#'   \item{taux_emploi_pct}{Taux d'emploi.}
#'   \item{revenus_du_travail_usd}{Revenus du travail.}
#'   \item{niveau_education_pct}{Niveau d'education.}
#'   \item{annees_education}{Nombre d'annees d'education.}
#'   \item{qualite_eau_pct}{Qualite de l'eau.}
#'   \item{participation_electorale_pct}{Participation electorale.}
#'   \item{sante_declaree_bonne_pct}{Part declarant une bonne sante.}
#'   \item{sentiment_securite_nuit_pct}{Sentiment de securite la nuit.}
#'   \item{continent}{Continent du pays, variable qualitative nominale.}
#' }
#'
#' @source \url{https://www.kaggle.com/datasets/jej13b/oecd-better-life-index}
"ocde"
