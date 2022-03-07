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

# Estimate auto ARIMA model
arima_mod <- auto.arima(headline_yoy)

# Create 1 year ahead forecasts
f_cast <- forecast(arima_mod, h=12)

# Plot forecast
plot(f_cast, main = "Forecast of 12 month ahead y-o-y headline CPI")
