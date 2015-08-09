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
png(file = "plot1.png", width = 480, height = 480,units = "px")  
with(myDF, hist(Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main = "Global Active Power"))
#close the device		
dev.off() 