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

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,
  destfile = "./power.txt",
  method = "auto") #  Required for Linux, Mac - use auto for Windows

power <- read.csv("./power.txt",
  sep=";", na.strings="?", stringsAsFactors=FALSE)

names(power) <- tolower(names(power))
power$date <- as.Date(power$date, "%d/%m/%Y")
power$time <- format(as.POSIXct(power$time, format="%H:%M:%S")
