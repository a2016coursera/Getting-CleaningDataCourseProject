# Getting and Cleaning Data Course Project
# 
# This script performs the following activities:
# 1.Merges the training and the test sets to create one data set.
# 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3.Uses descriptive activity names to name the activities in the data set
# 4.Appropriately labels the data set with descriptive variable names. 
# 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#

# NOTE: Update the base directory below for your environment:
baseDir <- "C:\\R\\UCI_HAR_Dataset\\"

## Merge the training and test sets ##

## First do things that apply to both 
# Get the feature we want
# Load the feature names
features <- read.table(paste(baseDir,"features.txt", sep=""))
# Reduce to only those on the mean and standard deviation for each measurement
reducedFeatures <- features[grepl("mean|std",features$V2),]

# Load the activity names
activityLables <- read.table(paste(baseDir,"activity_labels.txt", sep=""))
# Name the columns
names(activityLables) <- c("activity","activityName")

## Test Data
# Load the test data set subjects
subjectTest <- read.table(paste(baseDir,"test\\subject_test.txt", sep=""))
# Name the column
names(subjectTest) <- c("subject")

# Load the test data set activities
testSetActivities <- read.table(paste(baseDir,"test\\y_test.txt", sep=""))
# Name the column
names(testSetActivities) <- c("activity")

# Combine the subject and activity
subjectAndActivity <- cbind(subjectTest,testSetActivities)

# Load the test data set activity names
activityLables <- read.table(paste(baseDir,"activity_labels.txt", sep=""))
# Name the columns
names(activityLables) <- c("activity","activityName")

# Use descriptive activity names
subjectAndActivityWithNames <- merge(subjectAndActivity,activityLables,by.x="activity",by.y="activity", sort=FALSE)

# Arrange columns
testSetFinal <- subjectAndActivityWithNames[,c(2,1,3)]

# Load the test data set 
testSet <- read.table(paste(baseDir,"test\\X_test.txt", sep=""))

# Rename the columns to prep for reduction
names(testSet) <- c(1:561)

# Reduce the test set based on mean and standard deviation
reducedTestSet <- testSet[colnames(testSet)%in%reducedFeatures$V1]

# Name the columns
names(reducedTestSet) <- c(as.character(reducedFeatures$V2))

# Combine subject, activity, and test set
testSetFinal <- cbind(testSetFinal,reducedTestSet)

## Trainning Data
# Load the train data set subjects
subjectTrain <- read.table(paste(baseDir,"train\\subject_train.txt", sep=""))
# Name the column
names(subjectTrain) <- c("subject")

# Load the train data set activities
trainSetActivities <- read.table(paste(baseDir,"train\\y_train.txt", sep=""))
# Name the column
names(trainSetActivities) <- c("activity")

# Combine the subject and activity
subjectAndActivityTrain <- cbind(subjectTrain,trainSetActivities)

# Use descriptive activity names
subjectAndActivityWithNamesTrain <- merge(subjectAndActivityTrain,activityLables,by.x="activity",by.y="activity", sort=FALSE)

# Arrange columns
trainSetFinal <- subjectAndActivityWithNamesTrain[,c(2,1,3)]

# Load the train data set 
trainSet <- read.table(paste(baseDir,"train\\X_train.txt", sep=""))

# Rename the columns to prep for reduction
names(trainSet) <- c(1:561)

# Reduce the train set based on mean and standard deviation
reducedTrainSet <- trainSet[colnames(trainSet)%in%reducedFeatures$V1]

# Name the columns
names(reducedTrainSet) <- c(as.character(reducedFeatures$V2))

# Combine subject, activity, and train set
trainSetFinal <- cbind(trainSetFinal,reducedTrainSet)

## Combine the test and train data and tidy up
# Combine the data
combinedDataSet <- rbind(testSetFinal,trainSetFinal)

# Set the column names to lower case using function
lowerColumnName <- function(x) {
  colnames(x) <- tolower(colnames(x))
  x
}
combinedDataSet <- lowerColumnName(combinedDataSet)

# Remove ()- from column names using function
removeCharactes <- function(x) {
  colnames(x) <- sub("()-","",colnames(x),fixed=TRUE)
  x
}
combinedDataSet <- removeCharactes(combinedDataSet)

# Independent tidy data set with the average of each variable for each activity and each subject
averageCombinedDataSet <- aggregate(combinedDataSet[,4:ncol(combinedDataSet)], combinedDataSet[,1:3], FUN = mean)

# Output the data
write.table(averageCombinedDataSet,file="averageCombinedDataSet.txt",row.name=FALSE)
