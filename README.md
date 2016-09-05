# Getting-CleaningDataCourseProject
Getting and Cleaning Data Course Project

The run_analysis.R script performs the following activities:
- 1. Merges the training and the test sets to create one data set.
- 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
- 3. Uses descriptive activity names to name the activities in the data set
- 4. Appropriately labels the data set with descriptive variable names. 
- 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

It accomplishes the above by setting the working directory to a specified location and then performing the following steps:
- Loading and reducing the features to averages and standard deviations
- Loading the test and trainning data with the associated subject and activity
- Naming the activities with descriptive names
- Combining the test and traninning data
- Cleaning the data labels
- Calculating the average of each variable for each activity and each subject

There is also a codebook in this repository that describes the variables.
