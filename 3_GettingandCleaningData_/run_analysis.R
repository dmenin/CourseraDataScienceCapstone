#Assumption: the "run_analysis.R" file and the "UCI HAR Dataset" folder should be on the working directory
run_analysis <- function() 
{
      #Register library reshape2 to be used
	library(reshape2)

	#Start by loading the train and test data
	#	x files contain the samples
	#	Y files contain the activities Ids (1 to 6)
	#	Subject files contian the  subject who performed the activity for each window sample. Its range is from 1 to 30. 

	testData    <- read.table("UCI HAR Dataset\\test\\X_test.txt")
	testLabels  <- read.table("UCI HAR Dataset\\test\\y_test.txt")
	testSubject <- read.table("UCI HAR Dataset\\test\\subject_test.txt")

	trainData    <- read.table("UCI HAR Dataset\\train\\X_train.txt")
	trainLabels  <- read.table("UCI HAR Dataset\\train\\y_train.txt")
	trainSubject <- read.table("UCI HAR Dataset\\train\\subject_train.txt")

	#loads a list of column names so latter on we can filter only the columns we want
	cols <- read.table("UCI HAR Dataset\\features.txt")

	#List of the 6 different activities
	activities <- read.table("UCI HAR Dataset\\activity_labels.txt")
	#Name the columns to facilitate the join latter on
	names(activities) <- c("ActivityId","ActivityDescription")


	
	#Merges the training and the test sets to create one data set.
	#(cd stands for combined data, cl combined labels and cs combined subjects)
	cd <- rbind(testData, trainData)
	cl <- rbind(testLabels, trainLabels)
	cs <- rbind(testSubject, trainSubject)
	
	#the names of cd's columns are V1,V2....and so, which is not user friendly.
	#Here I'm using the second colum of the cols data frame to set cd's columns names
	names(cd) <- cols$V2
	names(cl) <- 'ActivityId' #the "Y" files contain the activities
	names(cs) <- 'Subject'  #the "subject" files contains the subject who performed the activity



	#Extract only the measurements on the mean and standard deviation for each measurement
	#At this point, "cd" con"std"tains 561 variables but we only care about "the measurements on the mean and standard deviation"
	#so we get the indices of the columns we want, which are the one who are named like "mean" or "std":
	colIndices <- grep("mean\\(\\)|std\\(\\)", cols[, 2])
	#then we get only the clumns we want and eliminate the ones we dont need:
	cd <- cd[,colIndices]

	
	#add the 3 data frames togheter, so it will conain, SubjectId, Activity Description and the values
	#this is the Final "raw" Data
	rawFinalData <- cbind(cs, cl, cd)

	#Add the description to the Activities data frame (before it had only the id)
	rawFinalData <- merge(rawFinalData,activities,by.x="ActivityId",by.y="ActivityId")

	#them remove the activityId because we dont need it
	rawFinalData <- subset(rawFinalData , select=-ActivityId)

	
	#now we use the function melt to get a row per each combination of Subject X ActivityDescription X variable 
	#special atention to the last parameter which specifies the variable names using the cols vector (all variable names) at the colIndices(only cols we care about) Indice
	meltDS <- melt(rawFinalData ,id=c("Subject","ActivityDescription"),measure.vars=cols$V2[colIndices])
	
	#then we do a dcast to calcualte the mean of all variables for each Subject\ActivityDescription 
	final <- dcast(meltDS, Subject + ActivityDescription ~ variable, mean)
	
	write.table(final,'tidydata.txt', row.names=FALSE, sep=",")	
}