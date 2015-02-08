# Plot3 is xy plots of Energy sub metering (columns 7:9) as a function of time of day
# the x axis is plot in terms of day of the week

# read in dataset
power <-read.table("household_power_consumption.txt", sep=";", header=TRUE, as.is=FALSE, na.strings="?")

# extract data range of interest from data set
datelist<-as.Date(power[,1], format="%d/%m/%Y")
picks<- (datelist=="2007/02/01" | datelist=="2007/02/02")
working<-power[picks,]


# plot the data of interest, set labels 
png(filename="plot3.png",width = 480, height = 480)
sub1<-working[,7]
sub2<-working[,8]
sub3<-working[,9]

#date and time is being a problem
x<-as.POSIXct(paste(working[,1],working[,2]), format="%d/%m/%Y %H:%M:%S") 
# determine size for yaxis
yrange<-range(working[,7:9])

# from summary(working) - sub metering varies from 0 to 38
plot(x,sub1, type="l", ylim=yrange, xlab="", ylab="Energy sub metering", xaxt="n", col="black")
lines(x,sub2, col="red")
lines(x,sub3, col="blue")

#set up legend
leglabels<-names(working)[7:9]
legend("topright",leglabels, lwd=1, col=c("black","red","blue"))

# draw axis in terms of the length of the data set (fast way based on understanding data)
cnt<-length(y)
axis(1,at=c(x[1],x[cnt/2],x[cnt]),labels=c("Thu","Fri","Sat"))
dev.off()