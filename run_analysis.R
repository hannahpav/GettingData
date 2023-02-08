library(dplyr)

#check if the zip file exists
#if not, download
filename <- "UCI HAR Dataset.zip"
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method = "curl")
}

#check if the folder exists
#if not, download
if(!file.exists("UCI HAR Dataset")){
  unzip(filename)
}

#read in all of the files
features <- read.table(".\UCI HAR Dataset\features.txt", col.names = c("n","features"))
activities <- read.table(".\UCI HAR Dataset\activity_labels.txt", col.names = c("code", "activity"))
x_train <- read.table(".\UCI HAR Dataset\train\X_train.txt", col.names = features$functions)
y_train <- read.table(".\UCI HAR Dataset\train\Y_train.txt", col.names = "code")
x_test <- read.table(".\UCI HAR Dataset\test\X_test.txt", col.names = features$functions)
y_test <- read.table(".\UCI HAR Dataset\test\Y_test.txt", col.names = "code")
subject_train <- read.table(".\UCI HAR Dataset\train\subject_train.txt", col.names = "subject")


                      