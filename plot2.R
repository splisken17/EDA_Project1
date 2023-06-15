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

plot(df3$Global_active_power, type= 'l', 
     ylab = 'Global Active Power (kilowatts)',
     xlab ='',
     xaxt = 'n')

axis(1, at = c(0,1440,2880),
     labels = c('Thu', 'Fri', 'Sat'))


dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()
