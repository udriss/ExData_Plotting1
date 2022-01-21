library(lubridate)
library(dplyr)
Sys.setlocale("LC_TIME", "en_US.UTF-8")

txt_data<-read.table(file = "./household_power_consumption.txt",strip.white = T,sep = ";",header=T)

# Convert the variable "Date" into date.
txt_data$Date<-dmy(txt_data$Date)
txt_data$Time<-hms(txt_data$Time)

# Select two specific days : 01 and 02 february 2007
txt_data_trunced<-txt_data[txt_data$Date>="2007-02-01" & txt_data$Date<="2007-02-02",]

# Mutate then delete variables Date and Time into new variable named new.date
txt_data_trunced %<>% mutate(new.date=Date+Time,Date=NULL,Time=NULL)
txt_data_trunced %<>% relocate(new.date)

# Convert variables into numerics
txt_data_trunced[,2:8]<-txt_data_trunced %>% summarise(across(Global_active_power:Sub_metering_3,as.numeric))

# Open a png file, store it the histogram and close the file
png(file="plot4.png",
     width=480, height=480)
par(mfrow=c(2,2))
plot(txt_data_trunced[,1],txt_data_trunced[,2],type="s",xlab = "",ylab = "Global Active Power (kilowatts)")

plot(txt_data_trunced[,1],txt_data_trunced[,4],type="s",xlab = "datetime",ylab = "Voltage")

plot(txt_data_trunced[,1],txt_data_trunced[,6],type="s",xlab = "",ylab = "Global Active Power (kilowatt)")
lines(txt_data_trunced[,1], txt_data_trunced[,7], col="red")
lines(txt_data_trunced[,1], txt_data_trunced[,8], col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),lty=c(1,1,1), col=c("black", "red","blue"))

plot(txt_data_trunced[,1],txt_data_trunced[,3],type="s",xlab = "datetime",ylab = "Global_reactive_power")

dev.off()



par(mfrow=c(2,2))