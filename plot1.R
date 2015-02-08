# Plot1 is histogram of Global Active Power (column3) in red

# read in dataset
power <-read.table("household_power_consumption.txt", sep=";", header=TRUE, as.is=FALSE, na.strings="?")

# extract data range of interest from data set
datelist<-as.Date(power[,1], format="%d/%m/%Y")
picks<- (datelist=="2007/02/01" | datelist=="2007/02/02")
working<-power[picks,]

# plot the data of interest, set labels and color
png(filename="plot1.png",width = 480, height = 480)
hist(working[,3], main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
dev.off()