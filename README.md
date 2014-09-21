Getting and Cleaning Data Course Project
===============

# Description
This repository is part of the coursera *Getting and Cleaning Data* course project. The purpose of the project is to demonstrate the ability to collect, work with, and clean a data set.

The data should be manually downloaded from <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip> and placed in the working directory.

# Contents
The files in this repository are:
- README.md: this file
- Codebook.md: describes the data, the variables and any transformations to clean up the data
- run_analysis.R: An R script that creates a tidy dataset as described below.

# Script

The R script 'run_analysis.R' does the following:

1. Merges the training and the test sets to create one data set and saves it in a directory with the name 'merged'.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. The tidy data set is saved in the 'merged' directory.

# Additional information

For more information, check out the course website - <https://www.coursera.org/course/getdata>