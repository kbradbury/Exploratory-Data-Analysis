#Read in data
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp,"household_power_consumption.txt"),sep=";",header=TRUE,na.strings="?",stringsAsFactors=FALSE)
unlink(temp)
data$Date <- as.Date(data$Date,format="%d/%m/%Y") #convert to Date class
data$DOW <- weekdays(data$Date)
plot_data <- data[which((data$Date=="2007-02-01")|(data$Date=="2007-02-02")),] #create subclass for 2 dates
plot_data[is.na(plot_data)]<-0

#find occurrence of midnight
midnight <- which(plot_data$Time=="00:00:00")

png(filename="plot2.png")
plot(plot_data$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)",ylim=c(0,8),xaxt="n",yaxt="n")
axis(1,at=c(1,1441,2880),lab=c("Thu","Fri","Sat"))
axis(2,at=seq(0,6,2),labels=seq(0,6,2))
dev.off()