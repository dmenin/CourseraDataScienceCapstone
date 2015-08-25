data <- read.csv("c:\\rwd\\repdata-data-StormData - train.csv")
data <- read.csv("c:\\rwd\\repdata-data-StormData.csv")


datazip <- read.csv("repdata-data-StormData.csv.bz2")


data <- read.csv("train.csv")

data <- read.csv("repdata-data-StormData.csv")
names(data) <- tolower(names(data))

#dont need all these values
data<-subset(data, select = -c(state__, bgn_date, bgn_time, time_zone, county, countyname, state, bgn_range, bgn_azi, bgn_locati, end_date, end_time, county_end, countyendn, end_range, end_azi, end_locati,length, width, f, mag, wfo, stateoffic, zonenames, latitude, longitude, latitude_e, longitude_,remarks, refnum))


#HEALTH
data$fatalscore <- (data$fatalities * 10) + data$injuries

data<-subset(data, select = -c(fatalities, injuries)) #dont need them anymore



#PROP DMG
data$propmult <- revalue(data$propdmgexp, c(" "="1",NULL="1","0"="1","1"="10","2"="100","3"="1000","4"="10000","5"="100000","6"="1000000","7"="10000000","8"="100000000","-"="1","?"="1","+"="1","B"="1000000000","h"="1","H"="1","K"="1000", "M"="1000000","m"="1000000"), warn_missing = FALSE)

data$propmult <- as.character(data$propmult)
data$propmult <- as.integer(data$propmult)


data$propmult[is.na(data$propmult)] <- 1
data$propdmg <- data$propdmg * data$propmult

data<-subset(data, select = -c(propdmgexp, propmult)) #dont need them anymore


#CROP DMG
data$cropmult <- revalue(data$cropdmgexp, c(" "="1",NULL="1","0"="1","1"="10","2"="100","3"="1000","4"="10000","5"="100000","6"="1000000","7"="10000000","8"="100000000","-"="1","?"="1","+"="1","B"="1000000000","h"="1","H"="1","K"="1000", "M"="1000000","m"="1000000", "k"="1000"), warn_missing = FALSE)

data$cropmult <- as.character(data$cropmult)
data$cropmult <- as.integer(data$cropmult)

data$cropmult[is.na(data$cropmult)] <- 1
data$cropdmg <- data$cropdmg * data$cropmult


data$totaldamage <- data$propdmg + data$cropdmg

data<-subset(data, select = -c(cropdmgexp, cropmult, propdmg, cropdmg)) #dont need them anymore


#evtype 
trim <- function (x) gsub("^\\s+|\\s+$", "", x)
data$evtype <- trim(data$evtype)


data[grep("TORNADO",data$evtype),c("evtype")] <- 'TORNADO'
data[grep("THUNDERSTORM",data$evtype),c("evtype")] <- 'THUNDERSTORM'


summarydata <- ddply(data, 'evtype', summarise, fatalscore_sum = sum(fatalscore), dmg_sum  = sum(totaldamage))
summary_bydmg <- arrange(summarydata, desc(dmg_sum))
summary_byfatal <- arrange(summarydata, desc(fatalscore_sum))

summary_bydmg<-subset(summary_bydmg, select = -c(fatalscore_sum))
summary_byfatal<-subset(summary_byfatal, select = -c(dmg_sum))

##summary by dmg
a <- summary_bydmg [1:19,]
b <- summary_bydmg [20:883,]
b$evtype <- 'Other'
b <- ddply(b, 'evtype', summarise, dmg_sum  = sum(dmg_sum))

summary_bydmg <- rbind(a,b)


##summary by fatal
a <- summary_byfatal [1:59,]
b <- summary_byfatal [60:883,]
b$evtype <- 'Other'
b <- ddply(b, 'evtype', summarise, fatalscore_sum  = sum(fatalscore_sum))

summary_byfatal <- rbind(a,b)




p <- ggplot(summary_bydmg, aes(x=1, y=dmg_sum, fill=evtype)) +
+     ggtitle("Events with the greatest economic consequences ((Billion Dollars)") +
+     # black border around pie slices
+     geom_bar(stat="identity", color='black') +
+     # remove black diagonal line from legend
+     guides(fill=guide_legend(override.aes=list(colour=NA))) +
+     # polar coordinates
+     coord_polar(theta='y') +
+     # label aesthetics
+     theme(axis.ticks=element_blank(),  # the axis ticks
+           axis.title=element_blank(),  # the axis labels
+           axis.text.y=element_blank(), # the 0.75, 1.00, 1.25 labels
+           axis.text.x=element_text(color='black'))





 ggplot(summary_byfatal, aes(x=evtype, y=fatalscore_sum, fill=evtype)) + geom_bar(stat="identity", color='black')