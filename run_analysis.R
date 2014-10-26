

## This makes a dataset called "NTables" which has variables "feature","direction","mean","std",
## "originset","activity","caseid", "subject", "fouriertransformed"


## This is a bit more complicated that maybe required in the task? But this
## makes a tidy data set that I could use if I would work with this data, so...
## - the datafiles are in a subfolder of the working directory ("./data"):
## 
##    the features.txt,X_train.txt, y_train.txt, X_test.txt, y_test.txt
##    activity_labels.txt, subject_train.txt, subject_test.txt

## it is assumed you already have these files so there's no downloading, unzipping etc.

## note that running this code will take about 10 min as the final dataset
## is quite big (339867 obs. of  9 variables)


## note that this code creates a bunch of "unnecessary" temp variables, datasets etc.
## (Creates x_train_5 out of x_train_4 instead of just overwriting x_train_4)
## this is to make the code easier to read, but if you're short on memory 
## maybe change this


#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#source packages you'll need 

library(stringr)

#read column names for the X_train and X_test tables

colN <- read.table("./data/features.txt") #this makes a two variable data.frame

#take only the vector that has the action names, note that "colN": Factor w/ 477 levels

colN <- colN[,2]



# make other variable with the  numbers of the columns of X_train.txt etc
# where the column names  have -mean() or -std() in them
# note that you need \\ before "(" as "(" is a special character
#     !!!this was my decision on how to interpret the order to choose only results on 
#     !!!means and standard deviations


meansDevs <- sort(c(grep("-mean\\()",colN),grep("-std\\()",colN))) #integer vector



#read activity code meanings

acc = as.character(
      as.vector(t(read.table("./data/activity_labels.txt", sep = "\t"))))

#remove the activity numbers from "acc" (otherwise "1 WALKING" etc.)
acc <- substring(acc, 3)
acc <- tolower(acc) # to lower case 
acc <- sub("_","", acc) #remove "_" symbols


#read X_train file (note that the created variable has a lowercase x)

x_train = read.table("./data/X_train.txt")

#add "column names"
colnames(x_train) <- as.character(colN)
x_train_2 <- x_train[,meansDevs] #only variables that are means or stdevs (PROJECT TASK 2 !!!)
origin <- "train" #which dataset this data comes from
x_train_3 <- cbind(x_train_2, origin)

#make vectors that tell which column have means and which stdevs

means <- grep("-mean\\()",names(x_train_3)) #integer vector
stds <- grep("-std\\()", names(x_train_3)) #integer vector


#add activity description
y_train = as.character(as.vector(t(read.table("./data/y_train.txt"))))

#replace the activity codes with activity names (PROJECT TASK 3!!!)
for (i in 1:6){
      y_train <- gsub(i,acc[i],y_train)
}
x_train_4 <- cbind(x_train_3, y_train)


## add subject code


subject = as.character(as.vector(t(read.table("./data/subject_train.txt"))))

x_train_5 <- cbind(x_train_4, subject)

#read X_test file

x_test = read.table("./data/X_test.txt")
colnames(x_test) <- as.character(colN)
x_test_2 <- x_test[,meansDevs] #only variables that are means or stdevs (PROJECT TASK 2 !!!)
origin2 <- "test"
x_test_3 <- cbind(x_test_2, origin2)

#add activity description
y_test = as.character(as.vector(t(read.table("./data/y_test.txt"))))

#replace the activity codes with activity names (PROJECT TASK 3!!!)
for (i in 1:6){
      y_test <- gsub(i,acc[i],y_test)
}
x_test_4 <- cbind(x_test_3, y_test)


## add subject code


subject = as.character(as.vector(t(read.table("./data/subject_test.txt"))))

x_test_5 <- cbind(x_test_4, subject) ## this is the "backup" of x_test sets,


x_test_6 <- x_test_5  # this dataset will have "wrong" column names from "train"
colnames(x_test_6) <- names(x_train_5) # this is necessary for binding the sets


