## Project Description

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

### For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.Used the dplyr package

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

### Variables in the file

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


