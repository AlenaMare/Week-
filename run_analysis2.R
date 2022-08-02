install.packages("plyr")
install.packages("dplyr")
library(plyr)
library(dplyr)
#Read file
if(!file.exists("./getcleandata")){dir.create("./getcleandata")}
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, destfile = "./getcleandata/projectdataset.zip")

unzip(zipfile = "./getcleandata/projectdataset.zip", exdir = "./getcleandata")

#1. Merges the training and the test sets to create one data set.
x_train <- read.table("./getcleandata/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./getcleandata/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./getcleandata/UCI HAR Dataset/train/subject_train.txt")

x_test <- read.table("./getcleandata/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./getcleandata/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./getcleandata/UCI HAR Dataset/test/subject_test.txt")

features <- read.table("./getcleandata/UCI HAR Dataset/features.txt")
activityLabels = read.table("./getcleandata/UCI HAR Dataset/activity_labels.txt")

colnames(x_train) <- features[,2]
colnames(y_train) <- "activityID"
colnames(subject_train) <- "subjectID"

colnames(x_test) <- features[,2]
colnames(y_test) <- "activityID"
colnames(subject_test) <- "subjectID"

colnames(activityLabels) <- c("activityID", "activityType")

alltrain <- cbind(y_train, subject_train, x_train)
alltest <- cbind(y_test, subject_test, x_test)
finaldataset <- rbind(alltrain, alltest)

#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
columnsToKeep <- grepl("subject|activity|mean|std", colnames(finaldataset))
humanActivity <- finaldataset[, columnsToKeep]

#3. Uses descriptive activity names to name the activities in the data set
ActivityNames <- merge(humanActivity, activityLabels,
                              by = "activityID",
                              all.x = TRUE)
ActivityNames <- select(ActivityNames, activityType, everything())
ActivityNames <- select(ActivityNames, -(activityID))

#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidyset <- ActivityNames %>% 
  group_by(activityType, subjectID) %>%
  summarise_each(funs(mean))

write.table(tidyset, "tidy_data.txt", row.names = FALSE, 
            quote = FALSE)