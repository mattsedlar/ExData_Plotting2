source("get_data.R")

plot1 <- NEI %>% group_by(year) %>% summarize('total emissions' = sum(Emissions))

with(plot1, plot(`total emissions` ~ year,
                 ylab="Total PM2.5 Emissions",
                 xlab="Year"))