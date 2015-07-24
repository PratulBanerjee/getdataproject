# Overview

This analysis project takes both training and test data from the UCI for the Human Activity Recognition project and summarises the data
according to values laid out in the [code book](CodeBook.md).

Sourcing the file `run_analysis.R` makes a function available `load.datasets()` which will provide a tidy dataset.

# Prerequisites

## R Package Requirements
 * dply v0.4.2
 * tidyr v0.2.0

## Data files

The source data set should be downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  and
extracted into the same directory as the `run_analysis.R` file.

# Run the analysis

```r
source("run_analysis.R")
dt <- load.datasets()
write.table(dt, "out.txt", row.names = FALSE)
```

# Explanation of analysis

## Activity Labels

The file `activity_labels.txt` is read into an `activities` data frame that will later be used to enrich the dataset with the label for the
activities.

## Features

I read the `features.txt` file into a `features` data frame.  Each feature label in this data frame has a *variable* that was estimated from
the original signal.  We are interested in the ones where the variable is `mean` (mean) or `std` (standard deviation).  The
`wanted_features` data frame contains only the features that are required in the final dataset.

## load.dataset()

The `load.dataset()` function reads the source datafiles from a particular set (**train** or **test**) into a data frame.  It filters out
the features requried from `wanted_features` then aggregates all the features by subject and activity.  This produces a tidy dataset for one
input set.

## load.datasets()

This loads both sets of data and binds the results together into a single tidy dataset.

# Helpers

## Summarised feature variables

I take the wanted_features data frame and add a column `colname` in the `wanted_features` data frame.  `colname` is the value of the column
name that `read.table` assigns to the feature using the `col.names = features$label` option.

There is a function `summarised_feature_vars()` that creates the parameter list to be passed to the `summarise` method inside the
`load.dataset` function.
