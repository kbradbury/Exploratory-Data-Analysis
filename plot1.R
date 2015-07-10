#Read in data
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp,"household_power_consumption.txt"),sep=";",header=TRUE,na.strings="?",stringsAsFactors=FALSE)
unlink(temp)
data$Date <- as.Date(data$Date,format="%d/%m/%Y") #convert to Date class
plot_data <- data[which((data$Date=="2007-02-01")|(data$Date=="2007-02-02")),] #create subclass for 2 dates

#plot histogram as a png file
png(filename="plot1.png")
hist(plot_data$Global_active_power,main="Global Active Power",xlab="Global Active Power (kilowatts)",ylab="Frequency",col="red",xlim=c(0,6),ylim=c(0,1200),xaxt="n")
axis(side=1,at=seq(0,6,2),labels=seq(0,6,2))
dev.off()
