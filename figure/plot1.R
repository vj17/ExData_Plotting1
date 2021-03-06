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

#Construct Plot1
#Extract Global_active_power
gAP <- household_data[,3]

#Plot
hist(gAP,main = "Global Active Power",xlab = "Global Active Power (kilowatts)",col="red")

#Copy to png
dev.copy(png,file="plot1.png")
dev.off()







