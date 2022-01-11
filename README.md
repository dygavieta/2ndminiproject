# SECOND MINI-PROJECT
## by: Don Michael Y. Gavieta
a. Create an R script called run_analysis.R. The script should include the following:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement
3. Uses descriptive activity names to name the activities in the dataset
4. Appropriately labels the data set with descriptive variable names
5. From the data set in step 4, create a second, independent tidy data set with the average of each variable
for each activity and each subject.

###### In run_analysis.R
###### ===Step 1: Merges the training and the test sets to create one data set.===
1. Read all the files(test,train, and subject) using read.table(file.path()) with their corresspodning col names:
subject files = subject; y files = activity
2. Read the subject test and train files first 
3. Used rbind() function to combine the rows of both data frame with the same length into one and stored it into variable y_data
4. The same process was made for the y and x data
5. But after merging the x train and test files, this data doesn't have col name yet. To add one, we need read the features textfile to get the listed feature names in V2 and 
assign it in to the col name of x data.
6. To merge the x, y and subject data into one, I merge the subject and y data first, then the x data with the combined data(subject and y data) and stored it into variable mergedData

###### ===Step 2: Extracts only the measurements on the mean and standard deviation for each measurement===
1. Used grep() function that allows you to find a specific pattern of string located in a data set, look for the string pattern of mean() or std(), and saved it into variable temp
2. Used as.character() function on temp, to test the pattern std and mean if found in the data or not
3. Used subset() to the mergedData by selecting only the pattern with std and mean and stored the final data on the variable extractedData.

###### ===Step 3: Uses descriptive activity names to name the activities in the data set===
1. Imported activity labels from the activity_label textifile provided and stored it in variable activityLabels
2. Used factor() function to pair the corresponding label to the activity number of the extracted data (extractedData$activity) to the activityLabelsV2
3. Changes the variable name of extractedData to main_data

###### ===Step 4: Appropriately labels the data set with descriptive variable names===
1. When doing str(main_data) you could only see shorcut variable names, to tidy these up in to the correct names I used gsub() function
2. gsub() function allows you to find certain string pattern in your data set and substitute its value. e.g "t" -> time, Acc -> "Accelerometer", "-mean -> Mean, and so on.

###### ===Step 5: From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.===
1. Used dplyr package
2. Used group_by (grouping the acitivity and subject) 
3. Used summarise_all (for getting the means of all variable under the group of activity and subejct) functions
