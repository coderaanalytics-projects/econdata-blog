library(econdatar)
library(forecast)
library(dplyr)
library(ggplot2)
library(xts)
library(gridExtra)

cpi <- read_econdata(id = "CPI_COICOP_5",
                     key = "TC.00.0.0.0",
                     releasedescription = "2022-02-16")

# Convert time series to xts and calculate YoY growth rate
headline <- xts(cpi$TC.00.0.0.0,
                order.by = rownames(cpi$TC.00.0.0.0) %>%
                  as.Date() %>%
                  as.yearmon())

headline_yoy <- (headline / stats::lag(headline, k = 12) - 1) * 100

png(filename = "C:/GIT/econdata-blog/post 3/inst/headline inflation.png",
    units = "in", width = 6, height = 4.5,pointsize = 12, res = 1600)
plot(headline_yoy, main =  "Headline y-o-y inflation", col = "#273b8d", lwd = 3)
dev.off()
# Estimate auto ARIMA model
arima_mod <- auto.arima(headline_yoy)

# Create 1 year ahead forecasts
f_cast <- forecast(arima_mod, h=12)

# Plot forecast
png(filename = "C:/GIT/econdata-blog/post 3/inst/forecast plot.png",
    units = "in", width = 6, height = 4.5,pointsize = 12, res = 1600)
plot(f_cast, main = "Forecast of 12-month ahead y-o-y headline inflation", 
     col = "#273b8d",
     lwd = 3)
axis(1,at=1:16,las=2, labels=seq(1:16))
dev.off()

# Make a simple table of forecast values
last_date <- last(index(headline_yoy))+1/12
f_cast_data <- data.frame((seq(as.Date(last_date), length=12, by="month")+1),
                f_cast$mean[1:12])
colnames(f_cast_data) <- c("Date","Forecast")
grid.table(f_cast_data, rows=NULL)

