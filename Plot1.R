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

# Grouping df by year and summing emissions
plot1 <- NEI %>% 
         group_by(year) %>% 
         summarize('total emissions' = sum(Emissions))

# plot
with(plot1, barplot(`total emissions`, year,
                 ylab="Total PM2.5 Emissions",
                 names.arg=unique(plot1$year),
                 xlab="Year",
                 main="Total PM2.5 Emissions in the U.S. by Year"))

dev.copy(png,"Plot1.png", width=480, height=480)
dev.off()