---
title: "CodeBook for run_analysis.R script"
output: html_document
---


"A code book describes the variables, the data, and any transformations or work performed to clean up the data."" 

Note that all the data presented here (means, standard
deviations were originally normalised  to 
be between -1...1 so no units!)

Original data comes from: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

with description in:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.


of these folders, the following files were included:



features.txt - "column names" aka variable names of X_train and X_test
X_train.txt - "train" dataset data
y_train.txt - "train" dataset activity codes
X_test.txt - "test" dataset data
y_test.txt  - "test" dataset activity codes
activity_labels.txt - activity names corresponding to y_train and y_test
subject_train.txt - subject numbers for "train" set
subject_test.txt - subject numbers for "test" set


see more about the transformations performed etc. in ReadMe.md!!!

"NTables" dataset is written into NTables.txt

!!!!OrderedTable" is written into table.txt <- this is the step 5 file you're looking for!!!!


These datasets were created:

Ntables,'data.frame':   339867 obs. of  9 variables (note this is in .csv table format, move to excel or something for easier reading):

variable,type,explanation,levels,explanation of this level (if not obvious),corresponding value or variable in original data,cleaning or transformation

feature,factor,the measured feature," [1] ""acceleration of body""                                ",,<BodyAcc>,"in features.txt, column names for the X_test.txt and X_train.txt"
,,," [2] ""acceleration of gravity""                             ",,<GravityAcc>,"only the features with ""-mean()"" or ""-std()"" were selected"
,,," [3] ""corrupted feature name""                              ",,<BodyBody>,"direction (X,Y,Z,none) was separated from feature name"
,,," [4] ""angular velocity of body""                                        ",,<BodyGyro>,"indicator of being fouriertransformed (t/f) as the first letter, was separated from the feature name"
,,," [5] ""jerk due to angular acceleration of body""               ",,<BodyGyroJerk>,the feature names were converted to lowercase and replaced with more comprehensible names
,,," [6] ""jerk due to linear acceleration of body""             ",,<BodyAccJerk>,"the feature names with ""BodyBody"" were written as ""corrupted feature name"""
,,," [7] ""magnitude of acceleration of body""                   ",,<BodyAccMag>,
,,," [8] ""magnitude of acceleration of gravity""                ",,<GravityAccMag>,
,,," [9] ""magnitude of angular velocity of body""                           ",,<BodyGyroMag>,
,,,"[10] ""magnitude of jerk due to angular acceleration of body""  ",,<BodyGyroJerkMag>,
,,,"[11] ""magnitude of jerk due to linear acceleration of body""",,<BodyAccJerkMag>,
,,,,,,
direction,factor,direction of the measured movement,x,movement in x-direction,<X>,extracted from the original feature name (in features.txt)
,,,y,movement in y-direction,<Y>,"only the features with ""-mean()"" or ""-std()"" were selected"
,,,z,movement in z-direction,<Z>,converted to lowercase
,,,none,this feature does not have direction,-,
,,,,,,
,,,,,,
,,,,,,
mean,numeric,mean of measurements,"-1.1, no units as original data was already normalised",,,"values corresponding to features.txt features with ""-mean()"""
standardDeviation,numeric,standard deviation of measurements,"-1.1, no units as original data was already normalised",,,"values corresponding to features.txt features with ""-std()"""
,,,,,,
originset,factor,train,,,,
,,test,,,,
caseid,factor,line number of combined X_train and X_test set,1.10299,,,
subject,factor,subject number,1.30,,,
activity,factor,activity while measurements were made,laying,,6,values in y_train and y_train were attached to X_train and X_test datasets
,,,sitting,,4,they were replaced by labels in activity_labels.txt
,,,standing,,5,they were converted to lowercase
,,,walking,,1,
,,,walking upstairs,,2,
,,,walking downstrairs,,3,
fouriertransformed,factor,are mean and std- values fourier transformed or not,istransformed,not transformed,f,first letter of the original feature names (in features.txt)
,,,nottransformed,the original data was fourier-transformed,t,
,,,,,,






						
OrderedTable:	character matrix with 3600 rows and  6 columns 

variable    type  explanation

"feature with direction by activity and by subject"	char	combinations of "feature" and "direction" and "activity" and "subject" in Ntables				
"feature with direction"	char	combinations of "feature" and "direction" in Ntables				
"activity"	char	see previously in Ntables				
"subject"	char	see previously in Ntables				
"average of means"	char	average of means by activity and subject				
"average of standard deviations"	char	average of standard deviations by activity and subject				

---