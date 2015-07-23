library(dplyr)
library(tidyr)

# Load metadata
activities <-
  read.table(
    "UCI HAR Dataset/activity_labels.txt", sep = " ", col.names = c("activity_id", "activity")
  )

features <-
  read.table(
    "UCI HAR Dataset/features.txt", sep = " ", col.names = c("feature_id", "label"), stringsAsFactors = FALSE
  ) %>%
  separate(label, c("signal", "func", "dimension"), extra = "drop", remove =
             FALSE)

# These are the features we want to report on
wanted_features <- features %>% 
  filter(func %in% c("mean", "std")) %>%
  mutate(colname=gsub("(-|\\(|\\))", ".", label))

load.dataset <- function(set) {
  subjects <- read.table(paste("UCI HAR Dataset/", set, "/subject_", set, ".txt", sep = ""), col.names =
                           "subject")
  
  loaded_activities <-
    read.table(paste("UCI HAR Dataset/", set, "/y_", set, ".txt", sep = ""), col.names =
                 "activity_id") %>%
    left_join(activities, by = "activity_id") %>%
    select(-activity_id)
  
  measurements <-
    read.table(paste("UCI HAR Dataset/", set, "/X_", set, ".txt", sep = ""), col.names = features$label) %>%
    select(wanted_features$feature_id)
  
  dataset <-
    tbl_df(data.frame(subjects, loaded_activities, measurements))
  
  dataset %>%
    group_by(subject, activity)
}

load.datasets <- function() {
  bind_rows(load.dataset("train"), load.dataset("test"))
}

# expect 
# mean(dataset$tBodyAcc.mean...X[dataset$subject==1 & dataset$activity_id ==6])
# mean(dataset$tBodyAcc.mean...X[dataset$subject==1 & dataset$activity == "LAYING"])
# 0.2215982