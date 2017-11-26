#load and prepare data frame
df <- read.csv("household_power_consumption.txt", sep = ";")

#convert date/time from factor to date-time field
df$Date <- as.Date(df$Date, format="%d/%m/%Y")

#filter dataframe for relevant dates
df2 <- subset(df, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))

#alternative method (longer way) for filtering
df_1 <- df[df$Date == "2007-02-01",]
df_2 <- df[df$Date == "2007-02-02",]
df2 <- rbind(df_1, df_2)

#combine date/time fields into new field
df2$datetime <- strptime(paste(df2$Date, df2$Time), "%Y-%m-%d %H:%M:%S")

#convert factors into numeric types
df2$Voltage <-as.numeric(as.character(df2$Voltage))
df2$Global_active_power <- as.numeric(as.character(df2$Global_active_power ))
df2$Global_reactive_power <-  as.numeric(as.character(df2$Global_reactive_power ))
df2$Sub_metering_1 <- as.numeric(as.character(df2$Sub_metering_1))
df2$Sub_metering_2 <- as.numeric(as.character(df2$Sub_metering_2))
df2$Sub_metering_3 <- as.numeric(as.character(df2$Sub_metering_3))

#check for ?'s or NA's
summary(df2[3:9])

#create plot
with(df2, plot(x = datetime, y = Sub_metering_1, 
               type = "l", xlab="", ylab = "Energy sub metering"))
with(df2, lines(x = datetime, y = Sub_metering_2, 
                type = "l", col = "red"))
with(df2, lines(x = datetime, y = Sub_metering_3, 
                type = "l", col = "blue"))
legend("topright", col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1)

#save plot as png
dev.copy(png, file = "plot3.png", height = 480, width = 480)
dev.off()