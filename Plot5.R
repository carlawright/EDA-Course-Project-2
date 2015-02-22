##Plot5:How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

##Source the data to work with
source("EDAAssignmentData.R")
##load the plotting library ( will use base plotting system)
library(data.table)

# Look for the codes that identify motor vehicle sources in dataset SCC
vehiclesource_SCC <- SCC[
        grep("vehicles", 
             SCC$EI.Sector, 
             ignore.case = TRUE), 
        c("SCC")]

# Get only the emissions from Baltimore
baltimoreemissions <- NEI[NEI$fips == "24510",]

# Get the total emissions sums in Baltimore split by year
baltimore_vehicleemssions<- data.table(
        baltimoreemissions[baltimoreemissions$SCC %in% vehiclesource_SCC,])[, list( total=sum(Emissions)), by=year]
        
##print plot to PNG file

png(file = "plot5.png")
##create a plot  of year and total pm2.5 emissions from balitmore and add annotations
plot(
        baltimore_vehicleemssions$year, 
        baltimore_vehicleemssions$total, 
        col="royalblue1",
        pch=19,
        main="Total PM2.5 Emissions of Motor Vehicles in Baltimore", 
        xlab="Year",
        ylab="Total Emissions [in millions of tons]")

##add in trend line
lm <- lm(total ~ year, baltimore_vehicleemssions)
abline(lm, col ="maroon3", lwd=2)
dev.off()