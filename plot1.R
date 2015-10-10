plot1 <- function() {
  ## read in the raw data
  rawdata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)

  ## subset only the data we need, i.e data for days 02-02-2007 and 02-02-2007
  subdata <- rawdata[rawdata$Date == "1/2/2007" | rawdata$Date == "2/2/2007", ]
  
  ## convert Global active power to numeric so it can be plotted
  subdata$Global_active_power <- as.numeric(subdata$Global_active_power)

  ## create a new png-image to hold the plot
  png(filename = "plot1.png")
  
  ## make the first plot
  hist(subdata$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
  
  ## close the plotting device (i.e. the png file) so that it can be read
  dev.off()
}