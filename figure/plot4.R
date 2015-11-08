#Set dates and times
firstDateTime <- strptime("2006-12-16 17:24:00", "%Y-%m-%d %H:%M:%S")
beginDateTime <- strptime("2007-02-01 00:00:00", "%Y-%m-%d %H:%M:%S")

#Find how many rows to skip
skip <- as.numeric(beginDateTime - firstDateTime) * 24 * 60

#Required number of rows of dates 01/02/2007 & 02/02/2007
nrows <- 48 * 60

#Read required data of dates 01/02/2007 & 02/02/2007
household_data <- read.csv("household_power_consumption.txt", skip = get("skip")+7, nrows = get("nrows"),sep=";")
write.table(household_data, file = "household_data.csv",col.names = FALSE, row.names = FALSE,sep=",")
household_data <- read.csv("household_data.csv")

#Construct Plot4

#Set mfcol using par and set margins
par(mfcol=c(2,2),mar=c(4,4,2,2))

#Merge Date and Time
library(lubridate)
DateTime <- with(household_data,paste(household_data[,1],household_data[,2],sep=" "))
household_data$dates <- dmy_hms(DateTime)
dates <- household_data$dates

#Plot 1
gAP <- household_data[,3]
plot(dates,gAP,type="n",ylab="Global Active Power (kilowatts)",xlab=" ")
lines(dates,gAP)

#Plot 2
sub1 <- household_data[,7]
sub2 <- household_data[,8]
sub3 <- household_data[,9]
plot(dates,sub1,ylab="Energy sub metering",xlab=" ",type="n")
lines(dates,sub1,col="black")
lines(dates,sub2,col="red")
lines(dates,sub3,col="blue")
legend("topright",pch = "-", col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=0.5)

#Plot 3
voltage <- household_data[,5]
plot(dates,voltage,type="n",ylab="Voltage",xlab="datetime")
lines(dates,voltage)

#Plot 4
gRP <- household_data[,4]
plot(dates,gRP,type="n",ylab="Global_reactive_power",xlab="datetime")
lines(dates,gRP)

#Copy to png
dev.copy(png,file="plot4.png")
dev.off()
