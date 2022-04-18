library(econdatar)
library(dplyr)
library(ggplot2)
library(gridExtra)

ba100 <- read_econdata(id = "BA100",
                       key = "TOT..L024",
                       releasedescription = "Mar 2022")

# Series returned from EconData
names(ba100)

# Data set and time series metadata
attributes(ba100)$metadata
attributes(ba100$TOT.A3.L024)$metadata

# Time series data
head(ba100$TOT.A3.L024)

# Convert time series to tibble and calculate YoY growth rate
(loans_and_advances <- tibble(Period = as.Date(rownames(ba100$TOT.A3.L024)),
                              Value = ba100$TOT.A3.L024$OBS_VALUE,
                              Label = "loans") %>%
   mutate(Value = (Value / dplyr::lag(Value, n = 12) - 1) * 100) %>%
   filter(!is.na(Value)))

# Plot YoY loans and advances
(p <- ggplot(data = loans_and_advances) +
  geom_line(aes(x = Period, y = Value), colour = "#273b8d", size = 2) +
  labs(caption = "Source: EconData") +
  xlab("") + ylab("%") +
  theme_classic(base_size = 14) +
  theme(panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_blank(),
        panel.grid.minor.y = element_blank(),
        axis.text = element_text(face = "bold")))

# Save plot as PNG
ggsave("loans and advances.png",
       height = 4.5,
       width = 6,
       plot = p,
       dpi = 1600,
       limitsize = FALSE,
       device = "png")
