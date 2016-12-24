library(data.table) ## need this for fread, which is faster than read.table

## download the data to wd
download.file(
    "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    ,"hpc.zip")

## unzip the downloaded file
unzip("hpc.zip")

## read the table in using fread
## being sure to set the na.strings argument per the instructions
d<-fread("household_power_consumption.txt",na.strings = "?")

## convert the date column
d$Date<-as.Date(d$Date,"%d/%m/%Y")

## subset on the date column
d <- subset(d,Date>="2007-02-01" & Date<="2007-02-02")

## create a datetime column
d <- cbind(d,as.POSIXct(paste(d$Date,d$Time)))

## set the active graphics device to png (3)
dev.set(3)

## create a png file to output to
## default values for width and height are 480, so no need to set them
png(filename = "Plot1.png")

## create the plot
with(d,hist(Global_active_power,col="red"
            ,main="Global Active Power"
            ,xlab="Global Active Power (kilowatts)"))

## turn off the graphics device to unlock the file
dev.off()