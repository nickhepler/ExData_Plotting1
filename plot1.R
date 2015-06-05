# plot1.R
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

# Plot 1 :: Global Active Power Histogram
hist(power$global_active_power, main="Global Active Power",
  xlab="Global Active Power (kilowatts)", ylab="Frequency", col="red")
