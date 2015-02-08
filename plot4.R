# Plot2 is xy plot of Global Active Power (column3) as a function of time of day
# the x axis is plot in terms of day of the week

# read in dataset
power <-read.table("household_power_consumption.txt", sep=";", header=TRUE, as.is=FALSE, na.strings="?")

# extract data range of interest from data set
datelist<-as.Date(power[,1], format="%d/%m/%Y")
picks<- (datelist=="2007/02/01" | datelist=="2007/02/02")
working<-power[picks,]

#pull out the data sets (could just use data frame but easier to read)
gap<-working[,3]
cnt<-length(y) #length of data set

sub1<-working[,7]
sub2<-working[,8]
sub3<-working[,9]
volt<-working[,5]
grp<-working[,4]
x<-as.POSIXct(paste(working[,1],working[,2]), format="%d/%m/%Y %H:%M:%S") 



# plot the data of interest, set labels 
png(filename="plot4.png",width = 480, height = 480)
par(mfcol=c(2,2)) #set up for grid

# this goes in upper left
plot(x,gap, type="l", xaxt="n", xlab="", ylab="Global Active Power (kilowatts)")
# draw axis in terms of the length of the data set (fast way based on understanding data)
axis(1,at=c(x[1],x[cnt/2],x[cnt]),labels=c("Thu","Fri","Sat"))


#this goes in lower left
# determine size for yaxis
yrange<-range(working[,7:9])

# from summary(working) - sub metering varies from 0 to 38
plot(x,sub1, type="l", ylim=yrange, xlab="", ylab="Energy sub metering", xaxt="n", col="black")
lines(x,sub2, col="red")
lines(x,sub3, col="blue")

#set up legend
leglabels<-names(working)[7:9]
legend("topright",leglabels, lwd=1, col=c("black","red","blue"), bty="n")

# draw axis in terms of the length of the data set (fast way based on understanding data)
axis(1,at=c(x[1],x[cnt/2],x[cnt]),labels=c("Thu","Fri","Sat"))

# the upper right is Voltage column 5 versus datetime
plot(x,volt, type="l", xaxt="n", xlab="datetime", ylab="Voltage")
# draw axis in terms of the length of the data set (fast way based on understanding data)
axis(1,at=c(x[1],x[cnt/2],x[cnt]),labels=c("Thu","Fri","Sat"))


# the lower right is Global_reactive_power column 4 versus datetime
plot(x,grp, type="l", xaxt="n", xlab="datetime", ylab="Global_reactive_power")
# draw axis in terms of the length of the data set (fast way based on understanding data)
axis(1,at=c(x[1],x[cnt/2],x[cnt]),labels=c("Thu","Fri","Sat"))

dev.off()
