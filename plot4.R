## ----------------------------------------------------------------------------------------------------------
##
## This script plots four graphs including 1. Global Active Power", Votage, Energy sub meter and global Reactive Power
## data for the two day period from 2007/02/01 to  2007/02/02. 
## The data is first cleaned up and tidied up before the plots can be run.
##
## ----------------------------------------------------------------------------------------------------------
##
##
# load all the additional libraries we will need to run this script
library(dplyr)
# Start by reading on the data file
hsdataset <- read.csv( "household_power_consumption.txt" , sep=";")
#Then convert the dates and the times from strings into the correct format date and time format
hsdata <- mutate(hsdataset, sTimeStamp = paste(as.Date(Date, "%d/%m/%Y"), Time))
#format the timestamp to a POSTit datetime format
hsdata$sTimeStamp <- strptime(hsdata$sTimeStamp, format="%Y-%m-%d %H:%M:%S", tz="UTC")
#now subset the data to retrieve teo day data - 2007-02-01 and 2007-02-02.
# Dont use this line of code -> subhsdata[which(subhsdata$sTimeStamp > "2010-11-25 00:00:00" & subhsdata$sTimeStamp < "2010-11-27 00:00:00" ), ]
subhsdata <- hsdata[which(hsdata$sTimeStamp >= strptime("2007-02-01 00:00:00",  format="%Y-%m-%d %H:%M:%S", tz="UTC") & hsdata$sTimeStamp < strptime("2007-02-03 00:0:00",  format="%Y-%m-%d %H:%M:%S", tz="UTC") ), ]
#convert the factor variables into numeric variables so the data can actually be plotted
subhsdata$Global_active_power <- as.numeric(as.character(subhsdata$Global_active_power))
subhsdata$Global_reactive_power <- as.numeric(as.character(subhsdata$Global_reactive_power))
subhsdata$Voltage <- as.numeric(as.character(subhsdata$Voltage))
subhsdata$Sub_metering_1 <- as.numeric(as.character(subhsdata$Sub_metering_1))
subhsdata$Sub_metering_2 <- as.numeric(as.character(subhsdata$Sub_metering_2))

#Open the PDF graphics device
#pdf(file="plot4.pdf")
# Create a 2 by 2 matix where we will add the plots. these plots will be added rowwise
par(mfrow = c(2, 2))

# R1C1
# then call hist function with the paramters and plot to the grqaphics device
plot(subhsdata$sTimeStamp, subhsdata$Global_active_power, type = "l",  ylab = "Global Active Power", xlab = "")

# R1C2
# Plot a time series to the graphics device
plot(subhsdata$sTimeStamp, subhsdata$Voltage, type = "l",  ylab = "Voltage", xlab = "datetime")

# R2C1 
# Plot the three lines each with a unique color
with(subhsdata, plot(sTimeStamp, Sub_metering_1, type = "l", col="black", ylab = "Energy sub metering", xlab = ""))
with(subhsdata, lines(sTimeStamp, Sub_metering_2, type = "l", col="red"))
with(subhsdata, lines(sTimeStamp, Sub_metering_3, type = "l", col="blue"))
#Add the legend
legend("topright", pch="-", cex = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# R2C2 
# Plot a time series to the graphics device
plot(subhsdata$sTimeStamp, subhsdata$Global_reactive_power, type = "l",  ylab = "Global_reactive_power", xlab = "datetime")

# copy the plot to a PNG file
dev.copy(png, file="plot4.png")

# then turn off the graphics device
dev.off()
