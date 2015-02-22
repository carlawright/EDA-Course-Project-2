##Plot2: Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
##(fips == "24510") from 1999 to 2008? 
##Use the base plotting system to make a plot answering this question

##Source the data to work with
source("EDAAssignmentData.R")
##Load the plotting library of choice (in this case base plotting system)
library(data.table)

# Get the sum of only Blatimore emissions (fips 24510) split by year
Baltimoreemissions_byyear<- data.table(NEI[NEI$fips == "24510",])[, list(total=sum(Emissions)), by=year]

##Decrease the Blatimore emissions sums from millions to allow for more descriptive plotting
Baltimoreemissions_byyear$total <- Baltimoreemissions_byyear$total/1e+03

##print plot to PNG file
png(file = "plot2.png")

## Create a plot to demonstrate changes in Baltimore's PM2.5 Emissions over the past decade
plot(Baltimoreemissions_byyear$year, Baltimoreemissions_byyear$total, 
     main="Change In Baltimore Emissions In The United States", 
     col="royalblue1", 
     pch=19,
     xlab="Year", 
     ylab="Total PM2.5 Emissions [in Thousands of Tons]")
lm <- lm(total ~ year, Baltimoreemissions_byyear)
abline(lm, col ="maroon3", lwd=2)
dev.off()