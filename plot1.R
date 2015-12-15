##
##
##
##
##
##
##
##
##
##
# Start by reading on the data file
hsdataset <- read.csv( "household_power_consumption.txt" , sep=";")

#Then convert the dates and the times from strings into the correct format date and time format

hsdata <- mutate(hsdataset, sTimeStamp = paste(as.Date(Date, "%d/%m/%Y"), Time))
hsdata[strptime(TimeStamp, format="%Y-%m-%d %H:%M:%S") == "2007-01-01",]
# 
head(hsdata[strptime(hsdata$sTimeStamp, format="%Y-%m-%d %H:%M:%S") == "2007-01-01 00:00:00",])
