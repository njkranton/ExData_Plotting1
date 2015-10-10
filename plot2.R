plot2 <- function() {
  ## Set locale to US & English - otherwise day names, etc will be incorrectly
  ## localized resulting in differences in the actual plots
  Sys.setlocale(category = "LC_ALL", locale = "English_United States.1252")
  
  ## read in the raw data
  rawdata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)
  
  ## subset only the data we need, i.e data for days 02-02-2007 and 02-02-2007
  subdata <- rawdata[rawdata$Date == "1/2/2007" | rawdata$Date == "2/2/2007", ]
  
  ## convert Global active power to numeric so it can be plotted
  subdata$Global_active_power <- as.numeric(subdata$Global_active_power)
  
  ## create new datetime column
  datetime <- as.POSIXct(paste(subdata$Date, subdata$Time), format="%d/%m/%Y %H:%M:%S")  
  
  ## add datetime column to rawdata
  data <- cbind(subdata, datetime)
  
  ## create a new png-image to hold the plot
  png(filename = "plot2.png")
  
  ## make the second plot
  with(subdata, plot(datetime, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))
  
  ## close the plotting device (i.e. the png file) so that it can be read
  dev.off()
}