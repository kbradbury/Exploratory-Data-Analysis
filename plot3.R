#Read in data
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp,"household_power_consumption.txt"),sep=";",header=TRUE,na.strings="?",stringsAsFactors=FALSE)
unlink(temp)
data$Date <- as.Date(data$Date,format="%d/%m/%Y") #convert to Date class
data$DOW <- weekdays(data$Date)
plot_data <- data[which((data$Date=="2007-02-01")|(data$Date=="2007-02-02")),] #create subclass for 2 dates
plot_data[is.na(plot_data)]<-0

midnight <- which(plot_data$Time=="00:00:00")

png(filename="plot3.png",width=480,height=480)
plot(plot_data$Sub_metering_1,type="l",xlab="",ylab="Energy Sub metering",ylim=c(0,40),xaxt="n",yaxt="n")
lines(plot_data$Sub_metering_2,type="l",xlab="",ylab="Energy Sub metering",ylim=c(0,40),xaxt="n",yaxt="n",col="red")
lines(plot_data$Sub_metering_3,type="l",xlab="",ylab="Energy Sub metering",ylim=c(0,40),xaxt="n",yaxt="n",col="blue")
axis(1,at=c(1,1441,2880),lab=c("Thu","Fri","Sat"))
axis(2,at=seq(0,30,10),labels=seq(0,30,10))

#create legend in upper right hand corner
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=0.8,col=c("black","red","blue"),lty=c(1,1,1))
dev.off()