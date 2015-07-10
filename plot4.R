#Read in data
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp,"household_power_consumption.txt"),sep=";",header=TRUE,na.strings="?",stringsAsFactors=FALSE)
unlink(temp)
data$Date <- as.Date(data$Date,format="%d/%m/%Y") #convert to Date class
data$DOW <- weekdays(data$Date)
plot_data <- data[which((data$Date=="2007-02-01")|(data$Date=="2007-02-02")),] #create subclass for 2 dates
plot_data[is.na(plot_data)]<-0

png(filename="plot4.png")
par(mfrow=c(2,2),mar=c(3, 3, 2, 1))

#plot upper left
plot(plot_data$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)",ylim=c(0,8),xaxt="n",yaxt="n")
axis(1,at=c(1,1441,2880),lab=c("Thu","Fri","Sat"))
axis(2,at=seq(0,6,2),labels=seq(0,6,2))

#plot upper right
plot(plot_data$Voltage,type="l",xlab="datetime",ylab="Voltage",ylim=c(230,250),xaxt="n",yaxt="n")
axis(1,at=c(1,1441,2880),lab=c("Thu","Fri","Sat"))
axis(2,at=seq(234,246,2),labels=c("234","","238","","242","","246"))


#plot lower left
plot(plot_data$Sub_metering_1,type="l",xlab="",ylab="Energy Sub metering",ylim=c(0,40),xaxt="n",yaxt="n")
lines(plot_data$Sub_metering_2,type="l",xlab="",ylab="Energy Sub metering",ylim=c(0,40),xaxt="n",yaxt="n",col="red")
lines(plot_data$Sub_metering_3,type="l",xlab="",ylab="Energy Sub metering",ylim=c(0,40),xaxt="n",yaxt="n",col="blue")
axis(1,at=c(1,1441,2880),lab=c("Thu","Fri","Sat"))
axis(2,at=seq(0,30,10),labels=seq(0,30,10))

#create legend in upper right hand corner
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=0.8,col=c("black","red","blue"),lty=c(1,1,1))

#plot in lower right
plot(plot_data$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power",ylim=c(0,0.6),xaxt="n",yaxt="n")
axis(1,at=c(1,1441,2880),lab=c("Thu","Fri","Sat"))
axis(2,at=seq(0,0.5,0.1),labels=seq(0,0.5,0.1))
dev.off()