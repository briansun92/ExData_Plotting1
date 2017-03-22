##  Plot4
##  Produce a histogram of Global Active Power for the given dates Feb 1st, 2007 and Feb 2nd, 2007
##  check if file exists; if not, download the file again
if(!file.exists("household_power_consumption.txt")){
    message("Downloading data")
    fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileURL, destfile = "./household_power_consumption.zip", method = "curl")
    unzip("household_power_consumption.zip")
}

##  read the data
initial<-read.table("household_power_consumption.txt",sep=";",header  = TRUE,stringsAsFactors = FALSE,nrows = 100,na.strings="?")
classes <- sapply(initial, class)

dataAll <- read.table("household_power_consumption.txt",sep=";",header  = TRUE,stringsAsFactors = FALSE, colClasses = classes,na.strings="?")

##  subset the data to only dates Feb 1st, 2007 and Feb 2nd, 2007
dataUse<-subset(dataAll,Date == "1/2/2007"|Date == "2/2/2007")

##  convert the Date and Time columns to the correct format
dataUse$Time<-strptime(paste(dataUse$Date, dataUse$Time), 
                       format = "%d/%m/%Y %H:%M:%S")
dataUse$Date<-as.Date(dataUse$Date,"%d/%m/%Y")

##  set par
par(mfrow = c(2,2))

##  produce plot1
plot(dataUse$Time,dataUse$Global_active_power,type="l",ylab = "Global Active Power (kilowatts)",xlab = "")

##  produce plot2
plot(dataUse$Time,dataUse$Voltage,type="l",ylab = "Voltage",xlab = "datetime")

##  produce plot3
plot(dataUse$Time,dataUse$Sub_metering_1,type="l",ylab = "Energy sub merting",xlab = "")
lines(dataUse$Time,dataUse$Sub_metering_2,type="l",xlab = "",col = "red")
lines(dataUse$Time,dataUse$Sub_metering_3,type="l",xlab = "",col = "blue")
legend("topright", lty = 1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"),bty = "n",y.intersp= 0.3)

##  produce plot4
plot(dataUse$Time,dataUse$Global_reactive_power,type="l",ylab = "Voltage",xlab = "datetime")

##  copy the graphics device to save to plot1.png
dev.copy(device=png, file ="plot4.png", bg = "transparent")

##  closes the PNG graphics device
dev.off()