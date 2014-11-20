## reading raw data
raw <- readRDS("summarySCC_PM25.rds")
## converting data.frame to data.table
raw <- data.table(raw)
## getting all sum data based on years
plotdata <- raw[, list(sum=sum(Emissions)), by = year]

## presenting data into a png file as a bar chart
png(filename = "plot1.png", width = 480, height = 480, units = "px",
    pointsize = 12, bg = "white")
barplot(plotdata$sum, names = plotdata$year, xlab = "years",
        ylab = "PM 2.5 in tons",
        main = "Total PM 2.5 Emission in US")

dev.off()