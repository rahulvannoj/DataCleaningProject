library(dplyr)
library(tidyr)

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("activity_id", "activity_name"))
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("feature_id", "feature_name"))

# Read training data
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject_id")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$feature_name)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "activity_id")

# Read test data
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject_id")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$feature_name)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "activity_id")

# Combine training and test data
train_data <- cbind(subject_train, y_train, X_train)
test_data <- cbind(subject_test, y_test, X_test)
combined_data <- rbind(train_data, test_data)

# Extract mean and standard deviation measurements
mean_std_data <- combined_data %>% select(subject_id, activity_id, contains("mean"), contains("std"))

# Replace activity IDs with descriptive names
mean_std_data <- mean_std_data %>% mutate(activity_id = factor(activity_id, levels = activity_labels$activity_id, labels = activity_labels$activity_name))

# Clean up variable names
names(mean_std_data) <- gsub("^t", "time", names(mean_std_data))
names(mean_std_data) <- gsub("^f", "frequency", names(mean_std_data))
names(mean_std_data) <- gsub("Acc", "Accelerometer", names(mean_std_data))
names(mean_std_data) <- gsub("Gyro", "Gyroscope", names(mean_std_data))
names(mean_std_data) <- gsub("Mag", "Magnitude", names(mean_std_data))
names(mean_std_data) <- gsub("BodyBody", "Body", names(mean_std_data))
names(mean_std_data) <- gsub("\\.", "", names(mean_std_data))

# Create a tidy data set with the average of each variable for each activity and each subject
tidy_data <- mean_std_data %>% group_by(subject_id, activity_id) %>% summarise(across(everything(), list(mean = mean), .names = "mean_{col}"))

# Write the tidy data set to a file
write.table(tidy_data, "tidy_data.txt", row.names = FALSE)

