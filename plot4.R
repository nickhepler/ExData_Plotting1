# plot4.R
#  Copyright 2015 Nick Hepler <nick.hepler@outlook.com>
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.

# Download file and save as "power.zip"
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,
  destfile = "./power.zip",
  method = "curl") #  Required for Linux, Mac - use auto for Windows

# Unzip the "household_power_consumption.txt" from the "power.zip" file.
unzip("./power.zip", files = "household_power_consumption.txt")

# Read the data into global envrionment and call the variable "power".
power <- read.csv("./household_power_consumption.txt",
  sep=";", na.strings="?", stringsAsFactors=FALSE)

# Tidy the data up.
names(power) <- tolower(names(power))
power$date <- as.Date(power$date, format="%d/%m/%Y")
power <- power[power$date >= "2007-02-01" & power$date <= "2007-02-02",]
datetime <- paste(as.Date(power$date), power$time)
power$datetime <- as.POSIXct(datetime)
rm(datetime)

# Plot 4 :: Global Active Power (kilowatts) by sub metering
opar <- par(no.readonly=TRUE) # Copy cureent graphical parameters.
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

with(power, {
  plot(global_active_power~datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(voltage~datetime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(sub_metering_1~datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(sub_metering_2~datetime,col="Red")
  lines(sub_metering_3~datetime,col="Blue")
  legend("topright", col=c("black", "Red", "Blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub Metering 1", "Sub Metering 2", "Sub Metering 3"))
  plot(global_reactive_power~datetime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()

par(opar)