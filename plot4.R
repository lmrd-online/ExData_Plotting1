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
power_consumption$datetime <- strptime(paste(power_consumption$Date, power_consumption$Time), "%Y-%m-%d %H:%M:%S")

#############################################################
# 3. Make plot
png("plot3.png", width = 480, height=480)
par(mfrow = c(2, 2)) 

# 1st figure
plot(power_consumption$datetime ,power_consumption$Global_active_power,type ="l", xlab="",
     ylab = "Global active power (kilowatts)")

# 2nd figure
plot(power_consumption$datetime , power_consumption$Voltage, type="l", xlab="datetime", ylab="Voltage")

#3rd figure
plot(power_consumption$datetime ,power_consumption$Sub_metering_1, type="l", ylab="Energy Sub metering", xlab="")
lines(power_consumption$datetime ,power_consumption$Sub_metering_2, type="l", col="red")
lines(power_consumption$datetime ,power_consumption$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

# 4th figure
plot(power_consumption$datetime, power_consumption$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()

