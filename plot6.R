## reading raw data
raw <- readRDS("summarySCC_PM25.rds")
## subsetting to get only baltimore data
raw_sub <- raw[((raw$fips == "24510") | (raw$fips == "06037")),]

## reading SCC info
scc <- readRDS("Source_Classification_Code.rds")

## grepping any observation that has "Motor" keyword
## in EI.Secotr column or SCC.Level.Three column in assumption
## that these are all coal combustion related ones
index <- c(grep("Motor", scc$EI.Sector), 
           grep("Motor", scc$SCC.Level.One),
           grep("Motor", scc$SCC.Level.Two),
           grep("Motor", scc$SCC.Level.Three))
## subsetting to find only the observations having keyword "Motor"
scc_sub <- scc[index,]

raw_sub <- raw_sub[which(raw_sub$SCC %in% scc_sub$SCC),]
raw_sub[raw_sub == "24510"] <- "Baltimore"
raw_sub[raw_sub == "06037"] <- "Los Angeles County"
raw_sub <- data.table(raw_sub)
plotdata <- raw_sub[, list(sum=sum(Emissions)), by = list(year,fips)]

png(filename = "plot6.png", width = 680, height = 480, units = "px",
    pointsize = 12, bg = "white")
ggplot(plotdata, aes(x = factor(year), y = sum, fill = factor(fips))) + 
  geom_bar(stat = "identity", position=position_dodge())

dev.off()