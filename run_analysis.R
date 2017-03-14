library(dplyr)
library(tidyr)
##Load the datasets from original folder 'UCI HAR Dataset' in working directory
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
names(activity_labels) <- c("ActivityCode", "Activity")
features <- read.table("./UCI HAR Dataset/features.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
##Combine the training and the test sets
subject <- rbind(subject_test, subject_train)
names(subject) <- c("Subject")
y <- rbind(y_test, y_train)
names(y) <- c("ActivityCode")
X <- rbind(X_test, X_train)
##Extract the measurements on the mean and standard deviation for each measurement
MeanStdCol <- grep("mean|std", features$V2, value = FALSE)
MeanStdColNames <- grep("mean|std", features$V2, value = TRUE)
X <- select(X, MeanStdCol)
##Label the data set with descriptive variable names
names(X) <- MeanStdColNames
##Combine the subject, activity and feature vectors
df1 <- cbind(subject, y, X) %>%
##Transpose the feature vector (in rows) into two columns 1) Measure (variable), and 2) Value
    gather(Measure, Value, -Subject, -ActivityCode)
##Use descriptive activity names to name the activities in the data set
df2 <- merge(df1, activity_labels, all.x = TRUE, sort = FALSE)
##Calculate mean value for each subject, activity and measure and save it to tidydataset.txt in the working directory
df_tidy <- df2 %>%
    select(-ActivityCode) %>%
    arrange(Subject, Activity, Measure, Value) %>%
    group_by(Subject, Activity, Measure) %>%
    summarise(mean(Value)) %>%
    write.table("tidydataset.txt", row.name=FALSE)
