#Getting and Cleaning Data Project
Shipeng

##Code description

The script `run_analysis.R` performs 5 steps in order to process the raw data and generate new tidy dataset for future processing, as described in the course project outline.

Following I will walk through the flow of the code.

* First, the training and testing data, as well as the labels, are read from the corrsponding files. All the similar data is merged using the `rbind()` function.
* Then, only those columns with the mean and standard deviation measures are taken from the whole dataset. 
* After extracting the columns of interest, they are given the correct names, taken from `features.txt`.
* As activity labels are addressed with values 1 to 6, we take the activity names and IDs from `activity_labels.txt` and substitute the label numbers, as addressed in the project requirements.
* On the whole dataset, those columns with overly abbreviated names are renamed with more descriptive names.
* Then, we generate a new dataset with all the average measures for each subject and activity types.
* Note that the dataset generated in the previous step is not yet tidy, as some headers are values, not variable names. A typical header consists with the measurement, the processing method (mean or standard deviation), and possibly a direction(X, Y, or Z). Thus we further tidy the data set using the gather and separate function.

The output file is called `averages_data.txt`, and uploaded to this repository.

