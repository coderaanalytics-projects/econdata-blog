library(econdatar)
library(tidyverse)

data_raw <- read_dataset(id = "BUSINESS_CYCLES",
                         tidy = TRUE,
                         wide = FALSE,
                         compact = FALSE)
str(data_raw)
print(names(data_raw$data))
print(names(data_raw$metadata))

as_tibble(data_raw$metadata) %>% print(width = 700L)

neat <- as_tibble(data_raw$metadata) %>%
    select(label, series_key, base_period, unit_of_measure, seasonal_adjustment, frequency) %>%
    distinct(label, .keep_all=TRUE)
view(neat)

write_csv(neat,
        "neat.csv",
        na = "" )