#Store original working directory
Base_working_dir <- getwd()

#Set the working directory
WorkDir <- "./data"
if(!dir.exists("./data")) dir.create("./data")
setwd(WorkDir)

# Download data filename
filename <- "exdata_data_household_power_consumption.zip"

# Checking if zip file already exists, if it does then no need to download
if (!file.exists(filename)){
    fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileURL, filename, method="curl")
}  

# Checking if unzipped folder already  exists, if exist use it if not unzip the file
if (!file.exists("household_power_consumption.txt")) unzip(filename) 

#Read the entire file and store in the data frame
df <- read.csv("household_power_consumption.txt", header = TRUE, sep=";", na.strings=c("?"))

#Change the date and time format
df$Date<-as.Date(df$Date, format = "%d/%m/%Y")
df$Time<-strptime(paste(df$Date,df$Time),"%F %T")

#Extract the data for 1st and 2nd Feb, 2017 days 
df<-subset(df,df$Date %in% as.Date(c("2007-02-01","2007-02-02")))

#Plot the graph of sub meters
plot(df$Time,df$Sub_metering_1,ylab="Energy sub metering", xlab="", type="l", col="black")
points(df$Time,df$Sub_metering_2, col="red", type="l")
points(df$Time,df$Sub_metering_3, col="blue", type="l")
legend("topright", lwd=1, col=c("black", "red", "blue"), legend=names(df[,7:9]))

#Store the plot into a PNG file
png("plot3.png", width=480, height=480)
plot(df$Time,df$Sub_metering_1,ylab="Energy sub metering", xlab="", type="l", col="black")
points(df$Time,df$Sub_metering_2, col="red", type="l")
points(df$Time,df$Sub_metering_3, col="blue", type="l")
legend("topright", lwd=1, col=c("black", "red", "blue"), legend=names(df[,7:9]))
dev.off()

#Set original working directory back
setwd(Base_working_dir)