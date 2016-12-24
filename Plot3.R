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
png(filename = "Plot3.png")

## create the plot
with(d,plot(V2
            ,Sub_metering_1
            ,col = "black"
            ,type = "l"
            ,xlab = ""
            ,ylab = "Energy sub metering"
            )
     )

## plot the red series
with(d,points(V2,Sub_metering_2,col="red",type="l"))

## plot the blue series
with(d,points(V2,Sub_metering_3,col="blue",type="l"))

## create the legend
legend("topright"
       ,col= c("black","red","blue")
       ,lty = c(1,1,1)
       ,legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       )

## turn off the graphics device to unlock the file
dev.off()