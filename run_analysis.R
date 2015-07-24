library(dplyr)
library(tidyr)

# Load metadata
activities <-
  read.table(
    "UCI HAR Dataset/activity_labels.txt", sep = " ", col.names = c("activity_id", "activity"), stringsAsFactors = FALSE
  )

features <-
  read.table(
    "UCI HAR Dataset/features.txt", sep = " ", col.names = c("feature_id", "label"), stringsAsFactors = FALSE
  ) %>%
  separate(label, c("signal", "func", "dimension"), extra = "drop", remove =
             FALSE)

# These are the features we want to report on
wanted_features <- features %>%
  filter(func %in% c("mean", "std")) 

load.dataset <- function(set) {
  subjects <-
    read.table(paste("UCI HAR Dataset/", set, "/subject_", set, ".txt", sep = ""), col.names =
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
    group_by(subject, activity) %>%
    summarise(
      "tBodyAcc-mean()-X" = mean(tBodyAcc.mean...X),
      "tBodyAcc-mean()-Y" = mean(tBodyAcc.mean...Y),
      "tBodyAcc-mean()-Z" = mean(tBodyAcc.mean...Z),
      "tBodyAcc-std()-X" = mean(tBodyAcc.std...X),
      "tBodyAcc-std()-Y" = mean(tBodyAcc.std...Y),
      "tBodyAcc-std()-Z" = mean(tBodyAcc.std...Z),
      "tGravityAcc-mean()-X" = mean(tGravityAcc.mean...X),
      "tGravityAcc-mean()-Y" = mean(tGravityAcc.mean...Y),
      "tGravityAcc-mean()-Z" = mean(tGravityAcc.mean...Z),
      "tGravityAcc-std()-X" = mean(tGravityAcc.std...X),
      "tGravityAcc-std()-Y" = mean(tGravityAcc.std...Y),
      "tGravityAcc-std()-Z" = mean(tGravityAcc.std...Z),
      "tBodyAccJerk-mean()-X" = mean(tBodyAccJerk.mean...X),
      "tBodyAccJerk-mean()-Y" = mean(tBodyAccJerk.mean...Y),
      "tBodyAccJerk-mean()-Z" = mean(tBodyAccJerk.mean...Z),
      "tBodyAccJerk-std()-X" = mean(tBodyAccJerk.std...X),
      "tBodyAccJerk-std()-Y" = mean(tBodyAccJerk.std...Y),
      "tBodyAccJerk-std()-Z" = mean(tBodyAccJerk.std...Z),
      "tBodyGyro-mean()-X" = mean(tBodyGyro.mean...X),
      "tBodyGyro-mean()-Y" = mean(tBodyGyro.mean...Y),
      "tBodyGyro-mean()-Z" = mean(tBodyGyro.mean...Z),
      "tBodyGyro-std()-X" = mean(tBodyGyro.std...X),
      "tBodyGyro-std()-Y" = mean(tBodyGyro.std...Y),
      "tBodyGyro-std()-Z" = mean(tBodyGyro.std...Z),
      "tBodyGyroJerk-mean()-X" = mean(tBodyGyroJerk.mean...X),
      "tBodyGyroJerk-mean()-Y" = mean(tBodyGyroJerk.mean...Y),
      "tBodyGyroJerk-mean()-Z" = mean(tBodyGyroJerk.mean...Z),
      "tBodyGyroJerk-std()-X" = mean(tBodyGyroJerk.std...X),
      "tBodyGyroJerk-std()-Y" = mean(tBodyGyroJerk.std...Y),
      "tBodyGyroJerk-std()-Z" = mean(tBodyGyroJerk.std...Z),
      "tBodyAccMag-mean()" = mean(tBodyAccMag.mean..),
      "tBodyAccMag-std()" = mean(tBodyAccMag.std..),
      "tGravityAccMag-mean()" = mean(tGravityAccMag.mean..),
      "tGravityAccMag-std()" = mean(tGravityAccMag.std..),
      "tBodyAccJerkMag-mean()" = mean(tBodyAccJerkMag.mean..),
      "tBodyAccJerkMag-std()" = mean(tBodyAccJerkMag.std..),
      "tBodyGyroMag-mean()" = mean(tBodyGyroMag.mean..),
      "tBodyGyroMag-std()" = mean(tBodyGyroMag.std..),
      "tBodyGyroJerkMag-mean()" = mean(tBodyGyroJerkMag.mean..),
      "tBodyGyroJerkMag-std()" = mean(tBodyGyroJerkMag.std..),
      "fBodyAcc-mean()-X" = mean(fBodyAcc.mean...X),
      "fBodyAcc-mean()-Y" = mean(fBodyAcc.mean...Y),
      "fBodyAcc-mean()-Z" = mean(fBodyAcc.mean...Z),
      "fBodyAcc-std()-X" = mean(fBodyAcc.std...X),
      "fBodyAcc-std()-Y" = mean(fBodyAcc.std...Y),
      "fBodyAcc-std()-Z" = mean(fBodyAcc.std...Z),
      "fBodyAccJerk-mean()-X" = mean(fBodyAccJerk.mean...X),
      "fBodyAccJerk-mean()-Y" = mean(fBodyAccJerk.mean...Y),
      "fBodyAccJerk-mean()-Z" = mean(fBodyAccJerk.mean...Z),
      "fBodyAccJerk-std()-X" = mean(fBodyAccJerk.std...X),
      "fBodyAccJerk-std()-Y" = mean(fBodyAccJerk.std...Y),
      "fBodyAccJerk-std()-Z" = mean(fBodyAccJerk.std...Z),
      "fBodyGyro-mean()-X" = mean(fBodyGyro.mean...X),
      "fBodyGyro-mean()-Y" = mean(fBodyGyro.mean...Y),
      "fBodyGyro-mean()-Z" = mean(fBodyGyro.mean...Z),
      "fBodyGyro-std()-X" = mean(fBodyGyro.std...X),
      "fBodyGyro-std()-Y" = mean(fBodyGyro.std...Y),
      "fBodyGyro-std()-Z" = mean(fBodyGyro.std...Z),
      "fBodyAccMag-mean()" = mean(fBodyAccMag.mean..),
      "fBodyAccMag-std()" = mean(fBodyAccMag.std..),
      "fBodyBodyAccJerkMag-mean()" = mean(fBodyBodyAccJerkMag.mean..),
      "fBodyBodyAccJerkMag-std()" = mean(fBodyBodyAccJerkMag.std..),
      "fBodyBodyGyroMag-mean()" = mean(fBodyBodyGyroMag.mean..),
      "fBodyBodyGyroMag-std()" = mean(fBodyBodyGyroMag.std..),
      "fBodyBodyGyroJerkMag-mean()" = mean(fBodyBodyGyroJerkMag.mean..),
      "fBodyBodyGyroJerkMag-std()" = mean(fBodyBodyGyroJerkMag.std..)
    )
}

load.datasets <- function() {
  bind_rows(load.dataset("train"), load.dataset("test"))
}