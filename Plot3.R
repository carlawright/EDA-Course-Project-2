##plot3:Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
##variable, which of these four sources have seen decreases in emissions from 1999-2008 
##for Baltimore City? Which have seen increases in emissions from 1999-2008? 
##Use the ggplot2 plotting system to make a plot answer this question.

##Source the data to work with
source("EDAAssignmentData.R")

##Load the plotting library of choice (in this case its ggplot2 which also requires plyr)
library(plyr)
library(ggplot2)

# Get the sum of only Blatimore emissions (fips 24510) split by type then year.
Baltimoreemissions_byyeartype<- ddply(NEI[NEI$fips == "24510",], .(year,type),summarize, total=sum(Emissions))

##Decrease the Blatimore emissions sums from millions to allow for more descriptive plotting
Baltimoreemissions_byyeartype$total <- Baltimoreemissions_byyeartype$total/1e+03

##print plot to PNG file
png(file = "plot3.png", width = 800, height = 480, units = "px")

##create a plot that has the same number of facets as there are types and adding a trend line to each
plot <- qplot(
        year, 
        total, 
        data = Baltimoreemissions_byyeartype, 
        facets= .~type, 
        geom=c("point","smooth"),
        method="lm", 
        se=FALSE
)

##annotate the plots
        plot <- plot + labs(
                x = "Year", 
                y="Total Emissions [in Thousands of tons]", 
                title="Change In Baltimore Emissions In The United States By Type")
        
        print(p)
        dev.off()