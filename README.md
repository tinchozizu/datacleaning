
## This File explains run_analysis.R code made by Martin Salvo

First of all, I get the data from a dynamic direction with str made by file path & directory (this variable is the dynamic part)

After I get those files, I assing row names and column names to data sets and get partial completed data sets called _"full test"_ and _"full train"_. Finally, these two DataSets are merge together to make _"fullDataset"_ which is the firs required dataset.

Measures of Mean and Std are under "VariablesMeans" and "VariablesStandardDeviation" on calculated on lines 56 and 57, respectively.

Then, through different methods I have calculated means for activities and subjects. In the first case, I split fullDataset and then calculate means. For subjects instead, with a loop that identifies Subject Number, I compose a Matrix of 30 row. One for each subject. At the end of the process I merge both "AvgSubject" and "AvgActivity" to get "tidyData" and finally write the correspondent table.

Merged Data Set

Name: fullDataset
Str: 'data.frame':  10299 obs. of  563 variables
Variables are: 561 given as default plus activities number (562) and subject number (563)

Tidy Data Set

Name: tidyData 

Str:
num [1:36, 1:561] 0.276 0.262 0.288 0.273 0.279 ...
 - attr(*, "dimnames")=List of 2
  ..$ : chr [1:36] "WALKING" "WALKING_UPSTAIRS" "WALKING_DOWNSTAIRS" "SITTING" ...
  ..$ : chr [1:561] "tBodyAcc-mean()-X" "tBodyAcc-mean()-Y" "tBodyAcc-mean()-Z" "tBodyAcc-std()-X" ...

Row.Names indicates wheter is a subjects or and activity, and the dataset contains the means of the observations in fullDataset



