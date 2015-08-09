#download and unzip file
download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip', "household_power_consumption.zip", method="curl")
unzip("household_power_consumption.zip")

#read one row of the file to extarct the column information
df <- read.table("household_power_consumption.txt", sep=';', header = TRUE, nrows = 1)
df = df[-1,]

#create a smaller file containing data for 1/2/2007 and 2/2/2007
readLines(pipe("grep '^[1-2]/2/2007' household_power_consumption.txt > t.txt"))
myDF  =  read.table("t.txt", sep=';', header = TRUE)
colnames(myDF) <- colnames(df)

#Reconstruct the Date variable by murging date and timestamp column.
myDF = transform(myDF, Date=strptime(paste( Date, Time) , format="%d/%m/%Y %H:%M:%S"))


# Open png device in working directory    
png(file = "plot4.png", width = 480, height = 480,units = "px")  
par(mfrow = c(2, 2))
with(myDF, {
  plot( Date, Global_active_power, type="l", ylab="Global Active Power")
  plot( Date, Voltage, xlab="datetime", ylab="Voltage", type="l")
  plot( Date, Sub_metering_1, ylab="Energy sub metering", xlab="", type="l", col="black")
  points( Date, Sub_metering_2, type="l", col="red")
  points( Date, Sub_metering_3, type="l", col="blue")
  legend("topright", lwd = 1, col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")) 
  plot( Date, Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", type="l")
}) 

#close the device		
dev.off() 
par(mfrow = c(1, 1))