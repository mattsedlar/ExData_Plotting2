library(dplyr)
library(ggplot2)

# reading data files
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# subset by combustion source and coal source
scc_df <- SCC[grep("Combustion", SCC$SCC.Level.One),]
scc_df <- scc_df[grep("Coal", scc_df$SCC.Level.Three),]

# grab the numbers for coal-combustion sources
scc_nums <- unique(scc_df$SCC)

# sort NEI by year and SCC numbers
df <- NEI %>% group_by(year,SCC) %>% summarize(`total emissions` = sum(Emissions))
