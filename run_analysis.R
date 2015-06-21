##SCRIPT:
  #Get the data
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
directory <- "data"
path <- function(...) { paste(..., sep = "/") }
zipped <- path(downloadDir, "dataset.zip")
if(!file.exists(zipFile)) { download.file(url, zipped) }

dataDir <- path(directory, "UCI HAR Dataset")
if(!file.exists(dataDir)) { unzip(zipFile, exdir = downloadDir) }


#Read in the training data and test data, and the column labels
textest <- read.table("./test/X_test.txt")
textrain <- read.table("./train/X_train.txt")


col_names <- read.table("./features.txt")[,2]

#Label the training and test data
colnames(textest) <- col_names
colnames(textrain) <- col_names

#Read in the subjects' ids, and introduce a "subject_id" variable to keep track of them.
testsubjectids <- read.table("./test/subject_test.txt ")
colnames(testsubjectids) <- "subject_id"

trainsubjectids <- read.table("./train/subject_train.txt")
colnames(trainsubjectids) <- "subject_id"

# Read in and label the activity IDs

activities <- read.table("./activity_labels.txt")[,2]


test_activities <- read.table("./test/y_test.txt")
colnames(test_activities) <- "activities"

train_activities  <- read.table("./train/y_train.txt")
colnames(train_activities) <- "activities"



#Finalize training and test data
fulltrain <- cbind(trainsubjectids, train_activities, textrain)
fulltest <- cbind(testsubjectids, test_activities, textest)

fulltrain <- cbind(trainsubjectids, train_activities, textrain)
fulltest <- cbind(testsubjectids, test_activities, textest)

#merge training and test data
fulldata <- rbind(fulltest, fulltrain)


#Take mean and standard deviation measurements only:
takemeansd <- grepl("mean|std", col_names)
simplerdata <- fulldata[,takemeansd]


library(plyr)
#Function to take the column means for all but subject and activity columns
averagethecolumns <- function(data) {colMeans(simplerdata[,-c(1,2)])}


#Creating the final, tidy data set
tidydata <- ddply(simplerdata, .(subject_id, activities), averagethecolumns)
names(tidydata)[-c(1,2)] <- paste0("Mean", names(tidydata)[-c(1,2)])

write.table(tidydata, "tidydata.txt", row.names = FALSE)
