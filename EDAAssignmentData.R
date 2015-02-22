##Download the data if it isn't already downloaded yet.
if (!file.exists("summarySCC_PM25.rds") || !file.exists("Source_Classification_Code.rds")) {
        if( .Platform$OS.type == "windows" ) {
                download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "project.zip", mode="wb")
                unzip("project.zip")
                unlink("project.zip")
        } else {
                download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "project.zip")
                unzip("project.zip")
                unlink("project.zip")
        }
        write(date(), file="dateDownloaded.txt")
}

# Load the data into WD if it hasn't already been loaded yet.
if(!exists("NEI")) {
        message( "Loading..." )
        NEI <- readRDS("summarySCC_PM25.rds")
} else {
        message("NEI has already been loaded" )
}
if(!exists("SCC")) {
        message( "Loading..." )
        SCC <- readRDS("Source_Classification_Code.rds")
} else {
        message( "SCC has already been loaded" )
}