### dataset will have data from both train and test - datasets (PROJECT TASK 1!!!)
dataset <- rbind (x_train_5,x_test_6)



### now we want to separate information from the "features" 
### so if someone wants to just look at eg. x- direction features that 
### were f-tranformed they can without having to figure out feature names
### "have only one variable per column"
### whereas if one wants to check "bodyacceleration in x-direction" they can
### select which(feature == "bodyacc" & direction == "X") quite easily
### (I'm not sure why one would want to watch just X direction data, but
### as it's included I guess it matters?)


# #set up for final table creating
#### first you need some vectors to make it possible to separate information
### from a row to several column

#"direction" makes a vector that has the direction for each column of "dataset"
# that has means (we don't need the ones that have std's, as one feature/row 
# of the output dataset has one measurement
# of means and one of stds, we dont' need it twice) 
# i.e. in the final dataset: feature direction mean std
# if the feature is not with direction, it has value "NONE"
      
x <- c("X","Y","Z")
direction <- names(dataset)[means] #direction is names of dataset that have "-means()" in them
for (i in 1:length(direction)){ 
      if (str_sub(direction[i], start= -1) %in% x){  #if last letter of feature is in "x"
            direction [i] <- str_sub(direction[i], start= -1) #put that letter to direction
      }else {direction [i] <- "NONE"}
}


                   
#"feature" is a vector that has the measured feature for 
#each column of "dataset" (such as tBodyAcc)  (t will be removed later)
#that has means (we don't need the ones that have std's, as one variable has one measurement
#of means and one of stds, we dont' need it twice)



