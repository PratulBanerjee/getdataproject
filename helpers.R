summarise_vars <-
  paste(
    "\"", wanted_features$label, "\" = mean(", wanted_features$colname, ")", sep =
      "", collapse = ", "
  )