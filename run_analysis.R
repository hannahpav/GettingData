library(dplyr)

#check if the zip file exists
#if not, download
#filename <- "UCI HAR Dataset.zip"
#if (!file.exists(filename)){
#  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#  download.file(fileURL, filename, method = "curl")
#}

#check if the folder exists
#if not, download 
#if(!file.exists("UCI HAR Dataset")){
#  unzip(filename)
#}

#read in all of the files
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/Y_train.txt", col.names = "code")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/Y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

#Merge the training and test sets together
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
merged_data <- cbind(Subject, Y, X)

#take only the mean and std info
clean_data <- select(merged_data, subject, code, contains("mean"), contains("std"))

#Uses descriptive activity names to name the activities in the data set
clean_data$code <- activities[clean_data$code, 2]
names(clean_data)[2] = "activity"

#Appropriately labels the data set with descriptive variable names. 
names(clean_data) <- gsub("Acc", "Accelerometer", names(clean_data))
names(clean_data) <- gsub("Mag", "Magnitude", names(clean_data))
names(clean_data) <- gsub("BodyBody", "Body", names(clean_data))
names(clean_data) <- gsub("^t", "Time", names(clean_data))
names(clean_data) <- gsub("^f", "Frequency", names(clean_data))
names(clean_data) <- gsub("-mean()", "Mean", names(clean_data), ignore.case = TRUE)
names(clean_data) <- gsub("-std()", "Std", names(clean_data), ignore.case = TRUE)
names(clean_data) <- gsub("-freq()", "Frequency", names(clean_data), ignore.case = TRUE)
names(clean_data) <- gsub("angle", "Angle", names(clean_data), ignore.case = TRUE)
names(clean_data) <- gsub("tBody", "TimeBody", names(clean_data))
names(clean_data) <- gsub("gravity", "Gravity", names(clean_data))
names(clean_data) <- gsub("\\.", "", names(clean_data))
names(clean_data) <- gsub("std", "Std", names(clean_data))
names(clean_data) <- gsub("mean", "Mean", names(clean_data))

#From the data set in step 4, creates a second, independent tidy data set 
#with the average of each variable for each activity and each subject.

FinalData <- clean_data %>% group_by(subject, activity) %>% summarize_all(list(mean))

#write to a new file
write.table(FinalData, "FinalData.txt", row.name = FALSE)