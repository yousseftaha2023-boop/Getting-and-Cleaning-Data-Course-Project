##################loading libraries############
library(dplyr)
library(tidyverse)
library(Hmisc)


# 1. Download and unzip the raw dataset
file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zip_file <- "UCI_HAR_Dataset.zip"

if (!file.exists(zip_file)) {
  download.file(file_url, destfile = zip_file, mode = "wb")
}

if (!file.exists("UCI HAR Dataset")) {
  unzip(zip_file)
}

data_dir <- "UCI HAR Dataset"

features <- read.table(file.path(data_dir, "features.txt"), col.names = c("index", "feature_name"))
activities <- read.table(file.path(data_dir, "activity_labels.txt"), col.names = c("code", "activity"))

# 3. Load training data
x_train <- read.table(file.path(data_dir, "train", "X_train.txt"))
y_train <- read.table(file.path(data_dir, "train", "y_train.txt"), col.names = "activity")
subject_train <- read.table(file.path(data_dir, "train", "subject_train.txt"), col.names = "subject")

# 4. Load test data
x_test <- read.table(file.path(data_dir, "test", "X_test.txt"))
y_test <- read.table(file.path(data_dir, "test", "y_test.txt"), col.names = "activity")
subject_test <- read.table(file.path(data_dir, "test", "subject_test.txt"), col.names = "subject")

# 5. Row-bind train and test tables
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)

# 6. Assign column names to feature measurements
colnames(x_data) <- features$feature_name

# 7. Column-bind everything into a single data frame
full_dataset <- cbind(subject_data, y_data, x_data)
#checking dim
dim(full_dataset)
#inspecting columns names
colnames(full_dataset)


mean_std_features <- grep("mean\\(\\)|std\\(\\)", features$feature_name, value = TRUE)

# Subset columns from full dataset
extracted_data <- full_dataset %>% 
  select(subject, activity, all_of(mean_std_features))



# converting activity into factor 
extracted_data$activity <- factor(
  extracted_data$activity, 
  levels = activities$code, 
  labels = activities$activity
)
extracted_data$activity


#cleaning up columns headers

names(extracted_data) <- names(extracted_data) %>%
  gsub("^t", "Time", .) %>%
  gsub("^f", "Frequency", .) %>%
  gsub("Acc", "Accelerometer", .) %>%
  gsub("Gyro", "Gyroscope", .) %>%
  gsub("Mag", "Magnitude", .) %>%
  gsub("BodyBody", "Body", .) %>%
  gsub("-mean\\(\\)", "Mean", .) %>%
  gsub("-std\\(\\)", "Std", .) %>%
  gsub("-", "", .)




# Calculate average for each variable per subject/activity pair
tidy_data <- extracted_data %>%
  group_by(subject, activity) %>%
  summarise(across(everything(), mean), .groups = "drop")
tidy_data
# Export the final tidy dataset for Coursera submission
write.table(tidy_data, "tidy_data.txt", row.name = FALSE)