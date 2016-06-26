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

##Variables
Some of the important variables are described as follows.

* `trainx`, `trainy`, `testx`, `testy`, `train_subject` and `test_subject` contain the data from the downloaded files.
* `allx`, `ally` and `alls` are the merged datasets (from training and testing sets) for further analysis.
* `featureNames` contains the correct names for the `all` dataset, which are used to name the features in the X data.
* A similar approach is taken with activity names through the `activities` variable.
* `mean_std_df` is a data frame containing the data related to mean and std.
* `all_data_sorted` is a data frame with correct measurements of interest.
* Finally, `tidymean` contains the relevant averages which will be later stored in the `data.txt` file.
