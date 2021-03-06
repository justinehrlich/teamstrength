#' @title Add Team Strength Formula
#' @description Add Strength (Difference Form Indicators) to a Formula
#'
#'
#' @param forumula_prefix Formula in String Form
#' @param data
#'
#' @return Formula with the Strength (Difference Form Indicators ) appended to the input formula.
#' @export
#'
#' @examples add_team_strength_formula("HomePointDifferential~Jamsil+PartialFans + NoFans + Playoffs", data)
#'
add_team_strength_formula <- function(forumula_prefix, data){
  formula_team_strength <- formula(paste(forumula_prefix, "+`Strength_",paste(sort(unique(data$HomeStrength)), collapse="` + `Strength_"),"`",sep=""))
  return(formula_team_strength)
}
