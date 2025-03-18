# Code Book for Tidy Dataset

## Dataset Information
The data used in this project was collected from the accelerometers of the Samsung Galaxy S smartphone. 
The original dataset can be found at the [UCI Machine Learning Repository]
(http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

## Variables
The final tidy dataset contains the following variables:
- `subject_id`: The ID of the subject (participant). Range: 1 to 30.
- `activity_id`: The name of the activity performed. Possible values: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING.
- `timeBodyAccelerometer-mean-X`: Mean of the time-domain body acceleration signal in the X direction.
- `timeBodyAccelerometer-mean-Y`: Mean of the time-domain body acceleration signal in the Y direction.
- `timeBodyAccelerometer-mean-Z`: Mean of the time-domain body acceleration signal in the Z direction.
- ... (list all variables)

## Data Processing Steps
1. The training and test datasets were merged into a single dataset.
2. Only the measurements on the mean and standard deviation for each measurement were extracted.
3. Activity IDs were replaced with descriptive activity names.
4. Variable names were cleaned up to make them more readable and descriptive.
5. A second, independent tidy dataset was created with the average of each variable for each activity and each subject.

## Tidy Dataset
The final tidy dataset contains the average of each variable for each subject and each activity. 
Each row represents a unique combination of subject and activity, and each column represents the average of a specific measurement.