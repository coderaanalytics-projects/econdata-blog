# https://econdata.co.za/charting-and-automation/

library(econdatar)
library(dplyr)
library(ggplot2)
library(gridExtra)

ba100 <- read_dataset(id = "BA100",
                      series_key = "TOT..L024")

# Series returned from EconData
names(ba100)

# Data set and time series metadata
attributes(ba100)$metadata
attributes(ba100$TOT.A3.L024)

# Time series data
head(ba100$TOT.A3.L024)

# Convert time series to tibble and calculate YoY growth rate
loans_and_advances <- as_tibble(ba100) %>%
    arrange(time_period) %>%
    mutate(growth = (TOT.A3.L024 / dplyr::lag(TOT.A3.L024, n = 12) - 1) * 100) %>%
    filter(!is.na(growth))

# Plot YoY loans and advances
p <- ggplot(data = loans_and_advances) +
  geom_line(aes(x = time_period, y = growth), colour = "#273b8d", linewidth = 2) +
  labs(caption = "Source: www.econdata.co.za") +
  xlab("") + ylab("%") +
  theme_classic(base_size = 14) +
  theme(panel.grid = element_blank(),
        axis.text = element_text(face = "bold"))

# Save plot as PNG
ggsave("sarb/baforms/loans_advances/inst/loans and advances.png",
       height = 4.5,
       width = 6,
       plot = p,
       dpi = 1600,
       limitsize = FALSE,
       device = "png")
