library(lubridate)
library(tidyverse)
library(hms)
library(dplyr)

df <- read.table("./Data/household_power_consumption.txt", sep = ";", header=T)
head(df,5)
str(df)

# Convert data and time columns
df$Date <- dmy(df$Date)
df$Time <- as_hms(df$Time)

# subset data to relevant dates
df2 <- subset(df, Date >= '2007-02-01' & Date <= '2007-02-02')
head(df2,5)
tail(df2,5)

# convert columns to numeric
df3 <- df2 %>% mutate_if(is.character, as.numeric)
str(df3)


# Plot

png("plot3.png", width=480, height = 480)
plot(df3$Sub_metering_1, type= 'l', 
     ylab = 'Energy sub metering',
     xlab ='',
     xaxt = 'n')

lines(df3$Sub_metering_2, col="red")
lines(df3$Sub_metering_3, col="blue")

legend("topright", lty = 1, col=c("black","red", "blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

axis(1, at = c(0,1440,2880),
     labels = c('Thu', 'Fri', 'Sat'))

dev.off()
