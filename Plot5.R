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
SCC <- readRDS("data/Source_Classification_Code.rds")

# subset by combustion source and motor vehicle sources
scc_df <- SCC[grep("Mobile Sources", SCC$SCC.Level.One),]
scc_df <- scc_df[grep("Highway", scc_df$SCC.Level.Two),]

# grab the numbers for motor vehicle sources
scc_nums <- unique(scc_df$SCC)

# creating a Baltimore specific data frame
baltimore <- NEI %>% filter(fips == "24510")

# sort baltimore by year and SCC numbers, filter by motor vehicle sources
df <- baltimore %>% 
  group_by(year,fips,SCC) %>% 
  summarize(`total emissions` = sum(Emissions)) %>%
  filter(grepl(paste(scc_nums, collapse="|"),SCC))

# tried to do this with mutate, instead setting year variable as factor here
df$year <- as.factor(df$year)

# plot
ggplot(df, aes(year, `total emissions`)) + 
  geom_bar(stat="identity") +
  ggtitle("Total Emissions from Motor Vehicle Sources in Baltimore City")

dev.copy(png, "Plot5.png", width=480, height=480)
dev.off()