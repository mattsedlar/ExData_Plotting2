library(dplyr)
library(ggplot2)

# reading data files

NEI <- readRDS("data/summarySCC_PM25.rds")
# SCC <- readRDS("data/Source_Classification_Code.rds")

# group by year, type and summarize emissions
plot3 <- NEI %>% group_by(year, type) %>% summarize(`total emissions` = sum(Emissions))

# plot
ggplot(plot3, aes(x=year, y=`total emissions`)) + geom_line(aes(col=type, group=type))