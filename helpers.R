source("run_analysis.R")


summarised_feature_vars <- function() {
  f <- wanted_features %>%
    mutate(colname = gsub("(-|\\(|\\))", ".", label))
  paste(
    "\"", f$label, "\" = mean(", wanted_features$colname, ")", sep =
      "", collapse = ", "
  )
}