feature <- sub("(.*?)-.*", "\\1", names(dataset)[means]) #take only part until first "-"

 
 
 
 
 #one big table "NTables" is constructed, that only has 8 columns
 #"feature","direction","mean","std","originset","activity","caseid","subject"
 
 #this process is divided to 4 parts (NTable1-4) as otherwise it would take too much time
 #there must be a nicer, faster way to do this, but this works too...
 
 for (i in 1:3000){
       NiceTable = matrix(,33,8) #make new empty NiceTable
       NiceTable = as.data.frame(NiceTable)
       NiceTable[1:33,1] <- feature
       NiceTable[1:33,2]<- direction
       #each column of a row in "dataset" has the same origin
       NiceTable[1:33,5] <- as.character(t(rep(dataset$origin[i], times=33))) 
       #each column of a row in "dataset" has the same activity
       NiceTable[1:33,6] <- as.character(t(rep(dataset$y_train[i], times=33)))
       #each column of a row in "dataset" has the same subject
       NiceTable[1:33,8] <- as.character(t(rep(dataset$subject[i], times=33)))
       #caseid is the rownumber in "dataset"
       NiceTable[1:33,7]<- as.data.frame(rep(i,33))
       #means to "mean" column (column number 3)
       NiceTable[1:33,3] <-as.vector(t(dataset[i,means]))
       #stds to "std" column (coulumn number 4)
       NiceTable[1:33,4] <-as.vector(t(dataset[i,stds]))
       if (i == 1){ NTable1 <- NiceTable #make NTable1 in the first round
       }else {NTable1 <- rbind(NTable1, NiceTable)} #add the generated rows 
 }
 
 
 for (i in 3001:6000){
       NiceTable = matrix(,33,8) #make new empty NiceTable
       NiceTable = as.data.frame(NiceTable)
       NiceTable[1:33,1] <- feature
       NiceTable[1:33,2]<- direction
       NiceTable[1:33,5] <- as.character(t(rep(dataset$origin[i], times=33))) 
       NiceTable[1:33,6] <- as.character(t(rep(dataset$y_train[i], times=33)))
       NiceTable[1:33,8] <- as.character(t(rep(dataset$subject[i], times=33)))
       NiceTable[1:33,7]<- as.data.frame(rep(i,33)) #rownumber
       NiceTable[1:33,3] <-as.vector(t(dataset[i,means]))
       NiceTable[1:33,4] <-as.vector(t(dataset[i,stds]))
       if (i == 3001){ NTable2 <- NiceTable
       }else {NTable2 <- rbind(NTable2, NiceTable)}
 }
 
 
 for (i in 6001:9000){
       NiceTable = matrix(,33,8) #make new empty NiceTable
       NiceTable = as.data.frame(NiceTable)
       NiceTable[1:33,1] <- feature
       NiceTable[1:33,2]<- direction
       NiceTable[1:33,5] <- as.character(t(rep(dataset$origin[i], times=33))) #each variable of a row in "dataset" has the same origin
       NiceTable[1:33,6] <- as.character(t(rep(dataset$y_train[i], times=33)))#each variable of a row in "dataset" has the same action
       NiceTable[1:33,8] <- as.character(t(rep(dataset$subject[i], times=33)))#each variable of a row in "dataset" has the same subject
       NiceTable[1:33,7]<- as.data.frame(rep(i,33)) #rownumber
       NiceTable[1:33,3] <-as.vector(t(dataset[i,means]))
       NiceTable[1:33,4] <-as.vector(t(dataset[i,stds]))
       if (i == 6001){ NTable3 <- NiceTable
       }else {NTable3 <- rbind(NTable3, NiceTable)}
 }
 
 for (i in 9001:nrow(dataset)){
       NiceTable = matrix(,33,8) #make new empty NiceTable
       NiceTable = as.data.frame(NiceTable)
       NiceTable[1:33,1] <- feature
       NiceTable[1:33,2]<- direction
       NiceTable[1:33,5] <- as.character(t(rep(dataset$origin[i], times=33))) #each variable of a row in "dataset" has the same origin
       NiceTable[1:33,6] <- as.character(t(rep(dataset$y_train[i], times=33)))#each variable of a row in "dataset" has the same action
       NiceTable[1:33,8] <- as.character(t(rep(dataset$subject[i], times=33)))#each variable of a row in "dataset" has the same subject
       NiceTable[1:33,7]<- as.data.frame(rep(i,33)) #rownumber
       NiceTable[1:33,3] <-as.vector(t(dataset[i,means]))
       NiceTable[1:33,4] <-as.vector(t(dataset[i,stds]))
       if (i == 9001){ NTable4 <- NiceTable
       }else {NTable4 <- rbind(NTable4, NiceTable)}
 }
 
 NTables <- rbind(NTable1, NTable2, NTable3, NTable4) #combine the created "subtables"
 
 #set header we want for the final table (PART OF PROJECT TASK 4!!!)
 # the standardDeviation has a capital D for ease of reading (in real life,
# this would be just std but whatever)
 
colnames(NTables) <- c("feature","direction","mean","standardDeviation",
              "originset","activity","caseid","subject")

#make another column to NTables to show if the results are fourier-transformed or not
#(this can be seen from the first letter of "feature")

fd <- str_sub(NTables[,1], end = 1)

#remove the t or f from the feature (=remove first letter)

NTables$feature <- substring(NTables$feature, 2)


#let's change the feature names into more comprehensive ones (THIS IS TASK 4
# as the original variable names are kind of feature names here so...)
# here i left spaces to names as they could not be understood without
# if this was my dataset I would likely include the old short names as well
# as these new long names (easy to do, just copy the old column and change only
# the copy), then use the short names in calculation but keep the long names there 
# as a reminder...


### there are some strange features that have "bodybody" in them.
### probably some typo, renamed with "corrupted feature name"
NTables$feature[grep("BodyBody",NTables$feature)] <- "Corrupted feature name"

#this is a matrix that i use for replacing the old with the new names

