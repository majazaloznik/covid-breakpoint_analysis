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
library(RColorBrewer)

# load transformed data
df <- read_csv("data/transformed.data.csv")

# CALCULATE BREAK POINTS 
###############################################################################

b1 <- breakpoints(df$time.series.1 ~ 1, h = 0.05)
b2 <- breakpoints(df$time.series.2 ~ 1, h = 0.05, breaks = 8)

# PLOT 1
###############################################################################
png("figures/plot1.png", 800, 480)
par(mar = c(4,4,1,0.5))
plot(log(df$mov.avg.p1), type = "l", ylim = c(-2, 8),
     ylab = "cases.confirmed / mov.avg.p1 (3 weeks)",
     xlab = "day", col = "gray",
     axes = FALSE)
axis(1)
axis(2)
lines(df$time.series.1, type = "p", cex = 0.8, 
      col = rev(viridis::viridis(nrow(df))))
abline(v = b1[[1]] , col = "red", lty = "65")
legend(250, 6, col = "gray", lty = 1, 
       legend = "7d centered \n moving average \n of confirmed cases", 
       cex = 1, bty = "n")
dev.off()

# PLOT 2
###############################################################################
png("figures/plot2.png", 800, 480)
par(mar = c(4,4,1,0.5))
plot(log(df$mov.avg.p1.chart), type = "l", ylim = c(-2, 8),
     ylab = "mov.avg.p1 (1 week) / mov.avg.p1 (3 weeks)",
     xlab = "day", col = "gray",
     axes = FALSE)
axis(1)
axis(2)
lines(df$time.series.2, type = "p", cex = 0.8, 
      col = rev(viridis::viridis(nrow(df))))
abline(v = b2[[1]] -7 , col = "red", lty = "65")
legend(250, 6, col = "gray", lty = 1, 
       legend = "7d right aligned \n moving average \n of confirmed cases", 
       cex = 1, bty = "n")
dev.off()

# Phase diagram
###############################################################################

# Classic palette BuPu, with 4 colors
coul <- brewer.pal(4, "PuOr") 
coul <- wes_palette("Zissou1", 5)
# Add more colors to this palette :
coul <- rev(colorRampPalette(coul)(nrow(df)))

png("figures/phase.png", 800, 480)
par(mar = c(4,4,4,0.5))
plot(df$mov.avg.p2, df$mov.avg.p1, 
     log = c("xy"),
     type = "b", 
     col = rev(viridis::viridis(nrow(df))),
     ylab = "mov.avg.p1 (1 week)",
     xlab = "mov.avg.p2 (3 weeks)", axes = FALSE)
mtext(side = 3, line = 2, adj = 0,
      text = "Phase diagram of moving averages of daily confirmed cases of COVID-19")
marks <- c(1, 10, 100, 1000)
axis(2,at=marks,labels=format(marks,scientific=FALSE))
axis(1,at=marks,labels=format(marks,scientific=FALSE))
grid (NULL,NULL, lty = "93", col = "cornsilk2") 

points(df$mov.avg.p2[b2[[1]]],
       df$mov.avg.p1[b2[[1]]],
       pch = 18, cex = 2)
text(df$mov.avg.p2[1],
       df$mov.avg.p1[1],
       "4.3.2020", cex = 0.8)
dev.off()

