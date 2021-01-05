###############################################################################
## TRANSFORM DATA
###############################################################################

# PRELIMINARIES
###############################################################################
# # install packages
# install.packages("readr")
# install.packages("zoo")

# load packages
library(readr)
library(zoo)

# import data data 
download.file(paste0("https://raw.githubusercontent.com/",
                     "sledilnik/data/master/csv/stats.csv"),
              "data/raw.data.csv")

# load data
stats <- read_csv("data/raw.data.csv")

# TRANSFORM DATA
###############################################################################
# set number of periods and period length
d = 7
p1 = 1
p2 = 3

# remove first leading and trailing NAs, replace remaining NA with 0  
df <- na.trim(data.frame(cases.confirmed = stats$cases.confirmed))
df$cases.confirmed[is.na(df$cases.confirmed)] <- 0
rownames(df) <- NULL

# calculate moving average - right aligned
df$mov.avg.p1.chart <- rollmean(df$cases.confirmed, d * p1, na.pad = TRUE, align = "center")
df$mov.avg.p1 <- ifelse(as.numeric(rownames(df)) < 7,
                        cumsum(df$cases.confirmed)/as.numeric(rownames(df)),
                        rollmean(df$cases.confirmed, d * p1, na.pad = TRUE, align = "right"))

df$mov.avg.p2 <-  ifelse(as.numeric(rownames(df)) < 21,
                         cumsum(df$cases.confirmed)/as.numeric(rownames(df)),
                         rollmean(df$cases.confirmed, d * p2, na.pad = TRUE, align = "right"))

# calculate timeseries
df$time.series.1 <- df$cases.confirmed/df$mov.avg.p2
df$time.series.2 <- df$mov.avg.p1/df$mov.avg.p2

write_csv(df, "data/transformed.data.csv")