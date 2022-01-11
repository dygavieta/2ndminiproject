
path <- file.path("specdata") 

#list rows with the the pattern 1/2/2007 or 2/2/2007
x <- grep("^1/2/2007|^2/2/2007", readLines(file.path(path, "household_power_consumption.txt")), value = FALSE) 

data <-   read.table(file.path(path, "household_power_consumption.txt"), 
                     sep = ";", 
                     nrows = length(x), # rows only to be read
                     skip = x[1]-1,  # skip data until the first element of x
                     na.strings = "?", 
                     col.names = read.table(file.path(path,"household_power_consumption.txt"), 
                                            sep = ";", 
                                            nrows = 1),
                     colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
)   
#not included missing files
data <- na.omit(data)
#date time combined
str(data)

#=============PLOT 1=============
#Histogram
png(filename  = "plot1.png") 
hist(data$Global_active_power, col ="red", xlab="Global Active Power (kilowatts)", main="Global Active Power" )
dev.off()
#=============PLOT 2=============
#Plot
png(filename ="plot2.png" )
#type l for lines ; xlab no title ;xaxt no tick marks
plot(data$Global_active_power, type = "l", xlab="" , ylab="Global Active Power (kilowatts)", xaxt='n')
#Asumming there are 2880 ommitted according to str(data) divided by 2
#side 1 = below ;at = tick marks plamcement, labels = tick mark label
axis(side=1, at=c(1, 1440, 2880), labels=c("Thu","Fri","Sat"))
dev.off()
#=============PLOT 3============= 
png(filename ="plot3.png" )
plot(data$Sub_metering_1, type = "l", xlab="" , ylab="Energy sub metering", xaxt='n')
lines(data$Sub_metering_2, col = "red")
lines(data$Sub_metering_3, col = "blue")
axis(side=1, at=c(1, 1440, 2880), labels=c("Thu","Fri","Sat"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lty = 1, col = c("black","red", "blue"))
dev.off()
#=============PLOT 4============= 
png(filename ="plot4.png" )
#allow 4 plots in one image 2 col 2 row
par(mfrow=c(2,2))
#plot 2
plot(data$Global_active_power, type = "l", xlab="" , ylab="Global Active Power", xaxt='n')
#new plot Voltage
plot(data$Voltage, type = "l", xlab="datetime" , ylab="Voltage", xaxt='n')
axis(side=1, at=c(1, 1440, 2880), labels=c("Thu","Fri","Sat"))
#plot3
plot(data$Sub_metering_1, type = "l", xlab="" , ylab="Energy sub metering", xaxt='n')
lines(data$Sub_metering_2, col = "red")
lines(data$Sub_metering_3, col = "blue")
axis(side=1, at=c(1, 1440, 2880), labels=c("Thu","Fri","Sat"))
#bty="n" = no border
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lty = 1, col = c("black","red", "blue"), bty="n")
#new plot Reactive Power
plot(data$Global_reactive_power, type = "l", xlab="datetime" , ylab="Global_reactive_power", xaxt='n')
axis(side=1, at=c(1, 1440, 2880), labels=c("Thu","Fri","Sat"))
dev.off()
