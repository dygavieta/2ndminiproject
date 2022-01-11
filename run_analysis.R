path <- file.path("specdata")
#==========Step 1: Merges the training and the test sets to create one data set================
#Merging same terms
#Subject
subject_test  <- read.table(file.path(path, "test", "subject_test.txt"),col.names = "subject")
subject_train <- read.table(file.path(path, "train", "subject_train.txt"),col.names = "subject")
#row bind
subject_data <- rbind(subject_train, subject_test)

#Y 
y_test  <- read.table(file.path(path, "test" , "y_test.txt" ),col.names = "activity")
y_train  <- read.table(file.path(path, "train" , "y_train.txt" ),col.names = "activity")
#row bind
y_data <- rbind(y_train, y_test) 

#X
x_test  <- read.table(file.path(path, "test", "X_test.txt"),header = FALSE)
x_train  <- read.table(file.path(path, "train", "X_train.txt"),header = FALSE)
#row bind
x_data <- rbind(x_train, x_test)
dataFeatures <- read.table(file.path(path, "features.txt"),head=FALSE)
names(x_data)<- dataFeatures$V2

#store feature list
dataCombine <- cbind(subject_data, y_data)
mergedData <- cbind(x_data, dataCombine)

#==========Step 2: Extracts only the measurements on the mean and standard deviation for each measurement================
temp <-dataFeatures$V2[grep("mean\\(\\)|std\\(\\)", dataFeatures$V2)]
names<-c(as.character(temp), "subject", "activity" )
extractedData<-subset(mergedData,select=names)
str(extractedData)

#====================Step 3: Uses descriptive activity names to name the activities in the data set======================

#import activity table labels
activityLabels <- read.table(file.path(path, "activity_labels.txt"),header = FALSE)
#factor allows you to put a label coressponding to the activityLabels  and the activity number of the extracted data
extractedData$activity <- factor(extractedData$activity, labels = activityLabels$V2)
main_data <- extractedData
str(main_data)

#=======================Step 4: Appropriately labels the data set with descriptive variable names===============================
#using gsub to substitute a certain value 
names(main_data)<-gsub("^t", "time", names(main_data))
names(main_data)<-gsub("Acc", "Accelerometer", names(main_data))
names(main_data)<-gsub("Gyro", "Gyroscope", names(main_data))
names(main_data)<-gsub("Mag", "Magnitude", names(main_data))
names(main_data)<-gsub("^f", "frequency", names(main_data))
names(main_data)<-gsub("BodyBody", "Body", names(main_data))

names(main_data)<-gsub("-mean", "Mean", names(main_data))
names(main_data)<-gsub("-std", "STD", names(main_data)) 


#===========Step 5: From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.=====================)
#Using dplyr library to calculate mean by group
library(dplyr)
tidyData <- main_data %>%
  #group by subject and activity
  group_by(subject, activity) %>%
  #summarise_all with a funtion mean
  summarise_all(list(name = mean))

tidyData
