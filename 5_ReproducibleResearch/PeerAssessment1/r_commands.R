library(ggplot2)
library(reshape)
library(plyr)
library(dplyr)


data<-read.csv("activity.csv")
data$date <- as.Date(data$date)


summarydate <- ddply(data, 'date', summarise, day_sum = sum(steps), day_mean = mean(steps), day_median = median(steps))
summarydate_no_nas <- summarydate[-which(is.na(summarydate$day_sum)),]

##What is mean total number of steps taken per day?
#Make a histogram of the total number of steps taken each day
ggplot(summarydate_no_nas, aes(x=day_sum)) + geom_histogram(binwidth=3021, colour="black", fill="light blue") + ggtitle("Histogram of total number of steps taken each day")
                                                            
#Calculate and report the mean and median total number of steps taken per day
summarydate_no_nas[,c("date","day_mean","day_median")]



#What is the average daily activity pattern?
#Make a time series plot (i.e. type = "l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all days (y-axis)
byinterval <- ddply(data, 'interval',summarise, steps_avg = mean(steps, na.rm = TRUE))
ggplot(data=byinterval, aes(x=interval, y=steps_avg)) + geom_line() + geom_point() + ggtitle("Average number of steps by interval") + ylab("Number of steps")

#Which 5-minute interval, on average across all the days in the dataset, contains the maximum number of steps?
arrange(byinterval, desc(steps_avg) )[1,"interval"]


#Imputing missing values
#Calculate and report the total number of missing values in the dataset (i.e. the total number of rows with NAs)
length(data$steps[data$steps =="NA"])




#Devise a strategy for filling in all of the missing values in the dataset. The strategy does not need to be sophisticated. For example, you could use the mean/median for that day, or the mean for that 5-minute interval, etc.
#Create a new dataset that is equal to the original dataset but with the missing data filled in.

##this is the OK subset
data_no_nas <- data[-which(is.na(data$steps)),]

##this is the subset only with nas
data_nas <-    data[ which(is.na(data$steps)),]

##merge the subset with the na values with the one thta has AVG by interval
mergeddata<-merge(data_nas, byinterval, by.x="interval", by.y="interval")
mergeddata$steps <- mergeddata$steps_avg
mergeddata <- subset(mergeddata, select = -c(steps_avg))

##add the data frame with the original values and the dataframe with the merged values
newdata <- rbind(data_no_nas, mergeddata)

#Make a histogram of the total number of steps taken each day 
summary_newdate <- ddply(newdata, 'date', summarise, new_day_sum = sum(steps), new_day_mean = mean(steps), new_day_median = median(steps))
ggplot(summary_newdate, aes(x=new_day_sum)) + geom_histogram(binwidth=3021, colour="black", fill="green") + ggtitle("Histogram of total number of steps taken each day")


compare <- merge(summarydate, summary_newdate, by.x="date", by.y="date")
compare <- tbl_df(compare)


#Do these values differ from the estimates from the first part of the assignment? What is the impact of imputing missing data on the estimates of the total daily number of steps?
filter(compare, is.na(day_sum) )
#but considering that the NAs are at a "day" level, meaning that a whole day is either all NA or doesn't  have any NAs, no matter what we do with the NAs, it wont affect the days we already have data for....so clearly the answer for that question would be something like: it wont affect the days we already have data for, only the ones we dont (and thats because we set the new values on these days)


#Are there differences in activity patterns between weekdays and weekends?
newdata$isweekday <- ifelse( (weekdays(newdata$date) %in% c('Saturday','Sunday')), 'Weekend', 'Weekday' )

newdatagroup <- ddply(newdata, c('interval','isweekday'),summarise, steps_avg = mean(steps, na.rm = TRUE))
ggplot(data=newdatagroup, aes(x=interval, y=steps_avg)) + geom_line() + geom_point() + ggtitle("Average number of steps by interval") + ylab("Number of steps") + facet_grid(isweekday ~ .)



#mergeddata<-merge(data_nas, byinterval, by.x="interval", by.y="interval")




   
#byday<-aggregate(steps ~ date, data, sum)
#byday$date <- as.Date(byday$date)

#b <-barplot(byday$steps, ylab="Number of steps", xlab="Date", col="blue", main="Total number of steps taken each day")
#axis(1,at=b,labels=byday$date)


#m <- aggregate(steps ~ date, data, mean)
#names(m) <- c("date", "day_mean")

#n <- aggregate(steps ~ date, data, median, na.rm = TRUE)
#names(n) <- c("date", "day_median")


#working bar plot
#b <-barplot(summarydate_no_nas$day_sum, ylab="Number of steps", xlab="Date", col="blue", main="Total number of steps taken each day")
#axis(1,at=b,labels=byday$date)



