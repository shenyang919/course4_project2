## reading raw data
raw <- readRDS("summarySCC_PM25.rds")
## reading SCC info
scc <- readRDS("Source_Classification_Code.rds")

## grepping any observation that has Coal or coal keyword
## in EI.Secotr column or SCC.Level.Three column in assumption
## that these are all coal combustion related ones
index <- c(grep("Coal", scc$EI.Sector), 
           grep("Coal", scc$SCC.Level.Three))
## subsetting to find only the observations having keyword "Coal"
scc_sub <- scc[index,]

## extracting all emission data matching the SCC's in scc_sub
raw_sub <- raw[which(raw$SCC %in% scc_sub$SCC),]
## converting to data table to prepare for plotdata
raw_sub <- data.table(raw_sub)
## getting summary data to be plotted
plotdata <- raw_sub[, list(sum=sum(Emissions)), by = year]

## plotting barchart
png(filename = "plot4.png", width = 480, height = 480, units = "px",
    pointsize = 12, bg = "white")
barplot(plotdata$sum, names = plotdata$year, xlab = "years",
        ylab = "Emission in tons",
        main = "Total Coal Combustion Related Emission in US")

dev.off()
