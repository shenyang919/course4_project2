## reading raw data
raw <- readRDS("summarySCC_PM25.rds")
## subsetting to get only baltimore data
baltimore <- raw[(raw$fips == "24510"),]
## reading SCC info
scc <- readRDS("Source_Classification_Code.rds")

## grepping any observation that has "Motor" keyword
## in EI.Secotr column or SCC.Level.Three column in assumption
## that these are all coal combustion related ones
index <- c(grep("Motor", scc$EI.Sector), 
           grep("Motor", scc$SCC.Level.Three))
## subsetting to find only the observations having keyword "Motor"
scc_sub <- scc[index,]

## extracting all emission data matching the SCC's in scc_sub
baltimore_sub <- baltimore[which(baltimore$SCC %in% scc_sub$SCC),]
## converting to data table to prepare for plotdata
baltimore_sub <- data.table(baltimore_sub)
## getting summary data to be plotted
plotdata <- baltimore_sub[, list(sum=sum(Emissions)), by = year]

## plotting barchart
png(filename = "plot5.png", width = 480, height = 480, units = "px",
    pointsize = 12, bg = "white")
barplot(plotdata$sum, names = plotdata$year, xlab = "years",
        ylab = "Emission in tons",
        main = "Total Motor Vehicle Related Emission in Baltimore")

dev.off()