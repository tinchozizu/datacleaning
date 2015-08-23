
#You should create one R script called run_analysis.R that does the following. 
#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each measurement. 
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names. 
#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

setwd("C:/Users/samsung/Documents/Data_Science/Material/Data Cleaning/UCI HAR Dataset")

directory1 <- "activity_labels.txt"
directory2 <- "features.txt"

directory3 <- "test/X_test.txt"
directory4 <- "test/y_test.txt"
directory5 <- "test/subject_test.txt"
directory6 <- "train/X_train.txt"
directory7 <- "train/y_train.txt"
directory8 <- "train/subject_train.txt"

filePath1 <- file.path(getwd(),directory1)
filePath2 <- file.path(getwd(),directory2)
filePath3 <- file.path(getwd(),directory3)
filePath4 <- file.path(getwd(),directory4)
filePath5 <- file.path(getwd(),directory5)
filePath6 <- file.path(getwd(),directory6)
filePath7 <- file.path(getwd(),directory7)
filePath8 <- file.path(getwd(),directory8)

activity_labels <- read.table(file= filePath1, header=FALSE, sep="")
features <- read.table(file= filePath2, header=FALSE, sep="")

X_test <- read.table(file= filePath3, header=FALSE, sep="")
label_test <- read.table(file= filePath4, header=FALSE, sep="")
subject_test <- read.table(file= filePath5, header=FALSE, sep="")

X_train <- read.table(file= filePath6, header=FALSE, sep="")
label_train <- read.table(file= filePath7, header=FALSE, sep="")
subject_train <- read.table(file= filePath8, header=FALSE, sep="")

label_testOK <- factor(label_test[,1],labels=activity_labels[,2]) 
label_trainOK <- factor(label_train[,1],labels=activity_labels[,2]) 

full_test <- cbind(X_test,label_testOK, subject_test)
full_train <- cbind(X_train,label_trainOK, subject_train)

newTags <- matrix(c(562,563,"activity","subject"), nrow=2, ncol=2)

features2 <- rbind(features,newTags)

colnames(full_test) <- features2[,2]
colnames(full_train) <- features2[,2]

fullDataset <- rbind(full_test, full_train)

VariablesMeans <- apply(fullDataset[,1:561],2,mean)
VariablesStandardDeviation <- apply(fullDataset[,1:561],2,sd)

splitActivity <- split(fullDataset,fullDataset$activity)

ActivitySplit1 <- apply(splitActivity$WALKING[,1:561],2,mean)
ActivitySplit2 <- apply(splitActivity$WALKING_UPSTAIRS[,1:561],2,mean)
ActivitySplit3 <- apply(splitActivity$WALKING_DOWNSTAIRS[,1:561],2,mean)
ActivitySplit4 <- apply(splitActivity$SITTING[,1:561],2,mean)
ActivitySplit5 <- apply(splitActivity$STANDING[,1:561],2,mean)
ActivitySplit6 <- apply(splitActivity$LAYING[,1:561],2,mean)

AvgActivity <- rbind(ActivitySplit1, ActivitySplit2, ActivitySplit3, ActivitySplit4, ActivitySplit5, ActivitySplit6)
rownames(AvgActivity) <- activity_labels[,2]

AvgSubject <- t(c(rep(0,561)))
colnames(AvgSubject) <- features[,2]

for (i in 1:30) {  
  my.data.frame <- subset(fullDataset, fullDataset$subject == i)
  AvgSubject2 <- colMeans(my.data.frame[,1:561]) 
  AvgSubject <- rbind(AvgSubject2, AvgSubject)
}

AvgSubject <- AvgSubject[-1,]
rownames(AvgSubject) <- c("sub1", "sub2", "sub3", "sub4", "sub5", "sub6",
                             "sub7", "sub8", "sub9", "sub10", "sub11", "sub12", "sub13",
"sub14", "sub15", "sub16", "sub17", "sub18", "sub19","sub20", "sub21", "sub22", "sub23",
"sub24", "sub25", "sub26","sub27","sub28","sub29", "sub30")

tidyData <- rbind(AvgActivity,AvgSubject)
tidyDataStep5 <- cbind(tidyData,rownames(tidyData))

write.table(tidyDataStep5, file="tidyData.txt", row.names = FALSE, col.names=TRUE)

