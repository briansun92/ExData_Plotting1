##  Plot2
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

## produce plot
par(mfrow=c(1,1))
plot(dataUse$Time,dataUse$Global_active_power,type="l",ylab = "Global Active Power (kilowatts)",xlab = "")

##  copy the graphics device to save to plot1.png
dev.copy(device=png, file ="plot2.png", bg = "transparent")

##  closes the PNG graphics device
dev.off()