library(dplyr)
library(ggplot2)

# reading data files
NEI <- readRDS("data/summarySCC_PM25.rds")

# group by year, type and summarize emissions
plot3 <- NEI %>% 
         group_by(year, type, fips) %>% 
         summarize(`total emissions` = sum(Emissions)) %>%
         filter(fips=="24510")

# plot
ggplot(plot3, aes(x=year, y=`total emissions`)) +
  ggtitle("Emissions by type from 1999–2008 for Baltimore City") +
  geom_line() + 
  facet_grid(. ~ type)

dev.copy(png, "Plot3.png", width=500, height=500)
dev.off()
