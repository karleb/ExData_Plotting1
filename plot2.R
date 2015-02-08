# Plot2 is xy plot of Global Active Power (column3) as a function of time of day
# the x axis is plot in terms of day of the week

# read in dataset
power <-read.table("household_power_consumption.txt", sep=";", header=TRUE, as.is=FALSE, na.strings="?")

# extract data range of interest from data set
datelist<-as.Date(power[,1], format="%d/%m/%Y")
picks<- (datelist=="2007/02/01" | datelist=="2007/02/02")
working<-power[picks,]

# plot the data of interest, set labels 
png(filename="plot2.png",width = 480, height = 480)
y<-working[,3]
x<-as.POSIXct(paste(working[,1],working[,2]), format="%d/%m/%Y %H:%M:%S") 
plot(x,y, type="l", xaxt="n", xlab="", ylab="Global Active Power (kilowatts)")
# draw axis in terms of the length of the data set (fast way based on understanding data)
cnt<-length(y)
axis(1,at=c(x[1],x[cnt/2],x[cnt]),labels=c("Thu","Fri","Sat"))
dev.off()