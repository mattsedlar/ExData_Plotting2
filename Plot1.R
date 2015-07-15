library(dplyr)

# reading data files

NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# Grouping df by year and summing emissions
plot1 <- NEI %>% group_by(year) %>% summarize('total emissions' = sum(Emissions))

# plot
with(plot1, boxplot(`total emissions` ~ year,
                 ylab="Total PM2.5 Emissions",
                 xlab="Year",
                 main="Total PM2.5 Emissions in the U.S. by Year"))

dev.copy(png,"Plot1.png", width=480, height=480)
dev.off()