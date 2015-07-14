library(dplyr)

plot1 <- NEI %>% group_by(year) %>% summarize('total emissions' = sum(Emissions))
