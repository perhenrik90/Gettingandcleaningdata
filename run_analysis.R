
# Read test data
testsamples <- read.table("dataset/train/X_train.txt")
testlabels <- read.csv("dataset/train/y_train.txt")

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
