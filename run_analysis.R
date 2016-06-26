this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)

library(data.table)
library(dplyr)

featureNamesdf <- fread("./features.txt")
featureNames <- featureNamesdf$V2
activityNames <- fread("./activity_labels.txt", sep = " ", col.names = c("Activity","Name"))

#Merges the training and the test sets to create one data set.
trainx <- fread("./train/X_train.txt", sep = " ", col.names = featureNames)
trainy <- fread("./train/y_train.txt", sep = " ", col.names = c("Activity"))
train_subject <- fread("./train/subject_train.txt", sep = " ", col.names = c("Subject"))
testx <- fread("./test/X_test.txt", sep = " ", col.names = featureNames)
testy <- fread("./test/y_test.txt", sep = " ", col.names = c("Activity"))
test_subject <- fread("./test/subject_test.txt", sep = " ", col.names = c("Subject"))
allx <- rbind(trainx,testx)
ally <- rbind(trainy,testy)
alls <- rbind(train_subject,test_subject)
#all_data <- cbind(allx,ally,alls)
#all_data_sorted <- arrange(all_data,Subject)

#Extracts only the measurements on the mean and standard deviation for each 
name_new <- c(featureNames,"Label","Subject")
name1 <- grepl("mean", name_new, ignore.case = FALSE)
name2 <- grepl("std", name_new, ignore.case = FALSE)
mean_std <- c(name_new[name1],name_new[name2])
mean_std_df <- select(allx,which(names(allx) %in% mean_std))
new_mean_std_df <- select(mean_std_df,which(!grepl("meanFreq", names(mean_std_df)))) #except meanFreq stuffs
all_data <- cbind(alls,ally,new_mean_std_df)
all_data_sorted <- arrange(all_data,Subject)
all_data_sorted <- as.data.frame(all_data_sorted)

#Appropriately labels the data set with descriptive variable names.
all_data_sorted <- mutate(all_data_sorted,Activity = activityNames$Name[Activity])    
    
#Appropriately labels the data set with descriptive variable names.
names(all_data_sorted) <- gsub("^t", "Time", names(all_data_sorted))
names(all_data_sorted) <- gsub("^f", "Freq", names(all_data_sorted))
names(all_data_sorted) <- gsub("mean\\(\\)", "Mean", names(all_data_sorted))
names(all_data_sorted) <- gsub("std\\(\\)", "StdDev", names(all_data_sorted))

#Create a second, independent tidy data set with the average of each variable 
#for each activity and each subject.
#Column means for all but the subject and activity columns
allColMeans <- function(data) { colMeans(data[,-c(1,2)]) }
allMeans <- ddply(all_data_sorted, .(Subject, Activity), allColMeans)
library(tidyr)
#Some headers are values, not variable names. Tidy the data set as follows.
mean_gathered <- gather(allMeans,Measurement,Mean,-Subject,-Activity)
tidymean <- separate(mean_gathered,Measurement, into = c("Measurement","Processing","Direction"),sep = "-")
write.table(tidymean,file = "./data.txt", row.names = FALSE)
