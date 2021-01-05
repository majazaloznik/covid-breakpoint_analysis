###############################################################################
## BREAKPOINT ANALYSIS OF SLOVENIAN COVID 19 CONFIRMED CASES DATA
###############################################################################

# PRELIMINARIES
###############################################################################
# # install packages
# install.packages("readr")
# install.packages("strucchange")

# load packages
library(readr)
library(strucchange)

# load transformed data
df <- read_csv("data/transformed.data.csv")

# CALCULATE BREAK POINTS 
###############################################################################

b1 <- breakpoints(df$time.series.1 ~ 1, h = 0.05)
b2 <- breakpoints(df$time.series.2 ~ 1, h = 0.05, breaks = 8)

# PLOT 1
###############################################################################
# png("figures/plot1.png", 800, 480)
par(mar = c(4,4,1,0.5))
plot(log(df$mov.avg.p1), type = "l", ylim = c(-2, 8),
     ylab = "cases.confirmed / mov.avg (21)",
     xlab = "day", col = "gray")
lines(df$time.series.1, type = "l", col = "black")
abline(v = b1[[1]] , col = "red")
legend(250, 6, col = "gray", lty = 1, 
       legend = "7d centered \n moving average", 
       cex = 1, bty = "n")
# dev.off()

# PLOT 2
###############################################################################
# png("figures/plot2.png", 800, 480)
par(mar = c(4,4,1,0.5))
plot(log(df$mov.avg.p1.chart), type = "l", ylim = c(-2, 8),
     ylab = "mov.avg(7) / mov.avg (21)",
     xlab = "day", col = "gray")
lines(df$time.series.2, type = "l", col = "black")
abline(v = b2[[1]] , col = "red")
legend(250, 6, col = "gray", lty = 1, 
       legend = "7d right aligned \n moving average", 
       cex = 1, bty = "n")
# dev.off()


