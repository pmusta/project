---
title: "ReadMe for project which produces tidy data sets NTables and OrderedTable.
output: html_document
---
table.txt is the file you're probably looking for,
the step 5 data!!!








note that first there is the old ReadMe.txt and after that only my additions to this!!


The script "run_analysis.R" makes a tidy(ish) dataset called "NTables" which has variables "feature","direction","mean","standardDeviation", "originset","activity","caseid", "subject", "fouriertransformed".
This corresponds to parts 1-4 of the project exercise.

After this, it makes a separate tidy dataset (part 5 of the project) called OrderedTable, with the average of each (non-fourier transformed) variable for each activity and each subject (the transformed can be included if the subsetting is excluded, but they are the same values, transformed????). This dataset is written to disk as space separated data file "table.txt".

This is a bit more complicated that maybe required in the task? But this
makes a tidy data set that I could use if I would work with this data, so...
 - the datafiles are in a subfolder of the working directory ("./data"):

    the features.txt,X_train.txt, y_train.txt, X_test.txt, y_test.txt
    activity_labels.txt, subject_train.txt, subject_test.txt

it is assumed you already have these files so there's no downloading, unzipping etc.

note that running this code will take about 10 min as the final dataset
 is quite big (339867 obs. of 9 variables)


note that this code creates a bunch of "unnecessary" temp variables, datasets etc.
 (Creates x_train_5 out of x_train_4 instead of just overwriting x_train_4)
 this is to make the code easier to read, but if you're short on memory 
 maybe change this

Codebook is provided as CodeBook.md 


Original data comes from: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

with description in:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

here is the text of the README.txt file that came with the original data:


#####################
#############################
######################################
###########################################################
==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





##end of original readme file!!!!









%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%
%
%
%



of these folders/files, the following files were included:

features.txt - "column names" aka variable names of X_train and X_test
X_train.txt - "train" dataset data
y_train.txt - "train" dataset activity codes
X_test.txt - "test" dataset data
y_test.txt  - "test" dataset activity codes
activity_labels.txt - activity names corresponding to y_train and y_test
subject_train.txt - subject numbers for "train" set
subject_test.txt - subject numbers for "test" set

following cleaning of data was performed: 

-- X_train and X_test were labeled with features.txt vector as column names

- Section of only measurements of mean and standard deviation was included.
      this was done by only selecting the column in X_train and X_Test,
      where the corresponding features.txt feature labels
      had string "-mean()" or "-std()" in them.
      
- activities of X_train and X_test were included by adding y_train and y_test as last column
 of the dataset. Then y_train and y_test codes (1-6) were replaced by the activity names
 from the activity_labels.txt (without numbers, only "walking" etc., in all lowercase)
 
- subject numbers were added to X_train and X_test by adding subject_train.txt and
  subject_test.txt as additional column.

- the X_train and X_test were combined to one dataset. The row number of the original X_train and X_test dataset was added as caseid- variable (1st row of X_train would have caseid ="1" and 1st row of X_test would have last row number of X_train +1.

- In my opinion, the feature names such as "fBodyGyro-std()-Z" had several variables 
  (is it fourier transformed or not? what is the feature? what was measured, mean 
  or std? what was the direction of movement?) in one column, which is against tidy data set principles.
  For this reason, the data was converted so that each feature-transformation-direction-activity-subject-origin set
  was one observation (with both mean and std) aka had a one line. so in the end the final dataset had format
  
  feature   direction   mean  standardDeviation   originset   activity    caseid      subject     fouriertransformed
  
  BodyGyro  Z     value value train/test  walking     45    21    istransformed       
  
      
- f or t letter (the first letter of the original feature names) was separated to their
      own column to show if the data was transformed or not. This to make easier to
      use only transformed or not transformed data in analysis. f was replaced with 
      "istransformed" and t with "nottransformed"
      
- feature names were transformed to all lower case, and replaced by more easily 
  understandable long names. Note that here I had to decide between rule "no spaces"
  and having incomprehensible names, so I chose to have spaces in the feature long names.
  If this was my data, I would have just added another column with long names and left
  the short names (BodyAcc) as they were... 
  NOTE! There was some feature names that had string "BodyBody" in them, which was
  not found in the original ReadMe or Features_info.text... I chose to replace these
  with "corrupted feature name" as who knows what they meant.
  Here is a list of the replacements:
  
      Original Code (in lower case)          New long name of feature
      
      bodyaccjerkmag          magnitude of jerk due to linear acceleration of body
      bodyaccjerk                  jerk due to linear acceleration of body
      bodyaccmag	            magnitude of acceleration of body
      bodyacc	            acceleration of body
      bodygyrojerkmag  	      magnitude of jerk due to angular acceleration of body
      bodygyrojerk	      jerk due to angular acceleration of body
      bodygyromag   	      magnitude of angular velocity of body
      bodygyro	            angular velocity of body
      gravityaccmag	      magnitude of acceleration of gravity
      gravityacc 	            acceleration of gravity 

Additional table (task 5 in project assignment) was formed (table.txt)
For this table, NTablessubset with only non-transformed values was split by subject, activity, feature and feature direction to get unique cases, and then average of "mean" and "standard deviation" columns was calculated over these unique groups. 
The table has columns:
1)	name of combination of "feature" and "direction" and "activity" and "subject" in Ntables 
2-5) feature, direction, activity and subject of 1) separated to separate column for easy search
6) average of means of the group
7) average of standard deviation of the group








---
