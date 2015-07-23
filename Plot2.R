library(dplyr)

# check if data exists
if(!file.exists("./data")) {
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  fileName <- "exdata%2Fdata%2FNEI_data.zip"
  download.file(fileURL,fileName, method = "curl")
  unzip(fileName,exdir = "data")
  # remove file for clean directory
  file.remove(fileName)
}

# reading data files

NEI <- readRDS("data/summarySCC_PM25.rds")

# Grouping df by year and zip code and summing emissions
plot2 <- NEI %>% 
         group_by(year,fips) %>% 
         summarize('total emissions' = sum(Emissions))

# Filter for Baltimore City
plot2 <- filter(plot2,fips=="24510")

#plot
with(plot2, barplot(`total emissions`, year,
                    names.arg=unique(plot2$year),
                    ylab="Total PM2.5 Emissions",
                    xlab="Year",
                    main="Total PM2.5 Emissions in Baltimore City by Year"))

dev.copy(png,"Plot2.png", width=480, height=480)
dev.off()