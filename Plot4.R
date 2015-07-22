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

# sort NEI by year and SCC numbers, filter by coal-combustion sources
df <- NEI %>% 
      group_by(year,SCC) %>% 
      summarize(`total emissions` = sum(Emissions)) %>%
      filter(grepl(paste(scc_nums, collapse="|"),SCC))

# tried to do this with mutate, instead setting year variable as factor here
df$year <- as.factor(df$year)

# plot
# each bar has a fill representing all the emission sources
# guide is removed because it's 80 sources and the legend looked crazy
ggplot(df, aes(year, `total emissions`, fill=SCC)) + 
      geom_bar(stat="identity") +
      guides(fill=FALSE) +
      ggtitle("Total Emissions from Coal-Combustion Sources in the U.S.")

dev.copy(png, "Plot4.png", width=480, height=480)
dev.off()