## Exploratory Data Analysis
# This script is part of week 1 assignemnt of the Exploratory Data Analysis
# course: it reads the household_power_consumption and creates the plot4.png
# file containig a histogram

# Reading the data
elec_pwr_cons <-read.table("./household_power_consumption.txt",
                         header=TRUE,
                         sep=";",
                         dec=".",
                         colClasses="character")

# Converting the date to system date format
elec_pwr_cons$Date <- as.Date(elec_pwr_cons$Date, "%d/%m/%Y")

# Selecting the only 2 days of data we have to work with
elec_pwr_cons <- elec_pwr_cons[elec_pwr_cons$Date=="2007-02-01" |
                                elec_pwr_cons$Date=="2007-02-02",]

# Coverting time serie to system time and merging with system date
elec_pwr_cons$Time <- strftime(strptime(elec_pwr_cons$Time, "%H:%M:%S"),
                               "%H:%M:%S")
elec_pwr_cons$Time <- as.POSIXct(paste(elec_pwr_cons$Date, elec_pwr_cons$Time),
                                 format="%Y-%m-%d %H:%M:%S")

# Converting the rest of the data from character to numeric
elec_pwr_cons[,3:9] <- sapply(elec_pwr_cons[,3:9], as.numeric)

# Defining the plot4.png file resolution
png(filename = "plot4.png", width = 480, height = 480,
    units = "px", pointsize = 12, res = NA,
    restoreConsole = TRUE)

# Defining the graph frame that will hold the four graphs
par(mfrow = c(2, 2))

# Drawing the first graph as in plot2.R
plot(elec_pwr_cons$Time, elec_pwr_cons$Global_active_power,
     type="line",
     xlab="",
     ylab="Global Active Power")

# Drawing the second graph
plot(elec_pwr_cons$Time, elec_pwr_cons$Voltage,
     type="line",
     xlab="datetime",
     ylab="Voltage")

# Drawing the third graph as in plot3.R
plot(elec_pwr_cons$Time, elec_pwr_cons$Sub_metering_1,
     type="line",
     xlab="",
     ylab="Energy sub metering")

lines(elec_pwr_cons$Time, elec_pwr_cons$Sub_metering_2,
      type="line",
      col="red")

lines(elec_pwr_cons$Time, elec_pwr_cons$Sub_metering_3,
      type="line",
      col="blue")

legend("topright", lty = 1, bty="n",
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#Drawing the fourth graph
plot(elec_pwr_cons$Time, elec_pwr_cons$Global_reactive_power,
     type="line",
     xlab="datetime",
     ylab="Global_reactive_power")

# Closing the file device 
dev.off()
