##Plot4:Across the United States, how have emissions from 
##coal combustion-related sources changed from 1999-2008?

##Source the data to work with
source("EDAAssignmentData.R")
##load the plotting library ( will use base plotting system)
library(data.table)

# Look for the codes that identify coal combustion in dataset SCC
coalsource_SCC <- SCC[
        grep("coal", 
        SCC$EI.Sector, 
        ignore.case = TRUE), 
        c("SCC")]
##Get the sum of only coal combusion emissions split by year.
coalemissions<- data.table(
        NEI[NEI$SCC %in% coalsource_SCC,])[, list( total=sum(Emissions)), by=year]

##Decrease the emissions sums from millions to allow for more descriptive plotting
coalemissions$total <- coalemissions$total/1e+03


##print plot to PNG file
png(file = "plot4.png")

plot(
        coalemissions$year, 
        coalemissions$total, 
        col="royalblue1", 
        pch=19,
        main="Total PM2.5 Emissions In The Unitied States", 
        xlab="Year",
        ylab="Total Emissions For Coal Combustion Related Sources[in thousands of tons]" 
        )

lm<- lm(total ~ year, coalemissions)
abline(lm, col ="maroon3", lwd=2)
dev.off()
