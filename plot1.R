#############################################################
# 1. Download and unzip data
setwd("C:/Users/ruedadlm/Documents/Data/Exploratory_Data_Analysis")
# Download file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filename <- "household_power_consumption.zip"

if (!file.exists(filename)) {
  download.file(fileUrl, filename)
}

# Unzip file
path <- "household_power_consumption"
if (!file.exists(path)) {
  unzip(filename)
}

############################################################
# 2. Read data

temp <- read.table(paste0(path, ".txt"),sep =";",header = TRUE, as.is =TRUE, nrows = 2075259) # 7352 x 1

temp$Date <- as.Date(temp$Date, format="%d/%m/%Y")
## subset data from 2007-02-01 and 2007-02-02
power_consumption <- temp[temp$Date== "2007-02-01" |temp$Date=="2007-02-02",]
power_consumption$Global_active_power <- as.numeric(power_consumption$Global_active_power)
power_consumption$Global_reactive_power <- as.numeric(power_consumption$Global_reactive_power)
power_consumption$Voltage <- as.numeric(power_consumption$Voltage)
power_consumption$Global_intensity <- as.numeric(power_consumption$Global_intensity)
power_consumption$Sub_metering_1 <- as.numeric(power_consumption$Sub_metering_1)
power_consumption$Sub_metering_2 <- as.numeric(power_consumption$Sub_metering_2)
power_consumption$Sub_metering_3 <- as.numeric(power_consumption$Sub_metering_3)


#############################################################
# 3. Make histogram
png("plot1.png", width = 480, height=480)
hist(power_consumption$Global_active_power, col = "red",
     main = "Global active power", xlab = "Global active power (kilowatts)")
dev.off()