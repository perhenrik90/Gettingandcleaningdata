library(dplyr)

# Find a activity label based on numeric value given in activity_labels.txt
findLabel <- function(n){
    label = ''
    if(n == "1"){ label="WALKING" }
    else if( n == "2"){ label="WALKING_UPSTAIRS" }
    else if( n == "3"){ label="WALKING_DOWNSTAIRS" }
    else if( n == "4"){ label="SITTING" }
    else if( n == "5"){ label="STANDING" }
    else if( n == "6"){ label="LAYING" }
    label
}

#################
# TRAIN DATASET
#################

# Read train data
trainsamples <- read.table("dataset/train/X_train.txt")
traindata <- read.csv("dataset/train/y_train.txt", header=FALSE)


# Find labels according to lable id
traindata$activity <- sapply(traindata$V1, findLabel)

# Remove column V1
traindata <- within(traindata, rm("V1"))

# Read the subject list as a vector an add to dataframe
traindata$subjectid <- read.csv("dataset/train/subject_train.txt", head=FALSE)$V1

# Compute means 
traindata$means <- apply(trainsamples, 1, mean)

# Compute standard diviation
traindata$sd <- apply(trainsamples, 1, sd)

# Remove unused table (release memory)
rm(trainsamples)

# Add column for storing which dataset the data is comming from
traindata$dataset <- "Train"


####################
# Testdata
####################

# Read test data
testsamples <- read.table("dataset/test/X_test.txt")
testdata <- read.csv("dataset/test/y_test.txt", header=FALSE)


# Find labels according to lable id
testdata$activity <- sapply(testdata$V1, findLabel)

# Remove column V1
testdata <- within(testdata, rm("V1"))

# Read the subject list as a vector an add to dataframe
testdata$subjectid <- read.csv("dataset/test/subject_test.txt", head=FALSE)$V1

# Compute means 
testdata$means <- apply(testsamples, 1, mean)

# Compute standard diviation
testdata$sd <- apply(testsamples, 1, sd)

# Remove unused table (release memory)
rm(testsamples)

# Add column for storing which dataset the data is comming from
testdata$dataset <- "Test"



#####################
# Merge and cleanup
#####################

data <- rbind(traindata, testdata)
rm(traindata)
rm(testdata)

# write dataset to csv
write.csv(data, "data.csv", row.names=FALSE)


# use dplyr to aggregate the new dataset
data2 <- within(data, rm("dataset")) # remove unsued variable
data2 <- data2 %>% group_by(subjectid, activity) %>% summarise_all(funs(mean))

write.csv(data2, "data2.csv", row.names=FALSE)
