




# CodeBook - Human Activity Recognition Tidy Dataset

This codebook documents the structure, variables, and transformations used to create `tidy_data.txt` for the *Getting and Cleaning Data* course project.

## Overview

* **Source Data**: [UCI HAR Dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
* **Output File**: `tidy_data.txt`
* **Dimensions**: 180 rows $\times$ 68 columns
* **Unit of Observation**: A unique pair of `subject` (1–30) and `activity` (6 types), resulting in $30 \times 6 = 180$ rows. All feature measurements represent the average (mean) value for that specific subject-activity combination.

---

## Identifiers

| Variable | Type | Range / Values | Description |
| :--- | :--- | :--- | :--- |
| `subject` | Integer | `1` to `30` | Unique identifier for each of the 30 human volunteers. |
| `activity` | Factor | `WALKING`, `WALKING_UPSTAIRS`, `WALKING_DOWNSTAIRS`, `SITTING`, `STANDING`, `LAYING` | The specific activity performed during signal measurement. |

---

## Feature Measurements

All feature measurements are normalized and bounded within `[-1, 1]`. Values represent the average signal value for the given subject and activity.

### Variable Naming Convention
* **`Time`**: Time domain signals (captured at a constant rate of 50 Hz).
* **`Frequency`**: Frequency domain signals (obtained by applying a Fast Fourier Transform).
* **`Accelerometer`**: Triaxial acceleration signals from the accelerometer.
* **`Gyroscope`**: Triaxial angular velocity signals from the gyroscope.
* **`Body`**: Body motion signal component.
* **`Gravity`**: Gravity signal component.
* **`Jerk`**: Jerk signals derived from body linear acceleration and angular velocity.
* **`Magnitude`**: Magnitude of the three-dimensional signals calculated using the Euclidean norm.
* **`Mean` / `Std`**: Indicates whether the metric is a mean value or standard deviation.
* **`X`, `Y`, `Z`**: 3-axial direction of the measurement.

### Full List of Measurement Variables (66 Total)

#### Time Domain Signals
* `TimeBodyAccelerometerMeanX`, `TimeBodyAccelerometerMeanY`, `TimeBodyAccelerometerMeanZ`
* `TimeBodyAccelerometerStdX`, `TimeBodyAccelerometerStdY`, `TimeBodyAccelerometerStdZ`
* `TimeGravityAccelerometerMeanX`, `TimeGravityAccelerometerMeanY`, `TimeGravityAccelerometerMeanZ`
* `TimeGravityAccelerometerStdX`, `TimeGravityAccelerometerStdY`, `TimeGravityAccelerometerStdZ`
* `TimeBodyAccelerometerJerkMeanX`, `TimeBodyAccelerometerJerkMeanY`, `TimeBodyAccelerometerJerkMeanZ`
* `TimeBodyAccelerometerJerkStdX`, `TimeBodyAccelerometerJerkStdY`, `TimeBodyAccelerometerJerkStdZ`
* `TimeBodyGyroscopeMeanX`, `TimeBodyGyroscopeMeanY`, `TimeBodyGyroscopeMeanZ`
* `TimeBodyGyroscopeStdX`, `TimeBodyGyroscopeStdY`, `TimeBodyGyroscopeStdZ`
* `TimeBodyGyroscopeJerkMeanX`, `TimeBodyGyroscopeJerkMeanY`, `TimeBodyGyroscopeJerkMeanZ`
* `TimeBodyGyroscopeJerkStdX`, `TimeBodyGyroscopeJerkStdY`, `TimeBodyGyroscopeJerkStdZ`
* `TimeBodyAccelerometerMagnitudeMean`, `TimeBodyAccelerometerMagnitudeStd`
* `TimeGravityAccelerometerMagnitudeMean`, `TimeGravityAccelerometerMagnitudeStd`
* `TimeBodyAccelerometerJerkMagnitudeMean`, `TimeBodyAccelerometerJerkMagnitudeStd`
* `TimeBodyGyroscopeMagnitudeMean`, `TimeBodyGyroscopeMagnitudeStd`
* `TimeBodyGyroscopeJerkMagnitudeMean`, `TimeBodyGyroscopeJerkMagnitudeStd`

#### Frequency Domain Signals
* `FrequencyBodyAccelerometerMeanX`, `FrequencyBodyAccelerometerMeanY`, `FrequencyBodyAccelerometerMeanZ`
* `FrequencyBodyAccelerometerStdX`, `FrequencyBodyAccelerometerStdY`, `FrequencyBodyAccelerometerStdZ`
* `FrequencyBodyAccelerometerJerkMeanX`, `FrequencyBodyAccelerometerJerkMeanY`, `FrequencyBodyAccelerometerJerkMeanZ`
* `FrequencyBodyAccelerometerJerkStdX`, `FrequencyBodyAccelerometerJerkStdY`, `FrequencyBodyAccelerometerJerkStdZ`
* `FrequencyBodyGyroscopeMeanX`, `FrequencyBodyGyroscopeMeanY`, `FrequencyBodyGyroscopeMeanZ`
* `FrequencyBodyGyroscopeStdX`, `FrequencyBodyGyroscopeStdY`, `FrequencyBodyGyroscopeStdZ`
* `FrequencyBodyAccelerometerMagnitudeMean`, `FrequencyBodyAccelerometerMagnitudeStd`
* `FrequencyBodyAccelerometerJerkMagnitudeMean`, `FrequencyBodyAccelerometerJerkMagnitudeStd`
* `FrequencyBodyGyroscopeMagnitudeMean`, `FrequencyBodyGyroscopeMagnitudeStd`
* `FrequencyBodyGyroscopeJerkMagnitudeMean`, `FrequencyBodyGyroscopeJerkMagnitudeStd`

---

## Data Transformations

1. **Merging**: `X_train.txt` (7352 rows) and `X_test.txt` (2947 rows) were concatenated vertically to create a dataset of 10,299 observations. Subject and Activity IDs were appended horizontally.
2. **Feature Filtering**: Selected only columns containing literal `mean()` or `std()` substrings in `features.txt` (66 features extracted).
3. **Activity Labeling**: Transformed integer codes (1–6) into factor labels using mapping from `activity_labels.txt`.
4. **Variable Formatting**: Applied regular expression replacements (`gsub`) to transform cryptic abbreviations into clean CamelCase titles.
5. **Aggregation**: Used `group_by(subject, activity)` and `summarise(across(everything(), mean))` to calculate the average of each column per group.