transl <- rbind(
      c("bodyaccjerkmag","magnitude of jerk due to linear acceleration of body"),
      c("bodyaccjerk","jerk due to linear acceleration of body"),
      c("bodyaccmag","magnitude of acceleration of body"),
      c("bodyacc","acceleration of body"),       
      c("bodygyrojerkmag"  , "magnitude of jerk due to angular acceleration of body"),
      c("bodygyrojerk", "jerk due to angular acceleration of body"),
      c("bodygyromag"   ,"magnitude of angular velocity of body"),    
      c("bodygyro","gyro of body"),     
      c("gravityaccmag", "magnitude of acceleration of gravity"),
      c("gravityacc" ,"acceleration of gravity")) 

#rename "feature" and "direction" with lowercase activity names
NTables$feature <- tolower(NTables$feature)
NTables$direction <- tolower(NTables$direction)

# this is a bit bad code as it only works if the transl is in the same row order as 
# it is now, should google how to use gsub or something to only replace the exact string
# as in find only "world" and not also "world" in Worldpeace"...oh well...

for (i in 1: nrow(transl)){
      NTables$feature <- gsub(transl[i,1], transl[i,2], NTables$feature, fixed = TRUE)
}




#make "t"s into "notransformed" and "f"s into "istransformed" (i checked, 
# there are only those 2 options so can use else)

for (i in 1:length(fd)){
      if (fd[i] == "f") {
            fd[i] <- "istransformed"}
      else {fd[i] <- "nottransformed"}
}

fouriertransformed <- fd #lazy, don't want to rename the final column of NTables
fd=0

NTables <- cbind(NTables, fouriertransformed)

 
 # change chars to factors
 
 NTables$feature <- as.factor(NTables$feature)
 NTables$direction <- as.factor(NTables$direction)
 NTables$originset <- as.factor(NTables$originset)
 NTables$activity <- as.factor(NTables$activity)
 NTables$caseid <- as.factor(NTables$caseid)
 NTables$subject <- as.factor(NTables$subject)


#### finally, write NTables to disc

write.table(NTables, "./NTables.txt", row.names= FALSE)

#### step 5. From the data set in step 4, creates a second, independent 
#### tidy data set with 
#### the average of each variable for each activity and each subject.

## I'm assuming here that "variable" refers to "mean" and "std" of original features?
## for instance, "fBodyGyro" in "X" direction would have average for each activity and subject
## also, not including fourier transformed values as they are the same values, transformed?


# first extract non-fourier transformed 

NTableT <- NTables[which(NTables$fouriertransformed =="nottransformed"),]

#split by feature, direction, activity and subject

new <- split(NTableT, paste(NTableT$feature, NTableT$direction, NTableT$activity, NTableT$subject))

#there are 3600 combinations :  length(names(new))

for (i in 1:length(names(new))){ #for each combination
      data <- as.data.frame(new[i][1])
      sub_mean <- sapply(data[3], FUN = mean) #means are in column 3
      sub_std <- sapply(data[4], FUN = mean) #stds are in column 4
      variable <- names(new[i])
      subject <- as.character(data[[8]][1])
      feature <- as.character(paste (data [[1]][1],"in direction", data [[2]][1]))
      activity <- as.character(data [[6]][1])
     
      L <- c(variable, feature, activity, subject, sub_mean, sub_std)
      if (i == 1){
            table <- L #first create table
      }else{
      table <- rbind(table, L) #then add new row after each iteration
      }
      
}

# here the feature with direction by activity and by subject" column is redundant for this purpose as
# the same info in other column but lets leave it here anyway
colnames(table) <- c("feature with direction by activity and by subject","feature with direction", "activity","subject", "average of means", "average of standard deviations")
row.names(table) <- NULL
#order first by feature with direction by activity, then by subject number
OrderedTable <- table[order(str_sub(table[,1], end = -3),as.numeric(str_sub(table[,1], start= -2))),] 


write.table(OrderedTable, "./table.txt", row.names= FALSE)