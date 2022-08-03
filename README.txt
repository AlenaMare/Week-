==================================================================
Getting and Cleaning Data - Week 4
==================================================================

README expains each step of the R code, which is structured based on the instruction of assignment.

In the first step, dplyr package, used latter in the code, is dowloaded and uploaded.

After that, the appropriate data file is read. The code says to read url, which is in zip format and therefore have to be unziped. After downloading the data, the next steps focus on instucctions of assignment.

#1. First, all the data files are read as table, followed by defining columns in each set (in this step, instruction no. 4 is basically done). After those steps, the training and the test sets are merged into a new data set (finaldataset).

#2. Following code extracts only the measurements on the mean and standard deviation for each measurement, while also keeping information about the subject and activity. The new data set is called humanActivity 

#3. In this step, the code transforms number standing for activity into descriptive activity names to name the activities in the data set. The descriptive activity names are also placed as a first column in the ew data set called ActivityNames.

#5. In the last step, independent tidy data set with the average of each variable for each activity and each subject is created. This data set (tidy_data.txt) is enclosed in the repo.
