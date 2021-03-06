#' @title Add Team Strength
#' @description Add Team Strength (Difference Form Indicators) to a Tibble
#' @param data tibble to add strength to
#' @param home_team_column home team column.
#' @param away_team_column away team column
#' @param season_column season column - may be NULL, which will ignore the season
#' @param home_perspective logical: Whether to return difference form from perspective of home team (T) or away team (F). Will default to T
#'
#' @return dataframe with difference form indicators added, along with any input columns. Also a HomeStrength and AwayStrength columns are added.
#' @export
#'
#' @examples data %>% add_team_strength(HomeTeam, AwayTeam, Season) -> data
add_team_strength <- function(data, home_team_column, away_team_column, season_column=NULL, home_perspective=TRUE){

  if(missing(season_column)){
    data %>% mutate(HomeStrength = {{home_team_column}}) -> data
    data %>% mutate(AwayStrength = {{away_team_column}}) -> data

  }else{
    data %>% mutate(HomeStrength = paste({{home_team_column}}, {{season_column}}, sep="_")) -> data
    data %>% mutate(AwayStrength = paste({{away_team_column}}, {{season_column}}, sep="_")) -> data
  }


  #if the home and away teams per season are not symmetric, modeling will not be consistent. Therefore a warning will be raised and the data will be filtered to only include symmetric teams.
  if ((length(unique(data$AwayStrength)) != length(unique(data$HomeStrength))) | (sum(sort(unique(data$HomeStrength)) == sort(unique(data$AwayStrength))) != max(length(unique(data$AwayStrength)), length(unique(data$HomeStrength))))){
    warning("Away Teams set is not equal to the Home Teams set. Only including the intersection between these two sets.")

    data %>% filter(HomeStrength %in% unique(AwayStrength)) %>% filter(AwayStrength %in% unique(HomeStrength)) -> data
  }

  data %>% mutate(Strength = HomeStrength) -> data
  results_home <- fastDummies::dummy_cols(data, select_columns = c("Strength"))
  results_home$Strength_NA <- NULL

  data %>% mutate(Strength = AwayStrength) -> data
  results_away <- fastDummies::dummy_cols(data, select_columns = c("Strength"))
  results_away$Strength_NA <- NULL

  results_home -> results_home_copy #keep for the away perspective


  if(home_perspective){
    #home perspective
    results_home[(ncol(results_home)-length(unique(results_home$Strength))+1):ncol(results_home)] <- results_home[(ncol(results_home)-length(unique(results_home$Strength))+1):ncol(results_home)] - results_away[(ncol(results_away)-length(unique(results_away$Strength))+1):ncol(results_away)]
    return(results_home)
  }else{
    #away perspective
    results_away[(ncol(results_away)-length(unique(results_away$Strength))+1):ncol(results_away)] <- results_away[(ncol(results_away)-length(unique(results_away$Strength))+1):ncol(results_away)] - results_home_copy[(ncol(results_home_copy)-length(unique(results_home_copy$Strength))+1):ncol(results_home_copy)]
    return(results_away)
  }
}
