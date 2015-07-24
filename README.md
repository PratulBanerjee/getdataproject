# Overview

This analysis project takes both training and test data from the UCI for the Human Activity Recognition project and summarises the data
according to values laid out in the [code book](CodeBook.md "Code Book")

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
