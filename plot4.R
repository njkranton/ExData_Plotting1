plot4 <- function() {
  ## Set locale to US & English - otherwise day names, etc will be incorrectly
  ## localized resulting in differences in the actual plots vs. the spec
  Sys.setlocale(category = "LC_ALL", locale = "English_United States.1252")
  
  ## read in the raw data
  rawdata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)
  
  ## subset only the data we need, i.e data for days 02-02-2007 and 02-02-2007
  subdata <- rawdata[rawdata$Date == "1/2/2007" | rawdata$Date == "2/2/2007", ]
  
  ## convert Submetering values (3 variables) to numeric so they can be plotted
  subdata$Sub_metering_1 <- as.numeric(subdata$Sub_metering_1)
  subdata$Sub_metering_2 <- as.numeric(subdata$Sub_metering_2)
  subdata$Sub_metering_3 <- as.numeric(subdata$Sub_metering_3)
  ## convert Global active power to numeric so it can be plotted
  subdata$Global_active_power <- as.numeric(subdata$Global_active_power)
  ## convert Global reactive power to numeric so it can be plotted
  subdata$Global_reactive_power <- as.numeric(subdata$Global_reactive_power)
  ## convert Voltage to numeric so it can be plotted
  subdata$Voltage <- as.numeric(subdata$Voltage)
   
  ## create new datetime column
  datetime <- as.POSIXct(paste(subdata$Date, subdata$Time), format="%d/%m/%Y %H:%M:%S")  
  ## add datetime column to rawdata
  data <- cbind(subdata, datetime)
  
  ## create a new png-image to hold the plot
  png(filename = "plot4.png")
  
  ## set the layout of the plots
  par(mfcol = c(2,2))
  
  ## make the plots
  with(data, {
    ## make the Global active power plot
    plot(datetime, Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")
    ## make the Submetering plot
    plot(datetime, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
    lines(data$datetime, data$Sub_metering_2, col = "red")
    lines(data$datetime, data$Sub_metering_3, col = "blue")
    ## add a legend to the Submetering plot
    legend("topright", lty = 1, col = c("black", "red", "blue"), bty =  "n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    ## make the Voltage plot
    plot(datetime, Voltage, type = "l", ylab = "Voltage")
    ## make the Global reactive power plot
    plot(datetime, Global_reactive_power, type = "l")
    
  })
  ## close the plotting device (i.e. the png file) so that it can be read
  dev.off()
}