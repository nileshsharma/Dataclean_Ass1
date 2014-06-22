##Setting the working directory
setwd("C:/Users/v-nilsha/Desktop/Coursera/clean_ass1")

##Downloading the zipped file and unzipping it
url="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
a<-download.file(url,destfile ="database.zip")
unzip("database.zip")

##Downloading the features and activity labels file
setwd("UCI HAR Dataset")
features<- read.table("features.txt",header=FALSE,sep="", colClasses="character")
act_labels<- read.table("activity_labels.txt",header=FALSE,sep="", colClasses="character")

##Downloading the data files from "test" folder
setwd("test")
test<- read.table("X_test.txt",sep="")
subtest<-read.table("subject_test.txt")
ytest<-read.table("y_test.txt")

##Downloading the data files from "train" folder
setwd("C:/Users/v-nilsha/Desktop/Coursera/clean_ass1/UCI HAR Dataset/train")
train<- read.table("X_train.txt",sep="")
subtrain<-read.table("subject_train.txt")
ytrain<-read.table("y_train.txt")

###############  Q1.  Merging the dataset   ##############
##Combining train and test dataset
data<-rbind(train,test)
##Adding column names to the dataset
colhead<-features[,2]
colhead<-t(colhead)
names(data)<-colhead

###############  Q2.  Measuring mean and standard deviation   ##############
##Adding column names to the dataset
yes<-grepl("mean()|std()",colnames(data))
no<-grepl("meanFreq()",colnames(data))
Diff<-yes-no
for (i in 1:561){
  Diff[i]<-Diff[i]*i
}
musigma<-data[,Diff]

###############  Q3. & Q4.  Defining activity and variables   ##############
##Combining the subject dataset
subject<-rbind(subtrain,subtest)
  names(subject)<-"Subject"

##Combining the activity dataset
library(plyr)
activity<-rbind(ytrain,ytest)
  act_temp<-join(activity, act_labels, by="V1")
  act_final<-act_temp[,2]

##Combining main dataset with activity and subject files
musigma_final<-cbind(act_final,subject,musigma)
colnames(musigma_final)[1]<-"Activity"

###############  Q5.  Creating tidy dataset   ##############
##Melting and casting the dataset to create tidy dataset
library(reshape)
melt_ms<- melt(musigma_final, id.vars=c("Activity","Subject"))
final<-cast(data = melt_ms,fun = mean)

##Writing the dataset ina text file
setwd("C:/Users/v-nilsha/Desktop/Coursera/clean_ass1")
write.table(final,file="tidy.txt")
