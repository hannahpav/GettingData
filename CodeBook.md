## Project Description

The project intakes data from fitness devices and produces a tidy data set with summaries
Used the dplyr package

## Collection of the Raw Data

The zip file was downloaded into the working directory under "UCI HAR Dataset.zip", after which it was
unzipped with the same now

### Reading in the Data

Different varialbes are created for each of the items. The data from the test and train groups are then
put under the column names described as the features in the text file "features.txt."

Once all the data is read, we have the features on the device, names of activities, data 
from the training and test groups, and subject names 

activites, y_train, y_test all have "code" which is used later to merge the data

### Merging the data

As stated above, the variables all use "code" to merge easily. First, the X were combined to lump test and train subjects,
after which the labels of the activities were bound for test and train (Y), and the Subject names were bound.

The Final merged data is a set with the Subject of the study, the activity name ("code"), and then the data from the devices.

clean_data is finally the subject, code, and only information with mean or std.

### Cleaning the data

I went through and changed any abbreviations to the full name, and made camelcase readible.

### Output

The output, FinalData, is a summary table by subject and activity with summaries of their data.

## Variables in the file

Following were for reading in the data as placeholders:
      features
      activities
      x_train
      y_train
      x_test
      y_test
      subject_train
      subject_test

The following were to mearge the data into a larger table
      X
      Y
      Subject
      merged_data

#### clean_data variable is the data set with all information merged with only the mean and std data
#### FinalData is the summary table

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
