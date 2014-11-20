## reading raw data
raw <- readRDS("summarySCC_PM25.rds")
## subsetting to get only baltimore data
baltimore <- raw[(raw$fips == "24510"),]
## converting data.frame to data.table
baltimore <- data.table(baltimore)
## getting all sum data based on years
plotdata <- baltimore[, list(sum=sum(Emissions)), by = year]

## presenting data into a png file as a bar chart
png(filename = "plot2.png", width = 480, height = 480, units = "px",
    pointsize = 12, bg = "white")
barplot(plotdata$sum, names = plotdata$year, xlab = "years",
        ylab = "PM 2.5 in tons",
        main = "Total PM 2.5 Emission in Baltimore")

dev.off()