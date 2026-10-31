# Getting and Cleaning Data Course Project

This repository contains the R code, codebook, and tidy dataset produced for the Coursera *Getting and Cleaning Data* course project.

## Project Overview

The objective of this project is to collect, work with, and clean a wearable computing dataset collected from the accelerometers of the Samsung Galaxy S smartphone. 

A full description of the original data is available at the [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

## Repository Files

* **`run_analysis.R`**: The R script that downloads the raw data, cleans and merges the training and test datasets, extracts mean and standard deviation metrics, renames variables, and exports the final tidy dataset.
* **`tidy_data.txt`**: The final clean dataset exported by `run_analysis.R`. It contains the average of each feature metric grouped by subject and activity.
* **`CodeBook.md`**: A codebook describing the variables, the data transformations, and the summary calculations performed to generate `tidy_data.txt`.
* **`README.md`**: This file, explaining the repository layout and execution instructions.

## How to Run the Script

1. Open R or RStudio.
2. Install the required package if not already installed:
   ```R
   install.packages("dplyr")
