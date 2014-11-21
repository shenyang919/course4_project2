## reading raw data
raw <- readRDS("summarySCC_PM25.rds")
## subsetting to get only baltimore data
baltimore <- raw[(raw$fips == "24510"),]
## converting data.frame to data.table
baltimore <- data.table(baltimore)
## getting all sum data based on years and type
plotdata <- baltimore[, list(sum=sum(Emissions)), by = list(type, year)]

## presenting data into a png file as a bar chart
png(filename = "plot3.png", width = 680, height = 480, units = "px",
    pointsize = 12, bg = "white")
ggplot(plotdata, aes(x = factor(year), y = sum, fill = factor(type))) + 
  geom_bar(stat = "identity", position=position_dodge())

dev.off()