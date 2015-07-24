source("run_analysis.R")

summarise_vars <-
  paste(
    "\"", wanted_features$label, "\" = mean(", wanted_features$colname, ")", sep =
      "", collapse = ", "
  )