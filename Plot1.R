##plot 1: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
##Using the base plotting system, make a plot showing the total PM2.5 emission 
##from all sources for each of the years 1999, 2002, 2005, and 2008.

##Source the data to work with
source("EDAAssignmentData.R")
##Load the plotting library of choice (in this case base plotting system)
library(data.table)

# Get the sum of all emissions split by year
emissions_byyear<- data.table(NEI)[, list(total=sum(Emissions)), by=year]

# Decrease the emissions sums from millions to allow for more descriptive plotting
emissions_byyear$total <- emissions_byyear$total/1e+06

##print plot to PNG file
png(file = "plot1.png")

## Create a plot to demonstrate changes in PM2.5 Emissions over the past decade
plot(emissions_byyear$year, emissions_byyear$total, 
     main="Change in Emissions In The United States", 
     col="royalblue1", 
     pch=19,
     xlab="Year", 
     ylab="Total PM2.5 Emissions [in Millions of Tons]")
lm <- lm(total ~ year, emissions_byyear)
abline(lm, col ="maroon3", lwd=2)
dev.off()