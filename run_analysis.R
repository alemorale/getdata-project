# Getting & Cleaning Data Course Project
# run_analysis.R

if(!file.exists("UCI HAR Dataset")){
    unzip('getdata-projectfiles-UCI HAR Dataset.zip',overwrite = FALSE)
}
dir <- "UCI HAR Dataset/"
dir.create(paste(dir,"merged",sep=""),showWarnings = FALSE)

# 1. Merge train and test sets
print("1. Merge train and test sets.")
nameFile <- function (dir,name,part){   
    Name <- paste(dir,part,'/',name,'_',part,'.txt',sep="")
    Name
}
files <- c('X','subject','y')

for (i in 1:length(files)) {
    name <- files[i]
    writeName <- paste(dir,'merged/',name,'.txt',sep='')
    if (!file.exists(writeName)){
        file.A <- nameFile(dir,name,'train')
        file.B <- nameFile(dir,name,'test')
        print("reading files..."); print(file.A)
        data.A <- read.table(file.A)
        data.B <- read.table(file.B)
        print('merging')
        data <- rbind(data.A,data.B)        
        print('writing')
        write.table(data, file = writeName,col.names=FALSE,row.names=FALSE)            
    } else {
        print(paste(writeName,"Merged dataset already exist!"))
    }    
}
print("done!")

#open merged data files
X <- read.table('UCI HAR Dataset/merged/X.txt')
y <- read.table('UCI HAR Dataset/merged/y.txt')
subject <- read.table('UCI HAR Dataset/merged/subject.txt')

# 2. Extracts only the measurements on the mean and sd for each measurement
# Use grep to find column names of mean and sd
print("2. Extract measurements on the mean and sd")
fileName <- 'UCI HAR Dataset/features.txt'
features <- read.table(fileName, col.names = c('feature.Id','feature.Name'))
id.mean <- grep('mean',features$feature.Name)
id.std <- grep('std',features$feature.Name)
ids <- sort(c(id.mean,id.std))
X.subset <- X[,ids]  # new data set with only mean and sd measurements
print("done!")

# 3. Descriptive activity names to name activities of data set
print("3. Asign descriptive activity names")
simpleCap <- function(x) {
    s <- strsplit(x, " ")[[1]]
    paste(toupper(substring(s, 1, 1)), (substring(s, 2)),
          sep = "",collapse="")
}

fileName <- 'UCI HAR Dataset/activity_labels.txt'
activities <- read.table(fileName,col.names = c('Activity.Id','Activity'))
activities$Activity <- chartr(old ="_",new = " ",activities$Activity)
activities$Activity <- as.factor(unlist(lapply(activities$Activity,simpleCap)))
y <- as.matrix(sapply(y,function(x) activities$Activity[x]))
colnames(subject) <- "Subject"
colnames(y) <- "Activity"


print("done!")

# 4. labels the data set with descriptive variable names
print("4. Descriptive variable names...")
variableNames <- as.vector(features$feature.Name[ids])

trialNames<-chartr("()","  ",variableNames)
trialNames<-chartr("-"," ",trialNames)
# ^t -> "time "
# ^f -> "frequency"FourierTransform""
# Acc -> acceleration
# Gyro -> angularvelocity
# Mag -> magnitude
# Freq -> frequency
# mean() -> Mean
# std() -> Std
colnames(X.subset) <- variableNames
print("done!")

# 5. tidy data set with the average of each variable for each activity and each subject
#From the data set in step 4, creates a second, 
#independent tidy data set with the average of each variable for each activity and each subject.
print("5. Creadte tidy dataset")

newdata <- cbind(y,X.subset)
newdata <- cbind(subject,newdata)
s<-ddply(newdata,.(Subject, Activity), function(df) colMeans(df[,3:81]))
s2<-ddply(newdata,.(Subject,Activity),summarize,mean = ave(variableNames[1],FUN=mean))
s3<-ddply(newdata,.(Subject),function(df) colMeans=ave(df[,3:81],FUN=colMeans))
write.table(s,file = "UCI HAR Dataset/merged/tidydataset.txt",row.name=FALSE)
print("done.")