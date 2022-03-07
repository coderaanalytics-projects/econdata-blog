library(econdatar)
library(forecast)
library(dplyr)
library(ggplot2)
library(xts)

cpi <- read_econdata(id = "CPI_COICOP_5",
                     key = "TC.00.0.0.0",
                     releasedescription = "2022-02-16")

# Convert time series to xts and calculate YoY growth rate
headline <- xts(cpi$TC.00.0.0.0,
                order.by = rownames(cpi$TC.00.0.0.0) %>%
                  as.Date() %>%
                  as.yearmon())

headline_yoy <- (headline / stats::lag(headline, k = 12) - 1) * 100

plot(headline_yoy)
