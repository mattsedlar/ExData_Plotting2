library(dplyr)

# reading data files

NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# Grouping df by year and zip code and summing emissions
plot2 <- NEI %>% group_by(year,fips) %>% summarize('total emissions' = sum(Emissions))
# Filter for Baltimore City
plot2 <- filter(plot2,fips=="24510")

#plot
with(plot2, boxplot(`total emissions` ~ year,
                    ylab="Total PM2.5 Emissions",
                    xlab="Year",
                    main="Total PM2.5 Emissions in Baltimore City by Year"))

dev.copy(png,"Plot2.png", width=480, height=480)
dev.off()