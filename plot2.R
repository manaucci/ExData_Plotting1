## ----------------------------------------------------------------------------------------------------------
##
## This script plots the "Global Active Power" data for the two day period from 2007/02/01 to  2007/02/02. 
## The data is first cleaned up and tidied up before the plots can be run.
##
## ----------------------------------------------------------------------------------------------------------
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
# now our data is ready to be plotted

#Open the PDF graphics device
# pdf(file="plot2.pdf")

# Plot a time series to the graphics device
plot(subhsdata$sTimeStamp, subhsdata$Global_active_power, type = "l",  ylab = "Global Active Power (kilowatts)", xlab = "")

# copy the plot to a PNG file
dev.copy(png, file="plot2.png")

# then turn off the graphics device
dev.off()
