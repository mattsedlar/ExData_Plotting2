library(dplyr)
library(ggplot2)

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

# group by year, type and summarize emissions
plot3 <- NEI %>% 
         group_by(year, type, fips) %>% 
         summarize(`total emissions` = sum(Emissions)) %>%
         filter(fips=="24510")

plot3$year <- as.factor(plot3$year)

# plot
ggplot(plot3, aes(x=year, y=`total emissions`)) +
  ggtitle("Emissions by type from 1999–2008 for Baltimore City") +
  geom_bar(aes(fill=year),stat="identity") + 
  guides(fill=FALSE) +
  facet_grid(. ~ type)

dev.copy(png, "Plot3.png", width=500, height=300)
dev.off()
