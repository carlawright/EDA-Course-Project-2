##Plot6: Compare emissions from motor vehicle sources in Baltimore City with emissions 
##from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
##Which city has seen greater changes over time in motor vehicle emissions?

##Source the data to work with
source("EDAAssignmentData.R")
##load the plotting library ( will use base plotting system)
library(data.table)

## Look for the codes that identify motor vehicle sources in dataset SCC
vehiclesource_SCC <- SCC[
        grep("vehicles", 
             SCC$EI.Sector, 
             ignore.case = TRUE), 
        c("SCC")]

## Get only the emissions from Baltimore
baltimoreemissions <- NEI[NEI$fips == "24510",]

## Get the total emissions sums in Baltimore split by year
baltimore_vehicleemissions<- data.table(
        baltimoreemissions[baltimoreemissions$SCC %in% vehiclesource_SCC,])[, list( total=sum(Emissions)), by=year]

## Get only the emissions from LA
LAemissions<- NEI[NEI$fips == "06037",]

## Get the total emissions sums in LA split by year
LA_vehicleemissions<- data.table(
        LAemissions[LAemissions$SCC %in% vehiclesource_SCC,])[, list( total=sum(Emissions)), by=year]
LA_BaltimoreEmissions<-rbind(LA_vehicleemissions, baltimore_vehicleemissions)

##add a column to the cleaned table so we can differient between locations
LA_BaltimoreEmissions$location <- factor(c(rep("Los Angeles",4),rep("Baltimore",4)))



##print plot to PNG file
png(file = "plot6.png")
##create a plot  of year and total pm2.5 emissions from balitmore and LA and add annotations
plot(
        LA_BaltimoreEmissions$year, 
        LA_BaltimoreEmissions$total, 
        col=LA_BaltimoreEmissions$location,
        pch=19,
        main="Total PM2.5 Emissions of Motor Vehicles in Baltimore & LA", 
        xlab="Year",
        ylab="Total Emissions [in millions of tons]")

##add in trend lines
lm <- lm(total ~ year, LA_vehicleemissions)
abline(lm, col ="royalblue1", lwd=2)
lm <- lm(total ~ year, baltimore_vehicleemissions)
abline(lm, col ="orange", lwd=2)

##add legend 
legend("right", pch = 1, col=c("Red", "Black"), 
       legend=c("Los Angeles", "Balitmore"))
dev.off()