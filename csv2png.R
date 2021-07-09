library(ggplot2)
data <- read.csv("./csv/all.rows.csv", sep = ',')

png("results.png")
ggplot(data, aes(x=scheme, y=time)) + geom_bar(stat = "identity", aes(fill = test), position = "dodge") + labs(y = "time (seconds)")

dev.off()
