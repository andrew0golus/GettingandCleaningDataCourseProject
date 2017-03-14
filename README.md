# GettingandCleaningDataCourseProject
This repository holds R script, run_analysis.R, and code book, code_book.txt, related to the Getting and Cleaning Data Course Project.
The R script performs the following:
- Loads the datasets from original folder 'UCI HAR Dataset' in working directory
- Combines the training and the test sets
- Extracts the measurements on the mean and standard deviation for each measurement
- Labels the data set with descriptive variable names
- Combines the subject, activity and feature vectors
- Puts the feature vector (in rows) into two columns 1) Measure (variable), and 2) Value
- Uses descriptive activity names to name the activities in the data set
- Calculates mean value for each subject, activity and measure and saves it to tidydataset.txt in the working directory
