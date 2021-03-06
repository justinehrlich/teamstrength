% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/add_team_strength.R
\name{add_team_strength}
\alias{add_team_strength}
\title{Add Team Strength}
\usage{
add_team_strength(
  data,
  home_team_column,
  away_team_column,
  season_column = NULL,
  home_perspective = TRUE
)
}
\arguments{
\item{data}{tibble to add strength to}

\item{home_team_column}{home team column.}

\item{away_team_column}{away team column}

\item{season_column}{season column - may be NULL, which will ignore the season}

\item{home_perspective}{logical: Whether to return difference form from perspective of home team (T) or away team (F). Will default to T}
}
\value{
dataframe with difference form indicators added, along with any input columns. Also a HomeStrength and AwayStrength columns are added.
}
\description{
Add Team Strength (Difference Form Indicators) to a Tibble
}
\examples{
data \%>\% add_team_strength(HomeTeam, AwayTeam, Season) -> data
}
