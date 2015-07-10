## Exploratory Data Analysis
# This script is part of week 1 assignemnt of the Exploratory Data Analysis
# course: it reads the household_power_consumption and creates the plot1.png
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

# Coverting time serie to system time
elec_pwr_cons$Time <- strftime(strptime(elec_pwr_cons$Time, "%H:%M:%S"),
                               "%H:%M:%S")

# Converting the rest of the data from character to numeric
elec_pwr_cons[,3:9] <- sapply(elec_pwr_cons[,3:9], as.numeric)

# Defining the plot1.png file resolution
png(filename = "plot1.png", width = 480, height = 480,
    units = "px", pointsize = 12, res = NA,
    restoreConsole = TRUE)

# Drawing the histogram
hist(elec_pwr_cons$Global_active_power, col="red",
     xlab="Global Active Power (kilowatts)", main="Global Active Power")

# Closing the file device 
dev.off()
