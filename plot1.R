library(lubridate)
library(dplyr)

txt_data<-read.table(file = "./household_power_consumption.txt",strip.white = T,sep = ";",header=T)

# Convert the variable "Date" into date.
txt_data$Date<-dmy(txt_data$Date)

# Select two specific days : 01 and 02 february 2007
txt_data_trunced<-txt_data[txt_data$Date>="2007-02-01" & txt_data$Date<="2007-02-02",]

# Convert variables into numerics
txt_data_trunced[,3:9]<-txt_data_trunced %>% summarise(across(Global_active_power:Sub_metering_3,as.numeric),.groups = "keep")

# Open a png file, store it the histogram and close the file
png(file="plot1.png",
    width=480, height=480)
hist(x = txt_data_trunced[,3],col="red",main = "Global Active Power",xlab = "Global Active Power (kilowatts)")
dev.off()